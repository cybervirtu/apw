# GUIDED_PROJECT_STATE_INITIALIZATION.md — Guided Project-State Initialization

> [!TIP]
> Use this right after bootstrap and validation if you want APW to turn a plain-language project brief into the first drafts of the core `.gsd` files.

## What this is

This is APW's guided project initialization flow.

It exists for the moment right after bootstrap, when a new user usually knows the idea but does not want to hunt through multiple `.gsd` files manually.

Instead of asking you to open `SPEC.md`, `STACK.md`, `TODO.md`, `STATE.md`, and `ROADMAP.md` one by one, APW asks a short set of practical questions and writes a coherent first draft for you.

## When to use it

Use this after:

1. bootstrap
2. validation
3. profile selection

Use it before:

1. routine coding
2. command-heavy execution work
3. large orchestrator-led task breakdown

## How to run it

This helper writes state for a downstream project.

That means:

- APW root supplies the script
- the downstream project is the target
- after generation, normal work continues in the downstream project root

If you want the broader location model, read [WHERE_DO_I_WORK.md](./WHERE_DO_I_WORK.md).

From the APW checkout, point the script at the bootstrapped target repo:

```bash
/path/to/apw/scripts/init-project-state.sh --target /path/to/your/repo
```

If you are already inside the target repo, this is enough:

```bash
/path/to/apw/scripts/init-project-state.sh --target .
```

If you intentionally want to replace existing project-state drafts without a confirmation prompt:

```bash
/path/to/apw/scripts/init-project-state.sh --target . --force
```

## What it asks

The guided flow keeps the intake practical.

It asks for:

- project name
- what you are building
- who it is for
- what problem it solves
- the smallest useful first version
- top features
- whether the project is prototype, pilot, or production-oriented
- whether the work is solo or team-based
- preferred stack or technical direction, if any
- important constraints

You answer in plain language.

## What it writes

The helper generates first drafts for:

- `.gsd/SPEC.md`
- `.gsd/STACK.md`
- `.gsd/TODO.md`
- `.gsd/STATE.md`
- `.gsd/ROADMAP.md`

The generated drafts are meant to be:

- coherent with each other
- understandable to a beginner
- safe enough to start from
- easy to refine

## What it does not do

This helper does not replace the APW governance model.

It does not:

- remove orchestrator ownership of canonical state
- let routine execution work casually rewrite official summary files
- replace architecture or decision records when those become necessary
- turn APW into a no-governance prompt pack

It simply gives the project a clean starting state.

## How overwrite works

If the target files still match the bootstrap templates, the helper replaces them directly.

If the files already contain project-specific content, the helper asks before overwriting unless you pass `--force`.

## How this fits the orchestrator model

The key rule stays the same:

- execution work can move quickly
- `JOURNAL.md` can hold bounded evidence
- canonical summary files stay deliberate

The guided initializer is the first deliberate state-creation pass.

After that:

- use execution workflows for bounded implementation work
- use orchestrator when official project state needs synchronized updates

## Best next steps after initialization

1. Read the generated drafts once and fix anything obviously wrong.
2. Start from `AGENTS.md` in the target repo.
3. Use `docs/WORKFLOW_SELECTION_GUIDE.md` to choose the first workflow.
4. Use `docs/COMMAND_INVOCATION_GUIDE.md` to see what that workflow should read and produce.

## If you need more help

- Read [BASIC_ONBOARDING_PROCEDURE.md](./BASIC_ONBOARDING_PROCEDURE.md) for the shortest safe beginner path.
- Read [QUICK_START.md](./QUICK_START.md) for the full beginner bootstrap order.
- Read [IDEA_TO_PROJECT_GUIDE.md](./IDEA_TO_PROJECT_GUIDE.md) if the project idea still feels fuzzy.
- Read [TECH_STACK_SELECTION_GUIDE.md](./TECH_STACK_SELECTION_GUIDE.md) if the stack direction is still unclear.
