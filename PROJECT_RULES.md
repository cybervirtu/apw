# PROJECT_RULES.md — Core Governance

> [!IMPORTANT]
> These rules are mandatory for all projects bootstrapped from the APW standard.

## The APW Protocol
**SPEC → PLAN → EXECUTE (AGK) → VERIFY (GSD) → COMMIT**

1. **SPEC**: Define the target in `.gsd/SPEC.md`. Status must be `FINALIZED` before execution.
2. **PLAN**: Decompose the spec into phases in `.gsd/ROADMAP.md`.
3. **EXECUTE**: Use AGK workflows and specialist skills for implementation.
4. **VERIFY**: Prove completion with empirical evidence (captured output, screenshots).
5. **COMMIT**: One task = one commit. Format: `type(scope): description`. **Always utilize the provided `.gitmessage` template.**

## Rules of Engagement
- **Phase Completion Rule**: You may not begin work on tasks in Phase N+1 until all tasks in Phase N are marked complete in `.gsd/STATE.md` and explicitly verified.
- **Documentation-First Closure Rule**: Features are not "Done" until the corresponding setup, usage, and architectural documentation is written in `docs/` or `.gsd/`.
- **Architecture Decision Logging**: No implicit structural changes. If a change affects the system's architecture, data model, or core dependencies, it MUST be logged in `.gsd/DECISIONS.md` along with the rationale and alternatives considered.
- **Migration & Release Discipline**: Database schema updates and deployment configuration changes must be separated from feature commits. They must be explicitly documented in `.gsd/JOURNAL.md` as distinct rollout steps.
- **Canonical State Ownership Rule**: `.gsd/STATE.md`, `.gsd/ROADMAP.md`, `.gsd/TODO.md`, and `.gsd/DECISIONS.md` are controlled summary files. They are updated by the orchestrator or an explicitly acting GSD/governance pass, not by arbitrary execution agents during normal implementation.
- **Execution Evidence Rule**: Execution agents may modify code, create implementation artifacts, and append bounded evidence to `.gsd/JOURNAL.md`. Bounded means factual, append-only, and scoped to the work just performed.
- **Chat-First Requirement Intake Rule**: APW treats chat as the main input layer for requirements, changes, clarifications, decisions, and task directions. Chat is not canonical project memory by default. Requirement-bearing chat must be classified before persistence.
- **Requirement Classification Rule**: Use this simple classification set for requirement-bearing chat: new requirement, requirement change, clarification, decision, task request, exploration only, note/evidence only.
- **Requirement Mapping Rule**: Requirement or scope material maps to `.gsd/SPEC.md`; next work items map to `.gsd/TODO.md`; milestone or phase impact maps to `.gsd/ROADMAP.md`; chosen rationale or tradeoffs map to `.gsd/DECISIONS.md`; exploratory or evidence-only material maps to `.gsd/JOURNAL.md`.
- **Module Breakdown Rule**: Large requirement sets should be decomposed into coherent modules or workstreams before deep execution begins. High-level scope remains in `.gsd/SPEC.md`; module backlog and work slices land in `.gsd/TODO.md`; sequencing and milestone order land in `.gsd/ROADMAP.md`; major decomposition tradeoffs land in `.gsd/DECISIONS.md`.
- **Atomic Planning Rule**: Modules or workstreams should be broken into small, bounded implementation slices before routine execution. Actionable slices live in `.gsd/TODO.md`; sequencing and milestone placement live in `.gsd/ROADMAP.md`; important planning rationale lives in `.gsd/DECISIONS.md`. `/create`, `/debug`, and `/test` should operate on one slice at a time unless `/orchestrate` first decomposes the work further.
- **Brainstorm Persistence Rule**: `/brainstorm` is exploration, not canonical state by default. Meaningful brainstorm outcomes should usually be captured as a bounded summary in `.gsd/JOURNAL.md`. Promotion into `SPEC.md`, `TODO.md`, `ROADMAP.md`, or `DECISIONS.md` requires a deliberate planning, orchestrator, or governance step.
- **Workflow Persistence Rule**: Core workflow output is not canonical project state by default. The preferred APW save path for meaningful workflow evidence is `.gsd/JOURNAL.md`. Promotion into `STATE.md`, `ROADMAP.md`, `TODO.md`, `SPEC.md`, or `DECISIONS.md` is deliberate and remains under orchestrator or governance control.
- **Controlled Sync Rule**: Canonical state synchronization is a deliberate step after implementation, verification, or design change, not an incidental side effect of routine code edits.
- **Contract Preservation Rule**: Downstream repos must retain `AGENTS.md`, `PROJECT_RULES.md`, `AGENT_SYSTEM.md`, `COMMAND_POLICY.md`, `PROJECT_BOOTSTRAP.md`, `GSD-STYLE.md`, the required profile-backed `.gsd/` files, and the `.agent/` namespace. `AGENTS.md` is the tool-facing front door into that contract, not a replacement for it. Teams may extend project-local execution rules and `.gsd/` content, but they must not casually delete, rename, or fork APW contract files outside an intentional upgrade or migration step.
- **No speculative coding**: Do not implement features not defined in the finalized SPEC.
- **Evidence is mandatory**: No task is closed without captured proof of correctness.
- **Search-First Discipline**: Always use `grep` or `ripgrep` before reading a file.
- **Context Hygiene**: Keep active plans under 50% context usage. State dump and restart if debugging fails 3 times.

## Canonical State Sync Checklist

Run an orchestrator or explicit GSD synchronization pass when any of the following happens:

- implementation work meaningfully changes current status or next steps
- a phase boundary or verification status changes
- requirement-bearing chat changes official scope, roadmap, backlog, or rationale
- a large requirement set needs module or workstream decomposition before execution
- a module or TODO item still needs decomposition into atomic implementation slices
- new granular tasks must be promoted into canonical `.gsd/TODO.md`
- architectural or design rationale changes require `.gsd/DECISIONS.md`
- a session is handing off to another agent or another day
