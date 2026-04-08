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

APW's preferred interaction rule is:

- chat-first request
- IDE action if available
- terminal fallback when needed

For the canonical action catalog, read [APW_ACTION_MODEL.md](./APW_ACTION_MODEL.md).

For this specific moment, the beginner-friendly action name is:

- `APW: First Run`

Chat-first forms can be as simple as:

- "Show me first-run guidance."
- "Run first-run for this project."
- "What should I do first in this repo?"

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

If you want the command names fast without opening multiple docs, keep [../COMMAND_CHEATSHEET.md](../COMMAND_CHEATSHEET.md) nearby.
If you want the explicit reading-level model, read [DOCUMENTATION_LEVELS.md](./DOCUMENTATION_LEVELS.md).
If you have not installed APW locally yet, read [INSTALLATION_GUIDE.md](./INSTALLATION_GUIDE.md).
If you want the short first-use path before this in-IDE step, read [BASIC_USAGE_GUIDE.md](./BASIC_USAGE_GUIDE.md).
If project details are arriving through chat, read [CHAT_FIRST_REQUIREMENT_INGESTION.md](./CHAT_FIRST_REQUIREMENT_INGESTION.md).
If you want the full chat-to-execution route in one page, read [CHAT_REQUIREMENTS_TO_EXECUTION_FLOW.md](./CHAT_REQUIREMENTS_TO_EXECUTION_FLOW.md).
If you need to know what APW should say after saving or promoting requirement chat, read [CHAT_REQUIREMENT_PERSISTENCE_CHOICES.md](./CHAT_REQUIREMENT_PERSISTENCE_CHOICES.md).
If the requirements are large and need decomposition first, read [REQUIREMENT_MODULE_BREAKDOWN.md](./REQUIREMENT_MODULE_BREAKDOWN.md).
If the active module is still too large to hand straight to execution, read [ATOMIC_IMPLEMENTATION_PLANNING.md](./ATOMIC_IMPLEMENTATION_PLANNING.md).

## First-run checklist

Use this checklist inside the downstream project:

### 1. Confirm you are in the right place

You should normally be in the downstream project root.

That means the folder should contain things such as:

- `AGENTS.md`
- `.gsd/`
- `.agent/`

If you are unsure, use:

- `APW: Show Context`
  Terminal fallback:
  ```bash
  /path/to/apw/apw context
  ```

If that shows you are in APW root or the workspace parent folder, recover with:

- `APW: List Projects`
- `APW: Switch To Project`
  Terminal fallback:
  ```bash
  /path/to/apw/apw list-projects
  /path/to/apw/apw switch project <name>
  ```

If the project does not exist yet, create it with:

```bash
/path/to/apw/apw new MyProject --profile base --stack base
```

From APW root, that command creates `/path/to/workspace/MyProject` beside `apw` by default.
Use `--target /path/to/parent` only when you want a different parent location explicitly.

The chat-first `APW: Create Project` path follows the same rule and should show that destination before it creates the repo.

### 2. Read `AGENTS.md`

Read `AGENTS.md` first.

You should come away knowing:

- GSD governs
- AGK executes
- the orchestrator synchronizes canonical summary state

Then, if you want the fast command reference, open:

- `COMMAND_CHEATSHEET.md`

### 3. Confirm project state exists

Check whether the core `.gsd` files already tell a real project story:

- `.gsd/SPEC.md`
- `.gsd/STACK.md`
- `.gsd/STATE.md`
- `.gsd/TODO.md`
- `.gsd/ROADMAP.md`

If those still look like starter templates, run:

- `APW: Initialize Project State`
  Terminal fallback:

```bash
/path/to/apw/scripts/init-project-state.sh --target .
```

If you want a helper reminder instead of remembering the steps yourself, think:

- `APW: First Run`
  Terminal fallback:

```bash
/path/to/apw/apw first-run
```

### 4. Choose the first workflow that matches reality

Use this simple rule:

| If your situation sounds like this | First workflow |
| :--- | :--- |
| "I still need to think through the idea or first step." | `/brainstorm` |
| "I know one bounded slice and want to build it." | `/create` |
| "This work is large or crosses several areas." | `/orchestrate` |
| "I am returning later and need orientation." | `/status` |

Execution rule:

- if the work is too large for one clean `/create` pass, use `/orchestrate` first
- once the slice is clear, build one slice at a time and verify it before moving on

### 5. Know when the orchestrator matters

Use the orchestrator when official project summary state needs to change, especially:

- `STATE.md`
- `ROADMAP.md`
- `TODO.md`
- `DECISIONS.md`

Execution work can move quickly.

Canonical summary state should stay deliberate.

If you start with `/brainstorm`, remember:

- the brainstorm itself is not official project memory automatically
- save meaningful outcomes to `.gsd/JOURNAL.md`
- use orchestrator when the brainstorm should change `SPEC.md`, `TODO.md`, `ROADMAP.md`, or `DECISIONS.md`

The same safe rule works for the other core workflows too:

- useful workflow evidence usually goes to `.gsd/JOURNAL.md`
- official project memory changes should be synchronized deliberately through orchestrator or governance

The same rule applies when requirements, corrections, or directions arrive in normal chat:

- classify them first
- save them deliberately
- use orchestrator when official project memory must change across files

APW should also make the persistence result explicit:

- what was saved
- where it went
- whether official project memory changed

## What should I read only if needed?

Use only the next doc you need:

Read now:

- [../COMMAND_CHEATSHEET.md](../COMMAND_CHEATSHEET.md)
- [BASIC_ONBOARDING_PROCEDURE.md](./BASIC_ONBOARDING_PROCEDURE.md)

Only if needed:

- [WHERE_DO_I_WORK.md](./WHERE_DO_I_WORK.md)
- [SAFE_CONTEXT_SWITCHING.md](./SAFE_CONTEXT_SWITCHING.md)
- [GUIDED_PROJECT_STATE_INITIALIZATION.md](./GUIDED_PROJECT_STATE_INITIALIZATION.md)
- [WORKFLOW_SELECTION_GUIDE.md](./WORKFLOW_SELECTION_GUIDE.md)
- [COMMAND_INVOCATION_GUIDE.md](./COMMAND_INVOCATION_GUIDE.md)
- [BRAINSTORM_PERSISTENCE_AND_PROMOTION.md](./BRAINSTORM_PERSISTENCE_AND_PROMOTION.md)
- [WORKFLOW_PERSISTENCE_POLICY.md](./WORKFLOW_PERSISTENCE_POLICY.md)
- [ATOMIC_IMPLEMENTATION_PLANNING.md](./ATOMIC_IMPLEMENTATION_PLANNING.md)
- [APW_ACTION_MODEL.md](./APW_ACTION_MODEL.md)
- [START_HERE.md](./START_HERE.md)

Advanced reference:

- [DOCUMENTATION_LEVELS.md](./DOCUMENTATION_LEVELS.md)

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
