# TOOLING_GUIDE.md — AI IDE & Agent Compatibility

> [!NOTE]
> The APW standard is designed to be consumed by multiple AI coding assistants. This guide outlines how to utilize Antigravity, Cursor, and Codex within the APW framework to maximize efficiency and avoid context drift.

---

## 1. Tool Specialties & Operating Models

| Tool | Specialty | Operating Model |
| :--- | :--- | :--- |
| **Antigravity (AG)** | **Autonomous Orchestration** | Best for executing full phases of the `ROADMAP.md`. Unattended execution, complex scaffolding, multi-file refactors, and interacting with terminal environments (deployment, CI/CD). |
| **Cursor** | **Targeted Execution** | Best for localized feature development, precise line-level refactoring, real-time intellisense, and conversational debugging. Use the Composer for controlled multi-file edits. |
| **Codex (CLI/API)** | **Automated Pipelines** | Best for headless scripts, automated validation checks (`validate.sh`), or CI/CD test generation loops. |

---

## 2. Context Loading Rules

Context management is the most critical skill when using AI coding assistants. Overloading the context window leads to hallucinations and ignored instructions.

### The "Start Here" Rule
Whenever you open a new chat session in *any* tool, the very first step must be:
> "Read `.gsd/STATE.md` and `.gsd/TODO.md`."

### Avoiding Context Drift
1. **Search First**: Never read a 1,000-line file to find a single function. Use native IDE search or ask the agent to use `grep` before opening the file.
2. **Fresh Contexts**: Do not keep a single chat thread alive for weeks. The APW standard relies on `.gsd/STATE.md` to hold memory locally. After a complex debugging session or a completed milestone, dump the final state to `STATE.md`, close the chat, and open a new one.

### Keeping Outputs Aligned
- **Do not let the AI guess the architecture.** If it needs to build a new component, ensure it has read `ARCHITECTURE.md` and `STACK.md` first.
- If an agent generates code that violates `PROJECT_RULES.md`, immediately stop execution, instruct the agent to review the rules, and retry.

---

## 3. Operational Safety & Guidance

### ✅ Do's
- **DO** use Antigravity for running tests and reading the outputs over multiple iterative loops.
- **DO** use Cursor for nuanced UI/UX polishing where visual feedback (or user review) is required rapidly.
- **DO** force the AI to write tests *before* writing the implementation (TDD).

### ❌ Don'ts
- **DON'T** use `/plan` inside Cursor to generate code architecture. This conflicts with the GSD `/plan` (roadmap phases). Use `/design` instead.
- **DON'T** let Antigravity run massive `git commit` commands without reviewing the `git status` first to ensure only the intended files are staged.
- **DON'T** ask Cursor to "Fix all errors in the project." This will lead to unpredictable cascading changes. Use targeted `/debug` workflows instead.

---

## 4. Common Failure Modes & Troubleshooting

| Failure Mode | Cause | Resolution |
| :--- | :--- | :--- |
| **Endless Debug Loop** | The agent tries the same fix 3+ times without success. Context window is polluted. | **Stop.** Issue a "State Dump" to `.gsd/JOURNAL.md`. Start a new chat session, attach the journal entry, and approach the problem differently. |
| **Shadow Architecture**| The agent introduces a new library or pattern not in `STACK.md`. | Revert the code. Require the agent to propose the change via an ADR in `.gsd/DECISIONS.md`. |
| **Ignored Instructions**| The prompt was too long, or the agent favors its pre-training over your local rules. | Break the task down. Point the agent specifically to `.agent/rules/PROJECT.md` to force alignment with local constraints. |
