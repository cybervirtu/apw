# COMMAND_POLICY.md — APW Command Ownership and Naming Policy

> [!CAUTION]
> This policy eliminates ambiguity between **GSD (Governance & Lifecycle)** and **AGK (Specialist Execution)** commands. Modifying this policy requires a formal review, as it dictates the core interaction model for AI agents in the APW standard.

## 1. The Conflict Resolution Policy

In the APW standard, a command name cannot mean two different things. If a conflict arises between a lifecycle concept and a technical execution concept:
- **GSD retains ownership of the term if it relates to project lifecycle, state, or planning.**
- **AGK must rename its workflow to a more specific technical term.**

**Example:**
- Both GSD and AGK might have a concept of "planning."
- In GSD, `/plan` means updating `ROADMAP.md` and allocating phases.
- In AGK, `/plan` might mean designing a database schema or writing code architecture.
- **Resolution:** GSD keeps `/plan`. AGK renames its workflow to `/design` or `/arch`.

Canonical state synchronization follows the same rule: if a command updates summary memory or lifecycle state, that operation belongs to GSD/orchestrator control, not routine AGK execution.

---

## 2. Command Ownership Matrix

The following table defines the final approved command set for the APW standard.

### 🧠 GSD (Governance & Lifecycle) Commands
| Command | Purpose | Primary Target |
| :--- | :--- | :--- |
| `/gsd` | Main entry point for lifecycle management and canonical state sync. | `STATE.md`, `ROADMAP.md`, `TODO.md`, `JOURNAL.md` |
| `/plan` | Project decomposition, milestone setting. | `ROADMAP.md`, `TODO.md` |
| `/task` | Review current implementation progress and prepare safe state sync inputs. | `JOURNAL.md`, sync candidates for `STATE.md` / `TODO.md` |
| `/verify` | Validates completed work against requirements. | `SPEC.md`, `JOURNAL.md`, sync candidates for `STATE.md` |
| `/audit` | Inspects workspace for APW compliance. | All governance files |

### 🦾 AGK (Specialist Execution) Commands
| Command | Purpose | Primary Target |
| :--- | :--- | :--- |
| `/agk` | Main entry point for invoking specialist skills. | Source Code |
| `/create` | Generates boilerplates, features, or assets. | Source Code |
| `/debug` | Investigates errors, analyzes logs, fixes bugs. | Source Code |
| `/refactor`| Restructures code without changing behavior. | Source Code |
| `/design` | Technical architecture for a specific feature. | Source Code, Technical Specs |
| `/test` | Generates and runs unit/integration tests. | Tests |

### Canonical State Ownership Note

- Execution commands may write code and implementation artifacts.
- Execution commands may append bounded evidence to `.gsd/JOURNAL.md`.
- Free editing of `.gsd/STATE.md`, `.gsd/ROADMAP.md`, `.gsd/TODO.md`, and `.gsd/DECISIONS.md` is not part of routine AGK execution.
- Safe synchronization of those canonical files belongs to the orchestrator or an explicit GSD/governance command.

---

## 3. Naming Policy

When creating new workflows or skills for the unified `.agent/` namespace, with commands defined in `.agent/workflows/`:

1. **Verbs or Action-Nouns**: Commands must represent clear actions (e.g., `/deploy`, `/evaluate`, `/lint`).
2. **Single Word Preferred**: Use concise names. Avoid `/create-component` if `/create` with a prompt suffices.
3. **No Domain Overlap**: Do not use words like `spec`, `roadmap`, or `state` for tactical execution scripts, as these clash with GSD lifecycle concepts.

---

## 4. Deprecated and Banned Commands

The following commands are explicitly banned or deprecated in the APW standard to prevent context drift and governance violations:

| Banned Command | Reason | Use Instead |
| :--- | :--- | :--- |
| `/build-everything` | Violates atomic execution rules. | `/plan` then `/task` |
| `/fix-all` | Leads to unpredictable, cascading code changes. | `/debug` with specific context |
| `/update-docs` | Too vague. Overlaps with GSD's strict doc roles. | `/journal` or manual `.gsd` updates |

---

## 5. IDE Tooling Notes (Cursor / Antigravity / Codex)

- **Slash Commands**: Not all IDEs surface `.agent/workflows` natively as slash commands. This document serves as the standard nomenclature regardless of the IDE's UI. 
- If using an IDE without native workflow parsing, the user should type: "Use the `/debug` workflow" to invoke the AGK rule set.
