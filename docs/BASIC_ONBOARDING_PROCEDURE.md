# BASIC_ONBOARDING_PROCEDURE.md — Basic Onboarding Procedure

> [!IMPORTANT]
> Use this if you are new to APW and want the shortest safe path to get started without reading the full documentation set first.

## What this guide is

This is the basic first-use procedure for APW.

It is for:

- first-time APW users
- beginners
- non-technical or semi-technical users
- anyone who wants the minimum safe path before going deeper

This guide is intentionally short.

It tells you what to do first, why it matters, what "done" looks like, and where to go only if you need more help.

## Before you begin

You only need to know a few APW ideas to start:

- APW helps organize and guide project work so people and AI tools do not lose track of what is happening.
- `GSD` keeps the official project memory and rules in `.gsd/`.
- `AGK` helps do the work through agents, workflows, and execution support in `.agent/`.
- the orchestrator keeps official project state synchronized when the important summary files need to change.
- `.gsd/JOURNAL.md` is for bounded evidence about what happened during work.
- canonical state files such as `STATE.md`, `ROADMAP.md`, `TODO.md`, and `DECISIONS.md` should stay controlled instead of being rewritten casually.

If that already makes enough sense, keep going.

## Step 1 — Understand APW in one minute

What to do:

- Understand APW as a way to keep project memory, execution work, and validation organized.

Why it matters:

- If you think APW is only a prompt pack or only a code generator, the rest of the setup will feel confusing.

Done looks like:

- You can say, "APW helps me organize project state, guide AI-assisted work, and keep the repo aligned over time."

If you need more help:

- Read [APW_FOR_BEGINNERS.md](./APW_FOR_BEGINNERS.md).

## Step 2 — Identify what kind of project you want to build

What to do:

- Decide what you are trying to build at a simple level, such as a portfolio site, web app, backend API, AI assistant, or internal tool.

Why it matters:

- APW is easier to start when you know the rough shape of the project before choosing a profile or stack direction.

Done looks like:

- You can describe the project in one plain sentence.

If you need more help:

- Read [IDEA_TO_PROJECT_GUIDE.md](./IDEA_TO_PROJECT_GUIDE.md).

## Step 3 — Choose the right APW profile

What to do:

- Choose `minimal`, `base`, or `advanced`.
- If you are unsure, choose `base`.

Why it matters:

- The profile decides how much APW structure and execution material you start with.

Done looks like:

- You have picked a likely profile and can explain it in simple terms.

If you need more help:

- Read [TECH_STACK_SELECTION_GUIDE.md](./TECH_STACK_SELECTION_GUIDE.md).

## Step 4 — Bootstrap the project

What to do:

- Run the APW bootstrap script in the target repo.

```bash
/path/to/apw/scripts/bootstrap.sh --target . --profile base --stack base
```

Why it matters:

- Bootstrap creates the APW structure so you are working from a real framework setup instead of copying pieces by hand.

Done looks like:

- The target repo now has the APW files and folders, including `AGENTS.md`, `.gsd/`, and `.agent/`.

If you need more help:

- Read [QUICK_START.md](./QUICK_START.md).

## Step 5 — Validate the setup

What to do:

- Run validation with the same profile and stack you used during bootstrap.

```bash
/path/to/apw/scripts/validate.sh . --profile base --stack base
```

Why it matters:

- Validation checks that the repo actually matches the APW contract instead of only looking correct at a glance.

Done looks like:

- Validation completes cleanly, or you know exactly what must be fixed before you continue.

If you need more help:

- Read [QUICK_START.md](./QUICK_START.md).

## Step 6 — Initialize canonical `.gsd` state

What to do:

- Run the guided APW project-state initializer after bootstrap and validation.

```bash
/path/to/apw/scripts/init-project-state.sh --target .
```

It generates first drafts for:

- `SPEC.md`
- `ROADMAP.md`
- `STATE.md`
- `TODO.md`
- `STACK.md`

Why it matters:

- APW works best when the project has a clear official starting state before implementation work begins, but new users should not need to hunt through multiple files manually to get there.

Done looks like:

- Someone new to the repo could open `.gsd/STATE.md` and `.gsd/TODO.md` and understand what the project is doing now.
- The five core files tell the same basic project story.

If you need more help:

- Read [GUIDED_PROJECT_STATE_INITIALIZATION.md](./GUIDED_PROJECT_STATE_INITIALIZATION.md).

## Step 7 — Learn the first command or workflow to use

What to do:

- Learn which APW command or workflow fits your first task instead of starting with vague prompting.

Why it matters:

- APW is meant to be operated intentionally. A small amount of workflow guidance saves confusion later.

Done looks like:

- You know which command or workflow you would use for your first real task, or you know exactly where to look before starting.

If you need more help:

- Read [WORKFLOW_SELECTION_GUIDE.md](./WORKFLOW_SELECTION_GUIDE.md).
- Read [COMMAND_INVOCATION_GUIDE.md](./COMMAND_INVOCATION_GUIDE.md).

## Step 8 — Start implementation safely

What to do:

- Start work from `.gsd/STATE.md` and `.gsd/TODO.md`.
- Let execution work stay scoped.
- Add bounded evidence to `.gsd/JOURNAL.md` when useful.

Why it matters:

- This keeps implementation tied to the current project state instead of drifting into disconnected sessions.

Done looks like:

- You can start a real task while staying anchored to the repo's current state and task list.

If you need more help:

- Read [AGENT_PLUS_WORKFLOW_EXAMPLES.md](./AGENT_PLUS_WORKFLOW_EXAMPLES.md).

## Step 9 — Use orchestrator when work becomes larger or cross-cutting

What to do:

- Use orchestrator or a governance pass when the official project story needs to change, especially after larger implementation, design, or verification work.

Why it matters:

- Execution work can move quickly, but canonical state should stay deliberate and controlled.

Done looks like:

- You know that `JOURNAL.md` can hold evidence, but official summary files should be synchronized more carefully.

If you need more help:

- Read [HOW_APW_WORKS.md](./HOW_APW_WORKS.md).
- Read [AGENT_SYSTEM.md](../AGENT_SYSTEM.md).

## Step 10 — Keep validating as the project grows

What to do:

- Re-run validation as you keep building.
- Turn on CI early so the repo stays aligned.

Why it matters:

- APW is not only a day-one setup. It is a way to keep the project healthy over time.

Done looks like:

- Validation is part of your normal project routine, not something you remember only after drift has started.

If you need more help:

- Read [CI_CD_ENFORCEMENT.md](./CI_CD_ENFORCEMENT.md).

## Success checklist

You are in a good starting place if you can say:

- I know what I am building.
- I chose a likely APW profile.
- I bootstrapped the project.
- I validated it.
- I initialized the project state.
- I know which command or workflow to use first.
- I know when orchestrator matters.

## If you need more help

Use only the next doc you need:

- If you need help choosing a project type, read [IDEA_TO_PROJECT_GUIDE.md](./IDEA_TO_PROJECT_GUIDE.md).
- If you need help choosing a stack or profile, read [TECH_STACK_SELECTION_GUIDE.md](./TECH_STACK_SELECTION_GUIDE.md).
- If you want relatable examples, read [REAL_WORLD_EXAMPLES.md](./REAL_WORLD_EXAMPLES.md).
- If you want command and workflow guidance, read [COMMAND_INVOCATION_GUIDE.md](./COMMAND_INVOCATION_GUIDE.md).
- If you want the fuller beginner path, read [START_HERE.md](./START_HERE.md).
