#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
APW_ROOT="$(cd "$SCRIPT_DIR/.." && pwd -P)"
TEMP_ROOT="$(mktemp -d "${TMPDIR:-/tmp}/apw-setup-preflight.XXXXXX")"
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
    ./apw setup >"$TEMP_ROOT/setup.log"
)

assert_output_contains "$TEMP_ROOT/setup.log" "APW first-time setup" "Setup should announce the first-time setup flow"
assert_output_contains "$TEMP_ROOT/setup.log" "Core APW requirements" "Setup should show the core requirements section"
assert_output_contains "$TEMP_ROOT/setup.log" "- git: detected" "Setup should verify git"
assert_output_contains "$TEMP_ROOT/setup.log" "- ripgrep (rg): detected" "Setup should verify ripgrep"
assert_output_contains "$TEMP_ROOT/setup.log" "Installed at: $WORKSPACE/.apw/bin/apw" "Setup should install the workspace launcher"
assert_output_contains "$TEMP_ROOT/setup.log" "Optional website/docs tooling" "Setup should separate optional docs tooling"
assert_output_contains "$TEMP_ROOT/setup.log" "Setup status: ready" "Setup should end with a ready status when requirements are present"
[[ -x "$WORKSPACE/.apw/bin/apw" ]] || fail "Setup should create the workspace launcher"
pass "First-time setup installs the launcher and reports required tooling"

(
    cd "$TEST_APW_ROOT"
    if PATH="$WORKSPACE_LAUNCHER_BIN:/usr/bin:/bin" ./apw setup --check-only >"$TEMP_ROOT/missing-rg.log" 2>&1; then
        fail "Setup check-only should fail when ripgrep is unavailable"
    fi
)

assert_output_contains "$TEMP_ROOT/missing-rg.log" "- ripgrep (rg): missing" "Setup should detect missing ripgrep before later command failures"
assert_output_contains "$TEMP_ROOT/missing-rg.log" "Install ripgrep on macOS with: brew install ripgrep" "Setup should show macOS ripgrep install guidance"
assert_output_contains "$TEMP_ROOT/missing-rg.log" "Setup status: incomplete" "Setup should clearly report an incomplete setup state"
pass "Setup check-only fails clearly with corrective ripgrep guidance"

(
    export PATH="$WORKSPACE_LAUNCHER_BIN:/usr/bin:/bin"
    cd "$WORKSPACE"
    if apw new MissingRgProject --profile minimal --stack base >"$TEMP_ROOT/new-missing-rg.log" 2>&1; then
        fail "apw new should fail before bootstrap when ripgrep is missing"
    fi
)

assert_output_contains "$TEMP_ROOT/new-missing-rg.log" "Error: Missing required tool: ripgrep (rg)" "Project creation should fail with a clear ripgrep error"
assert_output_contains "$TEMP_ROOT/new-missing-rg.log" "Why it is needed: APW validation uses rg to scan files for contract and drift checks." "Project creation should explain why ripgrep is required"
[[ ! -e "$WORKSPACE/MissingRgProject" ]] || fail "Project creation should not start when ripgrep is missing"
pass "Validation prerequisites are checked before project creation begins"

echo
echo "All setup preflight checks passed."
