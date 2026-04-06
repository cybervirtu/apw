# APW_HANDBOOK.md — The APW Handbook

> [!IMPORTANT]
> Read this handbook first if you want to understand what APW is, why it exists, and how to use it in a real repository.

## 1. What APW Is

APW stands for **Agentic Project Workspace**.

It is a framework for running software projects with AI assistants in a way that stays organized over time.

APW gives a project:

- a modern repo-root `AGENTS.md` entrypoint for tool loading
- a clear place for project memory and planning
- a clear place for execution prompts, workflows, and skills
- rules for how humans and AI agents should work together
- bootstrap and validation tools that keep the workspace consistent

In plain English:

- APW helps you start a project cleanly
- APW helps you keep AI work grounded in the real project state
- APW helps you avoid the chaos that happens when multiple agents make disconnected changes

## 2. Why APW Exists

AI coding tools are fast, but they drift easily.

Common failure modes look like this:

- the AI forgets what the project is trying to build
- the team has no single place to see current status
- different sessions leave conflicting notes
- execution agents edit summary files casually and the repo loses coherence
- a project starts clean but becomes inconsistent after a few weeks

APW exists to solve that.

It separates the project into:

- **governance and memory**
- **execution and specialist capabilities**
- **automation that checks the contract**

That separation is the main reason APW stays usable over longer project lifetimes.

## 2.1 `AGENTS.md` as the Front Door

Newer Antigravity-native workflows often begin at repo-root `AGENTS.md`.

APW supports that directly.

In APW:

- `AGENTS.md` is the modern entrypoint
- the actual contract still lives in `PROJECT_RULES.md`, `AGENT_SYSTEM.md`, `COMMAND_POLICY.md`, `PROJECT_BOOTSTRAP.md`, and the APW docs
- `GEMINI.md` remains a compatibility concept, not an invalid file
- a fuller `.agents/...` migration is a separate architectural choice, not a silent default

That is why APW keeps `AGENTS.md` short and routes readers into the deeper documents instead of duplicating them.

## 3. GSD, AGK, and APW

You do not need prior knowledge of GSD or AGK to use APW.

Here is the simple model:

| Term | Plain-English Meaning | Role in APW |
| :--- | :--- | :--- |
| **GSD** | The governance and memory layer | Owns lifecycle, planning, state, verification, and canonical project memory |
| **AGK** | The execution and specialist layer | Provides execution workflows, specialist agents, and reusable skills |
| **APW** | The combined workspace standard | Integrates GSD governance with AGK execution in one repo contract |

APW’s core rule is:

**GSD documentation wins when there is a conflict.**

That means:

- execution can move fast
- but project memory and lifecycle state stay governed

## 4. Core Concepts

### 4.1 The `.gsd/` layer

`.gsd/` is the project memory layer.

It holds the files that explain:

- what the project is
- what phase it is in
- what is currently happening
- what tasks are next
- what architectural decisions have been made

For `base` and `advanced`, the canonical `.gsd/` file set is:

- `SPEC.md`
- `ROADMAP.md`
- `STATE.md`
- `TODO.md`
- `JOURNAL.md`
- `DECISIONS.md`
- `ARCHITECTURE.md`
- `STACK.md`

### 4.2 The `.agent/` layer

`.agent/` is the execution layer.

It contains:

- `agents/`
- `rules/`
- `scripts/`
- `workflows/`
- `skills/`

This is where specialist prompts, workflows, and reusable execution capability live.

### 4.3 Profiles

APW supports three profiles:

| Profile | What it means |
| :--- | :--- |
| `minimal` | Smallest practical APW footprint |
| `base` | Default profile for most product repos |
| `advanced` | Same canonical `.gsd` contract as `base`, plus richer vendored execution content |

### 4.4 Controlled canonical state sync

Execution agents are allowed to:

- change code
- create implementation artifacts
- append bounded evidence to `JOURNAL.md`

Execution agents are **not** allowed by default to casually rewrite:

- `STATE.md`
- `ROADMAP.md`
- `TODO.md`
- `DECISIONS.md`

Those files are synchronized through an orchestrator or explicit governance pass.

### 4.5 Bootstrap and validation

APW is not just a folder layout.

It comes with two core scripts:

- `scripts/bootstrap.sh`
- `scripts/validate.sh`

Bootstrap creates the workspace.
Validation checks that the workspace still matches the APW contract.

## 5. How APW Works End to End

The normal APW lifecycle looks like this:

1. Choose a profile.
2. Bootstrap the repo from APW.
3. Validate the repo against the same profile and stack.
4. Initialize the first canonical `.gsd` state with a single orchestrator-style pass.
5. Run implementation work through AI or human workflows.
6. Let execution agents write code and bounded `JOURNAL.md` evidence.
7. Run orchestrator/governance sync when canonical state must change.
8. Re-run validation before merge, release, or rollout.

That is the heart of APW.

## 6. APW Repository Structure

At a high level, APW looks like this:

```text
apw/
├── AGENTS.md            # Tool-facing entrypoint
├── .agent/              # Execution namespace
├── .gsd/                # APW governance workspace
├── docs/                # Human-facing guides
├── scripts/             # Bootstrap, validate, CI helpers
├── templates/           # Canonical downstream bootstrap source
├── README.md            # Front door
├── AGENT_SYSTEM.md      # Precedence and operating model
├── COMMAND_POLICY.md    # Command ownership rules
├── PROJECT_RULES.md     # Core governance rules
└── PROJECT_BOOTSTRAP.md # Bootstrap contract
```

For downstream repos, the important structure is:

```text
[target]/
├── AGENTS.md
├── .agent/
│   ├── agents/
│   ├── rules/
│   ├── scripts/
│   ├── workflows/
│   └── skills/
├── .gsd/
└── docs/
```

## 7. Rules and Responsibilities

### Humans

Humans are responsible for:

- choosing the right profile
- deciding when to run bootstrap and validation
- reviewing important AI-generated changes
- deciding when warnings must be cleaned up

### Execution agents

Execution agents are responsible for:

- implementing scoped work
- generating artifacts
- appending bounded evidence to `JOURNAL.md`

### Orchestrator or governance pass

The orchestrator is responsible for:

- reading execution results
- synchronizing canonical project memory safely
- resolving cross-file consistency in canonical `.gsd` files

## 8. Bootstrap, Validate, and Use Flow

Here is the practical path:

### Step 1: bootstrap

```bash
/path/to/apw/scripts/bootstrap.sh --target . --profile base --stack base
```

### Step 2: validate

```bash
/path/to/apw/scripts/validate.sh . --profile base --stack base
```

### Step 3: initialize canonical state

Before you begin a real tool session, open root `AGENTS.md`, then follow the linked APW files and docs.

Use one orchestrator-style pass to populate:

- `SPEC.md`
- `ROADMAP.md`
- `STATE.md`
- `TODO.md`
- `STACK.md`
- `ARCHITECTURE.md`

### Step 4: begin work safely

During implementation:

- start sessions from `STATE.md` and `TODO.md`
- keep execution scoped
- log evidence in `JOURNAL.md`
- sync canonical state through orchestrator/governance when needed

## 9. Profiles and Usage Modes

APW has both **profiles** and **usage modes**.

Profiles control how much of the APW workspace is bootstrapped.
Usage modes describe how you are applying APW.

Common usage modes include:

- greenfield project
- existing repo migration
- solo builder workflow
- team workflow
- monorepo workflow

See [FEATURES_AND_MODES.md](./FEATURES_AND_MODES.md) for the full breakdown.

## 10. Recommended Reading Order

If you are new to APW, read the docs in this order:

1. [QUICK_START.md](./QUICK_START.md)
2. [APW_HANDBOOK.md](./APW_HANDBOOK.md)
3. [ARCHITECTURE_OVERVIEW.md](./ARCHITECTURE_OVERVIEW.md)
4. [OPERATING_MODEL.md](./OPERATING_MODEL.md)
5. [FEATURES_AND_MODES.md](./FEATURES_AND_MODES.md)
6. [WORKFLOW_REFERENCE.md](./WORKFLOW_REFERENCE.md)
7. [USE_CASES_AND_EXAMPLES.md](./USE_CASES_AND_EXAMPLES.md)

Use these after that:

- [TEAM_ADOPTION_GUIDE.md](./TEAM_ADOPTION_GUIDE.md)
- [FAQ.md](./FAQ.md)
- [DOWNSTREAM_ADOPTION_GUIDE.md](./DOWNSTREAM_ADOPTION_GUIDE.md)
- [EXISTING_REPO_MIGRATION_GUIDE.md](./EXISTING_REPO_MIGRATION_GUIDE.md)
- [CI_CD_ENFORCEMENT.md](./CI_CD_ENFORCEMENT.md)

## 11. Deeper Technical References

When you need the exact contract, use these files:

- [PROJECT_RULES.md](../PROJECT_RULES.md)
- [AGENT_SYSTEM.md](../AGENT_SYSTEM.md)
- [PROJECT_BOOTSTRAP.md](../PROJECT_BOOTSTRAP.md)
- [TEMPLATE_STRUCTURE.md](./TEMPLATE_STRUCTURE.md)
- [TOOLING_GUIDE.md](./TOOLING_GUIDE.md)
- [DOWNSTREAM_COMPLIANCE_CHECKLIST.md](./DOWNSTREAM_COMPLIANCE_CHECKLIST.md)
