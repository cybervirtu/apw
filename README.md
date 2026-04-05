# APW (Agentic Project Workspace) Standard

> **The definitive operational framework for AI-assisted software engineering.**
> Merging the rigorous governance of the *Get-Shit-Done (GSD)* methodology with the advanced execution capabilities of the *Antigravity-Kit (AGK)*.

## 🌟 Philosophy

The APW Standard resolves the core tension in AI-assisted coding: **Context Drift vs. Execution Speed**. 
By enforcing a strict separation of concerns, the APW ensures that AI agents always have a single source of truth for *what* is being built, while retaining specialized "muscle" for *how* it gets built.

- **The Brain (GSD Layer)**: Memory, governance, project lifecycle, and verification.
- **The Muscle (AGK Layer)**: Specialist execution, dynamic workflows, and tactical refactoring.
- **The Rule**: In any conflict, GSD Documentation wins.

---

## 🏗️ Architecture

```text
./apw/
├── .agent/              # Execution + capability namespace
│   ├── agents/          # Specialist agent definitions
│   ├── rules/           # Governing prompts and routing rules
│   ├── scripts/         # Task-level automation
│   ├── workflows/       # Execution flows / slash commands
│   └── skills/          # Curated reusable capability library
├── .gsd/                # APW governance workspace (not a downstream template source)
├── docs/                # APW tooling, policies, and guides
├── scripts/             # Bootstrap and validation automation
├── templates/           # Canonical downstream bootstrap source
│   ├── base/.gsd/       # Canonical eight-file lifecycle contract
│   └── advanced/.gsd/   # Same canonical contract plus richer .agent content
├── AGENT_SYSTEM.md      # Dual-engine precedence rules
├── GSD-STYLE.md         # AI communication style guide
├── PROJECT_RULES.md     # Mandatory execution protocols
└── FILE_CONVENTIONS.md  # Naming and layout constraints
```

---

## 🚀 Quick Start

### For Maintaining the APW Standard
If you are modifying the APW rules themselves, read the [Upgrade Strategy](docs/UPGRADE_STRATEGY.md), the [Command Policy](COMMAND_POLICY.md), and the [Bootstrap Contract](PROJECT_BOOTSTRAP.md).

### Template Contract
- `templates/` is the only downstream bootstrap source in the active APW contract.
- The canonical downstream `.gsd` contract for `base` and `advanced` is: `SPEC.md`, `ROADMAP.md`, `STATE.md`, `TODO.md`, `JOURNAL.md`, `DECISIONS.md`, `ARCHITECTURE.md`, `STACK.md`.
- `advanced` is stronger through richer `.agent/` content, not through extra root `.gsd` state files.
- Canonical state synchronization for `.gsd/STATE.md`, `.gsd/ROADMAP.md`, `.gsd/TODO.md`, and `.gsd/DECISIONS.md` is a controlled orchestrator/governance step, not a routine side effect of execution work.
- Profile-by-profile structure notes live in [templates/README.md](templates/README.md).

### For Developers Starting a New Project
1. Run the bootstrap script in your new directory:
   ```bash
   /path/to/apw/scripts/bootstrap.sh --target . --profile base --stack base
   ```
2. Choose a profile intentionally:
   - `minimal`: lightweight lifecycle starter set plus any minimal profile `.agent` content
   - `base`: default downstream bootstrap profile with the standard lifecycle templates
   - `advanced`: the same canonical eight-file `.gsd` contract as `base`, plus specialist execution material
3. Validate the repo against the same profile:
   ```bash
   /path/to/apw/scripts/validate.sh . --profile base --stack base
   ```
4. Review the [Downstream Adoption Guide](docs/DOWNSTREAM_ADOPTION_GUIDE.md) and complete the [Downstream Compliance Checklist](docs/DOWNSTREAM_COMPLIANCE_CHECKLIST.md) before coding starts.
5. Open your new directory in Cursor/Antigravity and copy the prompt from [PROJECT_INSTANTIATION_PROMPT.md](docs/PROJECT_INSTANTIATION_PROMPT.md).
6. Use a single lead/orchestrator-style pass to populate the first canonical `.gsd/` state coherently, then begin implementation work.

### For Migrating an Existing Project
1. Start with the [Existing Repo Migration Guide](docs/EXISTING_REPO_MIGRATION_GUIDE.md).
2. Use the [Pilot Adoption Plan](docs/PILOT_ADOPTION_PLAN.md) for phased rollout in an active team.
3. Re-run the [Downstream Compliance Checklist](docs/DOWNSTREAM_COMPLIANCE_CHECKLIST.md) after the first APW-backed feature cycle.

---

## 📚 Policy Reference Index

- **[Agent System & Precedence](AGENT_SYSTEM.md)**: How GSD and AGK interact.
- **[Project Governance Rules](PROJECT_RULES.md)**: The strict rules of execution.
- **[Command Policy](COMMAND_POLICY.md)**: Reserved slash commands and conflict resolution.
- **[Project Bootstrap](PROJECT_BOOTSTRAP.md)**: Exact bootstrap inputs, outputs, overwrite rules, and upgrade behavior.
- **[Skill Curation](SKILL_CURATION.md)**: What makes an agent "Core" vs "Add-on".
- **[Template Structure](docs/TEMPLATE_STRUCTURE.md)**: Details on the template contract.
- **[Templates Directory Guide](templates/README.md)**: How `minimal`, `base`, and `advanced` differ at the filesystem level.
- **[Tooling Guide](docs/TOOLING_GUIDE.md)**: Practical operating guidance for Antigravity, Cursor, and Codex.
- **[Downstream Adoption Guide](docs/DOWNSTREAM_ADOPTION_GUIDE.md)**: Day-1 requirements, controlled customization, and safe team usage.
- **[Downstream Compliance Checklist](docs/DOWNSTREAM_COMPLIANCE_CHECKLIST.md)**: The practical checklist for staying APW-compliant after bootstrap.
- **[Existing Repo Migration Guide](docs/EXISTING_REPO_MIGRATION_GUIDE.md)**: How to move an active repository into APW safely.
- **[Monorepo Adaptation](docs/MONOREPO_ADAPTATION.md)**: How to scale APW across packages.
- **[CI/CD Enforcement](docs/CI_CD_ENFORCEMENT.md)**: Concrete downstream validation and pull-request enforcement patterns.
