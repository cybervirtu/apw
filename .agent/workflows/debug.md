---
description: Systematic investigation and fix workflow for broken behavior. Writes debugging evidence safely and promotes official updates deliberately.
---

# /debug - Systematic Problem Investigation

$ARGUMENTS

---

## Purpose

Use `/debug` to diagnose and fix issues, errors, or unexpected behavior through a reproduce-investigate-fix flow.

This workflow produces evidence and a root-cause understanding. It does not silently rewrite canonical project state by default.

---

## Behavior

When `/debug` is triggered:

1. **Gather information**
   - error message
   - reproduction steps
   - expected vs actual behavior
   - recent changes

2. **Form hypotheses**
   - list likely causes
   - order them by evidence and likelihood

3. **Investigate systematically**
   - test each hypothesis
   - inspect logs, traces, and data flow
   - narrow to the real root cause

4. **Fix and prevent**
   - apply the scoped fix
   - explain the root cause
   - add prevention measures when appropriate

5. **Make persistence explicit**
   - keep debugging evidence safely
   - promote only what should become official project memory

---

## Persistence Rules

### Safe default

The safe default is:

- debugging evidence goes to `.gsd/JOURNAL.md`

### Promotion map

When `/debug` changes official project understanding, promotion may affect:

- follow-up fixes or backlog items -> `.gsd/TODO.md`
- root-cause rationale that should remain authoritative -> `.gsd/DECISIONS.md`
- meaningful blocker, status, or readiness changes -> `.gsd/STATE.md`

### Orchestrator rule

If the debug result changes official project memory across canonical files, use this APW path:

1. save bounded debugging evidence in `.gsd/JOURNAL.md`
2. hand off to orchestrator or governance sync for official updates

---

## Output Format

```markdown
## Debug: [Issue]

### Symptom
[What is happening]

### Hypotheses
1. [possible cause]
2. [possible cause]

### Investigation
- [check] -> [result]
- [check] -> [result]

### Root Cause
[what actually caused the issue]

### Fix
[what changed]

### Prevention
[how recurrence should be reduced]

### Persistence Recommendation
- Default save: bounded debugging evidence to `.gsd/JOURNAL.md`
- Promote to `TODO.md`, `DECISIONS.md`, or `STATE.md` only if the official project understanding changed
- Use orchestrator for cross-file synchronization
```

---

## Key Principles

- test hypotheses instead of guessing
- explain the root cause, not just the patch
- keep debugging evidence bounded
- use orchestrator when blocker, status, or rationale changes become official
