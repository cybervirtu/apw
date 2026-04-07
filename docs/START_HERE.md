# START_HERE.md — Start Here

> [!IMPORTANT]
> Use this as the guided map for the beginner APW docs after you open the README.

## What this is

This page is the guided map for APW.

It explains what to read first, what to read next, and where to branch depending on what you want to do.

If you arrived here from repo-root `AGENTS.md`, you are on the right path:
`AGENTS.md` is the tool-facing entrypoint, and this page is the beginner-friendly human walkthrough.

If you want the shortest safe first-use path instead of the fuller guided map, read [BASIC_ONBOARDING_PROCEDURE.md](./BASIC_ONBOARDING_PROCEDURE.md) first.
If you want the setup path first, read [INSTALLATION_GUIDE.md](./INSTALLATION_GUIDE.md).
If you want the shortest "what do I do after install?" path, read [BASIC_USAGE_GUIDE.md](./BASIC_USAGE_GUIDE.md).
If you want the one-minute command reference, read [../COMMAND_CHEATSHEET.md](../COMMAND_CHEATSHEET.md).
If you want the preferred chat-first and IDE-friendly action model, read [APW_ACTION_MODEL.md](./APW_ACTION_MODEL.md).
If you want the explicit reading-level model, read [DOCUMENTATION_LEVELS.md](./DOCUMENTATION_LEVELS.md).
If you want the simple answer to "where should I actually work?", read [WHERE_DO_I_WORK.md](./WHERE_DO_I_WORK.md).
If you want explicit helpers for moving between APW root, project roots, and the workspace parent, read [SAFE_CONTEXT_SWITCHING.md](./SAFE_CONTEXT_SWITCHING.md).
If you want the short in-IDE checklist for a downstream project, read [FIRST_RUN_IN_IDE.md](./FIRST_RUN_IN_IDE.md).

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

You start a new product repo, create it with `apw new`, move into the downstream project root, initialize the canonical `.gsd` files once, then let execution agents implement scoped work while an orchestrator syncs the official state when needed.

When you launch `apw new` from APW root, APW creates the downstream repo in the parent workspace beside `apw` by default.
Use `--target /path/to/parent` only when you want a different parent location explicitly.

That gives you:

- a clear roadmap
- a current project state
- a controlled task list
- a log of evidence
- CI checks that stop the workspace from drifting

## The three APW documentation levels

### Level 1 — Start now

Read these now:

1. [INSTALLATION_GUIDE.md](./INSTALLATION_GUIDE.md)
2. [BASIC_USAGE_GUIDE.md](./BASIC_USAGE_GUIDE.md)
3. [BASIC_ONBOARDING_PROCEDURE.md](./BASIC_ONBOARDING_PROCEDURE.md)
4. [FIRST_RUN_IN_IDE.md](./FIRST_RUN_IN_IDE.md)
5. [../COMMAND_CHEATSHEET.md](../COMMAND_CHEATSHEET.md)
6. [QUICK_START.md](./QUICK_START.md)

This level answers:

- what to open first
- how to create a project
- what to do first in the IDE
- what command or workflow to use first

### Level 2 — Use APW better

Read these only when the next question appears:

1. [IDEA_TO_PROJECT_GUIDE.md](./IDEA_TO_PROJECT_GUIDE.md)
2. [TECH_STACK_SELECTION_GUIDE.md](./TECH_STACK_SELECTION_GUIDE.md)
3. [WHERE_DO_I_WORK.md](./WHERE_DO_I_WORK.md)
4. [SAFE_CONTEXT_SWITCHING.md](./SAFE_CONTEXT_SWITCHING.md)
5. [GUIDED_PROJECT_STATE_INITIALIZATION.md](./GUIDED_PROJECT_STATE_INITIALIZATION.md)
6. [WORKFLOW_SELECTION_GUIDE.md](./WORKFLOW_SELECTION_GUIDE.md)
7. [COMMAND_INVOCATION_GUIDE.md](./COMMAND_INVOCATION_GUIDE.md)

### Level 3 — Deep reference

Read these later, or when you are doing framework work:

1. [HOW_APW_WORKS.md](./HOW_APW_WORKS.md)
2. [APW_HANDBOOK.md](./APW_HANDBOOK.md)
3. [COMPATIBILITY_MODEL.md](./COMPATIBILITY_MODEL.md)
4. [FIRST_PROJECT_WALKTHROUGH.md](./FIRST_PROJECT_WALKTHROUGH.md)

## If you want to build now

Read now:

1. [QUICK_START.md](./QUICK_START.md)
2. [FIRST_RUN_IN_IDE.md](./FIRST_RUN_IN_IDE.md)

Optional next:

3. [WORKFLOW_SELECTION_GUIDE.md](./WORKFLOW_SELECTION_GUIDE.md)
4. [COMMAND_INVOCATION_GUIDE.md](./COMMAND_INVOCATION_GUIDE.md)
5. [AGENT_PLUS_WORKFLOW_EXAMPLES.md](./AGENT_PLUS_WORKFLOW_EXAMPLES.md)

## What to read next

If you want the shortest safe onboarding path, go to [BASIC_ONBOARDING_PROCEDURE.md](./BASIC_ONBOARDING_PROCEDURE.md) first.
If you want the setup steps first, go to [INSTALLATION_GUIDE.md](./INSTALLATION_GUIDE.md).
If you want the short first-use path after setup, go to [BASIC_USAGE_GUIDE.md](./BASIC_USAGE_GUIDE.md).
If you want the workspace/project context model in one page, go to [WHERE_DO_I_WORK.md](./WHERE_DO_I_WORK.md) next.
If you want the in-editor first-run path, go to [FIRST_RUN_IN_IDE.md](./FIRST_RUN_IN_IDE.md) next.
If you want the explicit level map, go to [DOCUMENTATION_LEVELS.md](./DOCUMENTATION_LEVELS.md).
If you want the broader plain-English intro, go to [APW_FOR_BEGINNERS.md](./APW_FOR_BEGINNERS.md).
If you want the diagram-first version, go to [APW_VISUAL_OVERVIEW.md](./APW_VISUAL_OVERVIEW.md).
