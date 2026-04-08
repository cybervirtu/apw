# BASIC_USAGE_GUIDE.md — Basic Usage Guide

> [!IMPORTANT]
> Use this after APW is installed and you want the shortest safe path to start using it on a real project.

## Before you start

Keep this model in mind:

- `APW root` is the framework repo
- `downstream project root` is the real repo where day-to-day work happens
- `workspace parent folder` is just the organizer around them

The simple rule is:

- create projects from APW
- do normal implementation work inside the downstream project root

If you want the fuller location model, read [WHERE_DO_I_WORK.md](./WHERE_DO_I_WORK.md).

In the APW documentation levels, this is a `Level 1 — Start now` guide.
For the full level model, read [DOCUMENTATION_LEVELS.md](./DOCUMENTATION_LEVELS.md).

These terminal fallbacks assume you already installed the workspace launcher from APW root with `./scripts/install-workspace-launcher.sh` and sourced the generated `../.apw/env.zsh`.

## 1. Create your first project

Prefer the action:

- `APW: Create Project`

Terminal fallback from the APW root:

```bash
apw new MyProject --profile base --stack base
```

Default destination policy:

- from APW root, APW creates the new repo in the parent workspace beside `apw`
- from the workspace parent, APW creates the new repo in the current folder
- from a downstream project, APW creates the new repo as a sibling in the same workspace parent
- use `--target /path/to/parent` when you want a different parent location

If you want to choose the parent directory explicitly:

```bash
apw new MyProject --profile base --stack base --target /path/to/MyWork
```

Done looks like:

- APW creates the downstream repo
- APW prints the resolved parent and final destination before bootstrap
- validation runs
- the new repo contains `AGENTS.md`, `.gsd/`, and `.agent/`

## 2. Initialize project state

Once the project exists, give it real `.gsd` content.

Prefer the action:

- `APW: Initialize Project State`

Terminal fallback:

```bash
/path/to/apw/scripts/init-project-state.sh --target /path/to/MyProject
```

If you are already inside the downstream project root:

```bash
/path/to/apw/scripts/init-project-state.sh --target .
```

Done looks like:

- `SPEC.md`, `STACK.md`, `STATE.md`, `TODO.md`, and `ROADMAP.md` tell a real project story

## 3. Open the downstream project

Move into the downstream project root and open your IDE there.

That is the normal place to work day to day.

If you are unsure which folder is the right one, think:

- `APW: Show Context`
- `APW: List Projects`
- `APW: Switch To Project`

Terminal fallback:

```bash
apw context
apw list-projects
apw switch MyProject
```

## 4. Read `AGENTS.md`

Open the downstream project's root `AGENTS.md` first.

It should tell you:

- what APW is in practical terms
- the core operating rule
- what to do first
- which docs to open only if needed

## 5. Run first-run guidance

Prefer the action:

- `APW: First Run`

Terminal fallback:

```bash
apw first-run /path/to/MyProject
```

This gives you the short next-step checklist for the repo you just opened.

## 6. Choose your first workflow

Use this simple rule:

- use `/brainstorm` if the idea or first step is still unclear
- use `/create` if the first feature is already clear
- use `/orchestrate` if the work is large or cross-cutting
- use `/status` if you are returning later or need orientation first

Run these workflows from the downstream project root.

## 7. Start implementation safely

Once the project is initialized:

1. start from `.gsd/STATE.md` and `.gsd/TODO.md`
2. keep implementation work scoped
3. use `.gsd/JOURNAL.md` for bounded evidence
4. use orchestrator when official summary state needs synchronized updates

## If you are stuck

Read now:

1. [FIRST_RUN_IN_IDE.md](./FIRST_RUN_IN_IDE.md)
2. [../COMMAND_CHEATSHEET.md](../COMMAND_CHEATSHEET.md)

Only if needed:

3. [WHERE_DO_I_WORK.md](./WHERE_DO_I_WORK.md)
4. [SAFE_CONTEXT_SWITCHING.md](./SAFE_CONTEXT_SWITCHING.md)
5. [WORKFLOW_SELECTION_GUIDE.md](./WORKFLOW_SELECTION_GUIDE.md)
6. [COMMAND_INVOCATION_GUIDE.md](./COMMAND_INVOCATION_GUIDE.md)

## What to read next

Read now:

1. [FIRST_RUN_IN_IDE.md](./FIRST_RUN_IN_IDE.md)
2. [BASIC_ONBOARDING_PROCEDURE.md](./BASIC_ONBOARDING_PROCEDURE.md)

Only if needed:

3. [GUIDED_PROJECT_STATE_INITIALIZATION.md](./GUIDED_PROJECT_STATE_INITIALIZATION.md)
4. [WHERE_DO_I_WORK.md](./WHERE_DO_I_WORK.md)
5. [SAFE_CONTEXT_SWITCHING.md](./SAFE_CONTEXT_SWITCHING.md)
6. [../COMMAND_CHEATSHEET.md](../COMMAND_CHEATSHEET.md)
