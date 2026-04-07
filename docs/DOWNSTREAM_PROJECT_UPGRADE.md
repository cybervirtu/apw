# DOWNSTREAM_PROJECT_UPGRADE.md — Safe Downstream APW Upgrade

> [!IMPORTANT]
> Use this when your APW framework repo has been updated and you want an existing downstream APW project to receive the latest APW-managed improvements safely.

## What this guide is

This guide explains the safe way to update an existing downstream APW project from a newer APW framework checkout.

The important rule is simple:

- APW-managed files can be refreshed
- project-owned files must stay protected

`apw upgrade-project` is the beginner-safe wrapper for that job.

## The upgrade boundary

APW treats downstream files in three categories.

### A. Safe auto-upgrade

These are clearly vendored APW-managed surfaces and can be refreshed automatically:

- the shared downstream core workflow pack in `.agent/workflows/`
- the shared downstream core agents in `.agent/agents/`
- the shared downstream core rules in `.agent/rules/`

For `base` and `advanced`, this includes the core commands:

- `/status`
- `/brainstorm`
- `/create`
- `/enhance`
- `/debug`
- `/test`
- `/orchestrate`

### B. Review-before-overwrite

These are APW-managed files, but teams may have made local edits to them:

- `AGENTS.md`
- `COMMAND_CHEATSHEET.md`
- `PROJECT_RULES.md`
- `AGENT_SYSTEM.md`
- `COMMAND_POLICY.md`
- `PROJECT_BOOTSTRAP.md`
- `GSD-STYLE.md`
- `.gitmessage`
- profile-local APW-managed extras under `.agent/`
- stack-managed APW extras under `.agent/skills/`

By default, `apw upgrade-project` restores these only when they are missing.

If they already exist and differ, APW warns and skips them unless you deliberately use `--force-managed`.

### C. Never blindly overwrite

These are project-owned surfaces and must stay protected:

- `.gsd/SPEC.md`
- `.gsd/TODO.md`
- `.gsd/STATE.md`
- `.gsd/ROADMAP.md`
- `.gsd/DECISIONS.md`
- `.gsd/JOURNAL.md`
- `.gsd/ARCHITECTURE.md`
- `.gsd/STACK.md`
- project source code
- project tests
- other repo-specific implementation files

If you remember one rule, remember this:

- `upgrade-project` refreshes APW-managed framework material, not your project memory or product code

## The safest command to use

From APW root, the workspace parent, or any other convenient location, run:

```bash
/path/to/apw/apw upgrade-project MyProject --dry-run
```

Or use a direct path:

```bash
/path/to/apw/apw upgrade-project /path/to/MyWork/MyProject --dry-run
```

If your workspace parent is not the default one, add:

```bash
--workspace /path/to/MyWork
```

## What `--dry-run` shows you

The preview tells you:

- which files would be refreshed automatically
- which APW-managed files are being skipped for review
- which files are already current
- which project-owned surfaces remain protected

Use preview first whenever the repo matters.

## When to use `--force-managed`

Use:

```bash
/path/to/apw/apw upgrade-project MyProject --force-managed
```

only when you intentionally want APW to refresh the review-before-overwrite surfaces too.

This is appropriate when:

- you want the latest APW root governance/reference files
- you do not need to preserve local edits to those APW-managed files
- you reviewed the preview and understand what will change

If you are unsure, do not use `--force-managed` yet.

## Recommended upgrade flow

1. Commit or checkpoint the downstream repo first.
2. Run `apw upgrade-project <name-or-path> --dry-run`.
3. Review what APW will refresh automatically and what it will skip.
4. Run `apw upgrade-project <name-or-path>` for the safe default upgrade.
5. Re-run with `--force-managed` only if you intentionally want the skipped APW-managed review surfaces refreshed too.
6. Run validation with the same profile and stack.

Example:

```bash
/path/to/apw/apw upgrade-project MyProject --dry-run
/path/to/apw/apw upgrade-project MyProject --validate
```

If you know you want a full APW-managed refresh of review surfaces too:

```bash
/path/to/apw/apw upgrade-project MyProject --force-managed --validate
```

## How this relates to raw bootstrap

`bootstrap.sh` is still the low-level engine and contract source.

But for an existing downstream repo:

- `bootstrap.sh` is the lower-level tool
- `apw upgrade-project` is the safer wrapper

Why:

- raw bootstrap always refreshes APW root operating files
- raw bootstrap always syncs execution-layer `.agent/` content
- raw bootstrap preserves `.gsd/` by default unless `--force` is used

So for existing repos, `apw upgrade-project` is usually the right first choice because it adds preview mode and a safer review boundary for APW-managed root files.

## What happens after upgrade

After a successful upgrade:

- review any files that were skipped for manual comparison
- run validation
- continue normal work in the downstream project root

Use:

```bash
/path/to/apw/scripts/validate.sh /path/to/MyWork/MyProject --profile base --stack base
```

Or let the wrapper do it:

```bash
/path/to/apw/apw upgrade-project MyProject --validate
```

## Beginner rule of thumb

If APW itself changed and you want your project to receive those APW improvements:

- use `apw upgrade-project`
- preview first
- keep `.gsd` memory and product code protected
- validate after the upgrade

## Read next only if needed

- [PROJECT_BOOTSTRAP.md](../PROJECT_BOOTSTRAP.md)
- [DOWNSTREAM_ADOPTION_GUIDE.md](./DOWNSTREAM_ADOPTION_GUIDE.md)
- [DOWNSTREAM_COMPLIANCE_CHECKLIST.md](./DOWNSTREAM_COMPLIANCE_CHECKLIST.md)
- [UPGRADE_STRATEGY.md](./UPGRADE_STRATEGY.md)
