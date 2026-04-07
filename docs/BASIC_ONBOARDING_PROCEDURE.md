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

For the explicit APW reading levels, read [DOCUMENTATION_LEVELS.md](./DOCUMENTATION_LEVELS.md).
If you still need local setup steps first, read [INSTALLATION_GUIDE.md](./INSTALLATION_GUIDE.md).
If you want the short first-use path after setup, read [BASIC_USAGE_GUIDE.md](./BASIC_USAGE_GUIDE.md).

## Where you should normally work

Use this quick rule:

- create new projects from anywhere with `APW: Create Project`
- do day-to-day project work inside the downstream project root
- use APW root mainly when you are maintaining APW itself
- treat the workspace parent folder as an organizer, not the normal place for project workflows

If you want the full version of that model, read [WHERE_DO_I_WORK.md](./WHERE_DO_I_WORK.md).
If you want safe helpers for moving between those places, read [SAFE_CONTEXT_SWITCHING.md](./SAFE_CONTEXT_SWITCHING.md).
If you want the in-IDE first-run checklist, read [FIRST_RUN_IN_IDE.md](./FIRST_RUN_IN_IDE.md).
If you want the one-minute command reference, read [../COMMAND_CHEATSHEET.md](../COMMAND_CHEATSHEET.md).
If you want the preferred chat/IDE action model, read [APW_ACTION_MODEL.md](./APW_ACTION_MODEL.md).

## Preferred interaction path

Use this rule:

- easiest path = chat-first or IDE-friendly APW action
- terminal commands = fallback, power-user, and automation path

That keeps APW easier for beginners without removing the existing command layer.

For the first beginner layer, think in these actions:

- `APW: Create Project`
- `APW: Initialize Project State`
- `APW: First Run`

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

## Step 4 — Create the project workspace

What to do:

- Prefer the beginner-friendly action:
  - `APW: Create Project`
- Use the workspace-friendly APW wrapper as the terminal fallback from wherever you are in the workspace.

```bash
/path/to/apw/apw new MyProject --profile base --stack base
```

Default destination policy:

- from APW root, APW creates the repo in the parent workspace beside `apw`
- from the workspace parent, APW creates the repo in the current folder
- from a downstream project, APW creates the repo as a sibling in the same workspace parent
- use `--target /path/to/parent` when you want a different parent location

Why it matters:

- This is the easiest way to create a new APW project without manually creating the directory, switching context, and wiring bootstrap and validation together yourself.

Done looks like:

- The new project directory exists and already contains `AGENTS.md`, `.gsd/`, and `.agent/`.
- APW prints the resolved parent and exact destination before creation.
- The wrapper tells you exactly where the project was created.
- You know that the new downstream project root is now the normal place to work.
- You know you can recover later with `apw list-projects` and `apw switch project <name>` if you lose track of the right repo.

If you need more help:

- Read [QUICK_START.md](./QUICK_START.md).
- Read [SAFE_CONTEXT_SWITCHING.md](./SAFE_CONTEXT_SWITCHING.md).

Later, when APW itself is updated and you want this project to receive the newer APW-managed framework layer safely, use:

- `APW: Preview Upgrade`
  Terminal fallback:

```bash
/path/to/apw/apw upgrade-project MyProject --dry-run
```

## Step 5 — Validate the setup

What to do:

- If you created the repo with `apw new`, validation already ran for you.
- Re-run validation manually any time you want to confirm the repo still matches the contract.
- Think of the command below as the exact fallback, not the main beginner path.

```bash
/path/to/apw/scripts/validate.sh /path/to/MyProject --profile base --stack base
```

Why it matters:

- Validation checks that the repo actually matches the APW contract instead of only looking correct at a glance.

Done looks like:

- Validation completes cleanly, or you know exactly what must be fixed before you continue.

If you need more help:

- Read [QUICK_START.md](./QUICK_START.md).

## Step 6 — Initialize canonical `.gsd` state

What to do:

- Prefer the beginner-friendly action:
  - `APW: Initialize Project State`
- Move into the downstream project root if you are not already there.
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

- If you are unsure what to do first after opening the repo, think:
  - `APW: First Run`
- Learn which APW command or workflow fits your first task instead of starting with vague prompting.
- Run those project workflows from the downstream project root, not from APW root or the workspace parent folder.

Use this simple first-run rule:

- use `/brainstorm` if the idea or first step is still unclear
- use `/create` if the first feature is already clear
- use `/orchestrate` if the project work is large or cross-cutting
- use `/status` if you are returning later or need orientation first

If you use `/brainstorm`, remember:

- the session helps shape ideas
- useful outcomes should usually be saved to `.gsd/JOURNAL.md`
- official project changes should be synchronized deliberately, usually through orchestrator

Why it matters:

- APW is meant to be operated intentionally. A small amount of workflow guidance saves confusion later.

Done looks like:

- You know which command or workflow you would use for your first real task, or you know exactly where to look before starting.

If you need more help:

- Read [FIRST_RUN_IN_IDE.md](./FIRST_RUN_IN_IDE.md).
- Read [BRAINSTORM_PERSISTENCE_AND_PROMOTION.md](./BRAINSTORM_PERSISTENCE_AND_PROMOTION.md).
- Read [WORKFLOW_SELECTION_GUIDE.md](./WORKFLOW_SELECTION_GUIDE.md).
- Read [COMMAND_INVOCATION_GUIDE.md](./COMMAND_INVOCATION_GUIDE.md).

Ignore for now:

- `PROJECT_RULES.md`
- `AGENT_SYSTEM.md`
- `COMMAND_POLICY.md`

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

- If you want the workspace-friendly creation command details, read [QUICK_START.md](./QUICK_START.md).
- If you want the workspace/project context model, read [WHERE_DO_I_WORK.md](./WHERE_DO_I_WORK.md).
- If you want the in-IDE first-run checklist, read [FIRST_RUN_IN_IDE.md](./FIRST_RUN_IN_IDE.md).
- If you need help choosing a project type, read [IDEA_TO_PROJECT_GUIDE.md](./IDEA_TO_PROJECT_GUIDE.md).
- If you need help choosing a stack or profile, read [TECH_STACK_SELECTION_GUIDE.md](./TECH_STACK_SELECTION_GUIDE.md).
- If you want relatable examples, read [REAL_WORLD_EXAMPLES.md](./REAL_WORLD_EXAMPLES.md).
- If you want command and workflow guidance, read [COMMAND_INVOCATION_GUIDE.md](./COMMAND_INVOCATION_GUIDE.md).
- If you want the fuller beginner path, read [START_HERE.md](./START_HERE.md).
