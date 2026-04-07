# APW_ACTION_MODEL.md — Non-Terminal APW Action Model

> [!IMPORTANT]
> Use this when you want the simple APW interaction rule for chat-first, IDE-friendly use, and terminal fallback.

## The short rule

APW uses one preferred interaction hierarchy:

1. chat-first request
2. IDE action or command-palette style action
3. terminal command fallback

The goal is simple:

- beginners should not need raw terminal commands for common APW tasks
- power users and automation still keep the terminal path
- both paths must map to the same APW engine underneath

## The first APW action layer

For beginners, three APW actions matter most first:

1. `APW: Create Project`
2. `APW: Initialize Project State`
3. `APW: First Run`

These are the first APW actions users should think about before they think about raw terminal commands.

Why:

- they remove the highest-friction beginner steps
- they map cleanly to the existing APW engine
- they make APW easier to understand in chat-first and IDE-friendly environments

## The context and switching action layer

Once the project exists, the next APW action layer is:

1. `APW: Show Context`
2. `APW: List Projects`
3. `APW: Switch To Project`
4. `APW: Switch To Framework`
5. `APW: Switch To Parent`

These actions help users recover orientation without hunting through folders manually.

They must stay:

- explicit
- visible
- non-magical

They do not silently change shell or IDE context.

## The upgrade action layer

When APW itself changes and a downstream repo needs the newer APW-managed layer, think in this sequence:

1. `APW: Preview Upgrade`
2. `APW: Upgrade Project`
3. `APW: Validate After Upgrade`

This must stay:

- preview-first
- explicit
- beginner-safe

It must not hide:

- what APW will update
- what APW will skip
- what APW protects as project-owned

## What this means in practice

For common APW tasks, the easiest user-facing path should be:

- ask for the APW action in chat
- use the matching IDE action when a tool provides one
- fall back to the terminal command when needed

Examples:

- "APW: Create Project"
- "APW: First Run"
- "APW: Show Context"
- "APW: Upgrade Project"

These are not a second system.

They are the preferred user-facing names for the same existing APW engine and command layer.

## The action catalog

| APW action | Best beginner path | Underlying APW engine |
| :--- | :--- | :--- |
| `APW: Create Project` | chat-first or IDE action | `apw new <project-name> ...` |
| `APW: First Run` | chat-first or IDE action | `apw first-run [path]` |
| `APW: Show Context` | chat-first or IDE action | `apw context [path]` |
| `APW: List Projects` | chat-first or IDE action | `apw list-projects [--workspace dir]` |
| `APW: Switch To Project` | chat-first or IDE action | `apw switch project <name-or-path> ...` |
| `APW: Switch To Framework` | chat-first or IDE action | `apw switch framework [--open]` |
| `APW: Switch To Parent` | chat-first or IDE action | `apw switch parent [--workspace dir] [--open]` |
| `APW: Initialize Project State` | chat-first or IDE action | `scripts/init-project-state.sh --target <repo>` |
| `APW: Preview Upgrade` | chat-first or IDE action | `apw upgrade-project <name-or-path> --dry-run` |
| `APW: Upgrade Project` | chat-first or IDE action | `apw upgrade-project <name-or-path> ...` |
| `APW: Validate After Upgrade` | chat-first or IDE action | `apw upgrade-project <name-or-path> --validate` or `scripts/validate.sh ...` |

## Preferred path per action

### 1. APW: Create Project

Use this when:

- you want a new downstream APW repo

Preferred path:

- chat request or IDE action first
- terminal fallback second

Chat-first forms:

- "Create a project."
- "Create a new APW project called MyProject."
- "Create a base APW project in this workspace."

Preferred IDE label:

- `APW: Create Project`

Engine:

```bash
/path/to/apw/apw new MyProject --profile base --stack base
```

Default destination rule:

- from APW root, APW creates the new repo in the parent workspace beside `apw`
- from the workspace parent, APW creates the new repo in the current folder
- from a downstream project, APW creates the new repo as a sibling in the same workspace parent
- use `--target /path/to/parent` when you want a different parent location explicitly

Chat-first behavior rule:

- detect the current context first instead of assuming the current folder should become the parent
- show the resolved parent and final destination before creation
- do not create inside APW root unless the user explicitly asks for that target

### 2. APW: First Run

Use this when:

- you opened a downstream project and want the short next-step checklist

Chat-first forms:

- "Show me first-run guidance."
- "Run first-run for this project."
- "What should I do first in this repo?"

Preferred IDE label:

- `APW: First Run`

Engine:

```bash
/path/to/apw/apw first-run /path/to/project
```

### 3. APW: Show Context

Use this when:

- you are unsure whether you are in APW root, a downstream project, or the workspace parent

Chat-first forms:

- "Show APW context."
- "Where am I working right now?"
- "Show context for this repo."

Preferred IDE label:

- `APW: Show Context`

Engine:

```bash
/path/to/apw/apw context /path/to/project
```

### 4. APW: List Projects

Use this when:

- you want to discover known downstream projects in the workspace

Chat-first forms:

- "List APW projects."
- "Show me the projects in this workspace."
- "What downstream projects are here?"

Preferred IDE label:

- `APW: List Projects`

Engine:

```bash
/path/to/apw/apw list-projects --workspace /path/to/workspace
```

### 5. APW: Switch To Project

Use this when:

- you want to get back to the right downstream repo

Chat-first forms:

- "Switch me to ProjectA."
- "Take me to the right project."
- "Switch to this project."

Preferred IDE label:

- `APW: Switch To Project`

Engine:

```bash
/path/to/apw/apw switch project MyProject --workspace /path/to/workspace
```

### 6. APW: Switch To Framework

Use this when:

- you intentionally want the APW framework repo

Chat-first forms:

- "Switch me to APW."
- "Take me to the framework repo."
- "Switch to the APW framework."

Preferred IDE label:

- `APW: Switch To Framework`

Engine:

```bash
/path/to/apw/apw switch framework
```

### 7. APW: Switch To Parent

Use this when:

- you want the workspace overview or organizer folder

Chat-first forms:

- "Switch me to the workspace parent."
- "Take me to the workspace overview."
- "Go back to the parent folder."

Preferred IDE label:

- `APW: Switch To Parent`

Engine:

```bash
/path/to/apw/apw switch parent --workspace /path/to/workspace
```

### 8. APW: Initialize Project State

Use this when:

- bootstrap is done but the core `.gsd` state still needs real first drafts

Chat-first forms:

- "Initialize this project."
- "Initialize project state for this repo."
- "Turn this project idea into the first `.gsd` drafts."

Preferred IDE label:

- `APW: Initialize Project State`

Engine:

```bash
/path/to/apw/scripts/init-project-state.sh --target /path/to/project
```

### 9. APW: Preview Upgrade

Use this when:

- APW itself changed and you want to see exactly what an upgrade would do before touching the repo

Chat-first forms:

- "Preview the APW upgrade for this project."
- "Show me what APW would upgrade."
- "Preview upgrade before changing anything."

Preferred IDE label:

- `APW: Preview Upgrade`

Engine:

```bash
/path/to/apw/apw upgrade-project /path/to/project --dry-run
```

### 10. APW: Upgrade Project

Use this when:

- APW itself changed and you want a downstream project to receive the latest APW-managed layer safely

Chat-first forms:

- "Upgrade this project from the latest APW."
- "Apply the APW-managed upgrade now."
- "Run the safe APW upgrade for this repo."

Preferred IDE label:

- `APW: Upgrade Project`

Engine:

```bash
/path/to/apw/apw upgrade-project /path/to/project
```

### 11. APW: Validate After Upgrade

Use this when:

- the upgrade is complete and you want to confirm the repo still matches the APW contract

Chat-first forms:

- "Validate this project after the upgrade."
- "Run post-upgrade validation."
- "Check that the upgraded repo still matches APW."

Preferred IDE label:

- `APW: Validate After Upgrade`

Engine:

```bash
/path/to/apw/apw upgrade-project /path/to/project --validate
```

## How chat-first should feel

The easiest APW requests should sound natural.

Examples:

- "Run APW: First Run for this project."
- "Show APW context for this repo."
- "List the APW projects in this workspace."
- "Switch to ProjectA."
- "Switch to the APW framework."
- "Create a new APW project called MyProject."
- "Initialize this project."
- "Preview the APW upgrade for this project."
- "Upgrade this project from the latest APW."
- "Validate this project after the upgrade."

For `APW: Create Project`, the visible behavior should be:

- APW identifies whether the user is in APW root, the workspace parent, or a downstream project
- APW resolves the destination using that workspace model
- APW shows the destination before creation
- APW only creates inside APW root when the user explicitly chooses that target

The user should not need to remember raw flags first if the tool can map the request safely.

## How IDE actions should feel

When an IDE, extension, or command palette exposes APW directly, the preferred labels should be the catalog names in this document:

- `APW: Create Project`
- `APW: First Run`
- `APW: Show Context`
- `APW: List Projects`
- `APW: Switch To Project`
- `APW: Preview Upgrade`
- `APW: Switch To Framework`
- `APW: Switch To Parent`
- `APW: Initialize Project State`
- `APW: Upgrade Project`

That keeps future IDE-native behavior aligned with the current APW engine instead of inventing a separate naming system.

## When terminal commands still matter

Terminal commands are still important for:

- power users
- automation
- CI
- explicit fallback when chat or IDE actions are unavailable
- exact flags and scripting

The rule is:

- terminal stays supported
- terminal is not the only front door

## Beginner rule of thumb

If a task has an APW action name, prefer that mental model first.

Think:

- "APW: Create Project"
- "APW: Initialize Project State"
- "APW: First Run"
- "APW: Show Context"
- "APW: List Projects"
- "APW: Switch To Project"

Then use the terminal form only when you need the lower-level path.

## Read next only if needed

- [../COMMAND_CHEATSHEET.md](../COMMAND_CHEATSHEET.md)
- [FIRST_RUN_IN_IDE.md](./FIRST_RUN_IN_IDE.md)
- [WHERE_DO_I_WORK.md](./WHERE_DO_I_WORK.md)
- [SAFE_CONTEXT_SWITCHING.md](./SAFE_CONTEXT_SWITCHING.md)
