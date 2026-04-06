# TOOLING_GUIDE.md — Antigravity, Cursor, and Codex Guide

> [!NOTE]
> The APW standard is designed to be consumed by multiple AI coding assistants. This guide outlines how to use Antigravity, Cursor, and Codex in ways that reinforce APW instead of bypassing it.

APW is one framework for all of those tools. This guide describes compatibility paths inside a shared contract, not separate framework variants.

---

## 1. Tool Specialties & Operating Models

| Tool | Specialty | Operating Model |
| :--- | :--- | :--- |
| **Antigravity (AG)** | **Autonomous orchestration** | Best for multi-step execution, longer-running implementation waves, terminal-heavy work, and specialist flow orchestration across files. |
| **Cursor** | **Interactive feature execution** | Best for tightly scoped implementation, UI iteration, code review follow-up, and conversational debugging inside an editor. |
| **Codex (CLI/API)** | **Headless repo operations** | Best for scripted workflows, repeatable repository maintenance, validation, CI/CD automation, and deterministic terminal-first tasks. |

---

## 2. Universal Session Start

Every new session should begin with the same APW grounding sequence:

1. Start from root `AGENTS.md`.
2. Read `.gsd/STATE.md`.
3. Read `.gsd/TODO.md`.
4. Read `.gsd/SPEC.md` if the task changes behavior or scope.
5. Read `.agent/rules/` material relevant to the repo.
6. Confirm the active milestone before writing code.

If the task changes architecture, also read `.gsd/ARCHITECTURE.md`, `.gsd/STACK.md`, and `.gsd/DECISIONS.md`.

## 3. Context Loading Rules

Context management is the most critical skill when using AI coding assistants. Overloading the context window leads to hallucinations and ignored instructions.

### The "Start Here" Rule
Whenever you open a new chat session in *any* tool, the very first step must be:
> "Read `AGENTS.md`, then `.gsd/STATE.md` and `.gsd/TODO.md`."

### One Compatibility Model

APW supports Codex and Antigravity through one shared model:

- one framework
- one core contract
- one bootstrap flow
- one validator
- one documentation system

Tool-specific differences are documented as adapters around that shared model.

### Operator Docs

For the practical invocation pattern, use these docs together:

- [COMMAND_INVOCATION_GUIDE.md](./COMMAND_INVOCATION_GUIDE.md)
- [WORKFLOW_SELECTION_GUIDE.md](./WORKFLOW_SELECTION_GUIDE.md)
- [AGENT_PLUS_WORKFLOW_EXAMPLES.md](./AGENT_PLUS_WORKFLOW_EXAMPLES.md)

Those guides teach the everyday operator layer for Antigravity, Codex, and Cursor:

- which workflow to choose
- which agent to pair with it
- what the workflow should read first
- what it should produce
- when orchestrator handoff is required

Prefer intentional `@agent /workflow task` style invocation over vague instructions like "fix this whole area."

### Avoiding Context Drift
1. **Search First**: Never read a 1,000-line file to find a single function. Use native IDE search or ask the agent to use `grep` before opening the file.
2. **Fresh Contexts**: Do not keep a single chat thread alive for weeks. The APW standard relies on controlled `.gsd` synchronization. After a complex debugging session or a completed milestone, append evidence to `.gsd/JOURNAL.md`, run a short orchestrator or governance sync for canonical state, close the chat, and open a new one.

### Keeping Outputs Aligned
- **Do not let the AI guess the architecture.** If it needs to build a new component, ensure it has read `ARCHITECTURE.md` and `STACK.md` first.
- If an agent generates code that violates `PROJECT_RULES.md`, immediately stop execution, instruct the agent to review the rules, and retry.

---

## 4. Tool-Specific Guidance

### Antigravity

Use Antigravity when the work benefits from sustained execution with fewer interruptions:

- milestone-sized refactors
- multi-step debugging loops
- large implementation waves that require terminal commands
- work that chains plan, execution, and verification across many files

Recommended operating pattern:

1. Give Antigravity the current phase and acceptance target.
2. Point it at `AGENTS.md`, `.gsd/STATE.md`, `.gsd/TODO.md`, and any relevant rules.
3. Keep the request phase-bounded.
4. Require it to summarize what changed and what still needs verification.
5. If it is acting as an execution agent, have it stop at evidence logging and hand canonical `.gsd` sync back to the orchestrator.

Avoid:

- asking it to “clean up the whole repo”
- allowing it to infer new architecture without checking `.gsd/DECISIONS.md`
- letting it stage or commit broadly without a manual review step

### Cursor

Use Cursor when you want fast iteration and close human supervision:

- component work
- API endpoint edits
- line-level refactors
- small debugging passes
- code review remediation

Recommended operating pattern:

1. Start with a narrow task.
2. Load only the local files needed for that task.
3. Ask for one concrete change at a time.
4. Re-ground on `.gsd/STATE.md` before switching to a different feature area.
5. Keep Cursor focused on implementation and bounded `JOURNAL.md` evidence unless you are explicitly using it as the orchestrator for a sync pass.

Avoid:

- vague prompts like “fix everything”
- using `/plan` for technical design work; use `/design`
- leaving one long chat open across multiple milestones

### Codex

Use Codex when the task is terminal-first or repo-wide but still deterministic:

- running `bootstrap.sh`
- running `validate.sh`
- enforcing CI-facing fixes
- repo maintenance and standards work
- scripted investigations with explicit command output

Recommended operating pattern:

1. Treat Codex as the automation-oriented operator.
2. Start it from root `AGENTS.md`, then route into the core APW files.
3. Prefer explicit commands and file targets.
4. Use it for repeatable validation and standards enforcement.
5. Keep the task grounded in the current APW contract rather than open-ended ideation.
6. Use an explicit orchestrator-style pass when Codex needs to synchronize canonical `.gsd` files after execution work.

Avoid:

- using Codex as the first choice for high-touch visual iteration
- asking it to improvise product direction without `.gsd` context

---

## 5. Operational Safety & Guidance

### ✅ Do's
- **DO** use Antigravity for running tests and reading the outputs over multiple iterative loops.
- **DO** use Cursor for nuanced UI/UX polishing where visual feedback (or user review) is required rapidly.
- **DO** force the AI to write tests *before* writing the implementation (TDD).
- **DO** use Codex for bootstrap, validation, and CI-facing repository maintenance tasks.
- **DO** restate the active profile and stack when discussing bootstrap or validation behavior.
- **DO** treat `.gsd/JOURNAL.md` as the safe execution log and canonical `.gsd` summaries as orchestrator-controlled state.

### ❌ Don'ts
- **DON'T** use `/plan` inside Cursor to generate code architecture. This conflicts with the GSD `/plan` (roadmap phases). Use `/design` instead.
- **DON'T** let Antigravity run massive `git commit` commands without reviewing the `git status` first to ensure only the intended files are staged.
- **DON'T** ask Cursor to "Fix all errors in the project." This will lead to unpredictable cascading changes. Use targeted `/debug` workflows instead.
- **DON'T** run validation without the profile context if the repo was bootstrapped intentionally as `minimal` or `advanced`.
- **DON'T** let routine execution agents freely rewrite `.gsd/STATE.md`, `.gsd/ROADMAP.md`, `.gsd/TODO.md`, or `.gsd/DECISIONS.md`.

---

## 6. Canonical State Sync Rule

Use this ownership split across Antigravity, Cursor, and Codex:

- **Execution agents may**:
  - modify code
  - create implementation artifacts
  - append bounded evidence to `.gsd/JOURNAL.md`
- **Execution agents may not by default**:
  - freely rewrite `.gsd/STATE.md`
  - freely rewrite `.gsd/ROADMAP.md`
  - freely rewrite `.gsd/TODO.md`
  - freely rewrite `.gsd/DECISIONS.md`
- **The orchestrator is responsible for**:
  - reading execution results
  - updating canonical state safely
  - resolving cross-file consistency after task completion

This is a controlled writeback step, not an extra approval ceremony. For simple work, the same human-operated assistant can switch into an orchestrator/governance pass at the end.

---

## 7. Practical Prompting Patterns

### Antigravity prompt shape

Use prompts like:

> Read `AGENTS.md`, `.gsd/STATE.md`, `.gsd/TODO.md`, and `.agent/rules/PROJECT.md`. Execute only the current milestone task, verify the change, and summarize remaining blockers.

### Cursor prompt shape

Use prompts like:

> Read `.gsd/STATE.md` and inspect only `src/components/cart.tsx` plus its tests. Implement the current TODO item without expanding scope.

### Codex prompt shape

Use prompts like:

> Read `AGENTS.md`, then validate this repo with `--profile base --stack base`, explain any hard failures or warnings, and patch only the files needed to restore compliance.

### Orchestrator sync prompt shape

Use prompts like:

> Read the latest code changes and `.gsd/JOURNAL.md`, then synchronize `.gsd/STATE.md`, `.gsd/TODO.md`, and `.gsd/ROADMAP.md` only where the canonical project state actually changed.

---

## 8. Common Failure Modes & Troubleshooting

| Failure Mode | Cause | Resolution |
| :--- | :--- | :--- |
| **Endless Debug Loop** | The agent tries the same fix 3+ times without success. Context window is polluted. | **Stop.** Issue a state dump to `.gsd/JOURNAL.md`, then run a short orchestrator sync before starting a fresh chat. |
| **Shadow Architecture**| The agent introduces a new library or pattern not in `STACK.md`. | Revert the code. Require the agent to propose the change via an ADR in `.gsd/DECISIONS.md`. |
| **Ignored Instructions**| The prompt was too long, or the agent favors its pre-training over your local rules. | Break the task down. Point the agent specifically to `.agent/rules/PROJECT.md` to force alignment with local constraints. |
| **Validation mismatch** | The repo was bootstrapped with one profile, but the validator was run with another. | Re-run `validate.sh` using the same `--profile` and `--stack` values used during bootstrap. |
| **Tool-role confusion** | The team uses Cursor, Antigravity, and Codex interchangeably without task boundaries. | Re-assign by operating model: Cursor for scoped edits, Antigravity for orchestrated execution, Codex for terminal-first and CI-facing tasks. |
| **Canonical state drift** | Multiple execution agents rewrite summary `.gsd` files independently. | Restrict execution agents to `JOURNAL.md` evidence, then run an orchestrator sync for `STATE.md`, `ROADMAP.md`, `TODO.md`, and `DECISIONS.md`. |

---

## 9. Minimum Team Standard

If a team adopts APW but ignores the rest of this guide, keep these minimum habits:

1. Start every session from `.gsd/STATE.md` and `.gsd/TODO.md`.
2. Use `/design`, not `/plan`, for technical design work.
3. Re-run `bootstrap.sh` and `validate.sh` with explicit `--profile` and `--stack` values.
4. Record architecture changes in `.gsd/DECISIONS.md`.
5. Let execution agents write code and `JOURNAL.md` evidence, then run a controlled orchestrator sync for canonical `.gsd` files.
6. Reset the session instead of pushing through a polluted context window.
