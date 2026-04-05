# COMMON_WORKFLOWS.md — Common Workflows

> [!TIP]
> This is the practical “how do I actually use APW day to day?” document.

## What this is

This doc explains the most common APW workflows in plain language.

It is the everyday-use companion to the architecture and handbook docs.

## Why it matters

APW becomes much easier once you understand the repeatable workflows.

You do not need to memorize every policy file.
You mostly need to know the right loop for the situation you are in.

## Workflow 1: start a new session

### When to use it

Use this whenever you open a fresh chat or begin a new block of work.

### The flow

1. Read `.gsd/STATE.md`
2. Read `.gsd/TODO.md`
3. Read `.gsd/SPEC.md` if behavior changes are involved
4. Read relevant `.agent/rules/`
5. Confirm the current task before writing code

### Example

“Read `.gsd/STATE.md` and `.gsd/TODO.md`, then implement only the next checklist item.”

## Workflow 2: implement a feature

### When to use it

Use this when adding a planned feature or milestone slice.

### The flow

1. Confirm the feature belongs in the current plan
2. Make sure `SPEC.md` and `ROADMAP.md` reflect it
3. Break the active slice into `TODO.md`
4. Execute the feature in a bounded way
5. Verify the result
6. Append evidence to `JOURNAL.md`
7. Sync canonical state if the official project summary changed
8. Validate before merge

### Example

You add notification settings to a user dashboard.
The execution agent builds the UI and tests it, writes proof into `JOURNAL.md`, then an orchestrator sync updates `STATE.md` and `TODO.md`.

## Workflow 3: fix a bug

### When to use it

Use this when correcting a scoped regression or broken behavior.

### The flow

1. Reproduce the issue
2. Read `STATE.md` and `TODO.md`
3. Fix only the bug
4. Verify with tests or reproducible proof
5. Log the evidence in `JOURNAL.md`
6. Sync canonical state if blockers or next steps changed
7. Validate before merge

### Example

You fix a checkout total calculation bug and record the proof in `JOURNAL.md`.

## Workflow 4: run an orchestrator sync

### When to use it

Use this when the project’s official state needs to change.

### The flow

1. Read recent code changes and `JOURNAL.md`
2. Update `STATE.md` if the current position changed
3. Update `TODO.md` if canonical tasks changed
4. Update `ROADMAP.md` if phase or milestone status changed
5. Update `DECISIONS.md` if design rationale changed

### Example

After finishing the auth slice, the orchestrator updates `STATE.md` to say auth is working, closes the completed checklist items, and promotes the next feature slice.

## Workflow 5: migrate an existing repo

### When to use it

Use this when the project already exists and APW is being introduced later.

### The flow

1. Inventory current docs, tickets, and AI rules
2. Bootstrap APW into the repo
3. Validate immediately
4. Translate current knowledge into canonical `.gsd`
5. Run one orchestrator sync
6. Deliver one APW-managed work cycle
7. Turn on CI

### Example

A team with a working app and scattered AI prompts moves the project into APW without redesigning the product itself.

## Workflow 6: work in a team

### When to use it

Use this when several people and AI tools share one APW repo.

### The flow

1. Agree on the profile and stack
2. Choose who performs canonical state sync
3. Keep execution agents scoped to implementation
4. Use `JOURNAL.md` for evidence
5. Validate before merge
6. Use CI to block structural drift

### Example

One teammate acts as the orchestrator for milestone closeout while other contributors focus on code and tests.

## Workflow 7: use APW in a monorepo

### When to use it

Use this when one repository contains multiple applications or deployable units.

### The flow

1. Decide which directories should be APW roots
2. Bootstrap each APW root intentionally
3. Validate each APW root separately
4. Keep state local unless the change is truly cross-package

### Example

`apps/api` and `apps/web` each keep their own `.gsd` state instead of fighting over one shared execution context.

## Workflow 8: upgrade APW in a downstream repo

### When to use it

Use this when the APW standard has changed and you want to refresh a downstream repo.

### The flow

1. Re-run `bootstrap.sh` with the current profile and stack
2. Avoid `--force` unless lifecycle templates should truly be replaced
3. Re-run validation
4. Review warnings
5. Update CI references if APW is pinned in CI

### Example

You adopt a newer APW version that improves CI enforcement and documentation, then refresh the repo and revalidate it.

## What to remember

Most APW work is just this:

- read current state
- execute in scope
- log evidence
- sync official memory deliberately
- validate before merge

## Read this next

1. [FEATURES_AND_MODES.md](./FEATURES_AND_MODES.md)
2. [TEAM_ADOPTION_GUIDE.md](./TEAM_ADOPTION_GUIDE.md)
3. [CI_CD_ENFORCEMENT.md](./CI_CD_ENFORCEMENT.md)
