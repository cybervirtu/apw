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
├── .agent/              # Execution Context (Workflows, Tools, Agent Prompts)
├── .agent/skills/       # Curated Specialists (React, Database, API Skills)
├── .gsd/                # Lifecycle Memory (Spec, Roadmap, State, Journal)
├── docs/                # APW Tooling, Policies, and Guides
├── scripts/             # Automation (Bootstrap, Validate)
├── templates/           # Origin templates for Bootstrapping downstreams
├── AGENT_SYSTEM.md      # Dual-Engine Precedence map
├── GSD-STYLE.md         # AI communication style guide
├── PROJECT_RULES.md     # Mandatory Execution protocols (Spec->Plan->Execute)
└── FILE_CONVENTIONS.md  # Standard naming constraints
```

---

## 🚀 Quick Start

### For Maintaining the APW Standard
If you are modifying the APW rules themselves, read the [Upgrade & Sync Strategy](docs/UPGRADE_STRATEGY.md) and the [Command Policy](COMMAND_POLICY.md) to understand namespace rules.

### For Developers Starting a New Project
1. Run the bootstrap script in your new directory:
   ```bash
   /path/to/apw/scripts/bootstrap.sh --target . --stack base
   ```
2. Open your new directory in Cursor/Antigravity and copy the prompt from [PROJECT_INSTANTIATION_PROMPT.md](docs/PROJECT_INSTANTIATION_PROMPT.md).
3. The AI will populate your `.gsd/` memory. You are now ready to code!

### For Migrating an Existing Project
1. Carefully review the [Pilot Adoption Plan](docs/PILOT_ADOPTION_PLAN.md).
2. Archive legacy AI rules.
3. Establish your baseline in `.gsd/STATE.md`.

---

## 📚 Policy Reference Index

- **[Agent System & Precedence](AGENT_SYSTEM.md)**: How GSD and AGK interact.
- **[Project Governance Rules](PROJECT_RULES.md)**: The strict rules of execution.
- **[Command Policy](COMMAND_POLICY.md)**: Reserved slash commands and conflict resolution.
- **[Skill Curation](SKILL_CURATION.md)**: What makes an agent "Core" vs "Add-on".
- **[Template Structure](docs/TEMPLATE_STRUCTURE.md)**: Details on the template contract.
- **[Tooling Guide](docs/TOOLING_GUIDE.md)**: IDE-specific do's and don'ts (Cursor vs. Antigravity).
- **[Monorepo Adaptation](docs/MONOREPO_ADAPTATION.md)**: How to scale APW across packages.
- **[CI/CD Enforcements](docs/CI_CD_MOCKUPS.md)**: Validating APW compliance on Pull Requests.
