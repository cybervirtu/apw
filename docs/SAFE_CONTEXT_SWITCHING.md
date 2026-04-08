# SAFE_CONTEXT_SWITCHING.md — Safe Workspace Context Switching

> [!IMPORTANT]
> Use this when you know APW supports multiple repos in one workspace and you want a safe, visible way to move between them.

## What this guide is

This guide explains how APW helps you switch between:

- `APW root`
- a `downstream project root`
- the `workspace parent folder`

The important rule is simple:

- APW helps you switch explicitly
- APW does not silently move you somewhere else

APW's preferred interaction order is still:

1. chat-first request
2. IDE action if available
3. terminal fallback

For the full action catalog behind those paths, read [APW_ACTION_MODEL.md](./APW_ACTION_MODEL.md).

## The APW action names for switching

If you want the simpler user-facing names, think in these actions first:

- `APW: Show Context`
- `APW: List Projects`
- `APW: Switch To Project`
- `APW: Switch To Framework`
- `APW: Switch To Parent`

Natural chat-first phrasing can sound like:

- "Show APW context."
- "List APW projects."
- "Switch to ProjectA."
- "Switch to the APW framework."
- "Go back to the workspace parent."
- "Create a new APW project called MyProject."

Then use the terminal form only when you need the explicit fallback or exact flags.

## The three places in plain language

| Location | Role | Typical Actions | Avoid Doing Here |
| :--- | :--- | :--- | :--- |
| `APW root` | the framework repo | maintain APW docs, templates, scripts, workflows, and validators | normal downstream project implementation |
| `downstream project root` | the real project you are building | open your IDE here; read `AGENTS.md`; run workflows here; change code and project state here | treating it as the source of APW framework maintenance |
| `workspace parent folder` | organizer for APW plus sibling projects | create projects, list projects, and choose where to go next | day-to-day project workflows |

If you only remember one rule, remember this:

- normal project work happens in the downstream project root

## What APW switching does

APW switching helpers do four things:

1. resolve the target path
2. classify what that path is
3. print what that location is for
4. tell you the next command to run
5. print the exact folder path so Antigravity or another IDE can open it cleanly

They do not silently change your shell.

They do not silently move your IDE.

## The switching commands

### Check your current context

- `APW: Show Context`
  Terminal fallback:

```bash
apw context
```

Or check a specific path:

```bash
apw context /path/to/somewhere
```

Use this when you are unsure whether you are in:

- APW root
- a downstream project root
- the workspace parent folder
- an unsupported location that needs an explicit `--workspace` or `--target`

### List known downstream projects

- `APW: List Projects`
  Terminal fallback:

```bash
apw list-projects
```

If your projects live under a specific workspace parent, you can point to it:

```bash
apw list-projects --workspace /path/to/MyWork
```

What it does:

- scans the workspace parent's immediate child folders
- lists APW downstream projects it can recognize
- gives you enough information to choose the right project
- if you are outside the supported APW roots, use `--workspace` instead of expecting APW to infer the workspace automatically

### Switch to APW root

- `APW: Switch To Framework`
  Terminal fallback:

```bash
apw switch framework
```

Use this when you mean to:

- maintain APW docs
- change templates
- update scripts or workflow definitions

### Switch to a downstream project

- `APW: Switch To Project`
  Terminal fallback:

Use a known project name:

```bash
apw switch ProjectA
```

Or use a direct path:

```bash
apw switch /path/to/MyWork/ProjectA
```

If the workspace parent is not the default one, add:

```bash
--workspace /path/to/MyWork
```

Use this when you mean to:

- do real day-to-day project work
- open the project in your IDE
- read `AGENTS.md`
- run project workflows such as `/status`, `/brainstorm`, `/create`, or `/orchestrate`

### Switch to the workspace parent folder

- `APW: Switch To Parent`
  Terminal fallback:

```bash
apw switch parent
```

Or point at a specific workspace parent:

```bash
apw switch parent --workspace /path/to/MyWork
```

Use this when you want to:

- get back to the workspace overview
- decide which project to open next
- create a new project from a clean launch point

Default project-creation rule:

- from APW root, `apw new` creates the new repo in the workspace parent beside `apw`
- from the workspace parent, `apw new` creates the new repo in the current folder
- from a downstream project, `apw new` creates the new repo as a sibling in the same workspace parent
- use `--target /path/to/parent` when you want a different parent location

For chat-first project creation, APW should:

- classify the current context first
- show the resolved destination before creating anything
- avoid nesting the new repo inside APW root unless the user explicitly requests that target

## Upgrade an existing downstream project safely

If APW itself has changed and you want one downstream repo to receive those APW-managed updates, you can launch the upgrade helper explicitly from APW root, the workspace parent, or another convenient location:

- `APW: Preview Upgrade`
  Terminal fallback:

```bash
apw upgrade-project ProjectA --dry-run
```

Or use a direct path:

```bash
apw upgrade-project /path/to/MyWork/ProjectA --dry-run
```

What this means:

- APW resolves the downstream project explicitly
- APW prints what will be upgraded and what stays protected
- APW does not silently switch your shell or IDE while doing it
- day-to-day project work still belongs in the downstream project root after the upgrade
- if you launch by project name from an unrelated folder, add `--workspace /path/to/MyWork` instead of expecting APW to guess

## Optional open behavior

APW switch uses Antigravity when it is available:

```bash
apw switch ProjectA
```

What this means:

- APW still prints the destination clearly
- APW still tells you what the location is for
- APW prints the exact resolved folder path either way
- APW runs `antigravity <resolved-path>` when that launcher is available
- if Antigravity is unavailable, APW says so clearly and leaves you with the exact folder path to open manually

Launcher expectation is simple:

1. `antigravity`

If the `antigravity` launcher is unavailable, APW falls back to clear printed guidance and the exact folder path you should open manually in Antigravity.

## The beginner recovery flow

If you feel lost:

1. run `apw context`
2. if needed, run `apw list-projects`
3. run `apw switch <name>` or `apw switch framework`
4. once you reach the downstream project root, open `AGENTS.md`
5. if the repo simply needs newer APW-managed files, run `apw upgrade-project <name> --dry-run`

## The practical rule

Create projects from APW.

When you run `apw new` from APW root, the new downstream repo belongs beside `apw`, not inside it.

Move between repos with explicit helpers.

Do normal implementation work in the downstream project root.
