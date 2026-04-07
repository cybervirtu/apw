---
description: Improve an existing implementation without inventing new scope. Writes bounded refactor or polish evidence, not canonical state by default.
---

# /enhance - Bounded Improvement

$ARGUMENTS

---

## Purpose

Use `/enhance` to improve an existing implementation without turning the task into net-new product scope.

This is the APW workflow for polish, cleanup, refactoring, maintainability improvements, and bounded upgrades to already-approved behavior.

---

## Behavior

When `/enhance` is triggered:

1. **Understand the current implementation**
   - what already works
   - what needs improvement
   - what behavior must stay stable

2. **Plan the bounded change**
   - identify affected files
   - detect dependencies and regression risk

3. **Apply the improvement**
   - make the enhancement
   - verify that behavior is preserved or intentionally clarified

4. **Make persistence explicit**
   - keep technical evidence safely
   - do not silently rewrite official state

---

## Persistence Rules

### Safe default

The safe default is:

- bounded enhancement or refactor evidence goes to `.gsd/JOURNAL.md`

### Promotion map

When `/enhance` changes official project understanding, promotion may affect:

- technical debt follow-ups or additional cleanup tasks -> `.gsd/TODO.md`
- important architecture, refactor, or rationale changes -> `.gsd/DECISIONS.md`
- meaningful blocker or progress changes -> `.gsd/STATE.md`

### Orchestrator rule

If the enhancement changes official state or rationale across canonical files, use this APW path:

1. save bounded evidence in `.gsd/JOURNAL.md`
2. hand off to orchestrator or governance sync for official updates

---

## Output Format

```markdown
## Enhance: [Scope]

### Improvement Goal
[What was improved]

### Changes Made
- [change]
- [change]

### Verification
- [regression check or proof]

### Persistence Recommendation
- Default save: bounded evidence to `.gsd/JOURNAL.md`
- Promote to `TODO.md`, `DECISIONS.md`, or `STATE.md` only if the project memory changed
- Use orchestrator for official synchronization
```

---

## Key Principles

- improve without silent scope expansion
- preserve or intentionally clarify behavior
- keep evidence bounded
- use orchestrator when official state or rationale must change
