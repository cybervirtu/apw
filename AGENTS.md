# AGENTS.md

> [!IMPORTANT]
> This is APW's modern tool-facing front door for Codex-, Antigravity-, and similarly compatible sessions. It is an entrypoint, not a second source of truth.

## What APW Is

APW stands for **Agentic Project Workspace**.

APW gives a project three simple working parts:

- **GSD** for governed project memory and lifecycle state in `.gsd/`
- **AGK** for execution rules, workflows, agents, and skills in `.agent/`
- an **orchestrator / governance pass** for controlled synchronization of canonical project state

## Core Operating Rule

- **GSD governs** what is being built, what state is official, and what counts as done.
- **AGK executes** implementation work inside that governed scope.
- The **orchestrator synchronizes** canonical summary files after meaningful implementation, verification, or design change.
- If there is a conflict, **GSD documentation wins**.

## First Run In This Repo

If this is your first time opening this downstream project in an IDE, do this:

1. Confirm you are in the downstream project root, not APW root or a workspace parent folder.
2. Read this file once.
3. Check whether `.gsd/SPEC.md`, `.gsd/STACK.md`, `.gsd/STATE.md`, `.gsd/TODO.md`, and `.gsd/ROADMAP.md` already describe the real project.
4. If those files still look like starter templates, run:
   ```bash
   /path/to/apw/scripts/init-project-state.sh --target .
   ```
5. If you want the same checklist in command form, run:
   ```bash
   /path/to/apw/apw first-run
   ```
6. Choose the first workflow that matches your situation:
   - `/brainstorm` if the idea or first step is still unclear
   - `/create` if the first feature is already clear
   - `/orchestrate` if the work is large or cross-cutting
   - `/status` if you are returning later or need orientation first
7. If you use `/brainstorm`, do not assume the chat became permanent project memory:
   - save the useful result to `.gsd/JOURNAL.md`
   - use orchestrator or governance sync if the result should change official project files
8. Keep `COMMAND_CHEATSHEET.md` nearby if you want the main slash commands and terminal commands in one page.

## Read Next

Read the minimum next files, not everything at once:

1. `PROJECT_RULES.md`
2. `AGENT_SYSTEM.md`
3. `COMMAND_POLICY.md`
4. `COMMAND_CHEATSHEET.md`
5. `docs/FIRST_RUN_IN_IDE.md` when present
6. `docs/WORKFLOW_SELECTION_GUIDE.md` when you need command choice help
7. `docs/COMMAND_INVOCATION_GUIDE.md` when you need command details
8. `docs/BRAINSTORM_PERSISTENCE_AND_PROMOTION.md` when you need the brainstorm save/promote model

Read these only if you need them:

9. `docs/BASIC_ONBOARDING_PROCEDURE.md`
10. `docs/WHERE_DO_I_WORK.md`
11. `docs/START_HERE.md`

## Do Not

- Do not treat this file as the full APW contract.
- Do not bypass `PROJECT_RULES.md`, `AGENT_SYSTEM.md`, or `COMMAND_POLICY.md`.
- Do not assume APW has already migrated to `.agents/` just because newer Antigravity-native examples may use that layout.

## Compatibility Note

APW uses root `AGENTS.md` as the shared modern entrypoint for both Codex and Antigravity-style tool sessions.

- Codex compatibility is routed through this file and the core APW contract.
- Antigravity compatibility is also routed through this file, with `GEMINI.md` treated as compatibility support when needed.
- A fuller `.agents/...` migration remains a separate architectural decision, not the default APW contract.

See `docs/COMPATIBILITY_MODEL.md`, `docs/CODEX_COMPATIBILITY.md`, and `docs/ANTIGRAVITY_COMPATIBILITY.md` when those docs are present.

## Where To Start

- **Humans**: work from the downstream project root. Read `docs/FIRST_RUN_IN_IDE.md` first when present, then use `docs/WORKFLOW_SELECTION_GUIDE.md` or `docs/COMMAND_INVOCATION_GUIDE.md` only as needed.
- **Tools and agents**: read `PROJECT_RULES.md`, `AGENT_SYSTEM.md`, and the repo's current `.gsd/STATE.md` and `.gsd/TODO.md` before acting.
