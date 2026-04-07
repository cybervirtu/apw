#!/usr/bin/env bash

# APW Bootstrap Script
# Initializes or upgrades a target repository with the APW standard.

set -euo pipefail

TARGET_DIR="."
PROFILE="base"
STACK="base"
FORCE=0

usage() {
    echo "Usage: $0 [--target value] [--profile base|minimal|advanced] [--stack value] [--force]"
    echo "  --target : Directory to initialize or upgrade (default: current directory)"
    echo "  --profile: Template profile to apply from ./templates (default: base)"
    echo "  --stack  : Optional stack add-on under ./templates/stack (default: base)"
    echo "  --force  : Overwrite existing .gsd lifecycle files in target"
}

copy_optional_tree() {
    local source_dir="$1"
    local target_dir="$2"
    local label="$3"
    local source_display

    if [[ -d "$source_dir" ]]; then
        source_display="${source_dir#$APW_ROOT/}"
        cp -R "$source_dir/." "$target_dir/"
        echo "✅ Synced $label from $source_display"
    else
        echo "ℹ️  No $label defined for profile '$PROFILE'. Leaving $target_dir as-is."
    fi
}

copy_required_markdown_set() {
    local source_dir="$1"
    local target_dir="$2"
    local label="$3"
    shift 3

    local name
    local source_file

    for name in "$@"; do
        source_file="$source_dir/$name.md"

        if [[ ! -f "$source_file" ]]; then
            echo "❌ Error: Missing canonical $label source: ${source_file#$APW_ROOT/}"
            exit 1
        fi

        cp "$source_file" "$target_dir/$name.md"
        echo "✅ Vendored $label: ${target_dir#$TARGET_DIR/}/$name.md"
    done
}

# Parse arguments
while [[ "$#" -gt 0 ]]; do
    case "$1" in
        --target)
            [[ $# -ge 2 ]] || { echo "❌ Error: --target requires a value."; usage; exit 1; }
            TARGET_DIR="$2"
            shift 2
            ;;
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
        --force)
            FORCE=1
            shift
            ;;
        -h|--help)
            usage
            exit 0
            ;;
        *)
            echo "❌ Error: Unknown parameter '$1'."
            usage
            exit 1
            ;;
    esac
done

if [[ "$PROFILE" != "base" && "$PROFILE" != "minimal" && "$PROFILE" != "advanced" ]]; then
    echo "❌ Error: Invalid profile '$PROFILE'. Must be base, minimal, or advanced."
    exit 1
fi

APW_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
VALIDATE_SCRIPT="$APW_ROOT/scripts/validate.sh"
CORE_PACK_LIB="$APW_ROOT/scripts/lib/downstream_core_pack.sh"
PROFILE_ROOT="$APW_ROOT/templates/$PROFILE"
PROFILE_GSD_DIR="$PROFILE_ROOT/.gsd"
PROFILE_AGENT_DIR="$PROFILE_ROOT/.agent"
STACK_SKILLS_DIR="$APW_ROOT/templates/stack/$STACK/.agent/skills"

if [[ ! -f "$CORE_PACK_LIB" ]]; then
    echo "❌ Error: Missing downstream core pack definition: $CORE_PACK_LIB"
    exit 1
fi

# shellcheck source=/dev/null
source "$CORE_PACK_LIB"

if [[ ! -d "$PROFILE_ROOT" ]]; then
    echo "❌ Error: Missing template profile directory: $PROFILE_ROOT"
    exit 1
fi

if [[ ! -d "$PROFILE_GSD_DIR" ]]; then
    echo "❌ Error: Missing lifecycle template directory: $PROFILE_GSD_DIR"
    exit 1
fi

echo "🚀 Bootstrapping APW Standard ($PROFILE profile, stack=$STACK) into $TARGET_DIR..."

# 1. Create Directory Structure
mkdir -p "$TARGET_DIR/.gsd"
mkdir -p "$TARGET_DIR/.agent/agents"
mkdir -p "$TARGET_DIR/.agent/rules"
mkdir -p "$TARGET_DIR/.agent/scripts"
mkdir -p "$TARGET_DIR/.agent/workflows"
mkdir -p "$TARGET_DIR/.agent/skills"
mkdir -p "$TARGET_DIR/docs"

echo "✅ Created APW directory structure."

# 2. Copy Root Entrypoint and Operating Files
# These are always overwritten to keep the APW contract current.
cp "$APW_ROOT/AGENTS.md" "$TARGET_DIR/"
cp "$APW_ROOT/PROJECT_RULES.md" "$TARGET_DIR/"
cp "$APW_ROOT/AGENT_SYSTEM.md" "$TARGET_DIR/"
cp "$APW_ROOT/COMMAND_POLICY.md" "$TARGET_DIR/"
cp "$APW_ROOT/PROJECT_BOOTSTRAP.md" "$TARGET_DIR/"
cp "$APW_ROOT/GSD-STYLE.md" "$TARGET_DIR/"

echo "✅ Applied root APW entrypoint and operating files."

# 3. Copy GSD Lifecycle Templates
# Existing lifecycle files are preserved unless --force is supplied.
for file in "$PROFILE_GSD_DIR"/*; do
    [[ -f "$file" ]] || continue

    basename="$(basename "$file")"
    target_file="$TARGET_DIR/.gsd/$basename"

    if [[ -f "$target_file" && $FORCE -eq 0 ]]; then
        echo "⏭️ Skipping existing lifecycle file: $basename (use --force to overwrite)"
    else
        cp "$file" "$target_file"
        echo "✅ Applied lifecycle file: $basename"
    fi
done

# 4. Inject Shared Downstream Command Pack
if apw_profile_gets_core_downstream_pack "$PROFILE"; then
    echo "🔄 Syncing shared downstream command pack for profile '$PROFILE'..."
    copy_required_markdown_set "$APW_ROOT/.agent/workflows" "$TARGET_DIR/.agent/workflows" "core workflow" "${APW_CORE_DOWNSTREAM_WORKFLOWS[@]}"
    copy_required_markdown_set "$APW_ROOT/.agent/agents" "$TARGET_DIR/.agent/agents" "core agent" "${APW_CORE_DOWNSTREAM_AGENTS[@]}"
    copy_required_markdown_set "$APW_ROOT/.agent/rules" "$TARGET_DIR/.agent/rules" "core rule" "${APW_CORE_DOWNSTREAM_RULES[@]}"
else
    echo "ℹ️  Profile '$PROFILE' does not receive the shared downstream command pack."
fi

# 5. Inject Profile-Specific Execution Layer
# Profile-local execution-layer content overwrites older prompts/workflows when
# present so downstream repos receive the current APW contract plus profile extras.
echo "🔄 Syncing profile-specific execution layer from template profile '$PROFILE'..."
copy_optional_tree "$PROFILE_AGENT_DIR/agents" "$TARGET_DIR/.agent/agents" ".agent/agents"
copy_optional_tree "$PROFILE_AGENT_DIR/rules" "$TARGET_DIR/.agent/rules" ".agent/rules"
copy_optional_tree "$PROFILE_AGENT_DIR/scripts" "$TARGET_DIR/.agent/scripts" ".agent/scripts"
copy_optional_tree "$PROFILE_AGENT_DIR/workflows" "$TARGET_DIR/.agent/workflows" ".agent/workflows"
copy_optional_tree "$PROFILE_AGENT_DIR/skills" "$TARGET_DIR/.agent/skills" ".agent/skills"

# 6. Inject Stack-Specific Skills
if [[ "$STACK" != "base" ]]; then
    if [[ -d "$STACK_SKILLS_DIR" ]]; then
        cp -R "$STACK_SKILLS_DIR/." "$TARGET_DIR/.agent/skills/"
        echo "✅ Injected stack skills from templates/stack/$STACK/.agent/skills"
    else
        echo "⚠️  Warning: Stack '$STACK' has no vendored skill pack under templates/stack/. Continuing without stack add-ons."
    fi
fi

# 7. Configure Git Commit Template
if [[ -f "$APW_ROOT/.gitmessage" ]]; then
    cp "$APW_ROOT/.gitmessage" "$TARGET_DIR/"
    if [[ -d "$TARGET_DIR/.git" ]]; then
        (cd "$TARGET_DIR" && git config commit.template .gitmessage)
        echo "✅ Configured Git commit template."
    else
        echo "ℹ️  No .git directory found in target; skipped git config."
    fi
fi

echo "🎉 Bootstrap complete."
echo "   Target: $TARGET_DIR"
echo "   Profile: $PROFILE"
echo "   Stack: $STACK"
echo "   Force lifecycle overwrite: $FORCE"
echo "   Next steps:"
echo "   1. Validate: $VALIDATE_SCRIPT \"$TARGET_DIR\" --profile $PROFILE --stack $STACK"
echo "   2. Generate first drafts of core project state: $APW_ROOT/scripts/init-project-state.sh --target \"$TARGET_DIR\""
echo "   3. Use the core workflows directly in $TARGET_DIR/.agent/workflows for base/advanced repos."
echo "   4. Start from: $TARGET_DIR/AGENTS.md"
echo "   5. Review: $APW_ROOT/docs/DOWNSTREAM_ADOPTION_GUIDE.md"
echo "   6. Keep canonical .gsd summary files under deliberate orchestrator/governance control as the project evolves."
