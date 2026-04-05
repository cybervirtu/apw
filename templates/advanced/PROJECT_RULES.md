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
- **No speculative coding**: Do not implement features not defined in the finalized SPEC.
- **Evidence is mandatory**: No task is closed without captured proof of correctness.
- **Search-First Discipline**: Always use `grep` or `ripgrep` before reading a file.
- **Context Hygiene**: Keep active plans under 50% context usage. State dump and restart if debugging fails 3 times.
