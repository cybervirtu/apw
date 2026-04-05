#!/usr/bin/env bash

# APW Validate Script
# Verifies that a target repository complies with the current APW standard.

set -euo pipefail

TARGET_DIR="."
PROFILE="base"
STACK="base"
FAILS=0
WARNS=0
CHECKS=0

usage() {
    echo "Usage: $0 [target] [--profile base|minimal|advanced] [--stack value]"
    echo "  target   : Repository to validate (default: current directory)"
    echo "  --profile: APW bootstrap profile to validate against (default: base)"
    echo "  --stack  : Optional stack add-on name for skill checks (default: base)"
}

pass() {
    local message="$1"
    CHECKS=$((CHECKS + 1))
    echo "✅ $message"
}

fail() {
    local message="$1"
    CHECKS=$((CHECKS + 1))
    FAILS=$((FAILS + 1))
    echo "❌ $message"
}

warn() {
    local message="$1"
    CHECKS=$((CHECKS + 1))
    WARNS=$((WARNS + 1))
    echo "⚠️  $message"
}

info() {
    local message="$1"
    echo "ℹ️  $message"
}

check_source_file() {
    local path="$1"
    if [[ -f "$APW_ROOT/$path" ]]; then
        pass "APW source contract file present: $path"
    else
        fail "APW source contract file missing: $path"
    fi
}

check_target_file() {
    local path="$1"
    if [[ -f "$TARGET_DIR/$path" ]]; then
        pass "Required file present: $path"
    else
        fail "Required file missing: $path"
    fi
}

check_target_dir() {
    local path="$1"
    if [[ -d "$TARGET_DIR/$path" ]]; then
        pass "Required directory present: $path"
    else
        fail "Required directory missing: $path"
    fi
}

require_template_files() {
    local source_dir="$1"
    local target_dir="$2"
    local label="$3"
    local found_any=0

    if [[ ! -d "$source_dir" ]]; then
        info "No vendored $label directory for profile '$PROFILE'. Directory-only validation applied."
        return
    fi

    while IFS= read -r -d '' source_file; do
        local rel_path="${source_file#$source_dir/}"
        local target_file="$TARGET_DIR/$target_dir/$rel_path"
        found_any=1

        if [[ -f "$target_file" ]]; then
            pass "$label file present: $target_dir/$rel_path"
        else
            fail "$label file missing: $target_dir/$rel_path"
        fi
    done < <(find "$source_dir" -type f -print0 | sort -z)

    if [[ $found_any -eq 0 ]]; then
        info "No vendored $label files defined for profile '$PROFILE'. Directory-only validation applied."
    fi
}

warn_legacy_advanced_gsd_files() {
    local found_any=0
    local legacy_files=(
        "CONTEXT.md"
        "DEBUG.md"
        "DISCOVERY.md"
        "MILESTONE.md"
        "PHASE-SUMMARY.md"
        "PLAN.md"
        "PROJECT.md"
        "REQUIREMENTS.md"
        "RESEARCH.md"
        "SPRINT.md"
        "STATE_SNAPSHOT.md"
        "SUMMARY.md"
        "TOKEN_REPORT.md"
        "UAT.md"
        "USER-SETUP.md"
        "VERIFICATION.md"
    )

    for file in "${legacy_files[@]}"; do
        if [[ -f "$TARGET_DIR/.gsd/$file" ]]; then
            found_any=1
            warn "Legacy advanced .gsd fragmentation file detected: .gsd/$file. Consolidate live content into ROADMAP.md, STATE.md, TODO.md, or JOURNAL.md."
        fi
    done

    if [[ $found_any -eq 0 ]]; then
        pass "No legacy advanced root .gsd fragmentation files detected"
    fi
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

if [[ "$PROFILE" != "base" && "$PROFILE" != "minimal" && "$PROFILE" != "advanced" ]]; then
    echo "❌ Error: Invalid profile '$PROFILE'. Must be base, minimal, or advanced."
    exit 1
fi

APW_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PROFILE_ROOT="$APW_ROOT/templates/$PROFILE"
PROFILE_GSD_DIR="$PROFILE_ROOT/.gsd"
PROFILE_AGENT_DIR="$PROFILE_ROOT/.agent"
STACK_SKILLS_DIR="$APW_ROOT/templates/stack/$STACK/.agent/skills"

if [[ ! -d "$TARGET_DIR" ]]; then
    echo "❌ Error: Target directory does not exist: $TARGET_DIR"
    exit 1
fi

if [[ ! -d "$PROFILE_ROOT" ]]; then
    echo "❌ Error: Missing template profile in APW source: $PROFILE_ROOT"
    exit 1
fi

if [[ ! -d "$PROFILE_GSD_DIR" ]]; then
    echo "❌ Error: Missing lifecycle template directory in APW source: $PROFILE_GSD_DIR"
    exit 1
fi

echo "🔍 Validating APW compliance in $TARGET_DIR"
echo "   Profile: $PROFILE"
echo "   Stack: $STACK"

echo "--- APW Source Contract ---"
check_source_file "README.md"
check_source_file "AGENT_SYSTEM.md"
check_source_file "ARCHITECTURE.md"
check_source_file "GSD-STYLE.md"
check_source_file "PROJECT_RULES.md"
check_source_file "COMMAND_POLICY.md"
check_source_file "FILE_CONVENTIONS.md"
check_source_file "PROJECT_BOOTSTRAP.md"
check_source_file "SKILL_CURATION.md"
check_source_file "templates/README.md"
check_source_file "docs/TEMPLATE_STRUCTURE.md"
check_source_file "docs/TOOLING_GUIDE.md"
check_source_file "docs/CI_CD_ENFORCEMENT.md"
check_source_file "docs/PROJECT_INSTANTIATION_PROMPT.md"
check_source_file "docs/PILOT_ADOPTION_PLAN.md"
check_source_file "docs/MONOREPO_ADAPTATION.md"
check_source_file "docs/UPGRADE_STRATEGY.md"
check_source_file "scripts/bootstrap.sh"
check_source_file "scripts/validate.sh"

echo "--- Target Root Governance ---"
check_target_file "PROJECT_RULES.md"
check_target_file "AGENT_SYSTEM.md"
check_target_file "GSD-STYLE.md"
check_target_file ".gitmessage"

echo "--- Target Lifecycle Memory ---"
check_target_dir ".gsd"
require_template_files "$PROFILE_GSD_DIR" ".gsd" ".gsd lifecycle"

echo "--- Target Execution Namespace ---"
check_target_dir ".agent"
check_target_dir ".agent/agents"
check_target_dir ".agent/rules"
check_target_dir ".agent/scripts"
check_target_dir ".agent/workflows"
check_target_dir ".agent/skills"

require_template_files "$PROFILE_AGENT_DIR/agents" ".agent/agents" ".agent/agents"
require_template_files "$PROFILE_AGENT_DIR/rules" ".agent/rules" ".agent/rules"
require_template_files "$PROFILE_AGENT_DIR/scripts" ".agent/scripts" ".agent/scripts"
require_template_files "$PROFILE_AGENT_DIR/workflows" ".agent/workflows" ".agent/workflows"
require_template_files "$PROFILE_AGENT_DIR/skills" ".agent/skills" ".agent/skills"

if [[ "$STACK" != "base" ]]; then
    if [[ -d "$STACK_SKILLS_DIR" ]]; then
        require_template_files "$STACK_SKILLS_DIR" ".agent/skills" "stack skill"
    else
        warn "Requested stack '$STACK' has no vendored skill pack in APW source. Stack-specific skill validation skipped."
    fi
fi

echo "--- Drift Checks ---"
if [[ -d "$TARGET_DIR/.agents" ]]; then
    warn "Legacy namespace drift detected: .agents/ exists. APW contract uses only .agent/."
else
    pass "No legacy .agents/ directory detected"
fi

if [[ -d "$TARGET_DIR/.agents/skills" ]]; then
    warn "Legacy capability path detected: .agents/skills/ exists. Use .agent/skills/ instead."
else
    pass "No legacy .agents/skills/ directory detected"
fi

if [[ "$PROFILE" == "advanced" ]]; then
    warn_legacy_advanced_gsd_files
fi

echo "--- Summary ---"
echo "Checks run: $CHECKS"
echo "Failures:   $FAILS"
echo "Warnings:   $WARNS"

if [[ $FAILS -gt 0 ]]; then
    echo "⚠️  Validation failed."
    echo "    Fix the missing required files/directories above, then re-run:"
    echo "    $APW_ROOT/scripts/validate.sh \"$TARGET_DIR\" --profile $PROFILE --stack $STACK"
    exit 1
fi

if [[ $WARNS -gt 0 ]]; then
    echo "✅ Validation passed with warnings."
    echo "   Review the warnings above to reduce drift or clarify optional profile content."
    exit 0
fi

echo "🎉 Validation passed: repository matches the current APW contract."
exit 0
