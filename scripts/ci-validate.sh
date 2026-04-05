#!/usr/bin/env bash

# APW CI Validate Wrapper
# Runs the canonical APW validator in CI-friendly mode without reimplementing
# the compliance logic outside validate.sh.

set -euo pipefail

TARGET_DIR="."
PROFILE="${APW_PROFILE:-base}"
STACK="${APW_STACK:-base}"
FAIL_ON_WARNINGS="${APW_FAIL_ON_WARNINGS:-0}"

usage() {
    echo "Usage: $0 [target] [--profile base|minimal|advanced] [--stack value] [--fail-on-warnings]"
    echo "  target            : Repository to validate (default: current directory)"
    echo "  --profile         : APW bootstrap profile to validate against (default: APW_PROFILE or base)"
    echo "  --stack           : Optional stack add-on name (default: APW_STACK or base)"
    echo "  --fail-on-warnings: Exit non-zero when validator warnings are present"
}

while [[ "$#" -gt 0 ]]; do
    case "$1" in
        --profile)
            [[ $# -ge 2 ]] || { echo "❌ Error: --profile requires a value."; usage; exit 1; }
            PROFILE="$2"
            shift 2
            ;;
        --stack)
            [[ $# -ge 2 ]] || { echo "❌ Error: --stack requires a value."; usage; exit 1; }
            STACK="$2"
            shift 2
            ;;
        --fail-on-warnings)
            FAIL_ON_WARNINGS=1
            shift
            ;;
        -h|--help)
            usage
            exit 0
            ;;
        --*)
            echo "❌ Error: Unknown flag '$1'."
            usage
            exit 1
            ;;
        *)
            if [[ "$TARGET_DIR" != "." ]]; then
                echo "❌ Error: Multiple target directories provided."
                usage
                exit 1
            fi
            TARGET_DIR="$1"
            shift
            ;;
    esac
done

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VALIDATE_SCRIPT="$SCRIPT_DIR/validate.sh"

if [[ ! -x "$VALIDATE_SCRIPT" ]]; then
    echo "❌ Error: APW validator not found or not executable: $VALIDATE_SCRIPT"
    exit 1
fi

set +e
VALIDATION_OUTPUT="$("$VALIDATE_SCRIPT" "$TARGET_DIR" --profile "$PROFILE" --stack "$STACK" 2>&1)"
VALIDATION_STATUS=$?
set -e

printf '%s\n' "$VALIDATION_OUTPUT"

FAILURES="$(printf '%s\n' "$VALIDATION_OUTPUT" | sed -n 's/^Failures:[[:space:]]*//p' | tail -n 1)"
WARNINGS="$(printf '%s\n' "$VALIDATION_OUTPUT" | sed -n 's/^Warnings:[[:space:]]*//p' | tail -n 1)"

FAILURES="${FAILURES:-unknown}"
WARNINGS="${WARNINGS:-unknown}"

if [[ -n "${GITHUB_STEP_SUMMARY:-}" ]]; then
    {
        echo "## APW CI Validation"
        echo
        echo "- Target: \`$TARGET_DIR\`"
        echo "- Profile: \`$PROFILE\`"
        echo "- Stack: \`$STACK\`"
        echo "- Failures: \`$FAILURES\`"
        echo "- Warnings: \`$WARNINGS\`"
        echo "- Warning policy: \`fail-on-warnings=$FAIL_ON_WARNINGS\`"
    } >> "$GITHUB_STEP_SUMMARY"
fi

if [[ $VALIDATION_STATUS -ne 0 ]]; then
    echo "❌ APW CI enforcement failed because the validator reported hard failures."
    echo "➡️  Fix the required files, content-shape errors, or profile/namespace drift above, then re-run CI."
    exit "$VALIDATION_STATUS"
fi

if [[ "$FAIL_ON_WARNINGS" == "1" && "$WARNINGS" != "0" && "$WARNINGS" != "unknown" ]]; then
    echo "❌ APW CI enforcement failed because warnings are configured as blocking in this workflow."
    echo "➡️  Clean up the warning-level drift above or set APW_FAIL_ON_WARNINGS=0 if this repo intentionally uses warning-only enforcement."
    exit 2
fi

if [[ "$WARNINGS" != "0" && "$WARNINGS" != "unknown" ]]; then
    echo "⚠️  APW CI enforcement passed with warnings."
    echo "➡️  Review the warnings above. They do not block by default, but they still indicate drift worth fixing."
else
    echo "🎉 APW CI enforcement passed with no warnings."
fi
