# FAQ.md — Frequently Asked Questions

## What is APW in one sentence?

APW is a workspace standard that combines governed project memory with AI execution tooling so a software project stays understandable and consistent over time.

## Do I need to know GSD or AGK before using APW?

No.

You only need to understand that:

- GSD is the governance and memory side
- AGK is the execution side
- APW combines them

## Which profile should I choose?

Use:

- `minimal` for very small or lightweight repos
- `base` for most projects
- `advanced` when you want richer vendored execution support

If you are unsure, choose `base`.

## Is `advanced` a heavier state model?

No.

`advanced` uses the same canonical `.gsd` contract as `base`.
Its extra depth comes from richer `.agent/` content.

## What files are the most important?

For most repos, the most important files are:

- `PROJECT_RULES.md`
- `AGENT_SYSTEM.md`
- `.gsd/STATE.md`
- `.gsd/TODO.md`
- `.gsd/SPEC.md`
- `.gsd/JOURNAL.md`

## Why does APW separate `JOURNAL.md` from `STATE.md`?

Because they do different jobs.

- `JOURNAL.md` is for evidence and chronological notes
- `STATE.md` is the canonical current position

Keeping them separate reduces drift and noise.

## Can execution agents update `STATE.md` directly?

Not by default.

Execution agents should normally:

- change code
- create artifacts
- append bounded evidence to `JOURNAL.md`

Canonical summary files are updated through orchestrator or governance sync.

## What does “bounded evidence” mean?

It means short, factual, append-only notes about work that was just done.

Examples:

- tests run
- bug reproduction result
- deployment step proof
- verification result

## Do I have to use CI with APW?

Technically no, but it is strongly recommended.

Without CI, drift is easier to miss until later.

## What blocks validation?

Hard failures include things like:

- missing required files
- broken namespace structure
- missing required profile-backed content
- broken content shape in key lifecycle files

Warnings usually mean softer drift, such as legacy namespace leftovers.

## What is the difference between `validate.sh` and `ci-validate.sh`?

- `validate.sh` is the main compliance engine
- `ci-validate.sh` is a thin CI wrapper around it

CI should wrap APW, not reimplement APW separately.

## Can I use APW in an existing repo?

Yes.

Read:

1. [EXISTING_REPO_MIGRATION_GUIDE.md](./EXISTING_REPO_MIGRATION_GUIDE.md)
2. [PILOT_ADOPTION_PLAN.md](./PILOT_ADOPTION_PLAN.md)

## Can I customize APW?

Yes, but carefully.

You can customize:

- project-specific `.gsd` content
- project-local `.agent` rules and prompts
- normal product docs

You should not casually fork or rename core APW contract files.

## What if my repo is a monorepo?

Use APW intentionally at each repo root that needs its own state and execution context.

Read [MONOREPO_ADAPTATION.md](./MONOREPO_ADAPTATION.md).

## What if I only use one AI tool?

That is fine.

APW is still useful because it gives you:

- durable state
- clearer handoffs between sessions
- a validator and CI enforcement path

## What should a beginner read first?

Start here:

1. [QUICK_START.md](./QUICK_START.md)
2. [APW_HANDBOOK.md](./APW_HANDBOOK.md)
3. [FEATURES_AND_MODES.md](./FEATURES_AND_MODES.md)
4. [WORKFLOW_REFERENCE.md](./WORKFLOW_REFERENCE.md)
