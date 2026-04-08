#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
APW_ROOT="$(cd "$SCRIPT_DIR/.." && pwd -P)"
TEMP_ROOT="$(mktemp -d "${TMPDIR:-/tmp}/apw-context-routing.XXXXXX")"
WORKSPACE="$TEMP_ROOT/workspace"
TEST_APW_ROOT="$WORKSPACE/apw"
UNRELATED_ROOT="$TEMP_ROOT/unrelated"
WORKSPACE_LAUNCHER_BIN=""

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

mkdir -p "$WORKSPACE" "$UNRELATED_ROOT"
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
    apw new ContextProject --profile minimal --stack base --skip-validate >"$TEMP_ROOT/create.log"
)

(
    export PATH="$WORKSPACE_LAUNCHER_BIN:$PATH"
    cd "$TEST_APW_ROOT"
    apw context >"$TEMP_ROOT/framework.log"
)

assert_output_contains "$TEMP_ROOT/framework.log" "Invocation context: framework-root" "APW root should resolve as framework-root"
assert_output_contains "$TEMP_ROOT/framework.log" "Context: APW root" "APW root should be described clearly"
pass "Framework root context is detected correctly"

(
    export PATH="$WORKSPACE_LAUNCHER_BIN:$PATH"
    cd "$WORKSPACE"
    apw context >"$TEMP_ROOT/parent.log"
    apw list-projects >"$TEMP_ROOT/parent-projects.log"
)

assert_output_contains "$TEMP_ROOT/parent.log" "Invocation context: workspace-parent" "Workspace parent should resolve as workspace-parent"
assert_output_contains "$TEMP_ROOT/parent-projects.log" "ContextProject" "Workspace parent should list downstream projects without extra flags"
pass "Workspace parent context is detected correctly"

(
    export PATH="$WORKSPACE_LAUNCHER_BIN:$PATH"
    cd "$WORKSPACE/ContextProject"
    apw context >"$TEMP_ROOT/downstream.log"
    apw list-projects >"$TEMP_ROOT/downstream-projects.log"
)

assert_output_contains "$TEMP_ROOT/downstream.log" "Invocation context: downstream-project-root" "Downstream project root should resolve as downstream-project-root"
assert_output_contains "$TEMP_ROOT/downstream-projects.log" "Current invocation context: downstream-project-root" "Downstream project root should keep workspace-aware routing"
pass "Downstream project root context is detected correctly"

(
    export PATH="$WORKSPACE_LAUNCHER_BIN:$PATH"
    cd "$UNRELATED_ROOT"
    apw context >"$TEMP_ROOT/unrelated-context.log"
)

assert_output_contains "$TEMP_ROOT/unrelated-context.log" "Invocation context: unsupported" "Unrelated folder should resolve as unsupported"
assert_output_contains "$TEMP_ROOT/unrelated-context.log" "Context: unsupported location" "Unrelated folder should explain that it is unsupported"
pass "Unrelated folder is detected as unsupported"

(
    export PATH="$WORKSPACE_LAUNCHER_BIN:$PATH"
    cd "$UNRELATED_ROOT"
    if apw list-projects >"$TEMP_ROOT/unrelated-list.log" 2>&1; then
        fail "Unrelated folder should not allow implicit workspace project discovery"
    fi
)

assert_output_contains "$TEMP_ROOT/unrelated-list.log" "cannot infer APW workspace routing from this location" "Unsupported project discovery should fail clearly"
assert_output_contains "$TEMP_ROOT/unrelated-list.log" "--workspace /path/to/workspace" "Unsupported project discovery should explain the corrective override"
pass "Unsupported folder gets a clean corrective error for implicit workspace routing"

(
    export PATH="$WORKSPACE_LAUNCHER_BIN:$PATH"
    cd "$UNRELATED_ROOT"
    apw list-projects --workspace "$WORKSPACE" >"$TEMP_ROOT/unrelated-explicit.log"
)

assert_output_contains "$TEMP_ROOT/unrelated-explicit.log" "Using explicit workspace override: $WORKSPACE" "Explicit workspace override should work from an unrelated folder"
assert_output_contains "$TEMP_ROOT/unrelated-explicit.log" "ContextProject" "Explicit workspace override should still list projects"
pass "Explicit workspace override still works from an unrelated folder"

echo
echo "All context routing checks passed."
