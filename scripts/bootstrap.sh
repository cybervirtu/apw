#!/usr/bin/env bash

# APW Bootstrap Script
# Initializes or upgrades a target repository with the APW standard.

set -e

# Default values
TARGET_DIR="."
STACK="base"
FORCE=0

# Parse arguments
while [[ "$#" -gt 0 ]]; do
    case $1 in
        --target) TARGET_DIR="$2"; shift ;;
        --stack) STACK="$2"; shift ;;
        --force) FORCE=1 ;;
        -h|--help)
            echo "Usage: $0 [--target value] [--stack value] [--force]"
            echo "  --target: Directory to initialize (default: current directory)"
            echo "  --stack : Add-on stack to install (e.g., react, fastapi)"
            echo "  --force : Overwrite existing GSD lifecycle files"
            exit 0
            ;;
        *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
done

echo "🚀 Bootstrapping APW Standard into $TARGET_DIR..."

# Source directory (assume script is run from apw root or adjust accordingly)
APW_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# 1. Create Directory Structure
mkdir -p "$TARGET_DIR/.gsd"
mkdir -p "$TARGET_DIR/.agent/agents"
mkdir -p "$TARGET_DIR/.agent/rules"
mkdir -p "$TARGET_DIR/.agent/workflows"
mkdir -p "$TARGET_DIR/.agent/skills"
mkdir -p "$TARGET_DIR/docs"

echo "✅ Created APW directory structure."

# 2. Copy Root Governance Files
# These are always overwritten to ensure governance is up-to-date
cp "$APW_ROOT/PROJECT_RULES.md" "$TARGET_DIR/"
cp "$APW_ROOT/AGENT_SYSTEM.md" "$TARGET_DIR/"
cp "$APW_ROOT/GSD-STYLE.md" "$TARGET_DIR/"

echo "✅ Applied Root Governance."

# 3. Copy GSD Lifecycle Templates
# Safer copy: don't overwrite user's actual STATE, ROADMAP unless forced.
for file in "$APW_ROOT/templates/base/.gsd/"*; do
    basename=$(basename "$file")
    target_file="$TARGET_DIR/.gsd/$basename"
    
    if [[ -f "$target_file" && $FORCE -eq 0 ]]; then
        echo "⏭️ Skipping existing lifecycle file: $basename (use --force to overwrite)"
    else
        cp "$file" "$target_file"
        echo "✅ Created lifecycle file: $basename"
    fi
done

# 4. Inject Intelligence Layer (Agents, Rules, Workflows, Core Skills)
# We generally overwrite execution logic so the AI has the newest tools.
cp -r "$APW_ROOT/.agent/workflows/"* "$TARGET_DIR/.agent/workflows/" 2>/dev/null || true
cp -r "$APW_ROOT/.agent/rules/"* "$TARGET_DIR/.agent/rules/" 2>/dev/null || true
cp -r "$APW_ROOT/.agent/agents/"* "$TARGET_DIR/.agent/agents/" 2>/dev/null || true
cp -r "$APW_ROOT/.agent/skills/"* "$TARGET_DIR/.agent/skills/" 2>/dev/null || true

echo "✅ Injected Core Intelligence Layer."

# 5. Inject Stack-Specific Add-ons
if [[ "$STACK" != "base" ]]; then
    if [[ -d "$APW_ROOT/templates/stack/$STACK/.agent/skills" ]]; then
        cp -r "$APW_ROOT/templates/stack/$STACK/.agent/skills/"* "$TARGET_DIR/.agent/skills/"
        echo "✅ Injected $STACK specialist skills."
    else
        echo "⚠️ Warning: Stack '$STACK' not found in templates."
    fi
fi

# 6. Configure Git Commit Template
if [[ -f "$APW_ROOT/.gitmessage" ]]; then
    cp "$APW_ROOT/.gitmessage" "$TARGET_DIR/"
    if [ -d "$TARGET_DIR/.git" ]; then
        (cd "$TARGET_DIR" && git config commit.template .gitmessage)
        echo "✅ Configured Git commit template."
    else
        echo "ℹ️  No .git directory found; skip git config (run manually later)."
    fi
fi

echo "🎉 Bootstrap Complete! Run ./scripts/validate.sh to verify compliance."
