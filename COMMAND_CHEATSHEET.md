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

Advanced extras when the project profile includes them:

| Command | Use it when |
| :--- | :--- |
| `/deploy` | you are preparing or managing deployment work |
| `/design` | you want UX, flows, or product-structure guidance |
| `/preview` | you want a review-oriented preview pass |
| `/ui-ux-pro-max` | you want a heavier UI/UX design workflow |

## Terminal commands

### APW wrapper commands

These are shown in their APW-root form. If you are reading this inside a downstream repo, replace `./apw` with `/path/to/apw/apw`.

| Command | What it does |
| :--- | :--- |
| `./apw help` | show the APW wrapper commands |
| `./apw context` | tell you whether you are in APW root, a project root, or a workspace folder |
| `./apw first-run` | print the beginner-safe first-run checklist |
| `./apw new MyProject --profile base --stack base` | create a new APW project |
| `./apw list-projects` | list known downstream projects in the workspace |
| `./apw switch framework` | show the APW framework root clearly |
| `./apw switch parent` | show the workspace parent clearly |
| `./apw switch project <name-or-path>` | resolve a downstream project clearly |
| `./apw upgrade-project <name-or-path> --dry-run` | preview a safe downstream APW upgrade |

### Lower-level APW script commands

These are also shown in their APW-root form. From a downstream repo, replace `./scripts/...` with `/path/to/apw/scripts/...`.

| Command | What it does |
| :--- | :--- |
| `./scripts/bootstrap.sh --target . --profile base --stack base` | low-level bootstrap engine |
| `./scripts/validate.sh . --profile base --stack base` | validate a repo against the APW contract |
| `./scripts/init-project-state.sh --target .` | generate the first core `.gsd` drafts |

## Common command sequences

These examples use the APW-root form.

### Create a new project

```bash
./apw new MyProject --profile base --stack base
```

### Validate a project

```bash
./scripts/validate.sh . --profile base --stack base
```

### Get first-run guidance

```bash
./apw first-run
```

### Safely upgrade an older project

```bash
./apw upgrade-project MyProject --dry-run
./apw upgrade-project MyProject --validate
```

## Short reminder

- start from `AGENTS.md`
- use this file when you just need the command names fast
- use `WORKFLOW_SELECTION_GUIDE.md` or `COMMAND_INVOCATION_GUIDE.md` only when you need more detail
