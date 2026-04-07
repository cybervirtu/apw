#!/usr/bin/env bash

# Shared downstream command pack for APW bootstrapped repositories.
# These files are sourced from the canonical root .agent tree so base and
# advanced downstream repos receive the same core command behavior.

APW_CORE_DOWNSTREAM_PROFILES=(
    "base"
    "advanced"
)

APW_CORE_DOWNSTREAM_WORKFLOWS=(
    "status"
    "brainstorm"
    "create"
    "enhance"
    "debug"
    "test"
    "orchestrate"
)

APW_CORE_DOWNSTREAM_AGENTS=(
    "orchestrator"
    "product-manager"
    "project-planner"
    "backend-specialist"
    "frontend-specialist"
    "debugger"
    "test-engineer"
    "qa-automation-engineer"
    "code-archaeologist"
    "explorer-agent"
)

APW_CORE_DOWNSTREAM_RULES=(
    "GEMINI"
)

apw_profile_gets_core_downstream_pack() {
    local profile="$1"
    local candidate

    for candidate in "${APW_CORE_DOWNSTREAM_PROFILES[@]}"; do
        if [[ "$candidate" == "$profile" ]]; then
            return 0
        fi
    done

    return 1
}
