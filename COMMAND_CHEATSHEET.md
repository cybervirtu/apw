# COMMAND_CHEATSHEET.md — APW Fast Command Reference

> [!TIP]
> Use this as the fast operator reference for the locked APW command surface.

> [!IMPORTANT]
> The only short aliases documented and supported here are:
> `h`, `s`, `c`, `fr`, `lp`, and `up`.

## Help And Discovery

### `apw help`
- Alias: `apw h`
- Purpose: show compact top-level help or detailed help for one command
- Syntax:
  - `apw help`
  - `apw h`
  - `apw help <command>`
- Example:
  - `apw help switch`

### `apw context`
- Alias: `apw c`
- Purpose: show whether you are in APW root, the workspace parent, a downstream project root, or an unsupported location
- Syntax:
  - `apw context`
  - `apw c`
  - `apw context <path>`
- Example:
  - `apw c`

### `apw first-run`
- Alias: `apw fr`
- Purpose: print the beginner-safe first-run checklist for a downstream project
- Syntax:
  - `apw first-run`
  - `apw fr`
  - `apw first-run <path>`
- Example:
  - `apw fr /path/to/project`

### `apw list-projects`
- Alias: `apw lp`
- Purpose: list recognized downstream APW projects under the inferred or explicit workspace parent
- Syntax:
  - `apw list-projects`
  - `apw lp`
  - `apw list-projects --workspace /path/to/workspace`
- Relevant extension:
  - `--workspace /path/to/workspace`
- Example:
  - `apw lp`

## Switching

### `apw switch`
- Alias: `apw s`
- Purpose: resolve a destination, print the exact path, and run Antigravity when the `antigravity` launcher is available
- Locked syntax:
  - `apw switch framework`
  - `apw switch parent`
  - `apw switch <project-name-or-path>`
  - `apw s framework`
  - `apw s parent`
  - `apw s <project-name-or-path>`
- Relevant extension:
  - `--workspace /path/to/workspace`
- Examples:
  - `apw switch framework`
  - `apw s parent`
  - `apw switch MyProject`
  - `apw s /path/to/workspace/MyProject`
  - `apw s MyProject --workspace /path/to/workspace`

## Project Lifecycle

### `apw setup`
- Alias: none
- Purpose: verify prerequisites and install or refresh the workspace launcher
- Syntax:
  - `apw setup`
  - `apw setup --check-only`
- Relevant extension:
  - `--check-only`
- Example:
  - `./apw setup`

### `apw new`
- Alias: none
- Purpose: create a new downstream APW project with workspace-aware destination resolution
- Syntax:
  - `apw new <project-name> [--profile base|minimal|advanced] [--stack value] [--target dir] [--force] [--skip-validate] [--init-state]`
- Relevant extensions:
  - `--profile base|minimal|advanced`
  - `--stack value`
  - `--target /path/to/workspace`
  - `--skip-validate`
  - `--init-state`
- Example:
  - `apw new MyProject --profile base --stack base`

### `apw upgrade-project`
- Alias: `apw up`
- Purpose: preview or apply APW-managed upgrades to one downstream project
- Syntax:
  - `apw upgrade-project <name-or-path> [--workspace /path/to/workspace] [--profile auto|minimal|base|advanced] [--stack value] [--dry-run] [--force-managed] [--validate]`
  - `apw up <name-or-path> [--workspace /path/to/workspace] [--profile auto|minimal|base|advanced] [--stack value] [--dry-run] [--force-managed] [--validate]`
- Relevant extensions:
  - `--workspace /path/to/workspace`
  - `--dry-run`
  - `--force-managed`
  - `--validate`
  - `--profile auto|minimal|base|advanced`
  - `--stack value`
- Example:
  - `apw up MyProject --dry-run`

## Common Examples

### Show help fast
```bash
apw h
apw help list-projects
```

### Check where you are
```bash
apw c
apw context /path/to/project
```

### Switch cleanly
```bash
apw s framework
apw s parent
apw s MyProject
apw s MyProject --workspace /path/to/workspace
```

### List and open the right repo
```bash
apw lp
apw s MyProject
```

### Create a new project
```bash
apw new MyProject --profile base --stack base
```

### Preview an upgrade safely
```bash
apw up MyProject --dry-run
```
