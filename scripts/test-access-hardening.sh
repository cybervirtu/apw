#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
APW_ROOT="$(cd "$SCRIPT_DIR/.." && pwd -P)"
TEMP_ROOT="$(mktemp -d "${TMPDIR:-/tmp}/apw-access-hardening.XXXXXX")"
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
)

(
    export PATH="$WORKSPACE_LAUNCHER_BIN:$PATH"
    cd "$WORKSPACE"
    apw help >"$TEMP_ROOT/help.log"
)

assert_output_contains "$TEMP_ROOT/help.log" "Canonical invocation is: apw ..." "Help should make the primary invocation obvious"
assert_output_contains "$TEMP_ROOT/help.log" "If your shell says \"apw: command not found\"" "Help should explain the missing-launcher recovery path"
assert_output_contains "$TEMP_ROOT/help.log" "Current launch mode: workspace-launcher" "Help should expose the current launch mode clearly"
pass "Help text teaches the canonical launcher model"

(
    export PATH="$WORKSPACE_LAUNCHER_BIN:$PATH"
    cd "$UNRELATED_ROOT"
    if apw new HardeningProject --profile minimal --stack base --skip-validate >"$TEMP_ROOT/unsupported-new.log" 2>&1; then
        fail "Unsupported folder should not allow implicit project creation"
    fi
)

assert_output_contains "$TEMP_ROOT/unsupported-new.log" "apw new cannot infer APW workspace routing from this location" "Unsupported project creation should fail with a precise explanation"
assert_output_contains "$TEMP_ROOT/unsupported-new.log" "--target /path/to/parent" "Unsupported project creation should explain the explicit target override"
pass "Unsupported project creation gets a corrective error"

mkdir -p "$UNRELATED_ROOT/copied-wrapper"
cp "$TEST_APW_ROOT/apw" "$UNRELATED_ROOT/copied-wrapper/apw"
chmod +x "$UNRELATED_ROOT/copied-wrapper/apw"

(
    cd "$UNRELATED_ROOT/copied-wrapper"
    if ./apw help >"$TEMP_ROOT/copied-wrapper.log" 2>&1; then
        fail "Copied wrapper should not look like a valid APW command entrypoint"
    fi
)

assert_output_contains "$TEMP_ROOT/copied-wrapper.log" "framework layout is incomplete or this wrapper is not inside a real APW framework repo" "Copied wrapper should fail with a framework-layout error"
assert_output_contains "$TEMP_ROOT/copied-wrapper.log" "Launcher recovery:" "Copied wrapper should explain how to recover"
pass "Copied wrapper fails with a clear framework-layout error"

mv "$TEST_APW_ROOT/scripts/bootstrap.sh" "$TEST_APW_ROOT/scripts/bootstrap.sh.bak"

(
    export PATH="$WORKSPACE_LAUNCHER_BIN:$PATH"
    cd "$WORKSPACE"
    if apw help >"$TEMP_ROOT/missing-framework-file.log" 2>&1; then
        fail "Missing framework files should stop APW with a corrective message"
    fi
)

assert_output_contains "$TEMP_ROOT/missing-framework-file.log" "Missing required framework path:" "Missing framework files should be called out explicitly"
assert_output_contains "$TEMP_ROOT/missing-framework-file.log" "scripts/bootstrap.sh" "Missing framework files should identify the missing prerequisite"
pass "Missing framework prerequisites fail clearly"

echo
echo "All access hardening checks passed."
