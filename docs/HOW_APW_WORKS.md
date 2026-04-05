# HOW_APW_WORKS.md — How APW Works

> [!TIP]
> Read this after `START_HERE.md` if you want the working mental model without diving into policy files.

## What this is

This is the plain-English explanation of how APW works as a system.

It is not the strict contract.
It is the easiest way to understand the contract before reading the stricter docs.

## Why it matters

APW makes more sense once you see the flow:

1. create the workspace
2. initialize project memory
3. execute work in a scoped way
4. sync official project state deliberately
5. validate and enforce the result

Without that flow, the repo can look like “a lot of files.”

## The simple model

Think of APW as three layers:

| Layer | What it does | Where it lives |
| :--- | :--- | :--- |
| Memory | stores requirements, plan, state, and decisions | `.gsd/` |
| Execution | stores prompts, workflows, agents, and reusable skills | `.agent/` |
| Enforcement | bootstraps and validates the workspace | `scripts/` |

## The memory layer

The memory layer is the part of APW that keeps the project understandable.

For `base` and `advanced`, the core files are:

- `SPEC.md`
- `ROADMAP.md`
- `STATE.md`
- `TODO.md`
- `JOURNAL.md`
- `DECISIONS.md`
- `ARCHITECTURE.md`
- `STACK.md`

These files do not all mean the same thing.

- `STATE.md` is the current position
- `TODO.md` is the canonical task list
- `JOURNAL.md` is evidence and chronological notes
- `DECISIONS.md` is design rationale

That separation is important because it reduces project-memory drift.

## The execution layer

The execution layer is where APW stores the things that help agents work inside the repo.

It always lives under `.agent/`.

Important paths:

- `.agent/agents/`
- `.agent/rules/`
- `.agent/scripts/`
- `.agent/workflows/`
- `.agent/skills/`

This is the active APW namespace.
APW does not use a top-level `.agents/` contract.

## The controlled sync rule

This is one of the most important APW ideas:

- execution agents may write code
- execution agents may create artifacts
- execution agents may append bounded evidence to `JOURNAL.md`
- execution agents should not casually rewrite `STATE.md`, `ROADMAP.md`, `TODO.md`, or `DECISIONS.md`

Those canonical summary files are synchronized by an orchestrator or governance pass.

In other words:

- execution work is fast
- canonical memory is controlled

## The lifecycle in practice

The normal APW loop is:

1. bootstrap the workspace
2. validate it
3. initialize canonical `.gsd`
4. run scoped implementation work
5. add evidence to `JOURNAL.md`
6. synchronize canonical state if needed
7. validate before merge or rollout

## Profiles

APW supports three profiles:

| Profile | Use it when |
| :--- | :--- |
| `minimal` | you want the lightest setup |
| `base` | you want the standard APW baseline |
| `advanced` | you want richer vendored execution support |

Important:

`advanced` is not a second, heavier root memory system.
It uses the same canonical `.gsd` contract as `base`.

## Example

Example:

You are building a web app.

You bootstrap with `base`, fill in the first version of `SPEC.md`, `ROADMAP.md`, `STATE.md`, and `TODO.md`, then ask an execution agent to implement the next scoped task.

The agent writes code and appends proof to `JOURNAL.md`.
After the work is verified, an orchestrator sync updates `STATE.md` and `TODO.md`.
Then `validate.sh` checks the repo before merge.

## When to use this document

Use this document when:

- you understand the idea of APW, but not the mechanics yet
- you need the “how it works” explanation before using it
- you want to explain APW to another person simply

## Read this next

1. [FIRST_PROJECT_WALKTHROUGH.md](./FIRST_PROJECT_WALKTHROUGH.md)
2. [FEATURES_AND_MODES.md](./FEATURES_AND_MODES.md)
3. [COMMON_WORKFLOWS.md](./COMMON_WORKFLOWS.md)
