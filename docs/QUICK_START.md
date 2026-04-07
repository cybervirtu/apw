# QUICK_START.md — Quick Start

> [!TIP]
> This is the fastest safe path to start using APW on a real project.

## What this is

This is the shortest safe route from “I found APW” to “I have a usable project workspace.”

## Why it matters

APW is easiest to understand when you use it once in the right order.

This document keeps you from:

- picking the wrong profile casually
- skipping validation
- starting work before canonical project memory exists

## When to use it

Use this for:

- a brand-new project
- a first APW trial
- a quick onboarding pass before deeper reading

If you are migrating an existing repo, use this together with the migration docs, not instead of them.

## Workspace context first

Before you do anything else, keep this model in mind:

| Location | Use It For | Avoid |
| :--- | :--- | :--- |
| `APW root` | framework maintenance, templates, bootstrap/validation engine, `apw new` | day-to-day downstream project work |
| `downstream project root` | normal project work, `AGENTS.md`, slash workflows, `.gsd` state, code changes | treating it as the source of APW framework updates |
| `workspace parent folder` | organizing APW plus multiple projects, launching `apw new` | normal project workflows |

If you want the fuller guide, read [WHERE_DO_I_WORK.md](./WHERE_DO_I_WORK.md).
If you want safe switching helpers for those locations, read [SAFE_CONTEXT_SWITCHING.md](./SAFE_CONTEXT_SWITCHING.md).
If you want the in-IDE first-run checklist, read [FIRST_RUN_IN_IDE.md](./FIRST_RUN_IN_IDE.md).
If you want the preferred chat/IDE action model, read [APW_ACTION_MODEL.md](./APW_ACTION_MODEL.md).

## Preferred interaction path

APW is not terminal-only.

Use this order when possible:

1. chat-first request
2. IDE action or command-palette style action
3. terminal command fallback

The terminal path still matters, but it is no longer the only mental model.

For the first beginner layer, use these action names:

- `APW: Create Project`
- `APW: Initialize Project State`
- `APW: First Run`

## 1. Choose a Profile

Use this table:

| Profile | Choose it when |
| :--- | :--- |
| `minimal` | You want the lightest possible setup for a small repo or prototype |
| `base` | You want the standard APW setup for most software projects |
| `advanced` | You want richer vendored specialist agents and workflows in addition to the standard `.gsd` contract |

If you are unsure, use `base`.

## Example

Example:

You are starting a normal product repo for a web app.
Choose `base`, not `minimal`, because you want the full canonical lifecycle set without needing the heavier execution bundle from `advanced`.

## 2. Create the Repo From Anywhere

The easiest beginner path is:

- `APW: Create Project`

Terminal fallback:

```bash
/path/to/apw/apw new MyProject --profile base --stack base
```

If you want to choose the parent directory explicitly:

```bash
/path/to/apw/apw new MyProject --profile base --stack base --target /path/to/MyWork
```

If you want the wrapper to launch guided state initialization immediately after validation:

```bash
/path/to/apw/apw new MyProject --profile base --stack base --init-state
```

Use raw bootstrap directly only when you intentionally want the lower-level engine:

```bash
/path/to/apw/scripts/bootstrap.sh --target . --profile base --stack base
```

## 3. Validate Immediately

`apw new` runs validation for you by default.

If you used raw bootstrap directly, or you want to re-check the repo later, run validation with the same profile and stack:

```bash
/path/to/apw/scripts/validate.sh /path/to/MyProject --profile base --stack base
```

Do not skip this step.

It confirms:

- required files exist
- the namespace is correct
- the selected profile is being validated correctly
- key lifecycle and governance files have usable content shape

## 4. Start From `AGENTS.md`

After project creation and validation, move into the downstream project root and open root `AGENTS.md` there.

That is the modern APW entrypoint for Codex, Antigravity, and similarly compatible tooling.

From there, follow the linked APW governance and handbook docs instead of treating `AGENTS.md` as a complete replacement for the framework.

If you want the shortest next-step action instead of remembering the command, think:

- `APW: First Run`

If you lose track of the right folder later, recover with:

```bash
/path/to/apw/apw context
/path/to/apw/apw list-projects
/path/to/apw/apw switch project <name>
```

If APW itself evolves later and you want this downstream repo to receive the newer APW-managed files safely, use:

```bash
/path/to/apw/apw upgrade-project MyProject --dry-run
```

## 5. How To Invoke Work

Once you are oriented, use the operator docs instead of improvising:

1. [FIRST_RUN_IN_IDE.md](./FIRST_RUN_IN_IDE.md)
2. [COMMAND_INVOCATION_GUIDE.md](./COMMAND_INVOCATION_GUIDE.md)
3. [WORKFLOW_SELECTION_GUIDE.md](./WORKFLOW_SELECTION_GUIDE.md)
4. [AGENT_PLUS_WORKFLOW_EXAMPLES.md](./AGENT_PLUS_WORKFLOW_EXAMPLES.md)

These explain which command to use, which agent to pair with it, what context it should read first, and when orchestrator sync is required.

## 6. Initialize the Project Properly

Before coding starts, do two things:

1. Read:
   - [START_HERE.md](./START_HERE.md)
   - [HOW_APW_WORKS.md](./HOW_APW_WORKS.md)
2. Prefer the action:
   - `APW: Initialize Project State`
   Terminal fallback:

```bash
/path/to/apw/scripts/init-project-state.sh --target .
```

This writes:

- `.gsd/SPEC.md`
- `.gsd/ROADMAP.md`
- `.gsd/STATE.md`
- `.gsd/TODO.md`
- `.gsd/STACK.md`

Then keep:

- `.gsd/JOURNAL.md` for bounded evidence during work
- `.gsd/ARCHITECTURE.md` when the technical shape needs to be made explicit
- `.gsd/DECISIONS.md` when rationale needs to become canonical

## 7. Begin Work Safely

Once initialized:

1. Start each session from `.gsd/STATE.md` and `.gsd/TODO.md`.
2. Let execution agents implement scoped work.
3. Let execution agents append bounded evidence to `.gsd/JOURNAL.md`.
4. Run an orchestrator or governance sync when `STATE.md`, `ROADMAP.md`, `TODO.md`, or `DECISIONS.md` must change.
5. Re-run validation before merge or release.

## 8. Turn On CI Early

After the first clean validation:

1. Copy [examples/github/apw-validate.yml](../examples/github/apw-validate.yml) into the downstream repo.
2. Set the profile and stack in that workflow.
3. Decide whether warnings are non-blocking or blocking in CI.

## 9. For Existing Repos

If you are adopting APW in an existing repo, do not use this quick start alone.

Read these next:

1. [EXISTING_REPO_MIGRATION_GUIDE.md](./EXISTING_REPO_MIGRATION_GUIDE.md)
2. [PILOT_ADOPTION_PLAN.md](./PILOT_ADOPTION_PLAN.md)

## 10. What to Read Next

If the repo exists and you want to keep moving:

1. Read [FIRST_RUN_IN_IDE.md](./FIRST_RUN_IN_IDE.md) to get the short in-editor checklist.
2. Read [WORKFLOW_SELECTION_GUIDE.md](./WORKFLOW_SELECTION_GUIDE.md) to choose the right command.
3. Read [COMMAND_INVOCATION_GUIDE.md](./COMMAND_INVOCATION_GUIDE.md) to understand what that command should read and produce.
4. Read [AGENT_PLUS_WORKFLOW_EXAMPLES.md](./AGENT_PLUS_WORKFLOW_EXAMPLES.md) to see the real invocation pattern.
5. Read [WHERE_DO_I_WORK.md](./WHERE_DO_I_WORK.md) if you want the workspace/project context model in one place.

If you want more beginner context before doing that, go back to:

1. [IDEA_TO_PROJECT_GUIDE.md](./IDEA_TO_PROJECT_GUIDE.md)
2. [TECH_STACK_SELECTION_GUIDE.md](./TECH_STACK_SELECTION_GUIDE.md)
3. [REAL_WORLD_EXAMPLES.md](./REAL_WORLD_EXAMPLES.md)

If you want the deeper reference layer, read [APW_HANDBOOK.md](./APW_HANDBOOK.md).

## 11. If You Only Remember Nine Things

1. Use `base` unless you have a reason not to.
2. Bootstrap and validate with the same profile.
3. Start tool sessions from root `AGENTS.md`.
4. Use the operator guides instead of vague prompts.
5. Keep `.gsd` as the canonical memory layer.
6. Let execution agents write code and `JOURNAL.md`, not casual summary rewrites.
7. Turn on CI before the repo starts drifting.
8. Normal project workflows belong in the downstream project root, not APW root.
9. When APW itself changes later, use `apw upgrade-project` before reaching for raw bootstrap on an existing repo.
