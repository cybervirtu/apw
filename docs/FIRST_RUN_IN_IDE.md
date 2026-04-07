# FIRST_RUN_IN_IDE.md — First-Run IDE Guide

> [!TIP]
> Use this the first time you open a downstream APW project in your IDE and want to know what to do next without hunting through files.

## The short answer

When you open a downstream APW project for the first time:

1. confirm you are in the downstream project root
2. open `AGENTS.md`
3. make sure the core `.gsd` state is initialized
4. choose the first workflow that matches your situation
5. use the orchestrator when official summary state needs synchronized updates

That is the beginner-safe path.

## What file should I open first?

Open:

- `AGENTS.md`

Why:

- it is the in-IDE front door
- it tells you the core operating rule
- it routes you to the minimum next files instead of the entire docs set

## What `AGENTS.md` is supposed to do

`AGENTS.md` is the front desk, not the whole building.

It should help you answer:

- what APW is in practical terms
- what governs project state
- what executes implementation work
- what to do first
- which file or workflow comes next

It should not force you to read the whole handbook before you can move.

## First-run checklist

Use this checklist inside the downstream project:

### 1. Confirm you are in the right place

You should normally be in the downstream project root.

That means the folder should contain things such as:

- `AGENTS.md`
- `.gsd/`
- `.agent/`

If you are unsure, use:

```bash
/path/to/apw/apw context
```

If that shows you are in APW root or the workspace parent folder, recover with:

```bash
/path/to/apw/apw list-projects
/path/to/apw/apw switch project <name>
```

### 2. Read `AGENTS.md`

Read `AGENTS.md` first.

You should come away knowing:

- GSD governs
- AGK executes
- the orchestrator synchronizes canonical summary state

### 3. Confirm project state exists

Check whether the core `.gsd` files already tell a real project story:

- `.gsd/SPEC.md`
- `.gsd/STACK.md`
- `.gsd/STATE.md`
- `.gsd/TODO.md`
- `.gsd/ROADMAP.md`

If those still look like starter templates, run:

```bash
/path/to/apw/scripts/init-project-state.sh --target .
```

If you want a helper reminder instead of remembering the steps yourself, run:

```bash
/path/to/apw/apw first-run
```

### 4. Choose the first workflow that matches reality

Use this simple rule:

| If your situation sounds like this | First workflow |
| :--- | :--- |
| "I still need to think through the idea or first step." | `/brainstorm` |
| "I know the first feature and want to build it." | `/create` |
| "This work is large or crosses several areas." | `/orchestrate` |
| "I am returning later and need orientation." | `/status` |

### 5. Know when the orchestrator matters

Use the orchestrator when official project summary state needs to change, especially:

- `STATE.md`
- `ROADMAP.md`
- `TODO.md`
- `DECISIONS.md`

Execution work can move quickly.

Canonical summary state should stay deliberate.

## What should I read only if needed?

Use only the next doc you need:

- Need the shortest beginner path: [BASIC_ONBOARDING_PROCEDURE.md](./BASIC_ONBOARDING_PROCEDURE.md)
- Need the workspace/project location model: [WHERE_DO_I_WORK.md](./WHERE_DO_I_WORK.md)
- Need explicit switch helpers: [SAFE_CONTEXT_SWITCHING.md](./SAFE_CONTEXT_SWITCHING.md)
- Need command choice help: [WORKFLOW_SELECTION_GUIDE.md](./WORKFLOW_SELECTION_GUIDE.md)
- Need command details and read-first context: [COMMAND_INVOCATION_GUIDE.md](./COMMAND_INVOCATION_GUIDE.md)
- Need help initializing state: [GUIDED_PROJECT_STATE_INITIALIZATION.md](./GUIDED_PROJECT_STATE_INITIALIZATION.md)
- Need broader beginner context: [START_HERE.md](./START_HERE.md)

## The simple operating model in IDE terms

| Thing | What it means in practice |
| :--- | :--- |
| `AGENTS.md` | first file to open |
| `.gsd/` | official project memory |
| `.agent/` | execution support and workflows |
| `/brainstorm` | use when the first move is still fuzzy |
| `/create` | use when the first feature is already clear |
| `/orchestrate` | use when the work is large or cross-cutting |
| `/status` | use when you need orientation |
| orchestrator | use when canonical summary state needs synchronized updates |

## If you only remember five things

1. Open the downstream project root, not APW root.
2. Read `AGENTS.md` first.
3. Make sure the core `.gsd` state is real before heavy workflow use.
4. Choose `/brainstorm`, `/create`, `/orchestrate`, or `/status` based on your actual situation.
5. Let the orchestrator handle canonical summary sync when official state changes.
