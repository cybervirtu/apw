# APW (Agentic Project Workspace) Standard

> **The definitive operational framework for AI-assisted software engineering.**
> Merging the rigorous governance of the *Get-Shit-Done (GSD)* methodology with the advanced execution capabilities of the *Antigravity-Kit (AGK)*.

APW helps people and AI agents build software without losing track of project state, rules, or execution context.

If you are new to APW, you should not have to read half the repo before it makes sense.

This README is the front door.
It gives you the short version, then sends you through the docs in a beginner-friendly order.

## What APW Is

APW is a framework for running software projects with humans and AI agents in a way that stays organized over time.

It gives you:

- a governed project memory layer in `.gsd/`
- an execution layer in `.agent/`
- bootstrap and validation scripts
- rules for how execution work and canonical project state should interact
- CI enforcement so the workspace does not slowly drift

## Why APW Exists

AI tools are fast, but they drift easily.

Without a framework, projects often end up with:

- unclear current state
- conflicting AI notes
- stale prompts
- random structure drift
- no reliable handoff between sessions or teammates

APW solves that by separating:

- **memory and governance**
- **execution and specialist capability**
- **automation and enforcement**

The short version:

- **GSD** is the brain
- **AGK** is the muscle
- **APW** integrates both into one workspace standard

And when there is a conflict:

**GSD documentation wins.**

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

### Start Here

Follow this order:

1. [Start Here](docs/START_HERE.md)
2. [Quick Start](docs/QUICK_START.md)
3. [How APW Works](docs/HOW_APW_WORKS.md)
4. [First Project Walkthrough](docs/FIRST_PROJECT_WALKTHROUGH.md)
5. [Features and Modes](docs/FEATURES_AND_MODES.md)
6. [Common Workflows](docs/COMMON_WORKFLOWS.md)
7. Team / migration / CI docs as needed
8. [FAQ](docs/FAQ.md)

### Fastest Safe Path

If you want the shortest path to using APW on a new project:

1. Bootstrap with a profile, usually `base`
2. Validate with the same profile and stack
3. Initialize canonical `.gsd` with one orchestrator-style pass
4. Start work from `STATE.md` and `TODO.md`
5. Log bounded evidence in `JOURNAL.md`
6. Sync canonical state deliberately
7. Turn on CI early

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
5. Enable CI enforcement using [CI/CD Enforcement](docs/CI_CD_ENFORCEMENT.md) and [the example GitHub Actions workflow](examples/github/apw-validate.yml).
6. Open your new directory in Cursor/Antigravity and copy the prompt from [PROJECT_INSTANTIATION_PROMPT.md](docs/PROJECT_INSTANTIATION_PROMPT.md).
7. Use a single lead/orchestrator-style pass to populate the first canonical `.gsd/` state coherently, then begin implementation work.

### For Migrating an Existing Project
1. Start with the [Existing Repo Migration Guide](docs/EXISTING_REPO_MIGRATION_GUIDE.md).
2. Use the [Pilot Adoption Plan](docs/PILOT_ADOPTION_PLAN.md) for phased rollout in an active team.
3. Re-run the [Downstream Compliance Checklist](docs/DOWNSTREAM_COMPLIANCE_CHECKLIST.md) after the first APW-backed feature cycle.

### For Teams
1. Read the [Team Adoption Guide](docs/TEAM_ADOPTION_GUIDE.md).
2. Turn on [CI/CD Enforcement](docs/CI_CD_ENFORCEMENT.md) early.
3. Use the [Downstream Compliance Checklist](docs/DOWNSTREAM_COMPLIANCE_CHECKLIST.md) as a repeatable operating checklist.

---

## 📚 Documentation Map

### Guided Learning Flow

- **[Start Here](docs/START_HERE.md)**: First read for a brand-new APW user.
- **[Quick Start](docs/QUICK_START.md)**: Fastest safe path to try APW on a real project.
- **[How APW Works](docs/HOW_APW_WORKS.md)**: The core mental model in plain English.
- **[First Project Walkthrough](docs/FIRST_PROJECT_WALKTHROUGH.md)**: A guided example from bootstrap to first milestone.
- **[Features and Modes](docs/FEATURES_AND_MODES.md)**: What APW provides and how to apply it in different situations.
- **[Common Workflows](docs/COMMON_WORKFLOWS.md)**: Day-to-day usage patterns for real work.

### Deeper Understanding

- **[APW Handbook](docs/APW_HANDBOOK.md)**: Broader end-to-end explanation of APW.
- **[Glossary](docs/GLOSSARY.md)**: Definitions of key APW terms.
- **[Architecture Overview](docs/ARCHITECTURE_OVERVIEW.md)**: The architecture in plain language.
- **[Operating Model](docs/OPERATING_MODEL.md)**: Roles, responsibilities, and controlled canonical state sync.
- **[Use Cases and Examples](docs/USE_CASES_AND_EXAMPLES.md)**: Scenario-driven examples.
- **[Team Adoption Guide](docs/TEAM_ADOPTION_GUIDE.md)**: How teams should adopt and operate APW.
- **[FAQ](docs/FAQ.md)**: Short answers to common questions.

## 📚 Policy and Contract Reference

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
- **[GitHub Actions Example](examples/github/apw-validate.yml)**: Minimal downstream CI workflow that wraps the canonical APW validator.
