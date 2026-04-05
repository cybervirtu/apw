# AGENT_SYSTEM.md — Precedence and Operating Model

> [!NOTE]
> This file defines the operational relationship between the **Get-Shit-Done (GSD)** governance layer and the **Antigravity-Kit (AGK)** execution layer.

## Core Relationship
APW uses a dual-engine approach where:
1. **GSD** is the **Brain** (Governance, Planning, State, Verification).
2. **AGK** is the **Muscle** (Execution, Workflows, Specialist Skills).

## Precedence Rules
- **Governance**: In any conflict regarding project timeline, specification, or completion status, **GSD wins**.
- **Execution**: In any conflict regarding the technical implementation path or debugging approach, **AGK wins**.
- **Documentation**: All implementation progress must eventually be recorded in the `.gsd/` folder as the source of truth.

## Workflow Ownership
- **GSD Commands**: `/gsd`, `/plan`, `/task`, `/validate`, `/audit`.
- **AGK Commands**: `/agk`, `/create`, `/debug`, `/orchestrate`, `/skill`.

## Lifecycle Sync
Every AGK execution phase must end with a lifecycle sync:
1. Summarize execution results (successes, errors, changes).
2. Update `.gsd/STATE.md` with the new position.
3. Commit work using GSD-style atomic commits.
