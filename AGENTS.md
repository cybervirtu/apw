# AGENTS.md

> [!IMPORTANT]
> This is APW's modern tool-facing front door. It is an entrypoint, not a second source of truth.

## What APW Is

APW stands for **Agentic Project Workspace**.

It is the governing standard for this repository and for repos bootstrapped from this standard.

APW combines:

- **GSD** for governed project memory and lifecycle state in `.gsd/`
- **AGK** for execution rules, workflows, agents, and skills in `.agent/`
- an **orchestrator / governance pass** for controlled synchronization of canonical project state

## Core Operating Rule

- **GSD governs** what is being built, what state is official, and what counts as done.
- **AGK executes** implementation work inside that governed scope.
- The **orchestrator synchronizes** canonical summary files after meaningful implementation, verification, or design change.
- If there is a conflict, **GSD documentation wins**.

## Read Next

1. `PROJECT_RULES.md`
2. `AGENT_SYSTEM.md`
3. `COMMAND_POLICY.md`
4. `PROJECT_BOOTSTRAP.md`

If this repo also includes APW handbook docs, continue with:

5. `docs/START_HERE.md`
6. `docs/APW_HANDBOOK.md`
7. `docs/ANTIGRAVITY_COMPATIBILITY.md`

## Do Not

- Do not treat this file as the full APW contract.
- Do not bypass `PROJECT_RULES.md`, `AGENT_SYSTEM.md`, or `COMMAND_POLICY.md`.
- Do not assume APW has already migrated to `.agents/` just because newer Antigravity-native examples may use that layout.

## Compatibility Note

Antigravity also supports `GEMINI.md`. APW adopts root `AGENTS.md` as the modern entrypoint and keeps fuller compatibility guidance in `docs/ANTIGRAVITY_COMPATIBILITY.md`.

## Where To Start

- **Humans**: read `docs/START_HERE.md` when present. Otherwise start with `PROJECT_RULES.md` and `AGENT_SYSTEM.md`, then follow the APW docs or checkout used to bootstrap this repo.
- **Tools and agents**: read `PROJECT_RULES.md`, `AGENT_SYSTEM.md`, and the repo's current `.gsd/STATE.md` and `.gsd/TODO.md` before acting.
