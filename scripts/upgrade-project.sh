#!/usr/bin/env bash

set -euo pipefail

TARGET_DIR=""
PROFILE="auto"
STACK="base"
DRY_RUN=0
FORCE_MANAGED=0
RUN_VALIDATE=0

usage() {
    cat <<EOF
Usage: $0 --target <path> [--profile auto|minimal|base|advanced] [--stack value] [--dry-run] [--force-managed] [--validate]

What it does:
  - safely refreshes APW-managed surfaces in an existing downstream APW project
  - protects project-owned .gsd memory and project code
  - shows exactly what will be updated, skipped, or protected

Flags:
  --target         Downstream APW project root to upgrade
  --profile        auto (default), minimal, base, or advanced
  --stack          Stack add-on name (default: base)
  --dry-run        Preview the upgrade without changing files
  --force-managed  Refresh review-before-overwrite APW-managed files too
  --validate       Run validate.sh after the upgrade completes
EOF
}

APW_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
VALIDATE_SCRIPT="$APW_ROOT/scripts/validate.sh"
CORE_PACK_LIB="$APW_ROOT/scripts/lib/downstream_core_pack.sh"

if [[ ! -f "$CORE_PACK_LIB" ]]; then
    echo "Error: Missing downstream core pack definition: $CORE_PACK_LIB"
    exit 1
fi

# shellcheck source=/dev/null
source "$CORE_PACK_LIB"

ROOT_REVIEW_FILES=(
    "AGENTS.md"
    "COMMAND_CHEATSHEET.md"
    "PROJECT_RULES.md"
    "AGENT_SYSTEM.md"
    "COMMAND_POLICY.md"
    "PROJECT_BOOTSTRAP.md"
    "GSD-STYLE.md"
    ".gitmessage"
)

UPDATED_COUNT=0
CREATED_COUNT=0
SKIPPED_COUNT=0
UNCHANGED_COUNT=0

resolve_existing_dir() {
    local input_path="$1"

    if [[ ! -d "$input_path" ]]; then
        echo "Error: Target directory does not exist: $input_path"
        exit 1
    fi

    (cd "$input_path" && pwd -P)
}

is_downstream_project_root() {
    local candidate="$1"

    [[ -d "$candidate" ]] || return 1
    [[ -f "$candidate/AGENTS.md" ]] || return 1
    [[ -d "$candidate/.gsd" ]] || return 1
    [[ -d "$candidate/.agent" ]] || return 1
    [[ -f "$candidate/PROJECT_RULES.md" ]] || return 1

    return 0
}

detect_profile() {
    local target_dir="$1"
    local advanced_marker=""

    if [[ ! -f "$target_dir/.gsd/JOURNAL.md" || ! -f "$target_dir/.gsd/DECISIONS.md" || ! -f "$target_dir/.gsd/ARCHITECTURE.md" || ! -f "$target_dir/.gsd/STACK.md" ]]; then
        printf '%s\n' "minimal"
        return 0
    fi

    for advanced_marker in \
        ".agent/workflows/deploy.md" \
        ".agent/workflows/design.md" \
        ".agent/workflows/preview.md" \
        ".agent/workflows/ui-ux-pro-max.md" \
        ".agent/agents/database-architect.md" \
        ".agent/agents/devops-engineer.md" \
        ".agent/agents/security-auditor.md"
    do
        if [[ -f "$target_dir/$advanced_marker" ]]; then
            printf '%s\n' "advanced"
            return 0
        fi
    done

    printf '%s\n' "base"
}

print_git_warning() {
    local target_dir="$1"
    local git_status=""

    if ! command -v git >/dev/null 2>&1; then
        return 0
    fi

    if ! git -C "$target_dir" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
        echo "Safety note:"
        echo "- This repo is not currently detected as a git work tree."
        echo "- Create a manual backup or checkpoint before applying the upgrade."
        echo
        return 0
    fi

    git_status="$(git -C "$target_dir" status --short 2>/dev/null || true)"

    echo "Safety note:"
    echo "- Commit or create a checkpoint branch before upgrading."

    if [[ -n "$git_status" ]]; then
        echo "- Warning: the target repo has uncommitted changes."
    else
        echo "- Good: the target repo appears clean right now."
    fi
    echo
}

record_created() {
    CREATED_COUNT=$((CREATED_COUNT + 1))
}

record_updated() {
    UPDATED_COUNT=$((UPDATED_COUNT + 1))
}

record_skipped() {
    SKIPPED_COUNT=$((SKIPPED_COUNT + 1))
}

record_unchanged() {
    UNCHANGED_COUNT=$((UNCHANGED_COUNT + 1))
}

copy_file_if_needed() {
    local source_file="$1"
    local relative_path="$2"
    local mode="$3"
    local target_file="$TARGET_DIR/$relative_path"
    local target_dirname=""

    if [[ ! -f "$source_file" ]]; then
        echo "Error: Missing APW-managed source file: $source_file"
        exit 1
    fi

    if [[ -f "$target_file" ]] && cmp -s "$source_file" "$target_file"; then
        echo "- $relative_path (already current)"
        record_unchanged
        return 0
    fi

    if [[ ! -f "$target_file" ]]; then
        echo "- $relative_path (missing -> will restore)"
        if [[ $DRY_RUN -eq 0 ]]; then
            target_dirname="$(dirname "$target_file")"
            mkdir -p "$target_dirname"
            cp "$source_file" "$target_file"
        fi
        record_created
        return 0
    fi

    if [[ "$mode" == "auto" ]]; then
        echo "- $relative_path (APW-vendored -> will refresh)"
        if [[ $DRY_RUN -eq 0 ]]; then
            cp "$source_file" "$target_file"
        fi
        record_updated
        return 0
    fi

    if [[ $FORCE_MANAGED -eq 1 ]]; then
        echo "- $relative_path (review surface -> will refresh because --force-managed was requested)"
        if [[ $DRY_RUN -eq 0 ]]; then
            cp "$source_file" "$target_file"
        fi
        record_updated
    else
        echo "- $relative_path (review surface -> skipped by default; use --force-managed to refresh)"
        record_skipped
    fi
}

process_root_review_files() {
    local name=""
    local source_file=""

    echo "Review-before-overwrite APW-managed root files:"

    for name in "${ROOT_REVIEW_FILES[@]}"; do
        source_file="$APW_ROOT/$name"

        if [[ -f "$source_file" ]]; then
            copy_file_if_needed "$source_file" "$name" "review"
        fi
    done

    echo
}

process_core_pack() {
    local name=""

    if ! apw_profile_gets_core_downstream_pack "$PROFILE"; then
        echo "Safe auto-upgrade APW-managed downstream pack:"
        echo "- none for profile '$PROFILE'"
        echo
        return 0
    fi

    echo "Safe auto-upgrade APW-managed downstream pack:"

    for name in "${APW_CORE_DOWNSTREAM_WORKFLOWS[@]}"; do
        copy_file_if_needed "$APW_ROOT/.agent/workflows/$name.md" ".agent/workflows/$name.md" "auto"
    done

    for name in "${APW_CORE_DOWNSTREAM_AGENTS[@]}"; do
        copy_file_if_needed "$APW_ROOT/.agent/agents/$name.md" ".agent/agents/$name.md" "auto"
    done

    for name in "${APW_CORE_DOWNSTREAM_RULES[@]}"; do
        copy_file_if_needed "$APW_ROOT/.agent/rules/$name.md" ".agent/rules/$name.md" "auto"
    done

    echo
}

process_profile_review_files() {
    local profile_agent_dir="$APW_ROOT/templates/$PROFILE/.agent"
    local source_file=""
    local relative_path=""
    local found_any=0

    if [[ ! -d "$profile_agent_dir" ]]; then
        echo "Review-before-overwrite profile-managed extras:"
        echo "- none for profile '$PROFILE'"
        echo
        return 0
    fi

    echo "Review-before-overwrite profile-managed extras:"

    while IFS= read -r source_file; do
        [[ -n "$source_file" ]] || continue
        found_any=1
        relative_path="${source_file#$profile_agent_dir/}"
        copy_file_if_needed "$source_file" ".agent/$relative_path" "review"
    done < <(find "$profile_agent_dir" -type f | sort)

    if [[ $found_any -eq 0 ]]; then
        echo "- none for profile '$PROFILE'"
    fi

    echo
}

process_stack_review_files() {
    local stack_skills_dir="$APW_ROOT/templates/stack/$STACK/.agent/skills"
    local source_file=""
    local relative_path=""
    local found_any=0

    echo "Review-before-overwrite stack-managed extras:"

    if [[ "$STACK" == "base" || ! -d "$stack_skills_dir" ]]; then
        echo "- none for stack '$STACK'"
        echo
        return 0
    fi

    while IFS= read -r source_file; do
        [[ -n "$source_file" ]] || continue
        found_any=1
        relative_path="${source_file#$stack_skills_dir/}"
        copy_file_if_needed "$source_file" ".agent/skills/$relative_path" "review"
    done < <(find "$stack_skills_dir" -type f | sort)

    if [[ $found_any -eq 0 ]]; then
        echo "- none for stack '$STACK'"
    fi

    echo
}

print_protected_surfaces() {
    echo "Protected project-owned surfaces:"
    echo "- .gsd/SPEC.md"
    echo "- .gsd/TODO.md"
    echo "- .gsd/STATE.md"
    echo "- .gsd/ROADMAP.md"
    echo "- .gsd/DECISIONS.md"
    echo "- .gsd/JOURNAL.md"
    echo "- .gsd/ARCHITECTURE.md"
    echo "- .gsd/STACK.md"
    echo "- project application code"
    echo "- repo-specific implementation files outside explicitly APW-managed surfaces"
    echo
}

print_summary() {
    echo "Summary:"
    echo "- Created or restored: $CREATED_COUNT"
    echo "- Refreshed: $UPDATED_COUNT"
    echo "- Skipped for review: $SKIPPED_COUNT"
    echo "- Already current: $UNCHANGED_COUNT"
    echo
}

while [[ "$#" -gt 0 ]]; do
    case "$1" in
        --target)
            [[ $# -ge 2 ]] || { echo "Error: --target requires a value."; usage; exit 1; }
            TARGET_DIR="$2"
            shift 2
            ;;
        --profile)
            [[ $# -ge 2 ]] || { echo "Error: --profile requires a value."; usage; exit 1; }
            PROFILE="$2"
            shift 2
            ;;
        --stack)
            [[ $# -ge 2 ]] || { echo "Error: --stack requires a value."; usage; exit 1; }
            STACK="$2"
            shift 2
            ;;
        --dry-run|--plan)
            DRY_RUN=1
            shift
            ;;
        --force-managed)
            FORCE_MANAGED=1
            shift
            ;;
        --validate)
            RUN_VALIDATE=1
            shift
            ;;
        -h|--help)
            usage
            exit 0
            ;;
        *)
            echo "Error: Unknown parameter '$1'."
            usage
            exit 1
            ;;
    esac
done

if [[ -z "$TARGET_DIR" ]]; then
    echo "Error: --target is required."
    usage
    exit 1
fi

if [[ "$PROFILE" != "auto" && "$PROFILE" != "minimal" && "$PROFILE" != "base" && "$PROFILE" != "advanced" ]]; then
    echo "Error: Invalid profile '$PROFILE'. Must be auto, minimal, base, or advanced."
    exit 1
fi

TARGET_DIR="$(resolve_existing_dir "$TARGET_DIR")"

if ! is_downstream_project_root "$TARGET_DIR"; then
    echo "Error: Target is not a downstream APW project root: $TARGET_DIR"
    exit 1
fi

if [[ "$PROFILE" == "auto" ]]; then
    PROFILE="$(detect_profile "$TARGET_DIR")"
    PROFILE_NOTE="auto-detected"
else
    PROFILE_NOTE="user-specified"
fi

echo "APW downstream project upgrade"
echo "Target: $TARGET_DIR"
echo "Profile: $PROFILE ($PROFILE_NOTE)"
echo "Stack: $STACK"

if [[ $DRY_RUN -eq 1 ]]; then
    echo "Mode: dry run"
else
    echo "Mode: apply"
fi

if [[ $FORCE_MANAGED -eq 1 ]]; then
    echo "Managed review surfaces: force refresh enabled"
else
    echo "Managed review surfaces: skip by default"
fi

echo
print_git_warning "$TARGET_DIR"

echo "Upgrade model:"
echo "- Safe auto-upgrade: clearly vendored downstream core workflow/agent/rule pack"
echo "- Review-before-overwrite: APW-managed root contract files and profile/stack extras"
echo "- Never blindly overwrite: .gsd project memory and project-specific implementation files"
echo

process_core_pack
process_root_review_files
process_profile_review_files
process_stack_review_files
print_protected_surfaces
print_summary

if [[ $DRY_RUN -eq 1 ]]; then
    echo "Dry run complete."
    echo "Next:"
    echo "- Review any skipped APW-managed files."
    echo "- Re-run with --force-managed if you intentionally want to refresh those review surfaces."
    echo "- Run: $VALIDATE_SCRIPT \"$TARGET_DIR\" --profile $PROFILE --stack $STACK after a real upgrade."
    exit 0
fi

echo "Upgrade complete."
echo "Next:"
echo "- Review any files that were skipped for manual comparison."
echo "- Run: $VALIDATE_SCRIPT \"$TARGET_DIR\" --profile $PROFILE --stack $STACK"

if [[ $RUN_VALIDATE -eq 1 ]]; then
    echo
    echo "Running validation..."
    "$VALIDATE_SCRIPT" "$TARGET_DIR" --profile "$PROFILE" --stack "$STACK"
fi
