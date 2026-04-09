# AGENTS.md

> [!IMPORTANT]
> This is APW's modern tool-facing front door for Codex-, Antigravity-, and similarly compatible sessions. It is an entrypoint, not a second source of truth.

## What APW Is

APW stands for **Agentic Project Workspace**.

APW gives a project three simple working parts:

- **GSD** for governed project memory and lifecycle state in `.gsd/`
- **AGK** for execution rules, workflows, agents, and skills in `.agent/`
- an **orchestrator / governance pass** for controlled synchronization of canonical project state

APW also uses one simple intake rule:

- important project details often arrive through chat first
- chat is the main intake layer for requirements, changes, clarifications, and directions
- chat still becomes project memory only through deliberate classification and persistence

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
4. If those files still look like starter templates, prefer:
   - `APW: Initialize Project State`
   Terminal fallback:
   ```bash
   /path/to/apw/scripts/init-project-state.sh --target .
   ```
5. If you want the same checklist in terminal form, use:
   - `APW: First Run`
   Terminal fallback:
   ```bash
   apw first-run
   ```
   If `apw` is not resolvable yet, install the workspace launcher from APW root with `./scripts/install-workspace-launcher.sh` and source the generated `../.apw/env.zsh`.
6. Choose the first workflow that matches your situation:
   - `/brainstorm` if the idea or first step is still unclear
   - `/create` if the first feature is already clear
   - `/orchestrate` if the work is large or cross-cutting
   - `/status` if you are returning later or need orientation first
7. If you use `/brainstorm`, do not assume the chat became permanent project memory:
   - save the useful result to `.gsd/JOURNAL.md`
   - use orchestrator or governance sync if the result should change official project files
8. Keep `COMMAND_CHEATSHEET.md` nearby if you want the main slash commands and terminal commands in one page.

## Preferred Interaction Path

Use this simple APW rule:

1. ask for the APW action in chat first
2. use the matching IDE action when a tool provides one
3. use the terminal command when you need the fallback or exact flags

The action names and command mapping live in `docs/APW_ACTION_MODEL.md`.

For the first beginner layer, keep these three actions in mind:

- `APW: Create Project`
- `APW: Initialize Project State`
- `APW: First Run`

For requirement-bearing chat, use this APW rule:

- classify the chat before persisting it
- default to a bounded `JOURNAL.md` summary when the official destination is not settled yet
- promote requirements into `SPEC.md`, tasks into `TODO.md`, milestone impact into `ROADMAP.md`, and chosen rationale into `DECISIONS.md`
- keep a lightweight requirement register in `SPEC.md` with stable requirement IDs and lifecycle status
- use orchestrator or governance when the chat changes official project memory across files

Use this unified APW requirement flow:

- requirement-bearing chat arrives first
- classify it before persistence
- make the persistence outcome explicit
- map the saved result into `SPEC.md`, `TODO.md`, `ROADMAP.md`, `DECISIONS.md`, or `JOURNAL.md`
- record official requirements in `SPEC.md` with IDs so later tasks, status, and verification can point back to them
- break large requirement sets into modules or workstreams
- break active modules into atomic implementation slices
- execute those slices with `/create`, `/debug`, `/test`, and `/orchestrate` as needed
- use orchestrator or governance when official cross-file memory must change

If you need one APW requirement doc first instead of four separate ones, start with `docs/CHAT_REQUIREMENTS_TO_EXECUTION_FLOW.md`.

For large requirement sets, use this APW decomposition rule:

- keep the high-level scope in `SPEC.md`
- break the work into coherent modules or workstreams
- put module backlog and work slices into `TODO.md`
- put module sequencing and milestone order into `ROADMAP.md`
- put major decomposition tradeoffs into `DECISIONS.md`
- use `/orchestrate` when one requirement blob needs practical module decomposition

After modules exist, use this APW atomic-planning rule:

- turn the active module or workstream into small implementation slices
- keep actionable slices in `TODO.md`
- keep sequencing and milestone placement in `ROADMAP.md`
- keep important planning rationale in `DECISIONS.md`
- use `/orchestrate` when a module is still too large to slice cleanly
- use `/create` for one slice at a time, then `/test` or `/debug` to close that slice before moving on

After meaningful requirement chat, make one persistence outcome explicit:

- save as notes / evidence only
- promote into requirements and plan files
- hand off to orchestrator for official cross-file sync
- do not save yet

Safe default:

- save a bounded summary to `.gsd/JOURNAL.md`

For `APW: Create Project`, keep this workspace rule in mind:

- if the current context is APW root, create the new downstream repo in the parent workspace beside `apw`
- if the current context is the workspace parent, create the new repo in the current folder
- if the current context is a downstream project, create the new repo as a sibling in the same workspace parent
- only create inside APW root when the operator explicitly provides that target
- show the resolved destination before creation so the choice stays visible

## Read Next

Read the minimum next files, not everything at once.

Read now:

1. `COMMAND_CHEATSHEET.md`
2. `docs/FIRST_RUN_IN_IDE.md` when present
3. `docs/APW_ACTION_MODEL.md` when present
4. `docs/CHAT_FIRST_REQUIREMENT_INGESTION.md` when requirements or changes are arriving through chat
5. `docs/CHAT_REQUIREMENTS_TO_EXECUTION_FLOW.md` when the next question is how the full chat-to-execution route works
6. `docs/CHAT_REQUIREMENT_PERSISTENCE_CHOICES.md` when the next question is what got saved and whether official memory changed
7. `docs/REQUIREMENT_MODULE_BREAKDOWN.md` when the next question is how to split a large requirement set into modules or workstreams
8. `docs/ATOMIC_IMPLEMENTATION_PLANNING.md` when the next question is how to turn modules into bounded implementation slices

Only if needed:

9. `docs/WORKFLOW_SELECTION_GUIDE.md` when you need command choice help
10. `docs/COMMAND_INVOCATION_GUIDE.md` when you need command details
11. `docs/BRAINSTORM_PERSISTENCE_AND_PROMOTION.md` when you need the brainstorm save/promote model
12. `docs/BASIC_ONBOARDING_PROCEDURE.md`
13. `docs/WHERE_DO_I_WORK.md`

Advanced reference:

14. `PROJECT_RULES.md`
15. `AGENT_SYSTEM.md`
16. `COMMAND_POLICY.md`

For the fuller routing model, read `docs/DOCUMENTATION_LEVELS.md`.

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

- **Humans**: work from the downstream project root. Prefer the APW action path first, read `docs/FIRST_RUN_IN_IDE.md` first when present, then use `docs/WORKFLOW_SELECTION_GUIDE.md` or `docs/COMMAND_INVOCATION_GUIDE.md` only as needed.
- **Tools and agents**: read `PROJECT_RULES.md`, `AGENT_SYSTEM.md`, and the repo's current `.gsd/STATE.md` and `.gsd/TODO.md` before acting.
