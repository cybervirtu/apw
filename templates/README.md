# Templates Directory Guide

`templates/` is the canonical downstream bootstrap source for APW profiles.

## Profile Model

- `minimal/`: smallest practical lifecycle starter plus any minimal profile `.agent` content
- `base/`: default lifecycle baseline for most repos, plus the shared downstream core command pack during bootstrap
- `advanced/`: the same canonical eight-file `.gsd` baseline as `base`, plus the shared downstream core command pack and additional specialist execution content

## Common Rules

- Every bootstrap profile starts from the same downstream skeleton: `.agent/agents/`, `.agent/rules/`, `.agent/scripts/`, `.agent/workflows/`, `.agent/skills/`, `.gsd/`, and `docs/`.
- Root APW entrypoint and operating files are not duplicated per profile. `bootstrap.sh` copies `AGENTS.md`, `PROJECT_RULES.md`, `AGENT_SYSTEM.md`, `COMMAND_POLICY.md`, `PROJECT_BOOTSTRAP.md`, and `GSD-STYLE.md` from the APW repo root.
- `base` and `advanced` also receive a shared downstream core command pack from the canonical root `.agent/` tree: `/status`, `/brainstorm`, `/create`, `/enhance`, `/debug`, `/test`, and `/orchestrate`.
- Missing profile subdirectories are intentional unless documented otherwise.
- Empty `docs/` or `scripts/` profile folders are placeholders only; bootstrap does not treat them as separate sources of truth.
- `.agent/skills/` remains the active capability-layer path for downstream repos.

## Reading The Tree

- A profile directory always tells you what that profile contributes directly.
- If a profile omits `.agent/agents/`, `.agent/rules/`, `.agent/scripts/`, `.agent/workflows/`, or `.agent/skills/`, bootstrap still creates those target directories but leaves them empty unless another source populates them.
- `templates/stack/` is reserved for optional stack-specific skill packs layered on top of the selected profile.

## Practical Interpretation

- `minimal` stays lighter than `base` and `advanced`.
- `base` is the standard downstream command baseline.
- `advanced` adds more vendored execution content on top of the shared core pack, not a second governance source or a second state model.
- `advanced` should keep milestone, sprint, phase-close, and session snapshot details inside `ROADMAP.md`, `STATE.md`, `TODO.md`, and `JOURNAL.md` rather than splitting them into extra root `.gsd` files.
- The repo root plus `templates/` together define the complete bootstrap contract, but `templates/` remains the only profile-selection source.
- Root `AGENTS.md` is the modern front door into that contract. A fuller `.agents/...` migration would be a separate architectural decision.
