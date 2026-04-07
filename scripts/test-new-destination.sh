#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
APW_ROOT="$(cd "$SCRIPT_DIR/.." && pwd -P)"
TEMP_ROOT="$(mktemp -d "${TMPDIR:-/tmp}/apw-new-destination.XXXXXX")"
WORKSPACE="$TEMP_ROOT/workspace"
TEST_APW_ROOT="$WORKSPACE/apw"

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

assert_dir_exists() {
    local dir_path="$1"
    local label="$2"

    [[ -d "$dir_path" ]] || fail "$label (missing directory: $dir_path)"
}

assert_dir_missing() {
    local dir_path="$1"
    local label="$2"

    [[ ! -e "$dir_path" ]] || fail "$label (unexpected path exists: $dir_path)"
}

assert_output_contains() {
    local output_path="$1"
    local expected_text="$2"
    local label="$3"

    if ! rg -F --quiet "$expected_text" "$output_path"; then
        printf 'Expected to find: %s\n' "$expected_text" >&2
        printf '%s\n' '--- output ---' >&2
        cat "$output_path" >&2
        printf '%s\n' '--------------' >&2
        fail "$label"
    fi
}

mkdir -p "$WORKSPACE"
cp -R "$APW_ROOT" "$TEST_APW_ROOT"
WORKSPACE="$(cd "$WORKSPACE" && pwd -P)"
TEST_APW_ROOT="$(cd "$TEST_APW_ROOT" && pwd -P)"

printf 'Temporary workspace: %s\n' "$WORKSPACE"
printf 'APW under test: %s\n' "$TEST_APW_ROOT"
echo

(
    cd "$TEST_APW_ROOT"
    ./apw new RootSibling --profile minimal --stack base --skip-validate >"$TEMP_ROOT/root.log"
)

assert_dir_exists "$WORKSPACE/RootSibling" "APW root should create a sibling project under the workspace parent"
assert_dir_missing "$TEST_APW_ROOT/RootSibling" "APW root should not create a nested project inside the framework repo"
assert_output_contains "$TEMP_ROOT/root.log" "Destination policy: apw-root" "APW root creation should report the apw-root policy"
assert_output_contains "$TEMP_ROOT/root.log" "Resolved destination: $WORKSPACE/RootSibling" "APW root creation should print the sibling destination"
pass "APW root defaults to workspace-parent sibling creation"

(
    cd "$WORKSPACE"
    ./apw/apw new ParentSibling --profile minimal --stack base --skip-validate >"$TEMP_ROOT/parent.log"
)

assert_dir_exists "$WORKSPACE/ParentSibling" "Workspace parent should create the project in the current folder"
assert_output_contains "$TEMP_ROOT/parent.log" "Destination policy: workspace-parent" "Workspace parent creation should report the workspace-parent policy"
assert_output_contains "$TEMP_ROOT/parent.log" "Resolved destination: $WORKSPACE/ParentSibling" "Workspace parent creation should print the current-folder destination"
pass "Workspace parent defaults to current-folder project creation"

mkdir -p "$WORKSPACE/custom-home"
(
    cd "$TEST_APW_ROOT"
    ./apw new ExplicitTarget --profile minimal --stack base --skip-validate --target "$WORKSPACE/custom-home" >"$TEMP_ROOT/target.log"
)

assert_dir_exists "$WORKSPACE/custom-home/ExplicitTarget" "Explicit --target should be honored"
assert_output_contains "$TEMP_ROOT/target.log" "Destination policy: explicit-target" "Explicit target creation should report the explicit-target policy"
assert_output_contains "$TEMP_ROOT/target.log" "Resolved destination: $WORKSPACE/custom-home/ExplicitTarget" "Explicit target creation should print the chosen destination"
pass "Explicit --target override still works"

(
    cd "$WORKSPACE/RootSibling"
    ../apw/apw new DownstreamSibling --profile minimal --stack base --skip-validate >"$TEMP_ROOT/downstream.log"
)

assert_dir_exists "$WORKSPACE/DownstreamSibling" "Downstream project creation should default to a sibling project in the same workspace"
assert_dir_missing "$WORKSPACE/RootSibling/DownstreamSibling" "Downstream project creation should not nest inside the current downstream repo"
assert_dir_missing "$TEST_APW_ROOT/DownstreamSibling" "Downstream project creation should not spill into APW root by default"
assert_output_contains "$TEMP_ROOT/downstream.log" "Destination policy: downstream-project" "Downstream project creation should report the downstream-project policy"
assert_output_contains "$TEMP_ROOT/downstream.log" "Resolved destination: $WORKSPACE/DownstreamSibling" "Downstream project creation should print the sibling destination"
pass "Downstream project context defaults to sibling creation"

echo
echo "All destination checks passed."
