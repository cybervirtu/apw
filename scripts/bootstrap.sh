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
PROFILE_ROOT="$APW_ROOT/templates/$PROFILE"
PROFILE_GSD_DIR="$PROFILE_ROOT/.gsd"
PROFILE_AGENT_DIR="$PROFILE_ROOT/.agent"
STACK_SKILLS_DIR="$APW_ROOT/templates/stack/$STACK/.agent/skills"

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

# 4. Inject Execution Layer
# Execution-layer content is sourced from the selected profile and overwrites
# older automation/prompts so downstream repos receive the current APW contract.
echo "🔄 Syncing execution layer from template profile '$PROFILE'..."
copy_optional_tree "$PROFILE_AGENT_DIR/agents" "$TARGET_DIR/.agent/agents" ".agent/agents"
copy_optional_tree "$PROFILE_AGENT_DIR/rules" "$TARGET_DIR/.agent/rules" ".agent/rules"
copy_optional_tree "$PROFILE_AGENT_DIR/scripts" "$TARGET_DIR/.agent/scripts" ".agent/scripts"
copy_optional_tree "$PROFILE_AGENT_DIR/workflows" "$TARGET_DIR/.agent/workflows" ".agent/workflows"
copy_optional_tree "$PROFILE_AGENT_DIR/skills" "$TARGET_DIR/.agent/skills" ".agent/skills"

# 5. Inject Stack-Specific Skills
if [[ "$STACK" != "base" ]]; then
    if [[ -d "$STACK_SKILLS_DIR" ]]; then
        cp -R "$STACK_SKILLS_DIR/." "$TARGET_DIR/.agent/skills/"
        echo "✅ Injected stack skills from templates/stack/$STACK/.agent/skills"
    else
        echo "⚠️  Warning: Stack '$STACK' has no vendored skill pack under templates/stack/. Continuing without stack add-ons."
    fi
fi

# 6. Configure Git Commit Template
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
echo "   2. Start from: $TARGET_DIR/AGENTS.md"
echo "   3. Review: $APW_ROOT/docs/DOWNSTREAM_ADOPTION_GUIDE.md"
echo "   4. Initialize canonical .gsd state with a single orchestrator/governance pass before routine coding starts."
