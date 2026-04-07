# DOWNSTREAM_ADOPTION_GUIDE.md — Safe APW Adoption Guide

> [!IMPORTANT]
> This guide defines what a downstream repository must do on day 1 to adopt APW safely and use it without drifting away from the standard.

## 1. Choose the Right Profile

Use the smallest profile that still matches the repo's operating needs:

| Profile | Use When | Tradeoff |
| :--- | :--- | :--- |
| `minimal` | Small scripts, prototypes, research, or very lightweight repos | Lowest ceremony, weakest lifecycle depth |
| `base` | Most product repositories | Canonical APW baseline with the full eight-file `.gsd` contract |
| `advanced` | Repos that need richer specialist execution prompts and workflows | Same canonical `.gsd` contract as `base`, but more `.agent/` execution material |

If a team is unsure, choose `base`.

For downstream command availability:

- `base` and `advanced` receive the shared core APW workflows directly in `.agent/workflows/`
- `minimal` stays lighter and may not vendor the full core command pack

## 2. Required Day-1 Steps

Before routine coding starts in a newly bootstrapped repo:

1. For a brand-new repo, use the workspace-friendly wrapper when possible:
   ```bash
   /path/to/apw/apw new MyProject --profile base --stack base --target /path/to/workspace
   ```
2. If you are not using the wrapper, bootstrap the repo with an explicit profile and stack.
3. Validate the repo with the same `--profile` and `--stack` values if validation was not already run by the wrapper.
4. Start from root `AGENTS.md`, then review `PROJECT_RULES.md`, `AGENT_SYSTEM.md`, `COMMAND_POLICY.md`, `PROJECT_BOOTSTRAP.md`, and `GSD-STYLE.md`.
5. Run guided project-state initialization to populate the first canonical `.gsd/` state.
6. Confirm the repo has a project-local execution rule file if needed, such as `.agent/rules/PROJECT.md`.
7. Make sure the team knows which profile was chosen and uses the same values for future validation and upgrades.

For `base` and `advanced`, also confirm that the core downstream commands are present locally:

- `/status`
- `/brainstorm`
- `/create`
- `/enhance`
- `/debug`
- `/test`
- `/orchestrate`

Do not begin normal implementation work until those steps are complete.

## 3. Mandatory Files and Paths

These must remain present in every APW-compliant downstream repo:

- `AGENTS.md`
- `PROJECT_RULES.md`
- `AGENT_SYSTEM.md`
- `COMMAND_POLICY.md`
- `PROJECT_BOOTSTRAP.md`
- `GSD-STYLE.md`
- `.gitmessage`
- `.agent/agents/`
- `.agent/rules/`
- `.agent/scripts/`
- `.agent/workflows/`
- `.agent/skills/`
- the selected profile's required `.gsd/` files

For `base` and `advanced`, the canonical `.gsd/` file set is:

- `SPEC.md`
- `ROADMAP.md`
- `STATE.md`
- `TODO.md`
- `JOURNAL.md`
- `DECISIONS.md`
- `ARCHITECTURE.md`
- `STACK.md`

Do not rename these paths casually. Do not replace `.agent/` with `.agents/` unless APW has an explicit migration plan for that repo.

## 4. What Teams May Customize

Downstream teams may customize:

- the contents of `.gsd/` files for their own project reality
- project-specific implementation constraints in `.agent/rules/PROJECT.md`
- additional local `.agent/` prompts, helpers, or workflows that do not conflict with APW governance
- product documentation under `docs/`

Downstream teams should not casually customize:

- `AGENTS.md` beyond keeping it as a front door into the APW contract
- `PROJECT_RULES.md`
- `AGENT_SYSTEM.md`
- `COMMAND_POLICY.md`
- `PROJECT_BOOTSTRAP.md`
- `GSD-STYLE.md`
- the canonical `.agent/` namespace
- the canonical `.gsd` filenames required by the selected profile

If those contract files need to change, treat it as an intentional APW upgrade or migration step, not an incidental project edit.

## 5. Canonical State Maintenance Rule

Use this ownership split in downstream repos:

- Execution agents may:
  - modify code
  - create implementation artifacts
  - append bounded evidence to `.gsd/JOURNAL.md`
- Execution agents should not by default:
  - freely rewrite `.gsd/STATE.md`
  - freely rewrite `.gsd/ROADMAP.md`
  - freely rewrite `.gsd/TODO.md`
  - freely rewrite `.gsd/DECISIONS.md`
- The orchestrator or explicit governance pass is responsible for:
  - synchronizing canonical summary/state files
  - promoting follow-up work into canonical `TODO.md`
  - resolving cross-file consistency after implementation

Use a controlled sync step after meaningful implementation, verification, or design changes.

## 6. Staying Compliant After Adoption

To reduce downstream drift:

1. Re-run `validate.sh` with the same profile and stack used during bootstrap.
2. Do not introduce `.agents/` or `.agents/skills/` as an unplanned alternate layout alongside APW's current `.agent/` contract.
3. Do not fragment advanced repos back into milestone, sprint, or snapshot root `.gsd` files.
4. Keep execution evidence in `JOURNAL.md`, then run a controlled orchestrator sync for canonical state.
5. Re-run `bootstrap.sh` intentionally when adopting APW updates. Use `--force` only when lifecycle templates in `.gsd/` should truly be replaced.

## 7. Team Operating Guardrails

For team use:

1. Treat one person or one agent pass as the orchestrator for canonical state sync.
2. Keep implementation agents scoped to bounded work and bounded `JOURNAL.md` evidence.
3. Record architectural changes in `DECISIONS.md`.
4. Validate before merge and after APW upgrades.
5. Review warnings even when validation still exits successfully.

## 8. What “APW Compliant” Means

A downstream repo is APW-compliant when:

- the required APW files and directories still exist
- the repo validates successfully against its chosen profile and stack
- canonical `.gsd` state is maintained through controlled sync, not casual multi-agent writeback
- the repo has not drifted into unplanned alternate namespaces or fragmented advanced state files

Pair this guide with [DOWNSTREAM_COMPLIANCE_CHECKLIST.md](./DOWNSTREAM_COMPLIANCE_CHECKLIST.md) for the recurring checklist and [EXISTING_REPO_MIGRATION_GUIDE.md](./EXISTING_REPO_MIGRATION_GUIDE.md) when adopting APW in an active repository.
