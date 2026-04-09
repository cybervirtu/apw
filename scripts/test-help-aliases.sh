#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
APW_ROOT="$(cd "$SCRIPT_DIR/.." && pwd -P)"
TEMP_ROOT="$(mktemp -d "${TMPDIR:-/tmp}/apw-help-aliases.XXXXXX")"
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

assert_output_not_contains() {
    local output_path="$1"
    local blocked_text="$2"
    local label="$3"

    if rg -F --quiet -- "$blocked_text" "$output_path"; then
        printf 'Did not expect to find: %s\n' "$blocked_text" >&2
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
    export PATH="$WORKSPACE_LAUNCHER_BIN:/usr/bin:/bin"
    apw new AliasProject --profile minimal --stack base --skip-validate >"$TEMP_ROOT/create.log"
)

(
    export PATH="$WORKSPACE_LAUNCHER_BIN:/usr/bin:/bin"
    cd "$WORKSPACE"
    apw h >"$TEMP_ROOT/top-help.log"
)

assert_output_contains "$TEMP_ROOT/top-help.log" "help (h)" "Top help should show the locked help alias"
assert_output_contains "$TEMP_ROOT/top-help.log" "switch (s)" "Top help should show the locked switch alias"
assert_output_contains "$TEMP_ROOT/top-help.log" "context (c)" "Top help should show the locked context alias"
assert_output_contains "$TEMP_ROOT/top-help.log" "first-run (fr)" "Top help should show the locked first-run alias"
assert_output_contains "$TEMP_ROOT/top-help.log" "list-projects (lp)" "Top help should show the locked list-projects alias"
assert_output_contains "$TEMP_ROOT/top-help.log" "upgrade-project (up)" "Top help should show the locked upgrade-project alias"
assert_output_not_contains "$TEMP_ROOT/top-help.log" "What it does:" "Top help should stay compact"
assert_output_not_contains "$TEMP_ROOT/top-help.log" "Notes:" "Top help should stay compact"
pass "Top-level help shows the locked alias map compactly"

(
    export PATH="$WORKSPACE_LAUNCHER_BIN:/usr/bin:/bin"
    cd "$WORKSPACE"
    apw help switch >"$TEMP_ROOT/help-switch.log"
)

assert_output_contains "$TEMP_ROOT/help-switch.log" "Alias:" "Switch help should include the alias section"
assert_output_contains "$TEMP_ROOT/help-switch.log" "apw s" "Switch help should document the locked short alias"
assert_output_contains "$TEMP_ROOT/help-switch.log" "apw switch <project-name-or-path>" "Switch help should document the locked destination-first form"
assert_output_not_contains "$TEMP_ROOT/help-switch.log" "switch project" "Switch help should not document deprecated switch project syntax"
pass "apw help switch works with the locked switch surface"

(
    export PATH="$WORKSPACE_LAUNCHER_BIN:/usr/bin:/bin"
    cd "$WORKSPACE"
    apw help list-projects >"$TEMP_ROOT/help-list.log"
)

assert_output_contains "$TEMP_ROOT/help-list.log" "apw lp" "List-projects help should document the locked short alias"
assert_output_contains "$TEMP_ROOT/help-list.log" "--workspace <dir>" "List-projects help should document its extension"
pass "apw help list-projects works"

(
    export PATH="$WORKSPACE_LAUNCHER_BIN:/usr/bin:/bin"
    cd "$WORKSPACE"
    apw switch --help >"$TEMP_ROOT/switch-help-flag.log"
)

assert_output_contains "$TEMP_ROOT/switch-help-flag.log" "apw s framework" "Switch --help should document the locked short switch form"
assert_output_contains "$TEMP_ROOT/switch-help-flag.log" "apw switch parent" "Switch --help should document the locked full switch form"
pass "apw switch --help works"

(
    export PATH="$WORKSPACE_LAUNCHER_BIN:/usr/bin:/bin"
    cd "$WORKSPACE"
    apw list-projects --help >"$TEMP_ROOT/list-help-flag.log"
)

assert_output_contains "$TEMP_ROOT/list-help-flag.log" "apw lp" "List-projects --help should document the locked short alias"
pass "apw list-projects --help works"

(
    export PATH="$WORKSPACE_LAUNCHER_BIN:/usr/bin:/bin"
    cd "$WORKSPACE"
    apw c >"$TEMP_ROOT/context-alias.log"
    apw lp >"$TEMP_ROOT/list-alias.log"
    apw s AliasProject >"$TEMP_ROOT/switch-alias.log"
    apw up --help >"$TEMP_ROOT/upgrade-alias-help.log"
)

assert_output_contains "$TEMP_ROOT/context-alias.log" "Invocation context:" "Context alias should execute the context command"
assert_output_contains "$TEMP_ROOT/list-alias.log" "Known downstream projects:" "List-projects alias should execute project discovery"
assert_output_contains "$TEMP_ROOT/switch-alias.log" "Resolved path: $WORKSPACE/AliasProject" "Switch alias should resolve the downstream project"
assert_output_contains "$TEMP_ROOT/upgrade-alias-help.log" "apw up" "Upgrade-project alias should expose command-specific help"
pass "Locked aliases execute the intended commands"

(
    export PATH="$WORKSPACE_LAUNCHER_BIN:/usr/bin:/bin"
    cd "$WORKSPACE"
    if apw ls >"$TEMP_ROOT/bad-alias.log" 2>&1; then
        fail "Undocumented list-projects alias should not exist"
    fi
)

assert_output_contains "$TEMP_ROOT/bad-alias.log" "Error: Unknown command 'ls'." "apw lp should be the only short alias for list-projects"
pass "No conflicting short alias remains for list-projects"

(
    export PATH="$WORKSPACE_LAUNCHER_BIN:/usr/bin:/bin"
    cd "$WORKSPACE"
    if apw switch project AliasProject >"$TEMP_ROOT/deprecated-switch.log" 2>&1; then
        fail "Deprecated switch project form should not be accepted"
    fi
)

assert_output_contains "$TEMP_ROOT/deprecated-switch.log" "Error: 'apw switch project <name-or-path>' is not supported." "Deprecated switch project form should fail clearly"
assert_output_contains "$TEMP_ROOT/deprecated-switch.log" "Use: apw switch <project-name-or-path>" "Deprecated switch project form should point to the locked syntax"
pass "Deprecated switch project syntax is rejected cleanly"

echo
echo "All help and alias checks passed."
