# Templates Directory Guide

`templates/` is the canonical downstream bootstrap source for APW profiles.

## Profile Model

- `minimal/`: smallest practical lifecycle starter plus any minimal profile `.agent` content
- `base/`: default lifecycle baseline for most repos
- `advanced/`: expanded lifecycle set plus vendored specialist execution content

## Common Rules

- Every bootstrap profile starts from the same downstream skeleton: `.agent/agents/`, `.agent/rules/`, `.agent/scripts/`, `.agent/workflows/`, `.agent/skills/`, `.gsd/`, and `docs/`.
- Root governance files are not duplicated per profile. `bootstrap.sh` copies them from the APW repo root.
- Missing profile subdirectories are intentional unless documented otherwise.
- Empty `docs/` or `scripts/` profile folders are placeholders only; bootstrap does not treat them as separate sources of truth.
- `.agent/skills/` remains the active capability-layer path for downstream repos.

## Reading The Tree

- A profile directory always tells you what that profile contributes directly.
- If a profile omits `.agent/agents/`, `.agent/rules/`, `.agent/scripts/`, `.agent/workflows/`, or `.agent/skills/`, bootstrap still creates those target directories but leaves them empty unless another source populates them.
- `templates/stack/` is reserved for optional stack-specific skill packs layered on top of the selected profile.

## Practical Interpretation

- `minimal` and `base` are intentionally lighter than `advanced`.
- `advanced` adds more vendored execution content, not a second governance source.
- The repo root plus `templates/` together define the complete bootstrap contract, but `templates/` remains the only profile-selection source.
