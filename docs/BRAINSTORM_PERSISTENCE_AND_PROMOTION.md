# BRAINSTORM_PERSISTENCE_AND_PROMOTION.md — Brainstorm Persistence and Promotion

> [!TIP]
> Use this when you want the practical answer to: "We used `/brainstorm`. What should be saved, where should it go, and when does orchestrator matter?"

## What this guide is

This guide defines APW's persistence model for `/brainstorm`.

It exists because a brainstorm session is useful, but chat by itself is not project memory.

APW keeps that distinction clear:

- exploration is useful
- exploration is not canonical state by default
- useful outcomes should not be lost

## The two-layer model

APW treats `/brainstorm` as two layers.

### Layer A — exploration

This is the brainstorm itself.

It may:

- explore ideas
- compare options
- suggest features
- clarify scope
- reduce uncertainty

This layer is for thinking, not automatic canonization.

### Layer B — persistence

This is the deliberate save step after the brainstorm.

It answers:

- what should be kept?
- where should it be kept?
- what should become official project memory?

Without this step, useful brainstorm outcomes can stay trapped in chat.

## Safe default persistence

For a meaningful brainstorm session, the safe default is:

- save a bounded structured summary to `.gsd/JOURNAL.md`

Why this is the default:

- it preserves the session
- it does not rewrite official state too early
- it fits APW's existing evidence model
- it is beginner-safe

Think of it this way:

- `JOURNAL.md` is the safe place to keep the useful result of exploratory thinking
- canonical summary files are for agreed project memory

## What belongs where

Use this practical mapping:

| Brainstorm outcome | Where it belongs |
| :--- | :--- |
| exploratory session notes, compared options, rejected paths, open questions | `.gsd/JOURNAL.md` |
| clarified requirements, users, problem framing, scope | `.gsd/SPEC.md` |
| next actions, backlog items, implementation slices | `.gsd/TODO.md` |
| milestone, phase, or sequencing implications | `.gsd/ROADMAP.md` |
| important tradeoffs and chosen rationale | `.gsd/DECISIONS.md` |

## When notes-only persistence is enough

Just saving a bounded summary to `JOURNAL.md` is enough when:

- the brainstorm is still exploratory
- the team has not agreed on one direction yet
- you want to preserve options before deciding
- the outcome is useful context, but not official project state yet

This is the default APW path for most brainstorm sessions.

## When direct planning updates are appropriate

Promotion beyond `JOURNAL.md` becomes appropriate when the brainstorm has produced something concrete and agreed, such as:

- a clearer problem statement
- a confirmed user need
- an agreed first feature
- a real backlog slice
- a chosen tradeoff that should guide future work

Even then, APW still treats this as a deliberate update, not a side effect of the brainstorm itself.

## When orchestrator is required

Use orchestrator when brainstorm outcomes change official project understanding across multiple files or across multiple kinds of project memory.

The recommended APW path is:

1. save a bounded summary in `.gsd/JOURNAL.md`
2. let orchestrator synchronize official project memory

This is especially appropriate when the brainstorm affects more than one of:

- `SPEC.md`
- `TODO.md`
- `ROADMAP.md`
- `DECISIONS.md`

It is also the right path when:

- the brainstorm changed scope
- the brainstorm changed milestone or phase direction
- the brainstorm settled a meaningful tradeoff
- another agent or teammate will continue from this point later

## The end-of-brainstorm decision

APW should not leave the user guessing what happened to the brainstorm.

At the end of a meaningful brainstorm, make one of these choices explicit:

1. **Save notes to `JOURNAL.md`**
   - best default for most sessions
2. **Promote agreed outcomes into one or more project files**
   - use this only when the result is concrete enough to be official
3. **Hand off to orchestrator for official synchronization**
   - use this when multiple canonical files need coordinated updates
4. **Do not save yet**
   - use this when the discussion is still too fuzzy

## Beginner-friendly rule of thumb

If you are unsure what to do after `/brainstorm`, use this:

- save the useful summary to `JOURNAL.md`
- if the project plan or official understanding changed, hand off to orchestrator

That is the safe APW path.

## Example

You run:

```text
@product-manager /brainstorm compare three onboarding flows for first-time sellers
```

Possible result:

- the compared options and reasoning go into `JOURNAL.md`
- the chosen onboarding direction may later update `SPEC.md`
- the chosen first implementation slice may later update `TODO.md`
- if that decision also changes milestone focus, orchestrator should synchronize `ROADMAP.md`

## The one-sentence rule

`/brainstorm` helps shape ideas.

`JOURNAL.md` safely preserves the useful outcome.

Orchestrator promotes agreed changes into official project memory when they truly become canonical.
