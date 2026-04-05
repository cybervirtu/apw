# PROJECT_BOOTSTRAP.md — Bootstrap Contract and Operational Rules

> [!NOTE]
> This document defines the exact behavior of `./scripts/bootstrap.sh` for creating or upgrading downstream repositories with the APW standard.

## 1. Canonical Source

- `templates/` is the canonical downstream bootstrap source for profile-selected `.gsd/` and `.agent/` content.
- The script never creates or expects a top-level `.agents/` directory.
- The active downstream execution namespace is always `.agent/`.
- Repo-root governance files (`PROJECT_RULES.md`, `AGENT_SYSTEM.md`, `GSD-STYLE.md`) are copied directly from the APW repo root during bootstrap.
- Profile-tree details are documented in `templates/README.md`.

## 2. Inputs

`./scripts/bootstrap.sh` accepts the following inputs:

- `--target <path>`: The directory to initialize or upgrade. Defaults to the current directory.
- `--profile <minimal|base|advanced>`: The template profile to apply from `templates/`. Defaults to `base`.
- `--stack <name>`: Optional stack add-on name under `templates/stack/`. Defaults to `base`, which means no add-on pack is applied.
- `--force`: Overwrite existing `.gsd` lifecycle files in the target repo.

If `--profile` points to a missing profile directory or that profile has no `.gsd` directory, bootstrap fails fast.

## 3. Outputs

Bootstrap always creates this downstream directory skeleton:

```text
[target]/
├── .agent/
│   ├── agents/
│   ├── rules/
│   ├── scripts/
│   ├── workflows/
│   └── skills/
├── .gsd/
└── docs/
```

Bootstrap also copies these root governance files into the target:

- `PROJECT_RULES.md`
- `AGENT_SYSTEM.md`
- `GSD-STYLE.md`
- `.gitmessage` when present in the APW repo

## 4. Profile Behavior

### `minimal`

- Copies the lightweight `.gsd` starter set from `templates/minimal/.gsd/`.
- Syncs any profile-local `.agent/` content that exists in `templates/minimal/.agent/`.
- Best for small projects, prototypes, or lightweight research repos.

### `base`

- Copies the standard lifecycle set from `templates/base/.gsd/`.
- Creates the full downstream `.agent/` directory tree even when the profile contributes no `.agent` files of its own.
- This is the default bootstrap profile and the intended baseline for most repositories.

### `advanced`

- Copies the canonical eight-file lifecycle set from `templates/advanced/.gsd/`: `SPEC.md`, `ROADMAP.md`, `STATE.md`, `TODO.md`, `JOURNAL.md`, `DECISIONS.md`, `ARCHITECTURE.md`, and `STACK.md`.
- Syncs vendored `.agent/agents/`, `.agent/rules/`, `.agent/workflows/`, and any profile-local `.agent/scripts/` or `.agent/skills/` content that exists.
- Best for repos that need the richest specialist execution bundle without fragmenting state across extra root `.gsd` files.

## 5. Force and Overwrite Rules

Bootstrap applies overwrite rules by content class:

- Root governance files are always overwritten.
- Execution-layer content under `.agent/` is always synced from the selected profile when source content exists.
- `.gsd` lifecycle files are preserved by default and only overwritten when `--force` is supplied.
- Missing optional profile directories do not fail the run; they are logged and the pre-created target directory remains empty.

This split is intentional:

- governance should stay current
- execution prompts/workflows should stay current
- lifecycle state should be preserved unless the operator explicitly requests replacement

## 6. Upgrade Behavior for Existing Repositories

Bootstrap is safe to run against an existing repository when used intentionally:

1. Re-run bootstrap against the repo root with the desired profile.
2. Omit `--force` to preserve existing `.gsd` lifecycle files.
3. Use `--force` only when you explicitly want to replace lifecycle templates in `.gsd/`.
4. Review any refreshed `.agent/` content, because prompts and workflows are always updated from the selected profile.
5. If a stack add-on is requested but no vendored skill pack exists under `templates/stack/<name>/`, bootstrap continues and logs a warning.
6. If an older advanced repo still has legacy root `.gsd` files such as `MILESTONE.md`, `SPRINT.md`, `PHASE-SUMMARY.md`, `STATE_SNAPSHOT.md`, or `TOKEN_REPORT.md`, consolidate their live content into `ROADMAP.md`, `STATE.md`, `TODO.md`, or `JOURNAL.md` before deleting the redundant files.

Recommended upgrade examples:

```bash
./scripts/bootstrap.sh --target . --profile base --stack base
./scripts/bootstrap.sh --target . --profile advanced --stack base
./scripts/bootstrap.sh --target . --profile base --stack base --force
```

## 7. Deterministic Contract Summary

- Downstream repos are bootstrapped under `.agent/`, never `.agents/`.
- `templates/` is the only profile source used for lifecycle and execution-layer template content.
- `.agent/skills/` is the active skills path.
- The advanced profile uses the same canonical eight-file `.gsd` contract as the base profile; its additional depth comes from `.agent/` execution content, not extra root state files.
- Stack-specific skills are only applied from `templates/stack/<name>/.agent/skills/` when that pack exists.
- Missing optional `.agent` profile directories are treated as empty, not as errors.

## 8. Validation Pairing

After bootstrap, validate the target repo against the same bootstrap inputs:

```bash
/path/to/apw/scripts/validate.sh [repo-root] --profile base --stack base
/path/to/apw/scripts/validate.sh [repo-root] --profile advanced --stack base
```

Validation enforces:

- required root governance files
- profile-selected `.gsd` lifecycle files
- minimum content shape for key lifecycle and governance files
- the full `.agent/` directory namespace
- profile-backed execution files when the selected profile vendors them
- warnings for legacy `.agents/` drift
- warnings for ownership drift that contradict the orchestrator-controlled state model

Validation is executed from the APW repository against a target repo path. Bootstrapped downstream repos do not receive a second local copy of the APW templates, policies, or validator scripts.
