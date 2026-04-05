# STATE.md — Canonical Current State

> **Purpose**: Single current-state file for pause/resume context, recent snapshot notes, and optional token/context-budget notes.
>
> Use `STATE.md` instead of separate root files such as `STATE_SNAPSHOT.md` or `TOKEN_REPORT.md`.

## Template

```markdown
---
updated: [ISO timestamp]
---

# Project State

## Current Position

**Milestone:** {name}
**Phase:** {N} - {name}
**Status:** {planning | executing | verifying | blocked}
**Plan:** {current plan if executing}

## Last Action

{What was just completed}

## Next Steps

1. {Immediate next action}
2. {Following action}
3. {Third action if known}

## Blockers

- [ ] {Blocker 1}: {resolution approach}
- [ ] {Blocker 2}: {resolution approach}

## Recent Verification

- **Check:** {what was verified}
- **Result:** {pass | fail | partial}
- **Evidence:** {command, screenshot path, or journal entry reference}

## Current Snapshot

- **Files in flight:** {key files or areas}
- **Risks / concerns:** {what to watch}
- **Resume point:** {what the next agent should do first}

## Context Budget Notes (Optional)

- **Loaded hotspots:** {files or systems consuming most context}
- **Compression / handoff note:** {what was summarized or intentionally omitted}
```

## Update Rules

- Update after every meaningful task completion, blocker discovery, verification event, or session pause.
- Keep this file lean and current; history belongs in `JOURNAL.md`.
- If you need more detail, expand the relevant section here before creating a new root `.gsd` file.
