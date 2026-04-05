# APW Template Structure

## 1. Full Folder Tree Design (./apw)

The following structure defines the master APW standard. It integrates the GSD lifecycle memory with the AGK specialist execution layer.

```text
./apw/
├── .agent/              # Specialist Execution Layer (Project-Specific)
│   ├── agents/          # Merged definitions (GSD.md, AGK.md)
│   ├── rules/           # Machine-readable governing prompts
│   ├── scripts/         # Task-level automation
│   └── workflows/       # Execution flows (Slash commands)
├── .agent/skills/       # Capability Library (Shared/Curated)
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
| **.agent/rules/**| AI governing prompts | Static | **Mandatory** |
| **.agent/skills/** | Specialist implementations | Syncable | **Optional** |
| **PROJECT_RULES.md**| Core governance rules | Never | **Mandatory** |
| **AGENT_SYSTEM.md** | Precedence rules | Never | **Mandatory** |

---

## 3. Distribution Rules (Copy vs Reference)

- **Copy-Don't-Reference**: All root `.md` files and `.gsd/` templates are **copied** into new projects to ensure repository independence.
- **Selective Sync**: `.agent/skills/` are **imported/synced** based on the chosen tech stack.
- **Never Edit Casually**: `PROJECT_RULES.md`, `GSD-STYLE.md`, and `AGENT_SYSTEM.md` are the governing standard and should only be modified in `./apw` before rolling out updates.

---

## 4. Continuous Update Rules

The following files must be updated continuously during each implementation session:
1. **.gsd/STATE.md**: Update after every wave completion or session end.
2. **.gsd/JOURNAL.md**: Record every significant action, decision, or failure.
3. **.gsd/TODO.md**: Update as tasks are planned and completed.

---

## 5. Template Versions & The Canonical Contract

**The Canonical Source**: The `./templates/` directory is the undisputed origin for all APW instantiations. The repo completely rejects the legacy concept of a root `.gsd/templates/` folder to prevent source-of-truth ambiguity. 

When invoking `bootstrap.sh`, developers must choose a profile. The profiles define what baseline memory and execution scaffolding is copied:

### **Minimal Profile (`templates/minimal`)**
Designed for simple scripts, research, or rapid prototyping workflows where deep validation is unnecessary overhead.
- **Includes**: Root governance files, `.gsd/SPEC.md`, `.gsd/STATE.md`, `.gsd/TODO.md`, and base `.agent/` workflows. (Excludes heavy tracking like ROADMAP, JOURNAL, DECISIONS).

### **Base Profile (`templates/base`)**
The standard, non-negotiable baseline for standard software engineering projects.
- **Includes**: The full `.gsd/` memory stack (SPEC, ROADMAP, STATE, JOURNAL, ARCHITECTURE, STACK, DECISIONS, TODO) and standard core skills.

### **Advanced Profile (`templates/advanced`)**
Designed for production-grade applications, strict CI/CD pipelines, and monorepos.
- **Includes**: Full `.gsd/` memory stack, curated `.agent/skills/` library, complex `.agent/` workflows, multi-module documentation support, and strict validation scripts.
- **Overrides**: Contains a stricter `PROJECT_RULES.md` and `AGENT_SYSTEM.md` that enforce higher commit and architectural logging thresholds.
