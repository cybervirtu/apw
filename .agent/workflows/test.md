---
description: Verification workflow for generating tests, running tests, and recording evidence without treating test output as canonical state automatically.
---

# /test - Verification and Test Evidence

$ARGUMENTS

---

## Purpose

Use `/test` to generate tests, run tests, check coverage, and produce verification evidence before work is treated as complete.

This workflow is about proof. Test output is not canonical project state by default.

---

## Sub-commands

```text
/test                - Run all tests
/test [file/feature] - Generate tests for a specific target
/test coverage       - Show or improve coverage understanding
/test watch          - Run tests in watch mode
```

---

## Behavior

When `/test` is triggered:

1. **Analyze the target**
   - identify the behavior under test
   - find risks, edge cases, and dependencies

2. **Generate or run tests**
   - use the project test framework
   - follow existing patterns
   - collect pass/fail evidence

3. **Report verification clearly**
   - what passed
   - what failed
   - what gaps or follow-ups remain

4. **Make persistence explicit**
   - preserve verification evidence safely
   - promote only what should become official project memory

---

## Persistence Rules

### Safe default

The safe default is:

- test and verification evidence goes to `.gsd/JOURNAL.md`

### Promotion map

When `/test` changes official project understanding, promotion may affect:

- failed coverage, flaky behavior, or follow-up verification tasks -> `.gsd/TODO.md`
- readiness, blocker, or verification status changes -> `.gsd/STATE.md`
- major milestone implications from verification results -> `.gsd/ROADMAP.md`

### Orchestrator rule

If verification results change official project memory across canonical files, use this APW path:

1. save bounded verification evidence in `.gsd/JOURNAL.md`
2. hand off to orchestrator or governance sync for official updates

---

## Output Format

```markdown
## Test: [Target]

### Scope
[what was tested]

### Results
- [pass/fail result]
- [coverage or gap]

### Follow-ups
- [remaining issue or next step]

### Persistence Recommendation
- Default save: bounded verification evidence to `.gsd/JOURNAL.md`
- Promote to `TODO.md`, `STATE.md`, or `ROADMAP.md` only if official project understanding changed
- Use orchestrator for cross-file synchronization
```

---

## Key Principles

- verify behavior, not wishful thinking
- keep evidence bounded and factual
- do not treat passing tests alone as canonical state updates
- use orchestrator when verification changes official status or milestone understanding
