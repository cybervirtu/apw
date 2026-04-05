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

## 2. Bootstrap the Repo

From the APW checkout, run:

```bash
/path/to/apw/scripts/bootstrap.sh --target . --profile base --stack base
```

Replace `base` with your chosen profile if needed.

## 3. Validate Immediately

Run validation with the same profile and stack used during bootstrap:

```bash
/path/to/apw/scripts/validate.sh . --profile base --stack base
```

Do not skip this step.

It confirms:

- required files exist
- the namespace is correct
- the selected profile is being validated correctly
- key lifecycle and governance files have usable content shape

## 4. Initialize the Project Properly

Before coding starts, do two things:

1. Read:
   - [START_HERE.md](./START_HERE.md)
   - [HOW_APW_WORKS.md](./HOW_APW_WORKS.md)
2. Use one orchestrator-style pass to populate the initial project memory coherently.

At minimum, initialize:

- `.gsd/SPEC.md`
- `.gsd/ROADMAP.md`
- `.gsd/STATE.md`
- `.gsd/TODO.md`
- `.gsd/STACK.md`
- `.gsd/ARCHITECTURE.md`

For `base` and `advanced`, also keep:

- `.gsd/JOURNAL.md`
- `.gsd/DECISIONS.md`

## 5. Begin Work Safely

Once initialized:

1. Start each session from `.gsd/STATE.md` and `.gsd/TODO.md`.
2. Let execution agents implement scoped work.
3. Let execution agents append bounded evidence to `.gsd/JOURNAL.md`.
4. Run an orchestrator or governance sync when `STATE.md`, `ROADMAP.md`, `TODO.md`, or `DECISIONS.md` must change.
5. Re-run validation before merge or release.

## 6. Turn On CI Early

After the first clean validation:

1. Copy [examples/github/apw-validate.yml](../examples/github/apw-validate.yml) into the downstream repo.
2. Set the profile and stack in that workflow.
3. Decide whether warnings are non-blocking or blocking in CI.

## 7. For Existing Repos

If you are adopting APW in an existing repo, do not use this quick start alone.

Read these next:

1. [EXISTING_REPO_MIGRATION_GUIDE.md](./EXISTING_REPO_MIGRATION_GUIDE.md)
2. [PILOT_ADOPTION_PLAN.md](./PILOT_ADOPTION_PLAN.md)

## 8. What to Read Next

If APW makes sense so far, read:

1. [FIRST_PROJECT_WALKTHROUGH.md](./FIRST_PROJECT_WALKTHROUGH.md)
2. [FEATURES_AND_MODES.md](./FEATURES_AND_MODES.md)
3. [COMMON_WORKFLOWS.md](./COMMON_WORKFLOWS.md)

If you want the deeper explanation, read [APW_HANDBOOK.md](./APW_HANDBOOK.md).

## 9. If You Only Remember Five Things

1. Use `base` unless you have a reason not to.
2. Bootstrap and validate with the same profile.
3. Keep `.gsd` as the canonical memory layer.
4. Let execution agents write code and `JOURNAL.md`, not casual summary rewrites.
5. Turn on CI before the repo starts drifting.
