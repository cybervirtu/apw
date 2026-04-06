# WORKFLOW_REFERENCE.md — Workflow Reference

## 1. The Standard APW Loop

The main APW workflow is:

**SPEC -> PLAN -> EXECUTE -> VERIFY -> SYNC -> VALIDATE**

In files, that usually maps to:

| Stage | Primary files |
| :--- | :--- |
| SPEC | `SPEC.md` |
| PLAN | `ROADMAP.md`, `TODO.md` |
| EXECUTE | code, tests, implementation artifacts |
| VERIFY | tests, proof, evidence, `JOURNAL.md` |
| SYNC | `STATE.md`, `ROADMAP.md`, `TODO.md`, `DECISIONS.md` |
| VALIDATE | `scripts/validate.sh` or `scripts/ci-validate.sh` |

## 2. Session Start Workflow

Start a normal session like this:

1. Read `STATE.md`.
2. Read `TODO.md`.
3. Read `SPEC.md` if behavior changes are involved.
4. Read relevant `.agent/rules/`.
5. Confirm the active milestone or task.

## 3. Feature Workflow

Use this pattern for a normal feature:

1. Confirm the feature belongs in the current scope.
2. Update or verify `SPEC.md`.
3. Break the work into roadmap and todo items.
4. Execute the feature in scoped steps.
5. Verify with tests or other evidence.
6. Append evidence to `JOURNAL.md`.
7. Run orchestrator sync if canonical state changed.
8. Run validation before merge.

## 4. Bug Fix Workflow

Use this pattern for a bug fix:

1. Read `STATE.md` and `TODO.md`.
2. Reproduce the bug or confirm the failure.
3. Fix only the scoped issue.
4. Verify with tests or a reproducible proof.
5. Append the debugging and verification evidence to `JOURNAL.md`.
6. Sync canonical state if the bug changes blockers, next steps, or backlog.
7. Validate before merge.

## 5. Architecture Change Workflow

When the change affects structure, dependencies, or design rationale:

1. Read `ARCHITECTURE.md`, `STACK.md`, and `DECISIONS.md`.
2. Update the design rationale in `DECISIONS.md` when needed.
3. Execute the change in bounded steps.
4. Verify the change.
5. Sync canonical state through orchestrator/governance.

## 6. Upgrade Workflow

When APW itself changes:

1. Re-run `bootstrap.sh` with the correct profile and stack.
2. Avoid `--force` unless lifecycle templates should actually be replaced.
3. Re-run validation.
4. Review warnings and cleanup drift.
5. Update CI references if APW is pinned by tag or commit.

## 7. Migration Workflow

For an existing repo:

1. Inventory the current repo state.
2. Bootstrap APW into the repo.
3. Validate.
4. Translate current project knowledge into canonical `.gsd`.
5. Run the first orchestrator sync.
6. Deliver one APW-managed work cycle.
7. Enable CI enforcement.

## 8. Monorepo Workflow

For monorepos:

1. Decide which directories should be APW roots.
2. Bootstrap each APW root intentionally.
3. Validate each APW root separately.
4. Keep canonical state local to each root unless the change is truly global.

## 9. Governance Commands and Execution Workflows

APW distinguishes governance-oriented actions from execution-oriented actions.

Governance-oriented commands include:

- `/gsd`
- `/plan`
- `/task`
- `/verify`
- `/audit`

Execution-oriented workflows commonly include:

- `/status`
- `/brainstorm`
- `/create`
- `/enhance`
- `/debug`
- `/design`
- `/ui-ux-pro-max`
- `/preview`
- `/deploy`
- `/test`
- `/orchestrate`
- `/skill`

Not every downstream repo will vendor the same execution workflows.

What matters is the operating model:

- governance controls lifecycle and canonical state
- execution performs scoped implementation work

For command-by-command operator guidance, see [COMMAND_INVOCATION_GUIDE.md](./COMMAND_INVOCATION_GUIDE.md), [WORKFLOW_SELECTION_GUIDE.md](./WORKFLOW_SELECTION_GUIDE.md), and [AGENT_PLUS_WORKFLOW_EXAMPLES.md](./AGENT_PLUS_WORKFLOW_EXAMPLES.md).

## 10. When to Pause and Re-Sync

Pause and run a sync pass when:

- the session is getting confused
- multiple execution loops are muddying state
- a milestone has been completed
- you are handing work to another agent or person
- the backlog or next steps have changed materially

## 11. Safe End-of-Session Workflow

Before you stop:

1. Make sure implementation work is verified.
2. Append bounded evidence to `JOURNAL.md`.
3. Run orchestrator/governance sync if canonical state changed.
4. Re-run validation if the work is heading to merge or release.
