---
description: Build a new implementation slice that is already inside approved scope. Writes code and bounded evidence, not canonical state by default.
---

# /create - Scoped Implementation

$ARGUMENTS

---

## Purpose

Use `/create` to build a new feature, file, flow, or implementation slice that is already inside approved project scope.

This workflow is for execution, not for silent project-memory rewrites.

---

## Behavior

When `/create` is triggered:

1. **Confirm scope**
   - what is being built
   - where it belongs in current requirements or backlog
   - what constraints already exist

2. **Implement the slice**
   - create or update the needed code, files, or assets
   - stay inside the approved scope

3. **Verify the work**
   - record proof, follow-up testing needs, or known gaps

4. **Make persistence explicit**
   - write bounded execution evidence safely
   - do not silently treat implementation output as canonical project state

---

## Persistence Rules

### Safe default

The safe default is:

- implementation evidence goes to `.gsd/JOURNAL.md`

### Promotion map

When `/create` changes official project understanding, promotion may affect:

- next actions or follow-up backlog -> `.gsd/TODO.md`
- current progress, blockers, or completion status -> `.gsd/STATE.md`
- milestone or phase implications -> `.gsd/ROADMAP.md`
- important design rationale or tradeoffs -> `.gsd/DECISIONS.md`

### Orchestrator rule

If implementation changes official project memory across canonical files, use this APW path:

1. save bounded execution evidence in `.gsd/JOURNAL.md`
2. hand off to orchestrator or governance sync for official updates

---

## Output Format

```markdown
## Create: [Scope]

### Scope
[What was built]

### Implementation
- [main change]
- [main change]

### Verification
- [tests run or proof gathered]
- [known follow-up if any]

### Persistence Recommendation
- Default save: bounded evidence to `.gsd/JOURNAL.md`
- Promote to `TODO.md`, `STATE.md`, `ROADMAP.md`, or `DECISIONS.md` only if official project memory changed
- Use orchestrator for cross-file synchronization
```

---

## Key Principles

- build inside approved scope
- keep evidence bounded
- do not treat code changes alone as canonical state updates
- use orchestrator when official state must change
