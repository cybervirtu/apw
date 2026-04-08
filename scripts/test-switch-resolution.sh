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
SAFE_PATH=""

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
SAFE_PATH="$WORKSPACE_LAUNCHER_BIN:/usr/bin:/bin"

printf 'Temporary workspace: %s\n' "$WORKSPACE"
printf 'APW under test: %s\n' "$TEST_APW_ROOT"
printf 'Unrelated folder: %s\n' "$UNRELATED_ROOT"
echo

(
    cd "$TEST_APW_ROOT"
    ./scripts/install-workspace-launcher.sh >"$TEMP_ROOT/install.log"
    export PATH="$SAFE_PATH"
    apw new SwitchProject --profile minimal --stack base --skip-validate >"$TEMP_ROOT/create.log"
    apw new SwitchProjectApi --profile minimal --stack base --skip-validate >"$TEMP_ROOT/create-api.log"
    apw new SwitchProjectWeb --profile minimal --stack base --skip-validate >"$TEMP_ROOT/create-web.log"
)

(
    export PATH="$SAFE_PATH"
    cd "$WORKSPACE"
    apw switch framework >"$TEMP_ROOT/framework.log"
)

assert_output_contains "$TEMP_ROOT/framework.log" "Resolved path: $TEST_APW_ROOT" "Switch framework should resolve the APW root exactly"
assert_output_contains "$TEMP_ROOT/framework.log" "Switch target: APW framework root" "Switch framework should describe the framework target"
assert_output_contains "$TEMP_ROOT/framework.log" "APW does not silently change your shell or IDE." "Switch framework should avoid pretending to mutate shell state"
assert_output_contains "$TEMP_ROOT/framework.log" "Antigravity launcher not found." "Switch framework should say when Antigravity is unavailable"
pass "Switch framework resolves the APW root cleanly"

(
    export PATH="$SAFE_PATH"
    cd "$TEST_APW_ROOT"
    apw switch parent >"$TEMP_ROOT/parent.log"
)

assert_output_contains "$TEMP_ROOT/parent.log" "Resolved path: $WORKSPACE" "Switch parent should resolve the workspace parent exactly"
assert_output_contains "$TEMP_ROOT/parent.log" "Switch target: workspace parent folder" "Switch parent should describe the workspace parent target"
assert_output_contains "$TEMP_ROOT/parent.log" "Exact folder for Antigravity: $WORKSPACE" "Switch parent should print an Antigravity-usable path"
pass "Switch parent resolves the workspace parent cleanly"

(
    export PATH="$SAFE_PATH"
    cd "$TEST_APW_ROOT"
    apw switch SwitchProject >"$TEMP_ROOT/project-name.log"
)

assert_output_contains "$TEMP_ROOT/project-name.log" "Resolved path: $WORKSPACE/SwitchProject" "Switch by project name should resolve the downstream project exactly"
assert_output_contains "$TEMP_ROOT/project-name.log" "Switch target: downstream project root" "Switch by project name should describe the downstream target"
assert_output_contains "$TEMP_ROOT/project-name.log" "Exact folder for Antigravity: $WORKSPACE/SwitchProject" "Switch by project name should print an Antigravity-usable path"
pass "Switch by project name resolves the downstream project cleanly"

(
    export PATH="$SAFE_PATH"
    cd "$TEST_APW_ROOT"
    apw switch project SwitchProject >"$TEMP_ROOT/project-alias.log"
)

assert_output_contains "$TEMP_ROOT/project-alias.log" "Resolved path: $WORKSPACE/SwitchProject" "Legacy switch project alias should still resolve the downstream project"
pass "Legacy switch project alias still works"

(
    export PATH="$SAFE_PATH"
    cd "$UNRELATED_ROOT"
    apw switch "$WORKSPACE/SwitchProject" >"$TEMP_ROOT/project-path.log"
)

assert_output_contains "$TEMP_ROOT/project-path.log" "Resolved path: $WORKSPACE/SwitchProject" "Switch by explicit path should work from unrelated folders"
pass "Switch by explicit path still works from unrelated folders"

(
    export PATH="$SAFE_PATH"
    cd "$UNRELATED_ROOT"
    if apw switch SwitchProject >"$TEMP_ROOT/project-unsupported.log" 2>&1; then
        fail "Switch by project name should not infer the workspace from an unrelated folder"
    fi
)

assert_output_contains "$TEMP_ROOT/project-unsupported.log" "cannot infer APW workspace routing from this location" "Unsupported switch should fail with a clear explanation"
assert_output_contains "$TEMP_ROOT/project-unsupported.log" "--workspace /path/to/workspace" "Unsupported switch should explain the corrective workspace override"
pass "Unsupported folder gets a clean corrective error for switch by project name"

(
    export PATH="$SAFE_PATH"
    cd "$UNRELATED_ROOT"
    apw switch SwitchProject --workspace "$WORKSPACE" >"$TEMP_ROOT/project-explicit-workspace.log"
)

assert_output_contains "$TEMP_ROOT/project-explicit-workspace.log" "Resolved path: $WORKSPACE/SwitchProject" "Explicit workspace override should resolve the downstream project"
pass "Explicit workspace override works for switch"

(
    export PATH="$SAFE_PATH"
    cd "$WORKSPACE"
    if apw switch MissingProject >"$TEMP_ROOT/project-missing.log" 2>&1; then
        fail "Missing project selector should fail clearly"
    fi
)

assert_output_contains "$TEMP_ROOT/project-missing.log" "Error: Could not find downstream project 'MissingProject'" "Missing project should fail with a precise explanation"
assert_output_contains "$TEMP_ROOT/project-missing.log" "Searched workspace parent: $WORKSPACE" "Missing project should show the searched workspace"
assert_output_contains "$TEMP_ROOT/project-missing.log" "Known downstream projects:" "Missing project should list known projects"
pass "Missing project selector fails with searched workspace guidance"

(
    export PATH="$SAFE_PATH"
    cd "$WORKSPACE"
    if apw switch SwitchProject --workspace "$WORKSPACE" >"$TEMP_ROOT/project-exact.log" 2>&1; then
        :
    else
        fail "Exact project name should not fail even when close matches exist"
    fi
)

assert_output_contains "$TEMP_ROOT/project-exact.log" "Resolved path: $WORKSPACE/SwitchProject" "Exact project names should still resolve cleanly"
pass "Exact project names win over close matches"

(
    export PATH="$SAFE_PATH"
    cd "$WORKSPACE"
    if apw switch Switch --workspace "$WORKSPACE" >"$TEMP_ROOT/project-ambiguous.log" 2>&1; then
        fail "Ambiguous project selector should not auto-pick a project"
    fi
)

assert_output_contains "$TEMP_ROOT/project-ambiguous.log" "Error: Downstream project selector is ambiguous: Switch" "Ambiguous selector should fail clearly"
assert_output_contains "$TEMP_ROOT/project-ambiguous.log" "Close matching downstream project paths:" "Ambiguous selector should show matching paths"
assert_output_contains "$TEMP_ROOT/project-ambiguous.log" "$WORKSPACE/SwitchProject" "Ambiguous selector should list the first matching path"
assert_output_contains "$TEMP_ROOT/project-ambiguous.log" "$WORKSPACE/SwitchProjectApi" "Ambiguous selector should list additional matching paths"
assert_output_contains "$TEMP_ROOT/project-ambiguous.log" "$WORKSPACE/SwitchProjectWeb" "Ambiguous selector should list all matching paths"
pass "Ambiguous project selector stops with all matching paths"

cat >"$FAKE_BIN/antigravity" <<EOF
#!/usr/bin/env bash
set -euo pipefail
printf '%s\n' "\$1" >"$FAKE_ANTIGRAVITY_LOG"
EOF
chmod +x "$FAKE_BIN/antigravity"

(
    export PATH="$FAKE_BIN:$SAFE_PATH"
    cd "$WORKSPACE"
    apw switch SwitchProject >"$TEMP_ROOT/project-open.log"
)

assert_output_contains "$TEMP_ROOT/project-open.log" "Antigravity launch command: antigravity $WORKSPACE/SwitchProject" "Switch output should advertise the Antigravity command"
assert_output_contains "$TEMP_ROOT/project-open.log" "Launching the selected folder with Antigravity CLI." "Switch should report the launcher it is using"
assert_output_contains "$TEMP_ROOT/project-open.log" "Launch request sent via: Antigravity CLI." "Switch should report a successful launch request"
assert_output_contains "$FAKE_ANTIGRAVITY_LOG" "$WORKSPACE/SwitchProject" "Switch should pass the resolved path to Antigravity"
pass "Switch launches Antigravity when available"

echo
echo "All switch resolution checks passed."
