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
- `.gsd/` in the repo root is the APW governance and documentation layer, not a downstream template source.
- `.gsd/templates/` is not present in the current implementation. If it appears in a future phase, it must be treated as internal authoring, transitional, or legacy support material unless the bootstrap implementation is explicitly updated to make it canonical.
- Root governance files (`PROJECT_RULES.md`, `AGENT_SYSTEM.md`, `GSD-STYLE.md`) are currently copied by `bootstrap.sh` from the APW repo root, not from per-profile template folders.

**Ownership Classification**:
- `templates/`: **canonical downstream source**
- `.gsd/templates/`: **currently absent**; if reintroduced without bootstrap changes, classify it as **internal authoring**, **transitional**, or **legacy support**, never as the canonical downstream source

When invoking `bootstrap.sh`, developers must choose a profile. The profiles define what baseline memory and execution scaffolding is copied:

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
- **Current downstream behavior**: This profile contributes an expanded `.gsd/` set plus profile-local `.agent/agents/`, `.agent/rules/`, `.agent/workflows/`, and `.agent/skills/` content. Root governance files are still copied from the APW repo root unless bootstrap behavior changes in a later phase.
- **Use when**: You need the richest APW execution bundle and are prepared for a heavier documentation and workflow surface area.
