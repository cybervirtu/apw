# WORKFLOW_PERSISTENCE_POLICY.md — Core Workflow Persistence Policy

> [!TIP]
> Use this when you want one clear answer to: "After a workflow runs, what gets saved, where does it go, and what becomes official project memory?"

## What this guide is

This guide defines APW's persistence policy for the core workflows:

- `/status`
- `/brainstorm`
- `/create`
- `/enhance`
- `/debug`
- `/test`
- `/orchestrate`

It exists so users do not have to guess whether workflow output stayed only in chat, became evidence, or became canonical project state.

For the intake model that applies before workflow persistence begins, read [CHAT_FIRST_REQUIREMENT_INGESTION.md](./CHAT_FIRST_REQUIREMENT_INGESTION.md).

## The APW-wide model

APW uses one simple persistence model across workflows:

1. workflow output is **not canonical project state by default**
2. the default safe save path is **bounded evidence in `.gsd/JOURNAL.md`**
3. promotion into canonical `.gsd` files is **deliberate**
4. orchestrator or governance owns **official cross-file synchronization**

That same discipline applies to requirement-bearing chat before or around workflows:

1. classify the chat input first
2. use `JOURNAL.md` as the safe buffer when needed
3. promote official requirement memory deliberately

## The practical default

For the important execution workflows, the preferred default is:

- bounded workflow evidence goes to `.gsd/JOURNAL.md`

That keeps useful work from being lost without pretending chat or execution output automatically became official project memory.

## Core rule: evidence first, then sync

When workflow outcomes affect official project understanding across canonical files, APW uses this path:

1. persist bounded evidence first
2. hand off to orchestrator or governance for official synchronization

This keeps the system safe, visible, and understandable.

## Per-workflow summary

| Workflow | Default persistence | Common promotion targets | Canonical by default? | When orchestrator matters |
| :--- | :--- | :--- | :--- | :--- |
| `/status` | none by default, optional bounded summary in `JOURNAL.md` | `STATE.md`, `TODO.md`, `ROADMAP.md` | no | when status reveals stale official state |
| `/brainstorm` | bounded summary in `JOURNAL.md` | `SPEC.md`, `TODO.md`, `ROADMAP.md`, `DECISIONS.md` | no | when exploration becomes agreed official project understanding |
| `/create` | implementation evidence in `JOURNAL.md` | `TODO.md`, `STATE.md`, `ROADMAP.md`, `DECISIONS.md` | no | when completed work changes official status, backlog, milestone, or rationale |
| `/enhance` | refactor or polish evidence in `JOURNAL.md` | `TODO.md`, `DECISIONS.md`, `STATE.md` | no | when improvement changes official blockers, follow-ups, or rationale |
| `/debug` | debugging evidence in `JOURNAL.md` | `TODO.md`, `DECISIONS.md`, `STATE.md` | no | when root cause or fix changes blockers, readiness, or authoritative rationale |
| `/test` | verification evidence in `JOURNAL.md` | `TODO.md`, `STATE.md`, `ROADMAP.md` | no | when pass/fail results change readiness or milestone understanding |
| `/orchestrate` | decomposition and coordination evidence in `JOURNAL.md` | `TODO.md`, `STATE.md`, `ROADMAP.md`, `DECISIONS.md` | no | commonly; orchestration often ends in deliberate canonical sync |

## Promotion map

Use this mapping across workflows:

| Outcome type | Canonical file |
| :--- | :--- |
| clarified requirements, scope, users, problem framing | `.gsd/SPEC.md` |
| next actions, follow-ups, backlog slices | `.gsd/TODO.md` |
| current progress, blockers, readiness, next-step status | `.gsd/STATE.md` |
| milestone or phase implications | `.gsd/ROADMAP.md` |
| important chosen rationale or architectural tradeoffs | `.gsd/DECISIONS.md` |
| bounded execution, debugging, testing, brainstorming, or orchestration evidence | `.gsd/JOURNAL.md` |

## What is not canonical by default

These do not become official project memory automatically:

- workflow chat output
- agent reasoning
- execution summaries
- brainstorm comparisons
- test logs
- debug notes
- orchestration discussion

They become durable APW memory only through deliberate persistence.

## Beginner rule of thumb

If you are unsure what to do after a workflow finishes:

- save the useful evidence to `JOURNAL.md`
- if official project understanding changed, hand off to orchestrator

That is the safe APW default.

If the meaningful input arrived through plain chat before the workflow even started, follow [CHAT_FIRST_REQUIREMENT_INGESTION.md](./CHAT_FIRST_REQUIREMENT_INGESTION.md) first.
