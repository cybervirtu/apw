# CODEX_COMPATIBILITY.md — APW and Codex

> [!TIP]
> Read this if you want the practical answer to: "How should Codex use APW?"

## 1. The Short Answer

Codex uses the same APW framework as every other supported tool.

There is no separate Codex branch or Codex-specific APW variant.

Codex should enter through root `AGENTS.md`, then follow the core APW contract.

## 2. The Codex Entry Path

For Codex, the intended flow is:

1. Open root `AGENTS.md`.
2. Read `PROJECT_RULES.md`.
3. Read `AGENT_SYSTEM.md`.
4. Read `COMMAND_POLICY.md`.
5. Read `PROJECT_BOOTSTRAP.md` when the task involves bootstrap, validation, or upgrade behavior.
6. Read `.gsd/STATE.md` and `.gsd/TODO.md` before acting on the current task.

That is the Codex adapter model in APW.

## 3. What Codex Should Treat as Canonical

Codex should treat these as canonical:

- `PROJECT_RULES.md`
- `AGENT_SYSTEM.md`
- `COMMAND_POLICY.md`
- `PROJECT_BOOTSTRAP.md`
- the relevant `.gsd/` files
- the current `.agent/` execution namespace

`AGENTS.md` is a front door into that system, not a replacement for it.

## 4. Why APW Does Not Need a Separate Codex Branch

Codex already works well with:

- repo-root entrypoint files
- explicit routing
- deterministic command and validation workflows
- strong local repository contracts

That means APW can support Codex without forking the framework.

The core APW contract stays the same.
Only the usage guidance needs to be clear.

## 5. Codex Strengths in APW

Codex is especially useful for:

- bootstrap and validation work
- CI-facing fixes
- repo-wide documentation maintenance
- controlled standards updates
- deterministic terminal-first tasks

That is why APW documents Codex as a strong operational fit, not as a separate framework mode.

## 6. What Codex Should Not Assume

Codex should not assume:

- that `AGENTS.md` is the whole APW framework
- that it may bypass `PROJECT_RULES.md` or `AGENT_SYSTEM.md`
- that `.agents/...` is the current APW default
- that APW has a separate Codex-specific branch or contract

## 7. Practical Summary

If you are using Codex with APW:

1. Start from root `AGENTS.md`.
2. Follow the APW routing into the core governance files.
3. Work inside the current `.gsd/` and `.agent/` contract.
4. Use orchestrator/governance sync when canonical state must change.
