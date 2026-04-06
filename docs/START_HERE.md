# START_HERE.md — Start Here

> [!IMPORTANT]
> This is the first document a new APW user should read.

## What this is

This page is the front door to APW.

It explains, in plain language, what APW is, why people use it, and what to read next.

If you arrived here from repo-root `AGENTS.md`, you are on the right path:
`AGENTS.md` is the tool-facing entrypoint, and this page is the beginner-friendly human walkthrough.

## Why it matters

APW has a real operating model behind it.

If you jump straight into policy files, it can feel heavier than it really is.

This page gives you the simple version first:

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

## Read this next

If you only have 10 minutes:

1. Root `AGENTS.md`
2. [QUICK_START.md](./QUICK_START.md)
3. [HOW_APW_WORKS.md](./HOW_APW_WORKS.md)
4. [FIRST_PROJECT_WALKTHROUGH.md](./FIRST_PROJECT_WALKTHROUGH.md)
5. [DIAGRAMS.md](./DIAGRAMS.md)

If you want the full framework explanation after that:

- [APW_HANDBOOK.md](./APW_HANDBOOK.md)
