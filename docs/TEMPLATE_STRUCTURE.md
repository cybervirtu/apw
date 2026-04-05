# APW Template Structure

## 1. Full Folder Tree Design (./apw)

The following structure defines the master APW standard. It integrates the GSD lifecycle memory with the AGK specialist execution layer.

```text
./apw/
├── .agent/              # Specialist execution + capability namespace
│   ├── agents/          # Merged definitions (GSD.md, AGK.md)
│   ├── rules/           # Machine-readable governing prompts
│   ├── scripts/         # Task-level automation
│   ├── workflows/       # Execution flows (Slash commands)
│   └── skills/          # Reusable high-fidelity skills
├── .gsd/                # Lifecycle Memory Layer (Documentation)
│   ├── SPEC.md          # Requirements and goal definition
│   ├── ROADMAP.md       # High-level phases and milestones
│   ├── STATE.md         # Narrative implementation status
│   ├── JOURNAL.md       # Chronological activity log
│   ├── ARCHITECTURE.md  # System design and component map
│   ├── STACK.md         # Technology and library choices
│   ├── DECISIONS.md     # Log of design choices
│   └── TODO.md          # Granular implementation tasks
├── docs/                # Human-readable references and runbooks
├── scripts/             # Standard automation and sync tools
│   ├── bootstrap.sh     # Repository initialization
│   └── validate.sh      # Standard compliance verification
├── AGENT_SYSTEM.md      # Dual-engine precedence rules
├── ARCHITECTURE.md      # APW governance architecture
├── GSD-STYLE.md         # Communication standards
└── PROJECT_RULES.md     # Mandatory governance rules
```

---

## 2. File and Folder Roles

| Path | Purpose | Update Rule | Distribution |
| :--- | :--- | :--- | :--- |
| **.gsd/SPEC.md** | Requirement source of truth | Before coding | **Mandatory** |
| **.gsd/STATE.md**| Current project position | Continuously | **Mandatory** |
| **.gsd/JOURNAL.md**| Audit trail of actions | Continuously | **Mandatory** |
| **.agent/agents/** | Specialist agent definitions | Curated | **Mandatory** |
| **.agent/rules/**| AI governing prompts | Static | **Mandatory** |
| **.agent/scripts/** | Task automation helpers | Curated | **Optional** |
| **.agent/workflows/** | Execution workflows / slash commands | Curated | **Mandatory** |
| **.agent/skills/** | Specialist implementations | Syncable | **Optional** |
| **PROJECT_RULES.md**| Core governance rules | Never | **Mandatory** |
| **AGENT_SYSTEM.md** | Precedence rules | Never | **Mandatory** |

---

## 3. Distribution Rules (Copy vs Reference)

- **Copy-Don't-Reference**: All root `.md` files and `.gsd/` templates are **copied** into new projects to ensure repository independence.
- **Selective Sync**: `.agent/skills/` entries are **imported/synced** based on the chosen tech stack.
- **Never Edit Casually**: `PROJECT_RULES.md`, `GSD-STYLE.md`, and `AGENT_SYSTEM.md` are the governing standard and should only be modified in `./apw` before rolling out updates.

---

## 4. Continuous Update Rules

The following files must be updated continuously during each implementation session:
1. **.gsd/STATE.md**: Update after every wave completion or session end.
2. **.gsd/JOURNAL.md**: Record every significant action, decision, or failure.
3. **.gsd/TODO.md**: Update as tasks are planned and completed.

---

## 5. Template Versions & The Canonical Contract

**The Canonical Source**: The `./templates/` directory is the canonical downstream bootstrap source used by `./scripts/bootstrap.sh`.

**Current Ownership Rule**:
- `templates/` is the only active downstream source for profile-selected `.gsd/` and `.agent/` scaffolding.
- `.gsd/` in the repo root is reserved for APW governance use and is not a downstream profile source.
- Root governance files (`PROJECT_RULES.md`, `AGENT_SYSTEM.md`, `GSD-STYLE.md`) are currently copied by `bootstrap.sh` from the APW repo root, not from per-profile template folders.

**Ownership Classification**:
- `templates/`: **canonical downstream source**
- repo-root `.gsd/`: **governance workspace**, not a downstream profile source

For a filesystem-level walkthrough of the profile tree itself, see [templates/README.md](../templates/README.md).

When invoking `bootstrap.sh`, developers choose a profile with `--profile` and an optional stack add-on with `--stack`. Bootstrap always creates `.agent/agents/`, `.agent/rules/`, `.agent/scripts/`, `.agent/workflows/`, `.agent/skills/`, `.gsd/`, and `docs/` in the target repo.

### **Minimal Profile (`templates/minimal`)**
Designed for simple scripts, research, or rapid prototyping workflows where deep validation is unnecessary overhead.
- **Current downstream behavior**: `bootstrap.sh` always copies root governance files from the repo root, then this profile contributes a lightweight `.gsd/` starter set (`SPEC.md`, `ROADMAP.md`, `STATE.md`, `TODO.md`) plus any profile-local `.agent/` content that exists.
- **Use when**: You want the smallest practical APW footprint and are comfortable with less lifecycle depth.

### **Base Profile (`templates/base`)**
The standard, non-negotiable baseline for standard software engineering projects.
- **Current downstream behavior**: This is the default profile. It contributes the standard `.gsd/` lifecycle set (`SPEC.md`, `ROADMAP.md`, `STATE.md`, `JOURNAL.md`, `ARCHITECTURE.md`, `STACK.md`, `DECISIONS.md`, `TODO.md`). The `.agent/` directories are still created by `bootstrap.sh`, but this profile does not currently add profile-specific `.agent/` files of its own.
- **Use when**: You want the canonical APW bootstrap baseline for most product repositories.

### **Advanced Profile (`templates/advanced`)**
Designed for production-grade applications, strict CI/CD pipelines, and monorepos.
- **Current downstream behavior**: This profile contributes the same canonical eight-file `.gsd/` set as `base` (`SPEC.md`, `ROADMAP.md`, `STATE.md`, `TODO.md`, `JOURNAL.md`, `DECISIONS.md`, `ARCHITECTURE.md`, `STACK.md`) plus vendored `.agent/agents/`, `.agent/rules/`, `.agent/workflows/`, and any profile-local `.agent/scripts/` or `.agent/skills/` content that exists. Root governance files are still copied from the APW repo root unless bootstrap behavior changes in a later phase.
- **Use when**: You need the richest APW execution bundle while keeping project state in the same lean canonical `.gsd` contract as the base profile.

### **Advanced State Consolidation Rule**

- Use headings and sections inside the canonical `.gsd` files before creating additional root state files.
- Keep milestone, sprint, and phase-close status in `ROADMAP.md`.
- Keep current snapshot, pause/resume context, and token/context-budget notes in `STATE.md`.
- Keep granular execution items and gap lists in `TODO.md`.
- Keep session history, verification evidence, debug findings, and operator handoff notes in `JOURNAL.md`.
- Legacy advanced root files such as `MILESTONE.md`, `SPRINT.md`, `PHASE-SUMMARY.md`, `STATE_SNAPSHOT.md`, and `TOKEN_REPORT.md` are not part of the active contract.

## 6. Bootstrap Overwrite Rules

- Root governance files are always overwritten.
- `.agent/` execution-layer content is always synced from the selected profile when source content exists.
- `.gsd/` lifecycle files are preserved unless `--force` is supplied.
- Optional profile directories that do not exist are treated as empty and logged, not as bootstrap failures.

For the operational contract and upgrade guidance, see [PROJECT_BOOTSTRAP.md](../PROJECT_BOOTSTRAP.md).

## 7. Validation Rules

- Run `/path/to/apw/scripts/validate.sh [target] --profile <profile> --stack <stack>` using the same profile and stack choices used for bootstrap.
- Validation enforces the required root governance files, profile-selected `.gsd` files, and the full `.agent/` namespace.
- Validation warns on legacy drift such as `.agents/` or `.agents/skills/`.
- `.agent/skills/` population is only enforced when the selected profile or stack pack vendors skill files.
- Downstream repos are validated by the APW checkout that owns the scripts and templates; bootstrap does not create a second local source of truth for those materials.
