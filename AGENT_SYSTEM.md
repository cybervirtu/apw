# AGENT_SYSTEM.md — Precedence and Operating Model

> [!NOTE]
> This file defines the operational relationship between the **Get-Shit-Done (GSD)** governance layer and the **Antigravity-Kit (AGK)** execution layer.

The operating model defined here is shared across APW-compatible tools such as Codex and Antigravity. Tool compatibility does not change the underlying APW precedence rules.

## 1. Unified Workspace Architecture: The Dual-Engine Model

APW operates through three distinct layers:

1. **The Memory Layer (GSD)**: Located in `.gsd/`. This is the canonical source of truth for project lifecycle, planning, state tracking, and verification. It persists across sessions and models.
2. **The Context Layer (AGK)**: Located in `.agent/`. This is the active instruction set for AI execution. It contains the unified execution namespace: `.agent/agents/`, `.agent/rules/`, `.agent/scripts/`, `.agent/workflows/`, and `.agent/skills/`.
3. **The Capability Layer (Merged)**: Located in `.agent/skills/` within that unified `.agent/` namespace. This is the shared library of curated, high-leverage specialist skills (e.g., refactoring, debugging, testing) imported from the AGK foundation.

APW does not fork this model by tool. Codex and Antigravity both route into the same workspace architecture.

---

## 2. Precedence and Decision Rules

### GSD Precedence (The "Brain")
- **Lifecycle & Planning**: GSD owns all decisions regarding "What" is built and "When" it is complete.
- **State Management**: `.gsd/STATE.md` is the final authority on implementation progress.
- **Canonical State Synchronization**: GSD controls updates to `.gsd/STATE.md`, `.gsd/ROADMAP.md`, `.gsd/TODO.md`, and `.gsd/DECISIONS.md` when summary state, plan state, or design rationale changes.
- **Verification**: No task is closed without empirical proof as defined by GSD protocols.

### AGK Precedence (The "Muscle")
- **Execution Logic**: AGK owns the "How" of implementation. Specialist agents and workflows determine the best technical path to achieve a GSD milestone.
- **Skill Orchestration**: Reusable skills from AGK are the primary tools for complex coding, debugging, and deployment tasks.
- **Evidence Logging**: AGK execution agents may append bounded evidence to `.gsd/JOURNAL.md`, but they do not freely rewrite canonical summary files during routine execution.

### Conflict Resolution: "GSD Documentation Wins"
If a conflict arises between execution logs (AGK) and state documentation (GSD), the GSD documentation remains the canonical source. All AGK execution results must be rectified against the GSD state before the session is closed.

---

## 3. Precedence Gate: Task Execution Flow

When an agent starts a task:
1. **Initialize**: Check `.gsd/STATE.md` to confirm the current position.
2. **Contextualize**: Load `.agent/rules/PROJECT.md` to understand local constraints.
3. **Execute**: Utilize curated skills from `.agent/skills/`.
4. **Verify**: Test outputs against `.gsd/SPEC.md` requirements.
5. **Record Evidence**: Append bounded implementation evidence to `.gsd/JOURNAL.md` when useful.
6. **Synchronize Canonical State**: Hand results to the orchestrator or explicit GSD/governance pass to update `.gsd/STATE.md`, `.gsd/ROADMAP.md`, `.gsd/TODO.md`, and `.gsd/DECISIONS.md` safely.
7. **Commit**: Commit with GSD-style atomicity after the relevant state sync has occurred.

---

## 4. Workflow Ownership
- **GSD Commands**: `/gsd`, `/plan`, `/task`, `/verify`, `/audit`.
- **AGK Commands**: `/status`, `/brainstorm`, `/agk`, `/create`, `/enhance`, `/debug`, `/design`, `/ui-ux-pro-max`, `/preview`, `/deploy`, `/test`, `/orchestrate`, `/skill`.

---

## 5. Scoping Boundaries
To prevent endless execution loops and feature creep, the following boundaries apply:
- **Scope Modification requires Governance**: Only GSD commands (e.g., `/plan`, `/gsd`) are permitted to alter the `ROADMAP.md` or `SPEC.md`. 
- **Execution operates within Scope**: AGK workflows (e.g., `/create`, `/refactor`, `/design`) operate *strictly* within the confines of the current phase defined in `STATE.md`. They are NOT allowed to unilaterally expand the scope, add new features, or alter the milestones. If an implementation requires a scope change, AGK must halt and request a GSD `/plan` review.
- **Canonical State Write Boundary**: Execution agents may append bounded entries to `.gsd/JOURNAL.md`, but they must not freely rewrite `.gsd/STATE.md`, `.gsd/ROADMAP.md`, `.gsd/TODO.md`, or `.gsd/DECISIONS.md` by default.
- **Micro-tasks vs Milestones**: Execution agents may propose micro-tasks or follow-up items, but promotion of those items into canonical `.gsd/TODO.md` is part of the orchestrator-controlled sync step.
