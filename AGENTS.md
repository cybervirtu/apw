# AGENTS.md

> [!IMPORTANT]
> This is APW's modern tool-facing front door for Codex-, Antigravity-, and similarly compatible sessions. It is an entrypoint, not a second source of truth.

## What APW Is

APW stands for **Agentic Project Workspace**.

It is the governing standard for this repository and for repos bootstrapped from this standard.

APW is one canonical framework. It does not maintain separate framework variants or branches for Codex and Antigravity.

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
7. `docs/COMPATIBILITY_MODEL.md`
8. `docs/CODEX_COMPATIBILITY.md`
9. `docs/ANTIGRAVITY_COMPATIBILITY.md`

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

- **Humans**: read `docs/BASIC_ONBOARDING_PROCEDURE.md` first when present if you want the shortest safe first-use path. Then continue with `docs/START_HERE.md` if you want the broader beginner path.
- **Tools and agents**: read `PROJECT_RULES.md`, `AGENT_SYSTEM.md`, and the repo's current `.gsd/STATE.md` and `.gsd/TODO.md` before acting.
