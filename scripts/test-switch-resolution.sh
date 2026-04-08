#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
APW_ROOT="$(cd "$SCRIPT_DIR/.." && pwd -P)"
TEMP_ROOT="$(mktemp -d "${TMPDIR:-/tmp}/apw-switch-resolution.XXXXXX")"
WORKSPACE="$TEMP_ROOT/workspace"
TEST_APW_ROOT="$WORKSPACE/apw"
UNRELATED_ROOT="$TEMP_ROOT/unrelated"
WORKSPACE_LAUNCHER_BIN=""
FAKE_BIN="$TEMP_ROOT/fake-bin"
FAKE_ANTIGRAVITY_LOG="$TEMP_ROOT/antigravity.log"

cleanup() {
    rm -rf "$TEMP_ROOT"
}

trap cleanup EXIT

pass() {
    printf 'PASS: %s\n' "$1"
}

fail() {
    printf 'FAIL: %s\n' "$1" >&2
    exit 1
}

assert_output_contains() {
    local output_path="$1"
    local expected_text="$2"
    local label="$3"

    if ! rg -F --quiet -- "$expected_text" "$output_path"; then
        printf 'Expected to find: %s\n' "$expected_text" >&2
        printf '%s\n' '--- output ---' >&2
        cat "$output_path" >&2
        printf '%s\n' '--------------' >&2
        fail "$label"
    fi
}

mkdir -p "$WORKSPACE" "$UNRELATED_ROOT" "$FAKE_BIN"
cp -R "$APW_ROOT" "$TEST_APW_ROOT"
WORKSPACE="$(cd "$WORKSPACE" && pwd -P)"
TEST_APW_ROOT="$(cd "$TEST_APW_ROOT" && pwd -P)"
UNRELATED_ROOT="$(cd "$UNRELATED_ROOT" && pwd -P)"
WORKSPACE_LAUNCHER_BIN="$WORKSPACE/.apw/bin"

printf 'Temporary workspace: %s\n' "$WORKSPACE"
printf 'APW under test: %s\n' "$TEST_APW_ROOT"
printf 'Unrelated folder: %s\n' "$UNRELATED_ROOT"
echo

(
    cd "$TEST_APW_ROOT"
    ./scripts/install-workspace-launcher.sh >"$TEMP_ROOT/install.log"
    export PATH="$WORKSPACE_LAUNCHER_BIN:$PATH"
    apw new SwitchProject --profile minimal --stack base --skip-validate >"$TEMP_ROOT/create.log"
)

(
    export PATH="$WORKSPACE_LAUNCHER_BIN:$PATH"
    cd "$WORKSPACE"
    apw switch framework >"$TEMP_ROOT/framework.log"
)

assert_output_contains "$TEMP_ROOT/framework.log" "Resolved path: $TEST_APW_ROOT" "Switch framework should resolve the APW root exactly"
assert_output_contains "$TEMP_ROOT/framework.log" "Switch target: APW framework root" "Switch framework should describe the framework target"
assert_output_contains "$TEMP_ROOT/framework.log" "APW does not silently change your shell or IDE." "Switch framework should avoid pretending to mutate shell state"
pass "Switch framework resolves the APW root cleanly"

(
    export PATH="$WORKSPACE_LAUNCHER_BIN:$PATH"
    cd "$TEST_APW_ROOT"
    apw switch parent >"$TEMP_ROOT/parent.log"
)

assert_output_contains "$TEMP_ROOT/parent.log" "Resolved path: $WORKSPACE" "Switch parent should resolve the workspace parent exactly"
assert_output_contains "$TEMP_ROOT/parent.log" "Switch target: workspace parent folder" "Switch parent should describe the workspace parent target"
assert_output_contains "$TEMP_ROOT/parent.log" "Exact folder for Antigravity or another IDE: $WORKSPACE" "Switch parent should print an IDE-usable path"
pass "Switch parent resolves the workspace parent cleanly"

(
    export PATH="$WORKSPACE_LAUNCHER_BIN:$PATH"
    cd "$TEST_APW_ROOT"
    apw switch project SwitchProject >"$TEMP_ROOT/project-name.log"
)

assert_output_contains "$TEMP_ROOT/project-name.log" "Resolved path: $WORKSPACE/SwitchProject" "Switch project by name should resolve the downstream project exactly"
assert_output_contains "$TEMP_ROOT/project-name.log" "Switch target: downstream project root" "Switch project should describe the downstream target"
assert_output_contains "$TEMP_ROOT/project-name.log" "Exact folder for Antigravity or another IDE: $WORKSPACE/SwitchProject" "Switch project should print an IDE-usable path"
pass "Switch project by name resolves the downstream project cleanly"

(
    export PATH="$WORKSPACE_LAUNCHER_BIN:$PATH"
    cd "$UNRELATED_ROOT"
    apw switch project "$WORKSPACE/SwitchProject" >"$TEMP_ROOT/project-path.log"
)

assert_output_contains "$TEMP_ROOT/project-path.log" "Resolved path: $WORKSPACE/SwitchProject" "Switch project by explicit path should work from unrelated folders"
pass "Switch project by explicit path still works from unrelated folders"

(
    export PATH="$WORKSPACE_LAUNCHER_BIN:$PATH"
    cd "$UNRELATED_ROOT"
    if apw switch project SwitchProject >"$TEMP_ROOT/project-unsupported.log" 2>&1; then
        fail "Switch project by name should not infer the workspace from an unrelated folder"
    fi
)

assert_output_contains "$TEMP_ROOT/project-unsupported.log" "cannot infer APW workspace routing from this location" "Unsupported switch should fail with a clear explanation"
assert_output_contains "$TEMP_ROOT/project-unsupported.log" "--workspace /path/to/workspace" "Unsupported switch should explain the corrective workspace override"
pass "Unsupported folder gets a clean corrective error for switch project by name"

(
    export PATH="$WORKSPACE_LAUNCHER_BIN:$PATH"
    cd "$UNRELATED_ROOT"
    apw switch project SwitchProject --workspace "$WORKSPACE" >"$TEMP_ROOT/project-explicit-workspace.log"
)

assert_output_contains "$TEMP_ROOT/project-explicit-workspace.log" "Resolved path: $WORKSPACE/SwitchProject" "Explicit workspace override should resolve the downstream project"
pass "Explicit workspace override works for switch project"

cat >"$FAKE_BIN/antigravity" <<EOF
#!/usr/bin/env bash
set -euo pipefail
printf '%s\n' "\$1" >"$FAKE_ANTIGRAVITY_LOG"
EOF
chmod +x "$FAKE_BIN/antigravity"

(
    export PATH="$FAKE_BIN:$WORKSPACE_LAUNCHER_BIN:$PATH"
    cd "$WORKSPACE"
    apw switch project SwitchProject --open >"$TEMP_ROOT/project-open.log"
)

assert_output_contains "$TEMP_ROOT/project-open.log" "Open request: APW will try Antigravity CLI with: antigravity $WORKSPACE/SwitchProject" "Switch output should advertise the Antigravity CLI command"
assert_output_contains "$TEMP_ROOT/project-open.log" "Open request sent via: Antigravity CLI." "Switch open should report the launcher it used"
assert_output_contains "$FAKE_ANTIGRAVITY_LOG" "$WORKSPACE/SwitchProject" "Switch open should pass the resolved path to the Antigravity launcher"
pass "Switch open uses an Antigravity-compatible launcher when available"

echo
echo "All switch resolution checks passed."
