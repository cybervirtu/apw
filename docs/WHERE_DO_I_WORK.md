# WHERE_DO_I_WORK.md — APW Workspace Context Guide

> [!TIP]
> Use this when you are asking: "Which folder should I actually be working in right now?"

## The short answer

APW has three practical locations:

| Location | Role | Typical Actions | Avoid Doing Here |
| :--- | :--- | :--- | :--- |
| `APW root` | the framework itself | maintain APW docs, templates, scripts, workflows, and compatibility files; run `apw new`; run bootstrap, validation, or guided initialization against target repos | day-to-day product implementation for a downstream project |
| `downstream project root` | the real project you are building | open your IDE here; start from `AGENTS.md`; run slash workflows here; edit code, tests, docs, `.gsd/`, and `.agent/` here | treating it as the source of APW framework templates or validators |
| `workspace parent folder` | organizer for APW plus multiple projects | create new projects with `apw new`; keep APW and project repos side by side; move into a project root before normal work | running day-to-day project workflows here unless a helper explicitly supports it |

If you only remember one rule, remember this:

- normal project work happens in the downstream project root

## The three locations in plain English

### 1. APW root

This is the APW framework repository itself.

Example:

```text
MyWork/
└── apw/
```

Use APW root when you are:

- changing APW docs or templates
- maintaining `bootstrap.sh`, `validate.sh`, or the `apw` wrapper
- updating workflows, agents, rules, or skills in the framework
- creating or validating downstream projects by target path

Do not treat APW root as the normal place to build your actual product.

## 2. Downstream project root

This is the real project repository you are building with APW.

Example:

```text
MyWork/
├── apw/
└── ProjectA/
```

This is where normal work happens.

Use the downstream project root when you are:

- opening your IDE for day-to-day work
- reading `AGENTS.md`
- using `/status`, `/brainstorm`, `/create`, `/debug`, `/test`, or `/orchestrate`
- editing product code
- working with `.gsd/STATE.md`, `.gsd/TODO.md`, and `.gsd/JOURNAL.md`
- adding project-specific rules in `.agent/rules/PROJECT.md`

If you are wondering where slash workflows should show up, the answer is:

- they should work from the downstream project root

## 3. Workspace parent folder

This is the folder that may contain APW plus multiple downstream projects.

Example:

```text
MyWork/
├── apw/
├── ProjectA/
└── ProjectB/
```

The workspace parent folder is mostly an organizer.

Use it when you are:

- deciding where projects should live
- creating a new repo with `apw new`
- moving between APW root and different downstream projects

It is not the normal place for day-to-day project workflows.

## Where commands should work

### Project workflows and slash commands

Run these from the downstream project root:

- `/status`
- `/brainstorm`
- `/create`
- `/enhance`
- `/debug`
- `/test`
- `/orchestrate`

Why:

- they need the downstream repo's `AGENTS.md`
- they need the downstream repo's `.gsd/` state
- they act on the downstream repo's code and tasks

### APW framework maintenance commands

These belong to APW root:

- editing APW framework docs
- changing templates
- changing bootstrap or validation behavior
- changing canonical workflow definitions

### Workspace parent folder actions

These are appropriate there:

- launching `apw new`
- organizing multiple project repos
- choosing where new repos should live

Do not assume the workspace parent folder is a project root just because it contains multiple projects.

## Where project creation happens

For a brand-new project, the friendliest path is:

```bash
/path/to/apw/apw new MyProject --profile base --stack base
```

You can launch that from:

- APW root
- the workspace parent folder
- any other convenient location

If you want to choose the parent location explicitly:

```bash
/path/to/apw/apw new MyProject --profile base --stack base --target /path/to/MyWork
```

What this means:

- the command can be launched from many places
- the resulting repo is still the downstream project root
- once the repo exists, that downstream project root becomes the normal place to work

## Where you should work day to day

For normal project implementation:

1. `cd` into the downstream project root
2. open your IDE there
3. start from `AGENTS.md`
4. use workflows there
5. keep project changes there

Use APW root mainly when you mean to maintain APW itself.

Use the workspace parent folder mainly as a container and launch point.

## The beginner rule of thumb

If you are unsure which folder you should be in, ask this:

- "Am I changing the APW framework, or am I building my project?"

If you are building your project:

- work in the downstream project root

If you are changing APW itself:

- work in APW root

If you are just creating a new repo or organizing several repos:

- the workspace parent folder is fine

## Quick examples

### I want to create a new project

You can be in the workspace parent folder or anywhere else.

Use:

```bash
/path/to/apw/apw new MyProject --profile base --stack base
```

Then move into the new project.

### I want to run `/create`

Be in the downstream project root, not APW root.

### I want to update APW templates

Be in APW root.

### I want to know what kind of folder I am in

Use:

```bash
/path/to/apw/apw context
```

Or point it at a specific path:

```bash
/path/to/apw/apw context /path/to/MyWork/ProjectA
```

## Related docs

- [BASIC_ONBOARDING_PROCEDURE.md](./BASIC_ONBOARDING_PROCEDURE.md)
- [QUICK_START.md](./QUICK_START.md)
- [DOWNSTREAM_ADOPTION_GUIDE.md](./DOWNSTREAM_ADOPTION_GUIDE.md)
- [GUIDED_PROJECT_STATE_INITIALIZATION.md](./GUIDED_PROJECT_STATE_INITIALIZATION.md)
