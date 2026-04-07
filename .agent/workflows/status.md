---
description: Re-orient on current project state and next best action. Orientation-first workflow with no silent canonical state mutation by default.
---

# /status - Project Orientation

$ARGUMENTS

---

## Purpose

Use `/status` to re-orient quickly when you need to understand:

- where the project stands
- what matters now
- what the next likely step should be

This is an orientation workflow, not a hidden state-sync workflow.

---

## Behavior

When `/status` is triggered:

1. **Read the current project memory**
   - current status
   - roadmap and active backlog
   - recent evidence when useful

2. **Summarize what matters now**
   - active milestone or phase
   - blockers or risks
   - likely next action

3. **Stay read-first by default**
   - do not silently mutate canonical project files
   - recommend a next workflow when appropriate

---

## Persistence Rules

### Safe default

The default is:

- no canonical state change

Optional safe persistence:

- add a bounded orientation summary to `.gsd/JOURNAL.md` when the briefing itself is useful for handoff or session recovery

### Promotion map

If `/status` reveals real project-memory drift, promotion may later affect:

- status progress, blockers, or next-step changes -> `.gsd/STATE.md`
- newly clarified follow-up work -> `.gsd/TODO.md`
- milestone or phase implications -> `.gsd/ROADMAP.md`

### Orchestrator rule

If `/status` reveals that canonical state is stale, use this APW path:

1. capture bounded evidence or summary in `.gsd/JOURNAL.md` when useful
2. hand off to orchestrator or governance sync for official updates

---

## Output Format

```markdown
## Status: [Project or Topic]

### Current Position
- Active phase: [value]
- Current focus: [value]
- Main blockers: [value]

### What Matters Now
- [important point]
- [important point]

### Next Best Action
- Recommended workflow: `/create` | `/debug` | `/test` | `/brainstorm` | `/orchestrate`
- Why: [reason]

### Persistence Recommendation
- Default: no canonical change
- Save to `JOURNAL.md` only if this orientation summary should be preserved
- Use orchestrator if canonical state is stale
```

---

## Key Principles

- orientation first
- no silent canonical mutation
- bounded `JOURNAL.md` evidence only when useful
- orchestrator owns official cross-file synchronization
