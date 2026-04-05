# Executive Summary
An exhaustive audit of the APW workspace standard reveals significant, but easily correctable, inconsistencies across naming conventions, folder structures, and automation scripts. The core operating model (GSD governs, AGK executes) remains structurally sound, but the repo is held back by legacy file duplication and validation gaps.

## Top Critical Inconsistencies
1. **Historical Namespace Drift**: Older documentation mixed a unified `.agent/` layout with references to a separate legacy skills namespace. The active APW contract is `.agent/` only, with capabilities living in `.agent/skills/`.
2. **Template Ownership Ambiguity**: `bootstrap.sh` uses `templates/` as the live downstream source, but older documentation spent too much time implying alternate template roots instead of simply documenting `templates/` as canonical.
3. **Naming Drift & Stray Docs**: Documentation is scattered between the repo root (`TOOLING_NOTES.md`, `PROJECT_BOOTSTRAP.md`, `TEMPLATE_STRUCTURE.md`) and the `docs/` folder (`TOOLING_GUIDE.md`, `PROJECT_INSTANTIATION_PROMPT.md`), with overlapping content.
4. **Previously Weak Validation**: Validation was once too thin to enforce the full APW contract. This has since been tightened, but the supporting operating docs still need practical alignment.

## Fix Priorities
- **Immediate**: Standardize all active documentation on the unified `.agent/` namespace and remove legacy split-namespace language.
- **Immediate**: Normalize documentation into `docs/` and eliminate redundancies.
- **Next-Pass**: Harden `validate.sh` and `bootstrap.sh` to enforce the newly unified structures.

---

# Full Inconsistency Matrix

| Problem Area | Inconsistency Class | Description | Proposed Fix | Priority |
| :--- | :--- | :--- | :--- | :--- |
| **Intelligence Folders** | Structure Mismatch | The repository contract is `.agent/` only, but older documentation still describes a split layout or renders `.agent/skills/` as if it were outside `.agent/`. | Standardize docs on `.agent/agents/`, `.agent/rules/`, `.agent/scripts/`, `.agent/workflows/`, and `.agent/skills/`. | Critical Now |
| **Template Chaos** | Template Ambiguity | `templates/` is the live bootstrap source, but parts of the documentation still implied alternate template roots or fuzzy ownership. | Document `templates/` as the only downstream source and remove wording that suggests a second public template root. | Critical Now |
| **Scattered Docs** | Naming Drift & Ownership | `TOOLING_NOTES.md`, `PROJECT_BOOTSTRAP.md`, `TEMPLATE_STRUCTURE.md` live at root. Overlap with `docs/*`. | Move root docs to `docs/`. Merge `TOOLING_NOTES.md` -> `docs/TOOLING_GUIDE.md` and delete. Update README links. | Critical Now |
| **Validation Guidance** | Operational Thinness | Validation now enforces the contract, but supporting docs need concrete downstream usage patterns. | Deepen tooling and CI/CD docs so enforcement is usable outside the APW repo itself. | Important Next |

---

# Detailed Remediation Plan & Execution Phases

### Phase 1.1: Standardize Agent Namespace
*Objective*: Eliminate documentation drift so the published APW contract matches the live `.agent/` structure.
*Files expected to change*:
- UPDATE active documentation to reference `.agent/agents/`, `.agent/rules/`, `.agent/scripts/`, `.agent/workflows/`, and `.agent/skills/`.
- REMOVE stale language that implies a separate top-level skills namespace remains part of the active APW contract.

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
- UPDATE `scripts/validate.sh` (add checks for `.agent/skills`, `.agent/rules`, `.agent/agents`).
- UPDATE the downstream CI/CD enforcement guide if validation inputs or outputs change.

---

# Repo Health Assessment after Fixes
Once complete, the APW standard will possess:
- A perfectly strict execution boundary: **ALL** intelligence lives in `.agent/`.
- A single undisputed canonical template origin: `templates/`.
- A single lean canonical downstream `.gsd` contract for both `base` and `advanced`.
- A clean root directory dedicated purely to high-level governance and indexing.
- Automation that actually enforces the complete model.
