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

advice() {
    local message="$1"
    echo "➡️  $message"
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

check_existing_file_contains_regex() {
    local path="$1"
    local label="$2"
    local regex="$3"
    local requirement="$4"
    local guidance="$5"

    if [[ ! -f "$path" ]]; then
        info "Skipping content check for missing file: $label"
        return
    fi

    if grep -Eq "$regex" "$path"; then
        pass "$label content check passed: $requirement"
    else
        fail "$label missing expected content: $requirement"
        advice "$guidance"
    fi
}

check_existing_file_not_regex() {
    local path="$1"
    local label="$2"
    local regex="$3"
    local problem="$4"
    local guidance="$5"
    local severity="${6:-warn}"
    local match

    if [[ ! -f "$path" ]]; then
        info "Skipping drift scan for missing file: $label"
        return
    fi

    match="$(grep -En "$regex" "$path" | head -n 1 || true)"
    if [[ -n "$match" ]]; then
        if [[ "$severity" == "fail" ]]; then
            fail "$label contains ownership/content drift: $problem ($match)"
        else
            warn "$label contains ownership/content drift: $problem ($match)"
        fi
        advice "$guidance"
    else
        pass "$label drift check passed: $problem not detected"
    fi
}

check_paths_not_regex() {
    local label="$1"
    local regex="$2"
    local guidance="$3"
    local severity="${4:-warn}"
    shift 4
    local match

    match="$(rg -n -e "$regex" "$@" | head -n 1 || true)"
    if [[ -n "$match" ]]; then
        if [[ "$severity" == "fail" ]]; then
            fail "$label detected: $match"
        else
            warn "$label detected: $match"
        fi
        advice "$guidance"
    else
        pass "$label not detected"
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

check_target_content_shape() {
    echo "--- Target Content Shape ---"

    check_existing_file_contains_regex \
        "$TARGET_DIR/AGENTS.md" \
        "AGENTS.md" \
        'tool-facing front door|entrypoint' \
        "entrypoint language" \
        "Restore the APW entrypoint language in AGENTS.md."

    check_existing_file_contains_regex \
        "$TARGET_DIR/AGENTS.md" \
        "AGENTS.md" \
        'PROJECT_RULES\.md|AGENT_SYSTEM\.md|COMMAND_POLICY\.md|PROJECT_BOOTSTRAP\.md' \
        "routing links into the core APW contract" \
        "Restore routing from AGENTS.md into the core APW files."

    check_existing_file_contains_regex \
        "$TARGET_DIR/.gsd/SPEC.md" \
        ".gsd/SPEC.md" \
        '(Objective|Vision|Goals|Scope|Core Requirements|Success Criteria|Acceptance Criteria)' \
        "recognizable problem/scope structure" \
        "Add or restore objective/scope/goal sections in .gsd/SPEC.md."

    check_existing_file_contains_regex \
        "$TARGET_DIR/.gsd/SPEC.md" \
        ".gsd/SPEC.md" \
        '(Status|DRAFT|FINALIZED|Last Updated|updated:|status:)' \
        "status or metadata markers" \
        "Add a status or metadata marker so SPEC.md clearly communicates lifecycle state."

    check_existing_file_contains_regex \
        "$TARGET_DIR/.gsd/ROADMAP.md" \
        ".gsd/ROADMAP.md" \
        '(Roadmap|ROADMAP|PROJECT ROADMAP)' \
        "roadmap heading" \
        "Add a clear roadmap heading to .gsd/ROADMAP.md."

    check_existing_file_contains_regex \
        "$TARGET_DIR/.gsd/ROADMAP.md" \
        ".gsd/ROADMAP.md" \
        '(Phase|Milestone|Current Phase|Phases / Milestones|Current Execution Window)' \
        "milestone or phase structure" \
        "Add milestone, phase, or execution-window sections to .gsd/ROADMAP.md."

    check_existing_file_contains_regex \
        "$TARGET_DIR/.gsd/STATE.md" \
        ".gsd/STATE.md" \
        '(State|CURRENT STATE|Project State)' \
        "state heading" \
        "Add a clear state heading to .gsd/STATE.md."

    check_existing_file_contains_regex \
        "$TARGET_DIR/.gsd/STATE.md" \
        ".gsd/STATE.md" \
        '(Current Position|Where We Are|Immediate Focus|Next Steps|Blockers|Resume point)' \
        "current-state section" \
        "Add current position, blockers, or next-step sections to .gsd/STATE.md."

    check_existing_file_contains_regex \
        "$TARGET_DIR/.gsd/TODO.md" \
        ".gsd/TODO.md" \
        '^\s*[-*] \[[ x]\]' \
        "at least one actionable checklist item" \
        "Add at least one actionable checkbox item to .gsd/TODO.md so task tracking is usable."

    check_existing_file_contains_regex \
        "$TARGET_DIR/PROJECT_RULES.md" \
        "PROJECT_RULES.md" \
        '## The APW Protocol' \
        "APW protocol heading" \
        "Restore the APW protocol section in PROJECT_RULES.md."

    check_existing_file_contains_regex \
        "$TARGET_DIR/PROJECT_RULES.md" \
        "PROJECT_RULES.md" \
        'Canonical State Ownership Rule' \
        "canonical state ownership rule" \
        "Restore the canonical state ownership rule in PROJECT_RULES.md."

    check_existing_file_contains_regex \
        "$TARGET_DIR/PROJECT_RULES.md" \
        "PROJECT_RULES.md" \
        'Execution Evidence Rule' \
        "execution evidence rule" \
        "Restore the execution evidence rule in PROJECT_RULES.md."

    check_existing_file_contains_regex \
        "$TARGET_DIR/PROJECT_RULES.md" \
        "PROJECT_RULES.md" \
        'Controlled Sync Rule' \
        "controlled canonical sync rule" \
        "Restore the controlled sync rule in PROJECT_RULES.md."

    check_existing_file_contains_regex \
        "$TARGET_DIR/AGENT_SYSTEM.md" \
        "AGENT_SYSTEM.md" \
        'Unified Workspace Architecture|Dual-Engine Model' \
        "workspace architecture / dual-engine definition" \
        "Restore the dual-engine model section in AGENT_SYSTEM.md."

    check_existing_file_contains_regex \
        "$TARGET_DIR/AGENT_SYSTEM.md" \
        "AGENT_SYSTEM.md" \
        'GSD Documentation Wins' \
        "precedence rule" \
        "Restore the GSD precedence / conflict-resolution language in AGENT_SYSTEM.md."

    check_existing_file_contains_regex \
        "$TARGET_DIR/AGENT_SYSTEM.md" \
        "AGENT_SYSTEM.md" \
        'Canonical State Synchronization' \
        "orchestrator-controlled state sync rule" \
        "Restore the canonical state synchronization language in AGENT_SYSTEM.md."

    check_existing_file_contains_regex \
        "$TARGET_DIR/AGENT_SYSTEM.md" \
        "AGENT_SYSTEM.md" \
        '\.agent/skills/' \
        "unified capability namespace reference" \
        "Restore the .agent/skills/ namespace reference in AGENT_SYSTEM.md."
}

check_source_content_contract() {
    echo "--- APW Source Content Contract ---"

    check_existing_file_contains_regex \
        "$APW_ROOT/AGENTS.md" \
        "APW source AGENTS.md" \
        'tool-facing front door|entrypoint' \
        "entrypoint language" \
        "Add front-door entrypoint language to AGENTS.md."

    check_existing_file_contains_regex \
        "$APW_ROOT/AGENTS.md" \
        "APW source AGENTS.md" \
        'PROJECT_RULES\.md|AGENT_SYSTEM\.md|COMMAND_POLICY\.md|PROJECT_BOOTSTRAP\.md' \
        "routing into the APW contract" \
        "Route AGENTS.md into PROJECT_RULES.md, AGENT_SYSTEM.md, COMMAND_POLICY.md, and PROJECT_BOOTSTRAP.md."

    check_existing_file_contains_regex \
        "$APW_ROOT/PROJECT_RULES.md" \
        "APW source PROJECT_RULES.md" \
        'Canonical State Ownership Rule' \
        "canonical state ownership rule" \
        "Add the orchestrator-controlled ownership rule to APW source PROJECT_RULES.md."

    check_existing_file_contains_regex \
        "$APW_ROOT/PROJECT_RULES.md" \
        "APW source PROJECT_RULES.md" \
        'Execution Evidence Rule' \
        "execution evidence rule" \
        "Add execution-evidence guidance to APW source PROJECT_RULES.md."

    check_existing_file_contains_regex \
        "$APW_ROOT/PROJECT_RULES.md" \
        "APW source PROJECT_RULES.md" \
        'Controlled Sync Rule' \
        "controlled sync rule" \
        "Add controlled canonical sync guidance to APW source PROJECT_RULES.md."

    check_existing_file_contains_regex \
        "$APW_ROOT/AGENT_SYSTEM.md" \
        "APW source AGENT_SYSTEM.md" \
        'Canonical State Synchronization' \
        "canonical state synchronization rule" \
        "Add canonical state synchronization ownership to AGENT_SYSTEM.md."

    check_existing_file_contains_regex \
        "$APW_ROOT/AGENT_SYSTEM.md" \
        "APW source AGENT_SYSTEM.md" \
        'Evidence Logging' \
        "bounded JOURNAL evidence rule" \
        "Add execution evidence logging guidance to AGENT_SYSTEM.md."

    check_existing_file_contains_regex \
        "$APW_ROOT/COMMAND_POLICY.md" \
        "APW source COMMAND_POLICY.md" \
        'canonical state sync|Canonical state synchronization' \
        "command-level canonical state sync rule" \
        "Add canonical state sync command ownership guidance to COMMAND_POLICY.md."

    check_existing_file_contains_regex \
        "$APW_ROOT/COMMAND_POLICY.md" \
        "APW source COMMAND_POLICY.md" \
        'Execution commands may append bounded evidence to `?\.gsd/JOURNAL\.md`?' \
        "execution evidence ownership note" \
        "Add JOURNAL evidence ownership guidance to COMMAND_POLICY.md."

    check_existing_file_contains_regex \
        "$APW_ROOT/docs/TEMPLATE_STRUCTURE.md" \
        "APW source docs/TEMPLATE_STRUCTURE.md" \
        'Orchestrator / governance sync' \
        "orchestrator-governed lifecycle update rules" \
        "Clarify controlled lifecycle file ownership in docs/TEMPLATE_STRUCTURE.md."

    check_existing_file_contains_regex \
        "$APW_ROOT/docs/TEMPLATE_STRUCTURE.md" \
        "APW source docs/TEMPLATE_STRUCTURE.md" \
        'Execution agents may append bounded evidence' \
        "bounded JOURNAL evidence guidance" \
        "Clarify JOURNAL evidence ownership in docs/TEMPLATE_STRUCTURE.md."
}

check_source_ownership_drift() {
    echo "--- APW Source Ownership Drift ---"

    check_paths_not_regex \
        "Direct execution-agent STATE.md finalize guidance" \
        'Finalize: Update \.gsd/STATE\.md|update `?\.gsd/STATE\.md`? and commit' \
        "Remove direct execution-agent STATE.md finalize language and route canonical sync through orchestrator/governance." \
        fail \
        "$APW_ROOT/PROJECT_RULES.md" \
        "$APW_ROOT/AGENT_SYSTEM.md" \
        "$APW_ROOT/COMMAND_POLICY.md" \
        "$APW_ROOT/docs/TOOLING_GUIDE.md" \
        "$APW_ROOT/docs/TEMPLATE_STRUCTURE.md" \
        "$APW_ROOT/docs/PILOT_ADOPTION_PLAN.md" \
        "$APW_ROOT/docs/MONOREPO_ADAPTATION.md"

    check_paths_not_regex \
        "Execution-agent TODO.md promotion guidance" \
        'micro-tasks in \.gsd/TODO\.md|update \.gsd/TODO\.md as tasks are planned and completed' \
        "Remove language that lets routine execution agents directly promote canonical TODO state." \
        fail \
        "$APW_ROOT/AGENT_SYSTEM.md" \
        "$APW_ROOT/docs/TEMPLATE_STRUCTURE.md" \
        "$APW_ROOT/docs/TOOLING_GUIDE.md"

    check_paths_not_regex \
        "Casual STATE.md dump guidance" \
        'dump the final state to .*STATE\.md|STATE\.md at the end of the day' \
        "Route session-end state writeback through JOURNAL evidence plus an orchestrator/governance sync." \
        warn \
        "$APW_ROOT/docs/TOOLING_GUIDE.md" \
        "$APW_ROOT/docs/PILOT_ADOPTION_PLAN.md" \
        "$APW_ROOT/docs/MONOREPO_ADAPTATION.md"
}

check_target_ownership_drift() {
    echo "--- Target Ownership Drift ---"

    check_existing_file_not_regex \
        "$TARGET_DIR/PROJECT_RULES.md" \
        "PROJECT_RULES.md" \
        'update `?\.gsd/STATE\.md`? at the end of the day|dump the final state to .*STATE\.md|update \.gsd/STATE\.md and commit' \
        "direct execution-agent STATE.md write guidance" \
        "Remove direct STATE.md write instructions from target governance docs and rely on orchestrator/governance sync." \
        warn

    check_existing_file_not_regex \
        "$TARGET_DIR/AGENT_SYSTEM.md" \
        "AGENT_SYSTEM.md" \
        'Update `?\.gsd/STATE\.md`?|micro-tasks in \.gsd/TODO\.md' \
        "stale direct-write or TODO-promotion guidance" \
        "Sync AGENT_SYSTEM.md from the current APW source so execution agents stop at JOURNAL evidence and orchestrator-controlled sync." \
        warn
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
check_source_file "AGENTS.md"
check_source_file "AGENT_SYSTEM.md"
check_source_file "ARCHITECTURE.md"
check_source_file "GSD-STYLE.md"
check_source_file "PROJECT_RULES.md"
check_source_file "COMMAND_POLICY.md"
check_source_file "FILE_CONVENTIONS.md"
check_source_file "PROJECT_BOOTSTRAP.md"
check_source_file "SKILL_CURATION.md"
check_source_file "templates/README.md"
check_source_file "docs/COMPATIBILITY_MODEL.md"
check_source_file "docs/CODEX_COMPATIBILITY.md"
check_source_file "docs/ANTIGRAVITY_COMPATIBILITY.md"
check_source_file "docs/COMMAND_INVOCATION_GUIDE.md"
check_source_file "docs/WORKFLOW_SELECTION_GUIDE.md"
check_source_file "docs/AGENT_PLUS_WORKFLOW_EXAMPLES.md"
check_source_file "docs/APW_FOR_BEGINNERS.md"
check_source_file "docs/APW_VISUAL_OVERVIEW.md"
check_source_file "docs/IDEA_TO_PROJECT_GUIDE.md"
check_source_file "docs/TECH_STACK_SELECTION_GUIDE.md"
check_source_file "docs/REAL_WORLD_EXAMPLES.md"
check_source_file "docs/START_HERE.md"
check_source_file "docs/DOCS_SOURCE_OF_TRUTH.md"
check_source_file "docs/APW_HANDBOOK.md"
check_source_file "docs/QUICK_START.md"
check_source_file "docs/GLOSSARY.md"
check_source_file "docs/ARCHITECTURE_OVERVIEW.md"
check_source_file "docs/DIAGRAMS.md"
check_source_file "docs/HOW_APW_WORKS.md"
check_source_file "docs/FIRST_PROJECT_WALKTHROUGH.md"
check_source_file "docs/OPERATING_MODEL.md"
check_source_file "docs/FEATURES_AND_MODES.md"
check_source_file "docs/COMMON_WORKFLOWS.md"
check_source_file "docs/REAL_WORLD_SCENARIOS.md"
check_source_file "docs/WORKFLOW_REFERENCE.md"
check_source_file "docs/USE_CASES_AND_EXAMPLES.md"
check_source_file "docs/TEAM_ADOPTION_GUIDE.md"
check_source_file "docs/FAQ.md"
check_source_file "docs/TEMPLATE_STRUCTURE.md"
check_source_file "docs/TOOLING_GUIDE.md"
check_source_file "docs/CI_CD_ENFORCEMENT.md"
check_source_file "docs/DOWNSTREAM_ADOPTION_GUIDE.md"
check_source_file "docs/DOWNSTREAM_COMPLIANCE_CHECKLIST.md"
check_source_file "docs/EXISTING_REPO_MIGRATION_GUIDE.md"
check_source_file "docs/PROJECT_INSTANTIATION_PROMPT.md"
check_source_file "docs/PILOT_ADOPTION_PLAN.md"
check_source_file "docs/MONOREPO_ADAPTATION.md"
check_source_file "docs/UPGRADE_STRATEGY.md"
check_source_file "website/package.json"
check_source_file "website/package-lock.json"
check_source_file "website/.gitignore"
check_source_file "website/next.config.mjs"
check_source_file "website/theme.config.jsx"
check_source_file "website/README.md"
check_source_file "website/pages/index.mdx"
check_source_file "website/pages/_meta.js"
check_source_file "website/pages/start-here.mdx"
check_source_file "website/pages/what-is-apw.mdx"
check_source_file "website/pages/idea-to-project.mdx"
check_source_file "website/pages/profiles-and-stack-selection.mdx"
check_source_file "website/pages/real-world-examples.mdx"
check_source_file "website/pages/commands-and-workflows.mdx"
check_source_file "website/pages/team-migration-and-adoption.mdx"
check_source_file "website/pages/reference/index.mdx"
check_source_file "website/pages/reference/_meta.js"
check_source_file "website/pages/reference/core-governance.mdx"
check_source_file "website/pages/reference/compatibility-and-migration.mdx"
check_source_file "website/pages/reference/validation-and-ci.mdx"
check_source_file "scripts/bootstrap.sh"
check_source_file "scripts/ci-validate.sh"
check_source_file "scripts/validate.sh"
check_source_file "examples/github/apw-validate.yml"
check_source_content_contract
check_source_ownership_drift

echo "--- Target Root Governance ---"
check_target_file "AGENTS.md"
check_target_file "PROJECT_RULES.md"
check_target_file "AGENT_SYSTEM.md"
check_target_file "COMMAND_POLICY.md"
check_target_file "PROJECT_BOOTSTRAP.md"
check_target_file "GSD-STYLE.md"
check_target_file ".gitmessage"

echo "--- Target Lifecycle Memory ---"
check_target_dir ".gsd"
require_template_files "$PROFILE_GSD_DIR" ".gsd" ".gsd lifecycle"
check_target_content_shape

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
    warn "Alternate Antigravity-style layout detected: .agents/ exists. APW's current contract still uses .agent/ unless an explicit migration plan says otherwise."
else
    pass "No unplanned .agents/ alternate layout detected"
fi

if [[ -d "$TARGET_DIR/.agents/skills" ]]; then
    warn "Alternate Antigravity-style capability path detected: .agents/skills/ exists. APW's current contract still uses .agent/skills/ unless an explicit migration plan says otherwise."
else
    pass "No unplanned .agents/skills/ alternate layout detected"
fi

if [[ "$PROFILE" == "advanced" ]]; then
    warn_legacy_advanced_gsd_files
fi

check_target_ownership_drift

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
