# FEATURES_AND_MODES.md — Features and Modes

## 1. Features vs Modes

In APW:

- **features** are capabilities APW provides
- **modes** are the situations or operating contexts in which you use APW

This distinction matters because APW does not change its core architecture every time you use it differently.

## 2. Major APW Features

### Structured project memory

APW gives every repo a governed `.gsd/` layer so project state is visible and durable.

### Unified execution namespace

APW standardizes execution under `.agent/` with:

- agents
- rules
- scripts
- workflows
- skills

### Profile-based bootstrap

APW supports lightweight to richer setups without changing the core contract.

### Content-aware validation

APW checks more than file existence.

It validates:

- required structure
- key content shape
- namespace drift
- advanced-state fragmentation drift
- ownership drift

### Controlled canonical state sync

APW protects canonical summary files from uncontrolled multi-agent rewriting.

### CI enforcement

APW can be enforced automatically in pull requests and rollout pipelines.

### Migration support

APW includes guidance for adopting the standard in an already-active repository.

## 3. Profiles

Profiles change how much of APW is bootstrapped into a downstream repo.

### `minimal`

Use `minimal` when:

- the repo is small
- the work is lightweight
- you want the least ceremony possible

What it gives you:

- a lightweight `.gsd` starter set
- any minimal profile-local `.agent` content if present

### `base`

Use `base` when:

- you want the standard APW operating model
- you are building a normal product repo
- you want the canonical eight-file `.gsd` contract

What it gives you:

- the full canonical `.gsd` baseline
- the full `.agent/` namespace directories
- room for project-local `.agent` rules and execution material

### `advanced`

Use `advanced` when:

- you want richer vendored execution support
- the repo benefits from more specialist agent definitions and workflows
- you still want the same lean canonical `.gsd` model as `base`

What it gives you:

- the same canonical `.gsd` contract as `base`
- richer vendored `.agent/agents/`, `.agent/rules/`, and `.agent/workflows/`

What it does **not** mean:

- it does not create a heavier root state model
- it does not reintroduce fragmented milestone or snapshot files

## 4. Usage Modes

APW supports several practical modes of use.

### Greenfield project

Use APW from day 1 in a brand-new repository.

Typical path:

- bootstrap
- validate
- initialize `.gsd`
- start coding

### Existing repo migration

Use APW to bring order to a repo that already exists.

Typical path:

- inventory current docs and AI rules
- bootstrap into the repo
- translate current knowledge into `.gsd`
- run a first orchestrator sync
- adopt CI and anti-drift habits

### Solo builder

One person uses APW with one or more AI assistants.

The main benefit is durable state and less context loss between sessions.

### Team usage

A team shares one APW contract and uses governed state to reduce confusion across multiple contributors and AI tools.

### Monorepo usage

A monorepo uses APW at multiple roots where needed, instead of forcing one global execution state to describe every package equally well.

## 5. Choosing the Right Mode and Profile

| Situation | Recommended profile | Notes |
| :--- | :--- | :--- |
| small experiment | `minimal` | use when lifecycle depth can stay light |
| most product repos | `base` | safest default |
| specialist-heavy execution | `advanced` | stronger execution layer, same root state contract |
| active repo migration | usually `base` | migrate first, then tighten if needed |
| monorepo packages | usually `base` | treat each APW root intentionally |

## 6. Common Misunderstandings

### “Advanced means more root state files”

No.

`advanced` is stronger, not heavier.
It keeps the same canonical `.gsd` contract as `base`.

### “Modes are separate architectures”

No.

Greenfield, migration, team, solo, and monorepo are usage patterns built on the same APW contract.

### “Base is incomplete because it ships fewer vendored `.agent` files”

No.

`base` is still the canonical APW baseline.
It simply leaves more execution content to project-local setup or lighter usage.

## 7. Where to Go Next

- For starting fast: [QUICK_START.md](./QUICK_START.md)
- For end-to-end explanation: [APW_HANDBOOK.md](./APW_HANDBOOK.md)
- For examples: [USE_CASES_AND_EXAMPLES.md](./USE_CASES_AND_EXAMPLES.md)
