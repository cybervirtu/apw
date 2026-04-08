# INSTALLATION_GUIDE.md — Installation Guide

> [!IMPORTANT]
> Use this if you are installing APW for the first time and want the shortest safe local setup path.

## What APW is installed as

APW is installed as a local framework repository.

In practice, that means:

- you clone the APW repo to your machine
- you keep it in a workspace alongside your downstream project repos
- you use the APW repo to create, validate, initialize, and upgrade downstream projects

Typical layout:

```text
MyWork/
├── apw/
├── ProjectA/
└── ProjectB/
```

APW is not a global package install.

It is a local framework checkout that you use alongside real project repos.
The canonical command is still `apw`, but you expose it through a workspace-scoped launcher instead of through per-project copies.

In the APW documentation levels, this is a `Level 1 — Start now` guide.
For the full level model, read [DOCUMENTATION_LEVELS.md](./DOCUMENTATION_LEVELS.md).

## What you need

### Required

- `git`
- `bash` or compatible shell support
- local terminal access

### Recommended

- `ripgrep` (`rg`) for faster search and smoother workflow use
- a code editor or IDE where you will open downstream projects

### Optional

- `node` and `npm` if you want to run the local docs portal under `website/`
- a supported launcher such as `code` if you want optional `apw switch ... --open` behavior

## Install APW locally

### 1. Clone the APW repository

Choose a workspace folder and clone APW into it:

```bash
git clone <your-apw-repo-url> apw
```

### 2. Enter the APW repository

```bash
cd apw
```

### 3. Install the workspace launcher

From APW root, run:

```bash
./scripts/install-workspace-launcher.sh
source ../.apw/env.zsh
```

The installer creates a workspace-scoped launcher at `../.apw/bin/apw` and a zsh-friendly PATH snippet at `../.apw/env.zsh`.

For future zsh shells, add the same source line to `~/.zshrc`:

```bash
source /path/to/MyWork/.apw/env.zsh
```

This keeps `apw` available from the workspace parent, APW root, and downstream project roots without copying wrappers into projects.

## Verify it works

Run these simple checks:

### Check Git

```bash
git --version
```

### Check Bash

```bash
bash --version
```

### Check the APW launcher

```bash
apw help
```

### Optional context check

```bash
apw context
```

Done looks like:

- Git responds normally
- Bash responds normally
- `apw help` prints the APW wrapper command list
- `apw context` correctly identifies the APW root

If `apw` is not resolvable yet:

- run `source ../.apw/env.zsh` from APW root
- then add that same source line to `~/.zshrc`
- if the workspace launcher itself is missing, run `./scripts/install-workspace-launcher.sh` again from APW root

## Optional docs portal setup

You do not need the docs portal to use APW.

Use it only if you want the rendered visual docs experience.

From the APW root:

```bash
cd website
npm install
npm run dev
```

If you only want the beginner path, you can skip this and read the Markdown docs directly.

## What to do next

Read now:

1. [BASIC_USAGE_GUIDE.md](./BASIC_USAGE_GUIDE.md)
2. [BASIC_ONBOARDING_PROCEDURE.md](./BASIC_ONBOARDING_PROCEDURE.md)
3. [FIRST_RUN_IN_IDE.md](./FIRST_RUN_IN_IDE.md)

Only if needed:

4. [WHERE_DO_I_WORK.md](./WHERE_DO_I_WORK.md)
5. [SAFE_CONTEXT_SWITCHING.md](./SAFE_CONTEXT_SWITCHING.md)
6. [../COMMAND_CHEATSHEET.md](../COMMAND_CHEATSHEET.md)

If you want the shortest next step after installation, think:

- `APW: Create Project`

Terminal fallback:

```bash
apw new MyProject --profile base --stack base
```

From APW root, that command creates `/path/to/workspace/MyProject` beside `apw` by default.
Use `--target /path/to/parent` only when you want a different parent location explicitly.
