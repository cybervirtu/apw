# ROADMAP.md — Canonical Planning Source

> **Purpose**: Single planning source of truth for milestones, phases, active sprint focus, and phase-close summaries.
>
> Use `ROADMAP.md` instead of separate root files such as `MILESTONE.md`, `SPRINT.md`, or `PHASE-SUMMARY.md`.

## Template

```markdown
---
milestone: {name}
version: {semantic version}
updated: [ISO timestamp]
---

# Roadmap

## Milestone Direction

**Milestone:** {name}
**Outcome:** {what this milestone delivers}
**Status:** {planning | executing | verifying | complete}
**Target Window:** {optional date range or release target}

## Current Execution Window

**Active Phase:** {N} - {name}
**Active Sprint / Focus Window:** {current slice of work}
**Current Goal:** {what must move next}
**Exit Criteria:** {what proves this slice is done}

## Must-Haves (from SPEC)

- [ ] {Must-have 1}
- [ ] {Must-have 2}
- [ ] {Must-have 3}

## Phases

### Phase 1: {Foundation}
**Status:** ⬜ Not Started | 🔄 In Progress | ✅ Complete | ❌ Blocked
**Objective:** {What this phase delivers}
**Depends on:** {None | prior phase}
**Plans:**
- [ ] Plan 1.1: {name}
- [ ] Plan 1.2: {name}
**Completion Notes:** {Short summary once complete}

### Phase 2: {Core Feature}
**Status:** ⬜ Not Started
**Objective:** {What this phase delivers}
**Depends on:** Phase 1
**Plans:**
- [ ] Plan 2.1: {name}
- [ ] Plan 2.2: {name}
**Completion Notes:** {Short summary once complete}

## Progress Summary

| Phase | Status | Plans | Complete |
|-------|--------|-------|----------|
| 1 | ⬜ | 0/2 | — |
| 2 | ⬜ | 0/2 | — |

## Risks / Sequencing Notes

- {Risk or dependency}
- {Scope shift or milestone note}

## Completed Phase Notes

- Phase {N}: {What completed, what was verified, what it unlocked next}
```

## Guidelines

- Keep milestone, sprint, and phase-close status here rather than creating separate root planning files.
- Update when scope changes, a phase starts or ends, or the active focus window changes.
- Put granular execution checklists in `TODO.md`, not here.
