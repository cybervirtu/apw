#!/usr/bin/env bash

# APW Validate Script
# Verifies that a repository complies with the APW workspace standard.

TARGET_DIR="${1:-.}"
FAILS=0

echo "🔍 Validating APW compliance in $TARGET_DIR..."

check_file() {
    if [[ ! -f "$TARGET_DIR/$1" ]]; then
        echo "❌ Missing: $1"
        FAILS=$((FAILS + 1))
    else
        echo "✅ Found:   $1"
    fi
}

echo "--- Root Governance ---"
check_file "PROJECT_RULES.md"
check_file "AGENT_SYSTEM.md"
check_file "GSD-STYLE.md"

echo "--- Lifecycle Memory ---"
check_file ".gsd/SPEC.md"
check_file ".gsd/ROADMAP.md"
check_file ".gsd/STATE.md"
check_file ".gsd/TODO.md"

echo "--- Intelligence Layer ---"
if [[ -d "$TARGET_DIR/.agent/workflows" && "$(ls -A "$TARGET_DIR/.agent/workflows")" ]]; then
    echo "✅ Found:   .agent/workflows populated"
else
    echo "❌ Missing: .agent/workflows is empty or does not exist"
    FAILS=$((FAILS + 1))
fi

if [[ $FAILS -gt 0 ]]; then
    echo "⚠️ Validation Failed: $FAILS required items are missing."
    exit 1
else
    echo "🎉 Validation Passed: Repository is fully APW compliant."
    exit 0
fi
