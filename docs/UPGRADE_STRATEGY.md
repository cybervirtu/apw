# UPGRADE_STRATEGY.md — Maintenance and Sync Policy

> [!NOTE]
> This document defines how the APW standard consumes upstream updates from the private GSD and AGK repositories without disrupting active product repositories downstream.

## 1. Vendor Strategy

Because APW is a merged standard, we do not blindly pull upstream changes.

- **GSD Updates**: Usually vendored verbatim. GSD is the canonical brain, and its conceptual updates (`PROJECT_RULES.md`, `.gsd/` structure) should be adopted as-is.
- **AGK Updates**: Aggressively curated. New workflows or skills in AGK must pass the Namespace Conflict check (see `COMMAND_POLICY.md`) before being merged into `.agent/` or `.agent/skills/`.

## 2. Synchronization Workflow

When updating APW from the upstream private repositories, follow these steps:
1. **Pull to Sandbox**: Pull GSD and AGK changes into the `./sources/` directory.
2. **Review Diff**: Compare the upstream changes against the current `./apw/` master representation.
3. **Merge**: Apply approved, curated changes to `./apw/`.
4. **Validate**: Run `/path/to/apw/scripts/validate.sh [repo-root] --profile base --stack base` or the equivalent profile-aware command for the target being reviewed.
5. **Release**: Commit to the APW `main` branch.

---

## 3. Versioning and Rollout Rhythm

APW utilizes a "Tick-Tock" release rhythm to protect active projects from stability issues.

### 🔴 Major Upgrades (Tick)
- **Definition**: Breaking changes to Governance rules or core `.gsd` file structures.
- **Action**: Bumps a major semantic version (e.g., `v2.0.0`). 
- **Rollout**: Product repositories must manually migrate their `.gsd` tracking during a sprint boundary.

### 🟢 Routine Updates (Tock)
- **Definition**: Non-destructive prompt tweaks, new skills, or bug fixes in workflows.
- **Action**: Bumps a minor/patch version (e.g., `v2.1.0`).
- **Rollout**: For existing downstream repos, prefer `apw upgrade-project <name-or-path> --dry-run` first. That wrapper previews what will refresh automatically, what will be skipped for review, and what remains protected. Use raw `bootstrap.sh` only when you intentionally want the lower-level contract behavior. Add `--force` only when lifecycle templates in `.gsd/` are intentionally being replaced. If downstream CI pins APW to a release tag or commit SHA, update that reference as part of the rollout.

### Downstream upgrade boundary

APW keeps one clear ownership split:

- APW-managed files may be refreshed from the framework
- project-owned `.gsd` memory and implementation files must not be blindly overwritten

In practice:

- safe auto-upgrade: vendored downstream `.agent` core pack
- review-before-overwrite: APW-managed root contract files and profile/stack extras
- never blindly overwrite: `.gsd/*`, project code, and repo-specific implementation files

---

## 4. Change Review & Compatibility

Before merging any change into APW, reviewers must use this **Compatibility Checklist**:

- [ ] Does this change overwrite active project memory (e.g., `STATE.md`) if accidentally synced?
- [ ] Does this new AGK workflow conflict semantically with a GSD governance rule?
- [ ] Does this update introduce a specific model dependency (violating GSD model-independence)?
- [ ] Is this change fully documented in `CHANGELOG.md`?

---

## 5. Deprecation & Rollback

### Deprecation Policy
If an APW command or template is rendered obsolete by an upstream change:
1. It is marked as `DEPRECATED` in the workflow file's YAML frontmatter.
2. It remains in the repository for **one major release cycle** before being removed entirely.

### Rollback Strategy
If a synced update corrupts downstream product repos:
1. Downgrade the active project utilizing standard `git checkout [stable-tag]`.
2. Re-run `apw upgrade-project <name-or-path>` from the downgraded version, or use raw `bootstrap.sh` if you intentionally need the lower-level contract behavior.
3. If corruption hit `.gsd/STATE.md`, perform a "State Dump" utilizing the project's own `.gsd/JOURNAL.md` to rebuild context.
