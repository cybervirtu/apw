---
description: Structured brainstorming for projects and features. Explores multiple options before implementation and ends with an explicit persistence decision.
---

# /brainstorm - Structured Idea Exploration

$ARGUMENTS

---

## Purpose

This command activates BRAINSTORM mode for structured idea exploration.

Use it when you need to explore options before committing to planning or implementation.

APW treats `/brainstorm` as a two-layer workflow:

1. **Exploration**
   - clarify the problem
   - compare options
   - reduce uncertainty
2. **Persistence**
   - decide what, if anything, should be saved
   - keep useful outcomes from being lost
   - avoid silently treating chat as canonical project state

---

## Behavior

When `/brainstorm` is triggered:

1. **Understand the goal**
   - What problem are we solving?
   - Who is the user?
   - What constraints exist?

2. **Generate options**
   - Provide at least 3 different approaches
   - Each with pros and cons
   - Consider unconventional solutions when useful

3. **Compare and recommend**
   - Summarize tradeoffs
   - Give a recommendation with reasoning

4. **Make the persistence decision explicit**
   - Do not assume the brainstorm became permanent project memory just because it happened in chat
   - Offer a clear next step:
     - save a bounded summary to `.gsd/JOURNAL.md` as the safe default
     - promote agreed outcomes into the right canonical file through orchestrator or explicit governance sync
     - keep the brainstorm unsaved for now

---

## Persistence Rules

### Safe default

For a meaningful brainstorm session, the safe default is:

- save a bounded structured summary to `.gsd/JOURNAL.md`

Why:

- it preserves useful thinking
- it does not prematurely rewrite official state
- it matches APW's evidence model

### Promotion map

When brainstorm outcomes become concrete, promote them deliberately:

- requirements, users, problem framing, scope clarification -> `.gsd/SPEC.md`
- next actions, backlog items, implementation slices -> `.gsd/TODO.md`
- milestone or phase implications -> `.gsd/ROADMAP.md`
- important tradeoffs or chosen rationale -> `.gsd/DECISIONS.md`
- exploratory notes, option comparison, rejected paths, unresolved questions -> `.gsd/JOURNAL.md`

### Orchestrator rule

If the brainstorm changes official project understanding across multiple files, the recommended APW path is:

1. save a bounded summary in `.gsd/JOURNAL.md`
2. hand off to orchestrator or an explicit governance pass for canonical synchronization

Do not silently rewrite official state files by default.

---

## Output Format

```markdown
## Brainstorm: [Topic]

### Context
[Brief problem statement]

---

### Option A: [Name]
[Description]

Pros:
- [benefit 1]
- [benefit 2]

Cons:
- [drawback 1]

Effort: Low | Medium | High

---

### Option B: [Name]
[Description]

Pros:
- [benefit 1]

Cons:
- [drawback 1]
- [drawback 2]

Effort: Low | Medium | High

---

### Option C: [Name]
[Description]

Pros:
- [benefit 1]

Cons:
- [drawback 1]

Effort: Low | Medium | High

---

## Recommendation

Option [X] because [reasoning].

## Persistence Recommendation

Default safe save:
- add a bounded summary to `.gsd/JOURNAL.md`

Promotion candidates:
- `SPEC.md`: [if requirements or scope became clearer]
- `TODO.md`: [if next actions became clear]
- `ROADMAP.md`: [if milestone or phase implications became clear]
- `DECISIONS.md`: [if rationale became authoritative]

Suggested next step:
- [save notes] or [hand off to orchestrator] or [continue exploring]
```

---

## End-of-Brainstorm Decision

Do not end with ambiguity about what happened to the result.

Close the brainstorm by making one of these choices explicit:

1. **Save notes to `JOURNAL.md`**
   - use this for most meaningful brainstorms
2. **Promote agreed outcomes into planning files**
   - use this only as a deliberate planning/governance action
3. **Hand off to orchestrator**
   - use this when official project memory across multiple files should change
4. **Do not save yet**
   - use this when the discussion is still too fuzzy or provisional

---

## Examples

```text
/brainstorm authentication system
/brainstorm state management for complex form
/brainstorm database schema for social app
/brainstorm caching strategy
```

---

## Key Principles

- **Exploration first** - `/brainstorm` is for option-shaping, not premature implementation
- **No silent canonization** - chat is not official project memory by default
- **Safe default persistence** - meaningful outcomes should usually be summarized in `JOURNAL.md`
- **Controlled promotion** - official state changes belong to orchestrator or explicit governance sync
- **Honest tradeoffs** - do not hide complexity
- **Defer to the user** - present options and persistence choices clearly
