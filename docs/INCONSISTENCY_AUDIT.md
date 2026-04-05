# Executive Summary
An exhaustive audit of the APW workspace standard reveals significant, but easily correctable, inconsistencies across naming conventions, folder structures, and automation scripts. The core operating model (GSD governs, AGK executes) remains structurally sound, but the repo is held back by legacy file duplication and validation gaps.

## Top Critical Inconsistencies
1. **The `.agent` vs `.agents` Split**: The intelligence layer is fragmented. `.agent/` holds workflows/rules/agents, while `.agents/skills` is completely split off. This violates the single-source-of-truth ideal.
2. **Template Duplication**: `bootstrap.sh` canonically pulls from `templates/base/.gsd/`, but a dormant `.gsd/templates/` folder exists directly in the repo root, causing deep ambiguity.
3. **Naming Drift & Stray Docs**: Documentation is scattered between the repo root (`TOOLING_NOTES.md`, `PROJECT_BOOTSTRAP.md`, `TEMPLATE_STRUCTURE.md`) and the `docs/` folder (`TOOLING_GUIDE.md`, `PROJECT_INSTANTIATION_PROMPT.md`), with overlapping content.
4. **Weak Validation**: `scripts/validate.sh` only checks for `.agent/workflows`, ignoring crucial execution layers (`rules`, `skills`, `agents`) and the new Git commit template.

## Fix Priorities
- **Immediate**: Resolve folder structure ambiguities (`.gsd/templates/` and `.agents/`).
- **Immediate**: Normalize documentation into `docs/` and eliminate redundancies.
- **Next-Pass**: Harden `validate.sh` and `bootstrap.sh` to enforce the newly unified structures.

---

# Full Inconsistency Matrix

| Problem Area | Inconsistency Class | Description | Proposed Fix | Priority |
| :--- | :--- | :--- | :--- | :--- |
| **Intelligence Folders** | Structure Mismatch | Both `.agent/` and `.agents/` exist. `README` mentions one thing, `bootstrap.sh` hardcodes another. | Consolidate `.agents/skills` into `.agent/skills`. Remove `.agents/`. Update docs/scripts. | Critical Now |
| **Template Chaos** | Template Ambiguity | `templates/base/.gsd/` is used by bootstrap. Root `.gsd/templates/` is ignored but present. | Delete root `apw/.gsd/templates/`. Canonicalize `apw/templates/` as the only source. | Critical Now |
| **Scattered Docs** | Naming Drift & Ownership | `TOOLING_NOTES.md`, `PROJECT_BOOTSTRAP.md`, `TEMPLATE_STRUCTURE.md` live at root. Overlap with `docs/*`. | Move root docs to `docs/`. Merge `TOOLING_NOTES.md` -> `docs/TOOLING_GUIDE.md` and delete. Update README links. | Critical Now |
| **Weak Validation** | Validation Gap | `validate.sh` misses `.agent/rules`, `.agent/skills`, `.agent/agents`, `.gitmessage`. | Expand `validate.sh` to require the full `.agent/` scaffolding. | Important Next |

---

# Detailed Remediation Plan & Execution Phases

### Phase 2: Normalize Folder Structure & Templates
*Objective*: Eradicate duplicate folders and merge intelligence layers.
*Files expected to change*:
- DELETE `.gsd/templates/` natively.
- MOVE `.agents/skills` to `.agent/skills`.
- UPDATE `README.md`, `SKILL_CURATION.md`, `COMMAND_POLICY.md` to reference `.agent/skills`.

### Phase 3: Documentation Alignment & Consolidation
*Objective*: Clean up the repo root and enforce the `docs/` directory as the only place for guides.
*Files expected to change*:
- MOVE `TEMPLATE_STRUCTURE.md` to `docs/TEMPLATE_STRUCTURE.md`.
- MERGE `TOOLING_NOTES.md` into `docs/TOOLING_GUIDE.md`, then DELETE root file.
- MERGE `PROJECT_BOOTSTRAP.md` into `README.md` (or `docs/`), then DELETE root file.
- UPDATE `README.md` links.

### Phase 4: Harden Automation & Validation
*Objective*: Ensure `bootstrap.sh` and `validate.sh` perfectly mirror the finalized structure.
*Files expected to change*:
- UPDATE `scripts/bootstrap.sh` (change `.agents/skills` to `.agent/skills`).
- UPDATE `scripts/validate.sh` (add checks for `.agent/skills`, `.agent/rules`, `.agent/agents`).
- UPDATE `docs/CI_CD_MOCKUPS.md` if paths change.

---

# Repo Health Assessment after Fixes
Once complete, the APW standard will possess:
- A perfectly strict execution boundary: **ALL** intelligence lives in `.agent/`.
- A single undisputed canonical template origin: `templates/`.
- A clean root directory dedicated purely to high-level governance and indexing.
- Automation that actually enforces the complete model.
