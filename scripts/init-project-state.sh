#!/usr/bin/env bash

set -euo pipefail

TARGET_DIR="."
FORCE=0

usage() {
    echo "Usage: $0 [--target value] [--force]"
    echo "  --target : Bootstrapped repo to initialize (default: current directory)"
    echo "  --force  : Overwrite existing guided state files without confirmation"
}

trim() {
    local value="$1"
    value="${value#"${value%%[![:space:]]*}"}"
    value="${value%"${value##*[![:space:]]}"}"
    printf '%s' "$value"
}

prompt_required() {
    local prompt="$1"
    local default_value="${2:-}"
    local answer=""

    while true; do
        if [[ -n "$default_value" ]]; then
            read -r -p "$prompt [$default_value]: " answer
        else
            read -r -p "$prompt: " answer
        fi

        answer="$(trim "$answer")"

        if [[ -z "$answer" && -n "$default_value" ]]; then
            answer="$default_value"
        fi

        if [[ -n "$answer" ]]; then
            PROMPT_RESULT="$answer"
            return 0
        fi

        echo "Please enter a value."
    done
}

prompt_optional() {
    local prompt="$1"
    local default_value="${2:-}"
    local answer=""

    if [[ -n "$default_value" ]]; then
        read -r -p "$prompt [$default_value]: " answer
    else
        read -r -p "$prompt: " answer
    fi

    answer="$(trim "$answer")"

    if [[ -z "$answer" && -n "$default_value" ]]; then
        answer="$default_value"
    fi

    PROMPT_RESULT="$answer"
}

prompt_yes_no() {
    local prompt="$1"
    local answer=""

    while true; do
        read -r -p "$prompt [y/N]: " answer
        answer="$(printf '%s' "$answer" | tr '[:upper:]' '[:lower:]')"

        case "$answer" in
            y|yes)
                return 0
                ;;
            ""|n|no)
                return 1
                ;;
            *)
                echo "Please answer y or n."
                ;;
        esac
    done
}

normalize_space() {
    printf '%s' "$1" | tr '\n' ' ' | sed 's/[[:space:]]\+/ /g; s/^ //; s/ $//'
}

is_unspecified() {
    local value
    value="$(printf '%s' "$1" | tr '[:upper:]' '[:lower:]')"

    case "$value" in
        ""|"none"|"n/a"|"na"|"not sure"|"unsure"|"unknown"|"tbd"|"to be decided")
            return 0
            ;;
        *)
            return 1
            ;;
    esac
}

csv_to_markdown_bullets() {
    local input="$1"
    local fallback="$2"
    local output=""
    local trimmed=""
    local item=""
    local count=0
    local old_ifs="$IFS"

    if is_unspecified "$input"; then
        printf -- '- %s\n' "$fallback"
        return 0
    fi

    IFS=','
    read -r -a CSV_ITEMS <<< "$input"
    IFS="$old_ifs"

    for item in "${CSV_ITEMS[@]}"; do
        trimmed="$(trim "$item")"
        if [[ -n "$trimmed" ]]; then
            output="${output}- ${trimmed}"$'\n'
            count=$((count + 1))
        fi
    done

    if [[ $count -eq 0 ]]; then
        printf -- '- %s\n' "$fallback"
    else
        printf '%s' "$output"
    fi
}

csv_to_checkbox_lines() {
    local input="$1"
    local fallback="$2"
    local output=""
    local trimmed=""
    local item=""
    local count=0
    local old_ifs="$IFS"

    if is_unspecified "$input"; then
        printf -- '- [ ] %s\n' "$fallback"
        return 0
    fi

    IFS=','
    read -r -a CSV_ITEMS <<< "$input"
    IFS="$old_ifs"

    for item in "${CSV_ITEMS[@]}"; do
        trimmed="$(trim "$item")"
        if [[ -n "$trimmed" ]]; then
            output="${output}- [ ] Verify this top feature works in the first usable version: ${trimmed}"$'\n'
            count=$((count + 1))
        fi
    done

    if [[ $count -eq 0 ]]; then
        printf -- '- [ ] %s\n' "$fallback"
    else
        printf '%s' "$output"
    fi
}

file_matches_bootstrap_template() {
    local target_file="$1"
    local file_name="$2"
    local candidate=""

    for candidate in \
        "$APW_ROOT/templates/base/.gsd/$file_name" \
        "$APW_ROOT/templates/minimal/.gsd/$file_name" \
        "$APW_ROOT/templates/advanced/.gsd/$file_name"
    do
        if [[ -f "$candidate" ]] && cmp -s "$target_file" "$candidate"; then
            return 0
        fi
    done

    return 1
}

infer_language() {
    local stack_text
    stack_text="$(printf '%s' "$1" | tr '[:upper:]' '[:lower:]')"

    if [[ "$stack_text" == *"typescript"* ]] || [[ "$stack_text" == *"javascript"* ]] || [[ "$stack_text" == *"node"* ]] || [[ "$stack_text" == *"next"* ]] || [[ "$stack_text" == *"react"* ]] || [[ "$stack_text" == *"nestjs"* ]] || [[ "$stack_text" == *"express"* ]]; then
        printf '%s\n' "TypeScript / JavaScript"
    elif [[ "$stack_text" == *"python"* ]] || [[ "$stack_text" == *"fastapi"* ]] || [[ "$stack_text" == *"django"* ]] || [[ "$stack_text" == *"flask"* ]]; then
        printf '%s\n' "Python"
    elif [[ "$stack_text" == *"go"* ]] || [[ "$stack_text" == *"golang"* ]]; then
        printf '%s\n' "Go"
    elif [[ "$stack_text" == *"ruby"* ]] || [[ "$stack_text" == *"rails"* ]]; then
        printf '%s\n' "Ruby"
    elif [[ "$stack_text" == *"kotlin"* ]]; then
        printf '%s\n' "Kotlin"
    elif [[ "$stack_text" == *"swift"* ]]; then
        printf '%s\n' "Swift"
    elif [[ "$stack_text" == *"flutter"* ]] || [[ "$stack_text" == *"dart"* ]]; then
        printf '%s\n' "Dart"
    else
        printf '%s\n' "To be confirmed"
    fi
}

infer_framework() {
    local stack_text
    stack_text="$(printf '%s' "$1" | tr '[:upper:]' '[:lower:]')"

    if [[ "$stack_text" == *"next.js"* ]] || [[ "$stack_text" == *"nextjs"* ]] || [[ "$stack_text" == *"next "* ]] || [[ "$stack_text" == next* ]]; then
        printf '%s\n' "Next.js"
    elif [[ "$stack_text" == *"react native"* ]]; then
        printf '%s\n' "React Native"
    elif [[ "$stack_text" == *"react"* ]]; then
        printf '%s\n' "React"
    elif [[ "$stack_text" == *"vue"* ]]; then
        printf '%s\n' "Vue"
    elif [[ "$stack_text" == *"nuxt"* ]]; then
        printf '%s\n' "Nuxt"
    elif [[ "$stack_text" == *"fastapi"* ]]; then
        printf '%s\n' "FastAPI"
    elif [[ "$stack_text" == *"django"* ]]; then
        printf '%s\n' "Django"
    elif [[ "$stack_text" == *"flask"* ]]; then
        printf '%s\n' "Flask"
    elif [[ "$stack_text" == *"rails"* ]]; then
        printf '%s\n' "Ruby on Rails"
    elif [[ "$stack_text" == *"nestjs"* ]]; then
        printf '%s\n' "NestJS"
    elif [[ "$stack_text" == *"express"* ]]; then
        printf '%s\n' "Express"
    elif [[ "$stack_text" == *"spring"* ]]; then
        printf '%s\n' "Spring"
    elif [[ "$stack_text" == *"flutter"* ]]; then
        printf '%s\n' "Flutter"
    else
        printf '%s\n' "To be confirmed"
    fi
}

infer_database() {
    local stack_text
    stack_text="$(printf '%s' "$1" | tr '[:upper:]' '[:lower:]')"

    if [[ "$stack_text" == *"postgres"* ]] || [[ "$stack_text" == *"postgresql"* ]]; then
        printf '%s\n' "PostgreSQL"
    elif [[ "$stack_text" == *"mysql"* ]]; then
        printf '%s\n' "MySQL"
    elif [[ "$stack_text" == *"sqlite"* ]]; then
        printf '%s\n' "SQLite"
    elif [[ "$stack_text" == *"mongo"* ]]; then
        printf '%s\n' "MongoDB"
    elif [[ "$stack_text" == *"supabase"* ]]; then
        printf '%s\n' "Supabase / PostgreSQL"
    elif [[ "$stack_text" == *"firebase"* ]]; then
        printf '%s\n' "Firebase"
    elif [[ "$stack_text" == *"none"* ]] || [[ "$stack_text" == *"static"* ]] || [[ "$stack_text" == *"landing page"* ]] || [[ "$stack_text" == *"portfolio"* ]]; then
        printf '%s\n' "None planned for the first version"
    else
        printf '%s\n' "To be confirmed"
    fi
}

while [[ "$#" -gt 0 ]]; do
    case "$1" in
        --target)
            [[ $# -ge 2 ]] || { echo "Error: --target requires a value."; usage; exit 1; }
            TARGET_DIR="$2"
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
            echo "Error: Unknown parameter '$1'."
            usage
            exit 1
            ;;
    esac
done

APW_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TARGET_DIR="$(cd "$TARGET_DIR" && pwd)"
TODAY="$(date '+%Y-%m-%d')"
NOW="$(date '+%Y-%m-%d %H:%M')"

if [[ ! -d "$TARGET_DIR/.gsd" ]]; then
    echo "Error: $TARGET_DIR does not look like a bootstrapped APW repo."
    echo "Run /path/to/apw/scripts/bootstrap.sh first, then run this initializer."
    exit 1
fi

GUIDED_FILES=("SPEC.md" "STACK.md" "TODO.md" "STATE.md" "ROADMAP.md")
NEEDS_CONFIRMATION=0

for file_name in "${GUIDED_FILES[@]}"; do
    target_file="$TARGET_DIR/.gsd/$file_name"

    if [[ -f "$target_file" ]] && ! file_matches_bootstrap_template "$target_file" "$file_name" && [[ $FORCE -eq 0 ]]; then
        NEEDS_CONFIRMATION=1
    fi
done

if [[ $NEEDS_CONFIRMATION -eq 1 ]]; then
    echo "Existing guided state files already contain project-specific content."
    if ! prompt_yes_no "Overwrite the current drafts for SPEC.md, STACK.md, TODO.md, STATE.md, and ROADMAP.md?"; then
        echo "Initialization cancelled."
        exit 1
    fi
fi

echo "APW guided project-state initialization"
echo
echo "This helper captures your project in plain language and generates first drafts for:"
echo "- .gsd/SPEC.md"
echo "- .gsd/STACK.md"
echo "- .gsd/TODO.md"
echo "- .gsd/STATE.md"
echo "- .gsd/ROADMAP.md"
echo
echo "It does not replace orchestrator ownership. It gives you a coherent starting draft."
echo

prompt_required "Project name" "$(basename "$TARGET_DIR")"
PROJECT_NAME="$PROMPT_RESULT"

prompt_required "What are you building"
PROJECT_SUMMARY="$(normalize_space "$PROMPT_RESULT")"

prompt_required "Who is it for"
TARGET_USERS="$(normalize_space "$PROMPT_RESULT")"

prompt_required "What problem does it solve"
PROBLEM_STATEMENT="$(normalize_space "$PROMPT_RESULT")"

prompt_required "What is the smallest useful first version"
FIRST_VERSION="$(normalize_space "$PROMPT_RESULT")"

prompt_required "What are the top features (comma-separated)"
TOP_FEATURES="$(normalize_space "$PROMPT_RESULT")"

prompt_required "Is this a prototype, pilot, or production-oriented project"
DELIVERY_MODE="$(normalize_space "$PROMPT_RESULT")"

prompt_required "Will this be built solo or by a team"
TEAM_MODE="$(normalize_space "$PROMPT_RESULT")"

prompt_optional "Preferred stack or technical direction" "not sure"
STACK_PREFERENCE="$(normalize_space "$PROMPT_RESULT")"

prompt_optional "Constraints, limits, or must-keep-in-mind notes (comma-separated)" "none"
CONSTRAINTS="$(normalize_space "$PROMPT_RESULT")"

if is_unspecified "$STACK_PREFERENCE"; then
    STACK_DIRECTION="Not chosen yet. Use docs/TECH_STACK_SELECTION_GUIDE.md if you need help."
else
    STACK_DIRECTION="$STACK_PREFERENCE"
fi

LANGUAGE_VALUE="$(infer_language "$STACK_PREFERENCE")"
FRAMEWORK_VALUE="$(infer_framework "$STACK_PREFERENCE")"
DATABASE_VALUE="$(infer_database "$STACK_PREFERENCE")"

FEATURE_BULLETS="$(csv_to_markdown_bullets "$TOP_FEATURES" "Define the highest-priority feature before implementation starts.")"
FEATURE_CHECKBOXES="$(csv_to_checkbox_lines "$TOP_FEATURES" "Verify the first user-visible capability works end to end.")"
CONSTRAINT_BULLETS="$(csv_to_markdown_bullets "$CONSTRAINTS" "No special constraints have been captured yet.")"

if is_unspecified "$STACK_PREFERENCE"; then
    STACK_CONTEXT_BULLET="- Stack direction is still open and should be chosen before large implementation work begins."
    STACK_TODO_LINE="- [ ] Choose and record the likely stack direction for the first usable version"
else
    STACK_CONTEXT_BULLET="- Current stack direction: $STACK_PREFERENCE"
    STACK_TODO_LINE="- [ ] Confirm the chosen stack direction still fits the first usable version"
fi

if [[ "$(printf '%s' "$DELIVERY_MODE" | tr '[:upper:]' '[:lower:]')" == *"production"* ]]; then
    M3_TITLE="M3: Hardening & Release Readiness"
    M3_GOALS="Stabilize the product, close important gaps, strengthen testing, and prepare the repo for repeatable release work."
    M3_VERIFICATION="Validation passes cleanly, important risks are documented, and the project is ready for broader usage or release preparation."
else
    M3_TITLE="M3: Feedback, Learning, and Next Decision"
    M3_GOALS="Use the first usable version to gather feedback, decide what to keep, and narrow the next improvement cycle."
    M3_VERIFICATION="A real review or trial has happened, the team knows what to improve next, and the roadmap reflects that decision."
fi

cat > "$TARGET_DIR/.gsd/SPEC.md" <<EOF
# REQUIREMENT SPECIFICATION

**Status:** DRAFT
**Last Updated:** $TODAY

## 1. Objective
$PROJECT_NAME is being built to help $TARGET_USERS by solving this problem: $PROBLEM_STATEMENT

## 2. Scope
- **In Scope:** Deliver the smallest useful version of the product: $FIRST_VERSION
- **Out of Scope:** Nice-to-have expansion beyond the first usable version, major architecture changes that are not needed yet, and features that do not directly support the top priorities below.

## 3. Core Requirements
### Functional
- Build a first usable version that clearly matches this product summary: $PROJECT_SUMMARY
$FEATURE_BULLETS

### Non-Functional
- Keep the first implementation aligned to a $DELIVERY_MODE effort instead of expanding scope too early.
- Support a $TEAM_MODE working model with clear project memory in \`.gsd/\`.
$CONSTRAINT_BULLETS

## 4. Acceptance Criteria
- A real user in this target group can understand and use the first version: $TARGET_USERS
- The first usable version is implemented and reviewable: $FIRST_VERSION
$FEATURE_CHECKBOXES
- The repo core project memory tells a consistent story across \`SPEC.md\`, \`STACK.md\`, \`STATE.md\`, \`TODO.md\`, and \`ROADMAP.md\`.
EOF
echo "✅ Wrote .gsd/SPEC.md"

cat > "$TARGET_DIR/.gsd/STACK.md" <<EOF
# PROJECT STACK

## Current Direction
- **Project Summary**: $PROJECT_SUMMARY
- **Delivery Mode**: $DELIVERY_MODE
- **Team Model**: $TEAM_MODE
- **Preferred Direction**: $STACK_DIRECTION

## Core Technologies
- **Language**: $LANGUAGE_VALUE
- **Framework**: $FRAMEWORK_VALUE
- **Database**: $DATABASE_VALUE

## Key Dependencies
- APW validation and governance files stay active while the project is taking shape.
- Choose the minimum app, service, or SDK dependencies needed to deliver: $FIRST_VERSION
- Add testing, formatting, and developer tooling that match the final stack choice.

## Tooling
- **Linting/Formatting**: To be confirmed with the chosen stack
- **Testing**: Must prove the first usable version works for $TARGET_USERS
- **CI/CD**: Re-run APW validation in CI before merge or release work

## Notes
- If the stack direction is still unclear, use \`docs/TECH_STACK_SELECTION_GUIDE.md\` before heavy implementation starts.
- Record architecture and rationale in \`ARCHITECTURE.md\` and \`DECISIONS.md\` once the technical shape becomes important enough to lock.
EOF
echo "✅ Wrote .gsd/STACK.md"

cat > "$TARGET_DIR/.gsd/TODO.md" <<EOF
# TODO LIST

## Current Phase: M1: Initialization & First Slice

### Guided Initialization
- [x] Capture the project brief for $PROJECT_NAME in plain language
- [x] Generate first drafts of \`SPEC.md\`, \`STACK.md\`, \`TODO.md\`, \`STATE.md\`, and \`ROADMAP.md\`
- [ ] Review these drafts and correct anything that is clearly wrong or missing

### Foundation
$STACK_TODO_LINE
- [ ] Confirm the smallest useful first version: $FIRST_VERSION
- [ ] Add any project-specific rules in \`.agent/rules/PROJECT.md\` if they are needed

### First Delivery Slice
- [ ] Implement the first usable version for $TARGET_USERS
$FEATURE_CHECKBOXES
- [ ] Record bounded evidence in \`.gsd/JOURNAL.md\` and run orchestrator sync when official state changes
EOF
echo "✅ Wrote .gsd/TODO.md"

cat > "$TARGET_DIR/.gsd/STATE.md" <<EOF
# CURRENT STATE

**Last Updated:** $NOW
**Current Phase:** M1: Initialization & First Slice

## 1. Where We Are
The APW workspace has been bootstrapped and the first project-state draft is now in place for $PROJECT_NAME. The project is aimed at $TARGET_USERS, focuses on solving this problem: $PROBLEM_STATEMENT, and is currently centered on this first usable version: $FIRST_VERSION

## 2. Immediate Focus
Review the generated drafts for accuracy, confirm the stack direction, and turn the first usable version into the next bounded implementation task.

## 3. Active Blockers / Context
- Delivery mode: $DELIVERY_MODE
- Team model: $TEAM_MODE
$STACK_CONTEXT_BULLET
$CONSTRAINT_BULLETS

## 4. Most Recent Verification
- **Test:** Guided project-state initialization completed
- **Result:** Draft core \`.gsd\` files were generated successfully. Product and implementation verification are still pending.
EOF
echo "✅ Wrote .gsd/STATE.md"

cat > "$TARGET_DIR/.gsd/ROADMAP.md" <<EOF
# PROJECT ROADMAP

## Overview
$PROJECT_NAME will move from guided initialization to a first usable version quickly, then tighten quality and direction based on what the project learns in real use.

## Phases / Milestones

### M1: Initialization & First Slice
- **Goals:** Confirm the project brief, lock the likely stack direction, and make the first usable version clear enough to implement.
- **Status:** IN PROGRESS
- **Verification Criteria:** The core guided state files tell the same story, the first usable version is understandable, and the next bounded task is obvious.

### M2: First Usable Version
- **Goals:** Build and verify this first usable version: $FIRST_VERSION
- **Status:** PENDING
- **Verification Criteria:** The top features work in a reviewable build and the repo has real verification evidence for the first slice.

### $M3_TITLE
- **Goals:** $M3_GOALS
- **Status:** PENDING
- **Verification Criteria:** $M3_VERIFICATION
EOF
echo "✅ Wrote .gsd/ROADMAP.md"

echo
echo "Next steps:"
echo "1. Read the five generated files once and fix any obvious wording that does not fit the project."
echo "2. Start new tool sessions from $TARGET_DIR/AGENTS.md."
echo "3. Use /status or /brainstorm after the draft state matches the project story."
echo "4. Keep architecture, decisions, and journal evidence in their own files as the project becomes more concrete."
