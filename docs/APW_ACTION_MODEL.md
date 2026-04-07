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
| `APW: Upgrade Project` | chat-first or IDE action | `apw upgrade-project <name-or-path> ...` |

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

Engine:

```bash
/path/to/apw/apw context /path/to/project
```

### 4. APW: List Projects

Use this when:

- you want to discover known downstream projects in the workspace

Engine:

```bash
/path/to/apw/apw list-projects --workspace /path/to/workspace
```

### 5. APW: Switch To Project

Use this when:

- you want to get back to the right downstream repo

Engine:

```bash
/path/to/apw/apw switch project MyProject --workspace /path/to/workspace
```

### 6. APW: Switch To Framework

Use this when:

- you intentionally want the APW framework repo

Engine:

```bash
/path/to/apw/apw switch framework
```

### 7. APW: Switch To Parent

Use this when:

- you want the workspace overview or organizer folder

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

### 9. APW: Upgrade Project

Use this when:

- APW itself changed and you want a downstream project to receive the latest APW-managed layer safely

Engine:

```bash
/path/to/apw/apw upgrade-project /path/to/project --dry-run
```

## How chat-first should feel

The easiest APW requests should sound natural.

Examples:

- "Run APW: First Run for this project."
- "Show APW context for this repo."
- "Create a new APW project called MyProject."
- "Initialize this project."
- "Upgrade this project from the latest APW, but preview first."

The user should not need to remember raw flags first if the tool can map the request safely.

## How IDE actions should feel

When an IDE, extension, or command palette exposes APW directly, the preferred labels should be the catalog names in this document:

- `APW: Create Project`
- `APW: First Run`
- `APW: Show Context`
- `APW: List Projects`
- `APW: Switch To Project`
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

Then use the terminal form only when you need the lower-level path.

## Read next only if needed

- [../COMMAND_CHEATSHEET.md](../COMMAND_CHEATSHEET.md)
- [FIRST_RUN_IN_IDE.md](./FIRST_RUN_IN_IDE.md)
- [WHERE_DO_I_WORK.md](./WHERE_DO_I_WORK.md)
- [SAFE_CONTEXT_SWITCHING.md](./SAFE_CONTEXT_SWITCHING.md)
