# ARCHITECTURE_OVERVIEW.md — Architecture Overview

## 1. The Big Picture

APW is built around a simple idea:

**separate project memory from project execution**

That split is what makes APW easier to keep stable over time.

## 2. The Three-Layer Model

| Layer | Lives in | What it does |
| :--- | :--- | :--- |
| Memory layer | `.gsd/` | Holds requirements, plan, current state, decisions, and history |
| Execution layer | `.agent/` | Holds agents, rules, workflows, scripts, and skills |
| Automation layer | `scripts/` | Bootstraps and validates the workspace contract |

## 3. Memory Layer

The memory layer exists so the project does not depend on a single chat thread or one developer’s memory.

Important files:

| File | Purpose |
| :--- | :--- |
| `SPEC.md` | What the project or feature must do |
| `ROADMAP.md` | Milestones and phases |
| `STATE.md` | Current position and next-step context |
| `TODO.md` | Canonical task backlog |
| `JOURNAL.md` | Evidence and chronological notes |
| `DECISIONS.md` | Architecture and design rationale |
| `ARCHITECTURE.md` | System structure |
| `STACK.md` | Technology choices |

## 4. Execution Layer

The execution layer is where APW puts the things that help AI assistants act inside the project.

| Path | Purpose |
| :--- | :--- |
| `.agent/agents/` | Specialist agent definitions |
| `.agent/rules/` | Governing prompts and local rules |
| `.agent/scripts/` | Task-level automation helpers |
| `.agent/workflows/` | Execution workflows |
| `.agent/skills/` | Reusable capabilities |

APW’s active execution namespace is always `.agent/`.

## 5. Automation Layer

The automation layer keeps the structure enforceable.

| Script | Purpose |
| :--- | :--- |
| `bootstrap.sh` | Create or upgrade a downstream repo with APW |
| `validate.sh` | Check APW compliance directly |
| `ci-validate.sh` | Wrap the validator for CI-friendly enforcement |

## 6. Data Flow

The normal APW flow looks like this:

1. `bootstrap.sh` creates the workspace.
2. A human or orchestrator initializes `.gsd`.
3. Execution agents read `.gsd` and `.agent`.
4. Execution agents write code and bounded `JOURNAL.md` evidence.
5. The orchestrator syncs canonical summary/state files.
6. `validate.sh` checks the repo still matches the contract.
7. CI can enforce the validator automatically.

## 7. Why This Architecture Works

This architecture solves several practical problems:

- it prevents random prompt files from becoming a second source of truth
- it prevents project memory from living only inside a tool chat
- it prevents routine execution from casually rewriting canonical state
- it gives teams a stable bootstrap and validation contract

## 8. What Changes by Profile

The architecture stays the same across profiles.

What changes is how much content is pre-vendored into the workspace.

| Profile | Memory layer | Execution layer |
| :--- | :--- | :--- |
| `minimal` | lightweight starter set | minimal or empty profile-local execution content |
| `base` | canonical lifecycle baseline | empty namespace ready for project-local additions |
| `advanced` | same canonical lifecycle baseline as `base` | richer vendored agents and workflows |

## 9. What Does Not Change

These parts stay constant:

- `.agent/` is the namespace
- `templates/` is the canonical downstream source
- canonical `.gsd` state is governed
- `validate.sh` is the compliance engine

For exact rules, see [AGENT_SYSTEM.md](../AGENT_SYSTEM.md), [PROJECT_RULES.md](../PROJECT_RULES.md), and [PROJECT_BOOTSTRAP.md](../PROJECT_BOOTSTRAP.md).
