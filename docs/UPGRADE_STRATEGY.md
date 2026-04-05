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
4. **Validate**: Run `./scripts/validate.sh` to ensure compliance.
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
- **Rollout**: Can be blindly deployed to downstream repositories via `./scripts/bootstrap.sh --force`.

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
2. Re-run `./scripts/bootstrap.sh` from the downgraded version.
3. If corruption hit `.gsd/STATE.md`, perform a "State Dump" utilizing the project's own `.gsd/JOURNAL.md` to rebuild context.
