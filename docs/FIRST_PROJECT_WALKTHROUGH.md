# FIRST_PROJECT_WALKTHROUGH.md — First Project Walkthrough

> [!TIP]
> Read this if you want to see APW used from start to finish on a small realistic project.

## What this is

This is a guided example of starting a project with APW.

It is written for someone who wants a practical path, not just a concept explanation.

## Why it matters

Most people understand a framework faster when they can see the steps in order.

This walkthrough shows:

- what to do first
- what files matter first
- how to begin work safely
- where APW helps in a real project

## Example scenario

Imagine you want to build a small task-tracking web app.

You are starting from scratch and you want:

- a clean project setup
- clear AI guidance
- a durable project memory layer
- validation before the repo drifts

## Step 1: choose a profile

For this example, choose `base`.

Why:

- `minimal` is lighter but leaves out some lifecycle depth
- `base` is the safest default for a normal app
- `advanced` is helpful later if you want richer vendored execution support

## Step 2: bootstrap the project

Run:

```bash
/path/to/apw/scripts/bootstrap.sh --target . --profile base --stack base
```

This creates:

- `.gsd/`
- `.agent/`
- root governance files
- the standard APW structure

## Step 3: validate right away

Run:

```bash
/path/to/apw/scripts/validate.sh . --profile base --stack base
```

This confirms:

- the structure is correct
- the namespace is correct
- the profile matches the validation inputs

## Step 4: initialize the memory layer

Now populate the core `.gsd` files with one orchestrator-style pass.

For the task-tracking app, that might look like:

- `SPEC.md`: “Users can create, edit, and complete tasks.”
- `ROADMAP.md`: milestone 1 is authentication, milestone 2 is task CRUD, milestone 3 is notifications
- `STATE.md`: “We are at project setup. No app code yet. First focus is repo scaffolding and auth.”
- `TODO.md`: first checklist for the setup and auth slice
- `STACK.md`: React, FastAPI, PostgreSQL, Docker
- `ARCHITECTURE.md`: frontend, backend, DB, auth boundary

## Step 5: start the first implementation slice

Now begin the first bounded task.

Example:

- implement project scaffolding
- create the auth skeleton
- add tests for the first working slice

An execution agent should:

- read `STATE.md` and `TODO.md`
- work only on the current slice
- add factual evidence to `JOURNAL.md`

## Step 6: synchronize official project state

Once the first slice is verified:

- do not casually dump everything into `STATE.md`
- instead, run an orchestrator or governance pass

That sync updates the official summary:

- what changed
- what the new next step is
- what tasks move in `TODO.md`

## Step 7: validate before merge

Before merging or pushing the repo toward rollout, run validation again.

Then add CI so the repo keeps checking APW automatically.

## What this looks like in practice

At the end of the first milestone, the repo should feel like this:

- you can open `STATE.md` and know where the project stands
- you can open `TODO.md` and know the next tasks
- you can open `JOURNAL.md` and see evidence of work completed
- the repo validates cleanly

## When to use this document

Use this when:

- you are starting your first APW project
- you want a concrete example instead of abstract guidance
- you want to teach someone else the first-run experience

## Read this next

1. [COMMON_WORKFLOWS.md](./COMMON_WORKFLOWS.md)
2. [FEATURES_AND_MODES.md](./FEATURES_AND_MODES.md)
3. [FAQ.md](./FAQ.md)
