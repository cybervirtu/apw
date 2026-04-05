# USE_CASES_AND_EXAMPLES.md — Use Cases and Examples

## 1. Build a Small App From Scratch

Example: a solo developer wants to build a small FastAPI service.

### Path

1. Bootstrap with `base`.
2. Validate the repo.
3. Initialize `SPEC.md`, `STACK.md`, `ROADMAP.md`, `STATE.md`, and `TODO.md`.
4. Build Milestone 1.
5. Append evidence to `JOURNAL.md`.
6. Sync canonical state.
7. Run validation before merge.

### Why this works

The developer gets:

- a clear feature plan
- a place to store current state
- a safe way to resume work later

## 2. Migrate an Existing Repo

Example: a team has a working app but scattered AI rules and no reliable state system.

### Path

1. Inventory current docs, tickets, and AI instructions.
2. Bootstrap APW into the repo with `base`.
3. Validate immediately.
4. Translate current architecture, stack, and work state into canonical `.gsd`.
5. Archive legacy AI rules.
6. Run one APW-managed feature cycle.
7. Turn on CI enforcement.

### Why this works

The team does not need to redesign the product.
They only need to establish one governed operating layer.

## 3. Team Usage

Example: three developers and multiple AI assistants are working in one product repo.

### Path

1. Agree on the profile and stack.
2. Assign one orchestrator owner per work cycle or milestone.
3. Keep execution agents scoped to implementation.
4. Use `JOURNAL.md` for evidence.
5. Use orchestrator sync for `STATE.md`, `ROADMAP.md`, `TODO.md`, and `DECISIONS.md`.
6. Enforce `validate.sh` in CI.

### Why this works

The team avoids “everyone editing the project summary at once.”

## 4. Bug Fix Workflow

Example: a regression appears in checkout flow.

### Path

1. Read `STATE.md` and `TODO.md`.
2. Reproduce the bug.
3. Fix only the bug.
4. Verify with tests.
5. Log the debugging evidence in `JOURNAL.md`.
6. If blockers or next steps changed, sync canonical state.
7. Validate before merge.

## 5. Feature Implementation Workflow

Example: add user notifications to an existing app.

### Path

1. Confirm the feature belongs in `SPEC.md`.
2. Add milestone planning in `ROADMAP.md`.
3. Break the first slice into `TODO.md`.
4. Implement the feature in bounded slices.
5. Verify each slice.
6. Append evidence to `JOURNAL.md`.
7. Sync canonical state after meaningful progress.

## 6. Advanced Project Workflow

Example: a production app wants richer specialist execution support.

### Path

1. Bootstrap with `advanced`.
2. Keep the same canonical `.gsd` contract as `base`.
3. Use the richer vendored `.agent/agents/` and `.agent/workflows/` support.
4. Keep milestone, sprint, and snapshot information inside canonical files instead of creating extra root state files.
5. Consider stricter CI enforcement once the repo is clean.

### Why this works

The team gets stronger execution support without making the state model heavier.

## 7. Monorepo Workflow

Example: a monorepo contains `apps/api` and `apps/web`.

### Path

1. Bootstrap the root for shared governance if needed.
2. Bootstrap each app root intentionally.
3. Validate each APW root separately.
4. Use local `.gsd` state for each app.
5. Only treat changes as global when they truly cross packages.

### Why this works

The frontend and backend do not thrash one shared state file unnecessarily.

## 8. Solo Builder Example

Example: one developer works nights and weekends with AI help.

### Path

1. Bootstrap with `base`.
2. Keep `STATE.md` current through orchestrator sync at the end of each serious session.
3. Use `TODO.md` to keep the next session obvious.
4. Use `JOURNAL.md` for evidence and debugging notes.

### Why this works

The developer can pause for days and still resume without guessing.

## 9. What These Examples Have in Common

Every successful APW example follows the same pattern:

- one governed memory layer
- one execution namespace
- scoped implementation work
- evidence in `JOURNAL.md`
- controlled summary-state synchronization
- validation before merge or rollout
