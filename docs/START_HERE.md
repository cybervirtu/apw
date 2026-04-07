# START_HERE.md — Start Here

> [!IMPORTANT]
> Use this as the guided map for the beginner APW docs after you open the README.

## What this is

This page is the guided map for APW.

It explains what to read first, what to read next, and where to branch depending on what you want to do.

If you arrived here from repo-root `AGENTS.md`, you are on the right path:
`AGENTS.md` is the tool-facing entrypoint, and this page is the beginner-friendly human walkthrough.

If you want the shortest safe first-use path instead of the fuller guided map, read [BASIC_ONBOARDING_PROCEDURE.md](./BASIC_ONBOARDING_PROCEDURE.md) first.

## Why it matters

APW has a real operating model behind it.

If you jump straight into policy files, it can feel heavier than it really is.

This page gives you the simple version of the navigation:

- APW is a way to keep AI-assisted software projects organized
- it separates project memory from project execution
- it gives you bootstrap, validation, and CI so the structure does not decay
- Codex and newer Antigravity-style sessions should start from root `AGENTS.md`, then follow the APW docs from here

## What APW is in one minute

APW stands for **Agentic Project Workspace**.

It is a framework for building software with humans and AI agents without losing track of:

- what the project is trying to do
- what work is in progress
- what rules the repo follows
- what the next contributor needs to know

APW does this with two main layers:

- `.gsd/` for governed project memory
- `.agent/` for execution rules, workflows, and skills

And two main scripts:

- `bootstrap.sh` to create the workspace
- `validate.sh` to check that the workspace still matches the contract

## When to use APW

Use APW when:

- you want to start a new project cleanly
- you use AI coding assistants and want less context drift
- you want a repo that is easier to hand off between sessions or teammates
- you want validation and CI to catch structural drift early

APW is especially helpful when the project will live longer than a single burst of coding.

## Example

Example:

You start a new product repo, bootstrap APW with the `base` profile, validate it, initialize the canonical `.gsd` files once, then let execution agents implement scoped work while an orchestrator syncs the official state when needed.

That gives you:

- a clear roadmap
- a current project state
- a controlled task list
- a log of evidence
- CI checks that stop the workspace from drifting

## Recommended beginner path

If you are new, read these in order:

1. [APW_FOR_BEGINNERS.md](./APW_FOR_BEGINNERS.md)
2. [APW_VISUAL_OVERVIEW.md](./APW_VISUAL_OVERVIEW.md)
3. [IDEA_TO_PROJECT_GUIDE.md](./IDEA_TO_PROJECT_GUIDE.md)
4. [TECH_STACK_SELECTION_GUIDE.md](./TECH_STACK_SELECTION_GUIDE.md)
5. [REAL_WORLD_EXAMPLES.md](./REAL_WORLD_EXAMPLES.md)
6. [QUICK_START.md](./QUICK_START.md)

This path answers:

- what APW is
- how it works
- how an idea becomes a project
- how to choose a likely profile and stack direction
- what APW looks like on real project ideas
- how to start safely

## If you want to build now

Go here next:

1. [QUICK_START.md](./QUICK_START.md)
2. [WORKFLOW_SELECTION_GUIDE.md](./WORKFLOW_SELECTION_GUIDE.md)
3. [COMMAND_INVOCATION_GUIDE.md](./COMMAND_INVOCATION_GUIDE.md)
4. [AGENT_PLUS_WORKFLOW_EXAMPLES.md](./AGENT_PLUS_WORKFLOW_EXAMPLES.md)

## If you want the deeper framework layer

Go here next:

1. [HOW_APW_WORKS.md](./HOW_APW_WORKS.md)
2. [APW_HANDBOOK.md](./APW_HANDBOOK.md)
3. [COMPATIBILITY_MODEL.md](./COMPATIBILITY_MODEL.md)
4. [FIRST_PROJECT_WALKTHROUGH.md](./FIRST_PROJECT_WALKTHROUGH.md)

## What to read next

If you want the shortest safe onboarding path, go to [BASIC_ONBOARDING_PROCEDURE.md](./BASIC_ONBOARDING_PROCEDURE.md) first.
If you have not read it yet, go to [APW_FOR_BEGINNERS.md](./APW_FOR_BEGINNERS.md) first.
If you already understand the plain-English intro, go to [APW_VISUAL_OVERVIEW.md](./APW_VISUAL_OVERVIEW.md) next.
