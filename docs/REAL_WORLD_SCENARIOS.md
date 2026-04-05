# REAL_WORLD_SCENARIOS.md — Real-World Scenarios

> [!TIP]
> Read this when you want to see how APW behaves in realistic project situations instead of abstract rules.

## What this is

This document shows APW in real-world scenarios.

Each scenario explains:

- the starting situation
- the APW setup choice
- what happens during execution
- where the orchestrator matters
- what validation or CI catches

## Why it matters

Frameworks become easier to trust when you can imagine using them on a real repo.

This document is meant to answer:

- “What does APW feel like in practice?”
- “How does it help in a real project?”
- “When do the rules actually matter?”

## When to use it

Use this when:

- you are deciding whether APW is worth adopting
- you want practical examples to show a teammate
- you understand the theory but want to see the workflow in context

## Scenario 1: Solo Developer Building a SaaS MVP

### Starting situation

A solo developer is building a small SaaS app on nights and weekends.
They use AI heavily and often return to the repo after a few days away.

### APW approach

- choose `base`
- bootstrap once
- validate immediately
- initialize the canonical `.gsd` files

### How APW helps

At the start of each session, the developer reads:

- `STATE.md`
- `TODO.md`

That means they do not need to reconstruct their own project from memory every time.

Execution agents:

- build features
- run tests
- append evidence to `JOURNAL.md`

The orchestrator sync:

- updates `STATE.md`
- promotes new tasks into `TODO.md`

### What validation catches

If the repo drifts structurally or a required file disappears, validation catches it before the repo gets messier.

### Why this scenario matters

This is where APW proves it is not only for teams.
It is also a strong solo workflow because it reduces context loss across sessions.

## Scenario 2: Team Adopting APW in an Active Product Repo

### Starting situation

A team already has a working application.
The codebase is real, but AI usage is inconsistent:

- multiple prompt files
- no reliable project state
- no shared handoff format

### APW approach

- inventory the existing repo
- bootstrap APW into the repo with `base`
- validate immediately
- translate current architecture, roadmap, and current state into canonical `.gsd`
- run one orchestrator pass to establish the first clean state

### How APW helps

The team does not need to redesign the product.
They only need to establish one governed workspace layer.

Execution agents can still move quickly, but the official state now has a home.

### What validation and CI catch

Validation and CI help stop:

- accidental namespace drift
- missing required files
- reintroduction of legacy patterns

### Why this scenario matters

This is the most common real-world APW adoption path:
not a greenfield toy, but a real repo that needs clearer structure.

## Scenario 3: Bug Fix From Report to Merge

### Starting situation

A regression appears in checkout or authentication.
The team wants to fix it quickly without muddying project state.

### APW approach

1. read `STATE.md` and `TODO.md`
2. reproduce the bug
3. fix only the scoped issue
4. record proof in `JOURNAL.md`
5. run orchestrator sync if blockers or next steps changed
6. validate before merge

### How APW helps

The fix stays bounded.
The evidence is stored.
The official project state only changes if the bug actually changes the current project position.

### What validation and CI catch

If the bug fix accidentally drifts the APW structure, CI can stop it.

### Why this scenario matters

APW is not just for milestone planning.
It also supports small tactical work without losing the larger project picture.

## Scenario 4: Feature Delivery With an Execution Agent and an Orchestrator

### Starting situation

A team is adding notification settings to a web app.

### APW approach

The execution agent:

- reads `STATE.md`, `TODO.md`, and the relevant project rules
- implements the UI and backend pieces
- writes tests
- appends evidence to `JOURNAL.md`

The orchestrator:

- reads the implementation result
- updates `STATE.md`
- closes or promotes tasks in `TODO.md`
- updates `ROADMAP.md` if the milestone status changed

### How APW helps

The execution agent stays focused on delivery.
The orchestrator keeps the official state coherent.

### What validation and CI catch

If the feature work leaves missing files, broken structure, or content-shape regressions in key lifecycle files, validation catches it.

### Why this scenario matters

This is the core APW model in action:

- execution is fast
- state is controlled

## Scenario 5: Advanced Profile in a Production App

### Starting situation

A production application wants richer specialist execution support and stronger CI habits.

### APW approach

- bootstrap with `advanced`
- keep the same canonical `.gsd` contract as `base`
- use vendored `.agent/agents/` and `.agent/workflows/`
- keep milestone and snapshot information inside canonical files instead of fragmenting state

### How APW helps

The repo gets richer execution support without creating a heavier root memory system.

### What validation and CI catch

Validation warns if legacy advanced fragmentation files reappear.
CI can optionally treat warnings as blocking once the repo is already clean.

### Why this scenario matters

It shows the real meaning of `advanced`:
stronger execution support, not extra state sprawl.

## Scenario 6: Monorepo With API and Web Apps

### Starting situation

A monorepo contains:

- `apps/api`
- `apps/web`

The team does not want one shared execution context to thrash constantly.

### APW approach

- bootstrap the root only where global governance is useful
- bootstrap `apps/api` as its own APW root
- bootstrap `apps/web` as its own APW root
- validate each APW root separately

### How APW helps

Each application gets its own state and execution context.
Cross-package work can still be coordinated, but day-to-day execution stays local.

### What validation and CI catch

CI can validate every APW root individually.
This prevents one healthy package from hiding another package’s drift.

### Why this scenario matters

It shows that APW scales beyond a single-app repo.

## What all real-world APW usage has in common

Across all scenarios, the same pattern holds:

- one governed memory layer
- one execution namespace
- evidence in `JOURNAL.md`
- controlled canonical state sync
- validation and CI to catch drift

## What to read next

1. [COMMON_WORKFLOWS.md](./COMMON_WORKFLOWS.md)
2. [TEAM_ADOPTION_GUIDE.md](./TEAM_ADOPTION_GUIDE.md)
3. [CI_CD_ENFORCEMENT.md](./CI_CD_ENFORCEMENT.md)
