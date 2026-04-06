# PROJECT_BOOTSTRAP.md — Bootstrap Contract and Operational Rules

> [!NOTE]
> This document defines the exact behavior of `./scripts/bootstrap.sh` for creating or upgrading downstream repositories with the APW standard.

## 1. Canonical Source

- `templates/` is the canonical downstream bootstrap source for profile-selected `.gsd/` and `.agent/` content.
- APW remains one canonical framework. Bootstrap does not create separate Codex and Antigravity variants of the standard.
- Bootstrap generates a repo-root `AGENTS.md` as the default modern tool-facing entrypoint.
- That root `AGENTS.md` routes readers into the deeper APW operating documents; it does not replace them.
- The script never creates or expects a top-level `.agents/` directory.
- The active downstream execution namespace is always `.agent/`.
- Repo-root APW entrypoint and operating files (`AGENTS.md`, `PROJECT_RULES.md`, `AGENT_SYSTEM.md`, `COMMAND_POLICY.md`, `PROJECT_BOOTSTRAP.md`, `GSD-STYLE.md`) are copied directly from the APW repo root during bootstrap.
- Downstream repos do not need separate APW branches, templates, or validators for Codex versus Antigravity. Compatibility is handled through the shared entrypoint and documentation.
- Bootstrap does not generate `GEMINI.md` by default. Teams may add or keep `GEMINI.md` deliberately when backward compatibility is needed.
- Newer Antigravity-native `.agents/...` pipeline layouts are a separate architectural choice. Bootstrap does not silently migrate APW repos to that layout.
- Any future structural migration must be explicit, versioned, and coordinated across bootstrap, validation, templates, docs, CI, and downstream migration guidance.
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

Bootstrap also copies these root APW entrypoint and operating files into the target:

- `AGENTS.md`
- `PROJECT_RULES.md`
- `AGENT_SYSTEM.md`
- `COMMAND_POLICY.md`
- `PROJECT_BOOTSTRAP.md`
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

- Root entrypoint and operating files are always overwritten.
- Execution-layer content under `.agent/` is always synced from the selected profile when source content exists.
- `.gsd` lifecycle files are preserved by default and only overwritten when `--force` is supplied.
- Missing optional profile directories do not fail the run; they are logged and the pre-created target directory remains empty.

This split is intentional:

- the tool-facing entrypoint should stay current
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
- Downstream repos receive a root `AGENTS.md` by default as the modern tool-facing front door.
- The real governance source remains the core APW operating files copied at repo root, not compatibility entrypoints alone.
- Downstream repos do not receive separate Codex and Antigravity framework variants.
- `templates/` is the only profile source used for lifecycle and execution-layer template content.
- `.agent/skills/` is the active skills path.
- `AGENTS.md` routes readers into the APW contract; it does not replace `PROJECT_RULES.md`, `AGENT_SYSTEM.md`, `COMMAND_POLICY.md`, or `PROJECT_BOOTSTRAP.md`.
- `GEMINI.md` remains a compatibility option, but it is not generated by default.
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

- required root APW entrypoint and operating files
- profile-selected `.gsd` lifecycle files
- minimum content shape for key lifecycle and governance files
- the full `.agent/` directory namespace
- profile-backed execution files when the selected profile vendors them
- warnings for unplanned `.agents/` or `.agents/skills/` alternate-layout drift against the current APW contract
- warnings for ownership drift that contradict the orchestrator-controlled state model

Validation is executed from the APW repository against a target repo path. Bootstrapped downstream repos do not receive a second local copy of the APW templates, policies, or validator scripts.

## 9. Required Post-Bootstrap Steps

Before a downstream team begins routine coding work:

1. Run validation with the same `--profile` and `--stack` values used during bootstrap.
2. Review [docs/DOWNSTREAM_ADOPTION_GUIDE.md](docs/DOWNSTREAM_ADOPTION_GUIDE.md) and complete [docs/DOWNSTREAM_COMPLIANCE_CHECKLIST.md](docs/DOWNSTREAM_COMPLIANCE_CHECKLIST.md).
3. Use a single orchestrator or explicit governance pass to populate the first canonical `.gsd/` state coherently.
4. Confirm the mandatory contract files remain present:
   - `AGENTS.md`
   - `PROJECT_RULES.md`
   - `AGENT_SYSTEM.md`
   - `COMMAND_POLICY.md`
   - `PROJECT_BOOTSTRAP.md`
   - `GSD-STYLE.md`
   - the selected profile's required `.gsd/` files
   - `.agent/agents/`, `.agent/rules/`, `.agent/scripts/`, `.agent/workflows/`, `.agent/skills/`
5. Add project-specific implementation constraints in project-local materials such as `.agent/rules/PROJECT.md` or the `.gsd/` contents instead of forking the APW contract files casually.
6. Enable CI enforcement using [docs/CI_CD_ENFORCEMENT.md](docs/CI_CD_ENFORCEMENT.md) and [examples/github/apw-validate.yml](examples/github/apw-validate.yml) so merge-time drift detection is active early.
7. For existing repositories, pair bootstrap with [docs/EXISTING_REPO_MIGRATION_GUIDE.md](docs/EXISTING_REPO_MIGRATION_GUIDE.md) before the team resumes normal delivery.
