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

Any future structural change to that workspace architecture must be handled as an explicit APW contract migration, not as silent compatibility drift.

Before those layers persist anything, APW also uses one intake rule:

- chat is the main input layer for requirements and project directions
- requirement-bearing chat is classified before persistence
- classification does not bypass GSD ownership of canonical state

---

## 2. Precedence and Decision Rules

### GSD Precedence (The "Brain")
- **Lifecycle & Planning**: GSD owns all decisions regarding "What" is built and "When" it is complete.
- **State Management**: `.gsd/STATE.md` is the final authority on implementation progress.
- **Canonical State Synchronization**: GSD controls updates to `.gsd/STATE.md`, `.gsd/ROADMAP.md`, `.gsd/TODO.md`, and `.gsd/DECISIONS.md` when summary state, plan state, or design rationale changes.
- **Verification**: No task is closed without empirical proof as defined by GSD protocols.
- **Requirement Ingestion Governance**: Requirement-bearing chat may introduce new scope, changes, clarifications, tasks, or rationale, but official promotion into `.gsd` files remains deliberate and GSD-governed.
- **Module Decomposition Governance**: Large requirement sets may be reorganized into modules or workstreams for planning clarity, but that decomposition still respects GSD ownership of `SPEC.md`, `ROADMAP.md`, `TODO.md`, and `DECISIONS.md`.
- **Atomic Planning Governance**: Module-level planning may be refined into atomic implementation slices for safe execution, but the official slice backlog, sequencing, and planning rationale still remain under GSD-governed project memory.

### AGK Precedence (The "Muscle")
- **Execution Logic**: AGK owns the "How" of implementation. Specialist agents and workflows determine the best technical path to achieve a GSD milestone.
- **Skill Orchestration**: Reusable skills from AGK are the primary tools for complex coding, debugging, and deployment tasks.
- **Evidence Logging**: AGK execution agents may append bounded evidence to `.gsd/JOURNAL.md`, but they do not freely rewrite canonical summary files during routine execution.
- **Brainstorm Persistence**: `/brainstorm` may generate useful requirements, options, and follow-up ideas, but those outcomes only persist through deliberate capture. The safe default is a bounded `JOURNAL.md` summary. Promotion into canonical state belongs to orchestrator or explicit governance sync.
- **Core Workflow Persistence**: Across `/status`, `/create`, `/enhance`, `/debug`, `/test`, and `/orchestrate`, workflow output is not canonical state by default. The preferred default is bounded evidence in `.gsd/JOURNAL.md`, followed by orchestrator/governance sync when official project memory changes.
- **Requirement Classification Support**: AGK sessions may help classify requirement-bearing chat as a new requirement, change request, clarification, decision, task request, exploration only, or note/evidence only, but classification alone does not make the result canonical.
- **Module Decomposition Support**: AGK orchestration sessions may help split large requirement sets into coherent modules, dependency order, and initial work slices, but official cross-file promotion remains deliberate.
- **Atomic Slice Execution Support**: AGK workflows may help turn active modules into bounded implementation slices, execute one slice at a time, debug one failing slice at a time, and verify one slice at a time, but those execution passes do not bypass orchestrator-controlled canonical sync.

### Conflict Resolution: "GSD Documentation Wins"
If a conflict arises between execution logs (AGK) and state documentation (GSD), the GSD documentation remains the canonical source. All AGK execution results must be rectified against the GSD state before the session is closed.

The same rule applies to compatibility materials: entrypoint or compatibility files may route into APW, but they must not compete with the core governance files as independent sources of authority.

---

## 3. Precedence Gate: Task Execution Flow

When an agent starts a task:
1. **Initialize**: Check `.gsd/STATE.md` to confirm the current position.
2. **Contextualize**: Load `.agent/rules/PROJECT.md` to understand local constraints.
3. **Classify Intake**: If the task starts from chat-borne project input, classify it before treating it as project memory.
4. **Plan the Slice**: If the work is large, decompose it into bounded implementation slices before direct execution.
5. **Execute**: Utilize curated skills from `.agent/skills/` on one bounded slice at a time.
6. **Verify**: Test outputs against `.gsd/SPEC.md` requirements and the slice goal.
7. **Record Evidence**: Append bounded implementation evidence or bounded intake summaries to `.gsd/JOURNAL.md` when useful.
8. **Synchronize Canonical State**: Hand results, including any brainstorm or chat-ingestion outcomes that should become official, to the orchestrator or explicit GSD/governance pass to update `.gsd/STATE.md`, `.gsd/ROADMAP.md`, `.gsd/TODO.md`, and `.gsd/DECISIONS.md` safely.
9. **Commit**: Commit with GSD-style atomicity after the relevant state sync has occurred.

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
- **Requirement Mapping Boundary**: Chat-borne requirement, change, clarification, decision, task, or evidence material follows the same deliberate mapping rules as workflow output. Classification suggests the destination; orchestrator or governance controls official promotion when canonical memory changes.
- **Module Mapping Boundary**: Module decomposition keeps high-level scope in `SPEC.md`, practical slices in `TODO.md`, sequencing in `ROADMAP.md`, and major decomposition rationale in `DECISIONS.md`. `/orchestrate` may propose or synchronize that structure, but it must not create hidden planning drift.
- **Atomic Execution Boundary**: `/create`, `/debug`, and `/test` should work against one bounded slice at a time. If the work is too broad for one clear execution pass, AGK should stop and request `/orchestrate` or governance decomposition instead of inventing a giant implementation step.
- **Brainstorm Promotion Boundary**: Exploration may produce candidate requirements, tasks, milestones, or rationale, but promotion of those outcomes into canonical `.gsd` files is deliberate and usually orchestrator-led.
- **Micro-tasks vs Milestones**: Execution agents may propose micro-tasks or follow-up items, but promotion of those items into canonical `.gsd/TODO.md` is part of the orchestrator-controlled sync step.
