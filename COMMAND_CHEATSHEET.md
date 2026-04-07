# COMMAND_CHEATSHEET.md — APW Fast Command Reference

> [!TIP]
> Use this as the one-minute command reference for day-to-day APW use.

## Quick rule

- create projects from APW
- do normal implementation work inside the downstream project root
- use APW root for framework maintenance

If you are in APW root, you can use `./apw ...`.

If you are elsewhere in the workspace, use `/path/to/apw/apw ...`.

The same rule applies to script commands:

- in APW root, use `./scripts/...`
- elsewhere, use `/path/to/apw/scripts/...`

## IDE slash commands

Run these from the downstream project root:

| Command | Use it when |
| :--- | :--- |
| `/status` | you need orientation or a quick project check |
| `/brainstorm` | the idea, scope, or first step is still unclear |
| `/create` | the feature is clear and you want to build it |
| `/enhance` | you want to improve or refactor something existing |
| `/debug` | something is broken and you need to investigate and fix it |
| `/test` | you want to verify behavior or improve test coverage |
| `/orchestrate` | the work is large, cross-cutting, or needs coordinated sync |

Notes:

- core slash commands appear in downstream projects that have the APW vendored workflow pack
- for most users, the downstream project root is the normal place where these commands should appear

Advanced extras when the project profile includes them:

| Command | Use it when |
| :--- | :--- |
| `/deploy` | you are preparing or managing deployment work |
| `/design` | you want UX, flows, or product-structure guidance |
| `/preview` | you want a review-oriented preview pass |
| `/ui-ux-pro-max` | you want a heavier UI/UX design workflow |

Notes:

- advanced extras like `/deploy`, `/design`, `/preview`, and `/ui-ux-pro-max` depend on profile/extras and may not always be present

## Terminal commands

### APW wrapper commands

These are shown in their APW-root form. If you are reading this inside a downstream repo, replace `./apw` with `/path/to/apw/apw`.

| Command | What it does |
| :--- | :--- |
| `./apw help` | show the APW wrapper commands |
| `./apw context` | tell you whether you are in APW root, a project root, or a workspace folder |
| `./apw context <path>` | check a specific path instead of the current one |
| `./apw first-run` | print the beginner-safe first-run checklist |
| `./apw first-run <project-path>` | print the first-run checklist for a specific downstream project |
| `./apw new MyProject --profile base --stack base` | create a new APW project |
| `./apw new MyProject --profile base --stack base --target /path/to/workspace` | create the project under a chosen workspace parent |
| `./apw new MyProject --profile base --stack base --init-state` | create a project and immediately run guided state initialization |
| `./apw new MyProject --profile base --stack base --target /path/to/workspace --init-state` | create the project in a chosen workspace and initialize state immediately |
| `./apw list-projects` | list known downstream projects in the default workspace |
| `./apw list-projects --workspace /path/to/workspace` | list downstream projects under a chosen workspace parent |
| `./apw switch framework` | show the APW framework root clearly |
| `./apw switch framework --open` | show the APW framework root and try to open it when supported |
| `./apw switch parent` | show the workspace parent clearly |
| `./apw switch parent --workspace /path/to/workspace` | resolve a specific workspace parent |
| `./apw switch parent --workspace /path/to/workspace --open` | resolve that workspace parent and try to open it |
| `./apw switch project <name-or-path>` | resolve a downstream project clearly |
| `./apw switch project <name-or-path> --workspace /path/to/workspace` | resolve a named project under a chosen workspace parent |
| `./apw switch project <name-or-path> --workspace /path/to/workspace --open` | resolve that project and try to open it |
| `./apw upgrade-project <name-or-path> --dry-run` | preview a safe downstream APW upgrade |
| `./apw upgrade-project <name-or-path> --workspace /path/to/workspace --dry-run` | preview an upgrade by project name under a chosen workspace parent |
| `./apw upgrade-project <name-or-path> --validate` | upgrade and run validation afterward |
| `./apw upgrade-project <name-or-path> --force-managed` | also refresh review-before-overwrite APW-managed files |
| `./apw upgrade-project <name-or-path> --profile auto|minimal|base|advanced` | override or pin the expected downstream profile |
| `./apw upgrade-project <name-or-path> --stack <value>` | use a specific stack value during upgrade and validation |

### Lower-level APW script commands

These are also shown in their APW-root form. From a downstream repo, replace `./scripts/...` with `/path/to/apw/scripts/...`.

| Command | What it does |
| :--- | :--- |
| `./scripts/upgrade-project.sh --help` | show the lower-level downstream upgrade script help |
| `./scripts/bootstrap.sh --target . --profile base --stack base` | low-level bootstrap engine |
| `./scripts/bootstrap.sh --target /path/to/project --profile base --stack base` | low-level bootstrap for a chosen target repo |
| `./scripts/validate.sh . --profile base --stack base` | validate a repo against the APW contract |
| `./scripts/validate.sh /path/to/project --profile base --stack base` | validate a chosen target repo |
| `./scripts/init-project-state.sh --target .` | generate the first core `.gsd` drafts |
| `./scripts/init-project-state.sh --target /path/to/project` | generate the first core `.gsd` drafts for a chosen repo |

## Common command sequences

These examples use the APW-root form.

### Create a new project

```bash
./apw new MyProject --profile base --stack base
```

### Create a new project in a specific workspace and initialize state

```bash
./apw new MyProject --profile base --stack base --target /path/to/workspace --init-state
```

### Validate a project

```bash
./scripts/validate.sh /path/to/project --profile base --stack base
```

### Check context for a specific project path

```bash
./apw context /path/to/project
```

### Get first-run guidance for a specific project

```bash
./apw first-run /path/to/project
```

### Switch to a named project in a workspace

```bash
./apw switch project MyProject --workspace /path/to/workspace
```

### Safely upgrade an older project

```bash
git add .
git commit -m "checkpoint before APW upgrade"
./apw upgrade-project /path/to/project --dry-run
./apw upgrade-project /path/to/project --validate
```

## Practical notes

- path-based forms are usually safer for beginners than implicit `.`-based commands
- start from `AGENTS.md`
- use this file when you just need the command names fast
- use `WORKFLOW_SELECTION_GUIDE.md` or `COMMAND_INVOCATION_GUIDE.md` only when you need more detail
