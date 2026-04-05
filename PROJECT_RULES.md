# PROJECT_RULES.md — Core Governance

> [!IMPORTANT]
> These rules are mandatory for all projects bootstrapped from the APW standard.

## The APW Protocol
**SPEC → PLAN → EXECUTE (AGK) → VERIFY (GSD) → COMMIT**

1. **SPEC**: Define the target in `.gsd/SPEC.md`. Status must be `FINALIZED` before execution.
2. **PLAN**: Decompose the spec into phases in `.gsd/ROADMAP.md`.
3. **EXECUTE**: Use AGK workflows and specialist skills for implementation.
4. **VERIFY**: Prove completion with empirical evidence (captured output, screenshots).
5. **COMMIT**: One task = one commit. Format: `type(scope): description`.

## Rules of Engagement
- **Phase Completion Rule**: You may not begin work on tasks in Phase N+1 until all tasks in Phase N are marked complete in `.gsd/STATE.md` and explicitly verified.
- **Documentation-First Closure Rule**: Features are not "Done" until the corresponding setup, usage, and architectural documentation is written in `docs/` or `.gsd/`.
- **Architecture Decision Logging**: No implicit structural changes. If a change affects the system's architecture, data model, or core dependencies, it MUST be logged in `.gsd/DECISIONS.md` along with the rationale and alternatives considered.
- **Migration & Release Discipline**: Database schema updates and deployment configuration changes must be separated from feature commits. They must be explicitly documented in `.gsd/JOURNAL.md` as distinct rollout steps.
- **No speculative coding**: Do not implement features not defined in the finalized SPEC.
- **Evidence is mandatory**: No task is closed without captured proof of correctness.
- **Search-First Discipline**: Always use `grep` or `ripgrep` before reading a file.
- **Context Hygiene**: Keep active plans under 50% context usage. State dump and restart if debugging fails 3 times.
