#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
APW_ROOT="$(cd "$SCRIPT_DIR/.." && pwd -P)"
TEMP_ROOT="$(mktemp -d "${TMPDIR:-/tmp}/apw-workspace-launcher.XXXXXX")"
WORKSPACE="$TEMP_ROOT/workspace"
TEST_APW_ROOT="$WORKSPACE/apw"
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

assert_file_exists() {
    local file_path="$1"
    local label="$2"

    [[ -f "$file_path" ]] || fail "$label (missing file: $file_path)"
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

mkdir -p "$WORKSPACE"
cp -R "$APW_ROOT" "$TEST_APW_ROOT"
WORKSPACE="$(cd "$WORKSPACE" && pwd -P)"
TEST_APW_ROOT="$(cd "$TEST_APW_ROOT" && pwd -P)"
WORKSPACE_LAUNCHER_BIN="$WORKSPACE/.apw/bin"

printf 'Temporary workspace: %s\n' "$WORKSPACE"
printf 'APW under test: %s\n' "$TEST_APW_ROOT"
echo

(
    cd "$TEST_APW_ROOT"
    ./scripts/install-workspace-launcher.sh >"$TEMP_ROOT/install.log"
)

assert_file_exists "$WORKSPACE/.apw/bin/apw" "Installer should create the workspace apw launcher"
assert_file_exists "$WORKSPACE/.apw/env.zsh" "Installer should create the workspace env.zsh snippet"
assert_output_contains "$TEMP_ROOT/install.log" "Installed workspace APW launcher:" "Installer should report where the launcher was written"
assert_output_contains "$TEMP_ROOT/install.log" "apw help" "Installer should tell the user how to verify the launcher"
assert_output_contains "$TEMP_ROOT/install.log" "do not rely on ./apw, ./apw/apw, or full wrapper paths for everyday work" "Installer should teach the canonical invocation model"
pass "Workspace launcher installs cleanly"

(
    export PATH="$WORKSPACE_LAUNCHER_BIN:$PATH"
    cd "$WORKSPACE"
    apw help >"$TEMP_ROOT/parent.log"
)

assert_output_contains "$TEMP_ROOT/parent.log" "Usage:" "Workspace parent should be able to run apw help"
assert_output_contains "$TEMP_ROOT/parent.log" "  apw help" "Workspace parent help should show the canonical apw entrypoint"
pass "Workspace parent resolves the canonical apw launcher"

(
    export PATH="$WORKSPACE_LAUNCHER_BIN:$PATH"
    cd "$TEST_APW_ROOT"
    apw help >"$TEMP_ROOT/framework.log"
)

assert_output_contains "$TEMP_ROOT/framework.log" "  apw help" "APW root should be able to run apw help without ./apw"
pass "APW root resolves the canonical apw launcher"

(
    export PATH="$WORKSPACE_LAUNCHER_BIN:$PATH"
    cd "$WORKSPACE"
    apw new LauncherProject --profile minimal --stack base --skip-validate >"$TEMP_ROOT/create.log"
    cd "$WORKSPACE/LauncherProject"
    apw help >"$TEMP_ROOT/downstream.log"
)

assert_output_contains "$TEMP_ROOT/downstream.log" "  apw help" "Downstream project root should be able to run apw help without a local ./apw"
pass "Downstream project root resolves the canonical apw launcher"

mv "$TEST_APW_ROOT/apw" "$TEST_APW_ROOT/apw.wrapper.bak"

(
    export PATH="$WORKSPACE_LAUNCHER_BIN:$PATH"
    cd "$WORKSPACE"
    if apw help >"$TEMP_ROOT/missing-wrapper.log" 2>&1; then
        fail "Launcher should fail clearly when the framework wrapper is missing"
    fi
)

assert_output_contains "$TEMP_ROOT/missing-wrapper.log" "APW launcher is installed, but the framework wrapper is missing:" "Missing framework wrapper should produce a clear corrective message"
assert_output_contains "$TEMP_ROOT/missing-wrapper.log" "./scripts/install-workspace-launcher.sh" "Missing framework wrapper should tell the user how to repair the launcher"
pass "Launcher reports a clear corrective error when the framework wrapper is missing"

echo
echo "All workspace launcher checks passed."
