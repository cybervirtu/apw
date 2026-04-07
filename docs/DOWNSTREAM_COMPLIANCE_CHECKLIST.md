# DOWNSTREAM_COMPLIANCE_CHECKLIST.md — APW Compliance Checklist

> [!TIP]
> Use this checklist after bootstrap, before major implementation waves, and after APW upgrades.

## 1. Bootstrap Completion Checklist

- [ ] The repo was bootstrapped with an explicit `--profile` and `--stack`.
- [ ] The same `--profile` and `--stack` values were used for validation.
- [ ] `AGENTS.md`, `PROJECT_RULES.md`, `AGENT_SYSTEM.md`, `COMMAND_POLICY.md`, `PROJECT_BOOTSTRAP.md`, `GSD-STYLE.md`, and `.gitmessage` exist at the repo root.
- [ ] The required `.gsd/` files for the selected profile exist.
- [ ] `.agent/agents/`, `.agent/rules/`, `.agent/scripts/`, `.agent/workflows/`, and `.agent/skills/` exist.
- [ ] A single orchestrator or governance pass populated the initial canonical `.gsd` state before coding started.

## 2. Day-to-Day Operating Checklist

- [ ] Sessions start from `.gsd/STATE.md` and `.gsd/TODO.md`.
- [ ] Execution agents are limited to code changes, artifacts, and bounded `JOURNAL.md` evidence.
- [ ] Canonical state updates to `STATE.md`, `ROADMAP.md`, `TODO.md`, and `DECISIONS.md` happen through a controlled orchestrator/governance sync.
- [ ] Architectural or dependency changes are recorded in `DECISIONS.md`.
- [ ] Validation is re-run before merge or release.

## 3. Anti-Drift Checklist

- [ ] No unplanned `.agents/` directory exists alongside APW's current `.agent/` contract.
- [ ] No unplanned `.agents/skills/` path exists alongside APW's current `.agent/skills/` contract.
- [ ] `advanced` repos do not reintroduce legacy root files like `MILESTONE.md`, `SPRINT.md`, `PHASE-SUMMARY.md`, `STATE_SNAPSHOT.md`, or `TOKEN_REPORT.md`.
- [ ] Root APW entrypoint and operating files were not casually renamed, deleted, or replaced with local variants.
- [ ] Profile-specific expectations still match the selected profile.
- [ ] APW-managed upgrades use `apw upgrade-project` or another intentional reviewed path instead of ad hoc file copying.

## 4. Customization Boundary Checklist

- [ ] Project-specific implementation rules live in project-local materials such as `.agent/rules/PROJECT.md`.
- [ ] Teams customize `.gsd/` content for project reality without renaming the canonical files.
- [ ] APW contract changes are handled as intentional upgrades, not ad hoc edits during feature work.

## 5. Team Rollout Checklist

- [ ] The team knows which profile the repo uses.
- [ ] The team knows who performs orchestrator/governance sync when canonical state changes.
- [ ] CI runs `ci-validate.sh` or `validate.sh` from an APW checkout with the correct profile and stack.
- [ ] The team has explicitly chosen whether warnings are non-blocking or blocking in CI.
- [ ] New contributors are pointed to [DOWNSTREAM_ADOPTION_GUIDE.md](./DOWNSTREAM_ADOPTION_GUIDE.md).

## 6. Safe Upgrade Checklist

- [ ] The downstream repo was committed or checkpointed before upgrade.
- [ ] `apw upgrade-project <name-or-path> --dry-run` was reviewed first.
- [ ] Project-owned `.gsd/*` files were kept protected.
- [ ] Product code was not treated as APW-managed upgrade surface.
- [ ] Any `--force-managed` use was deliberate and reviewed.
- [ ] Validation was re-run after the upgrade.

If any item fails, pause feature work long enough to restore the APW contract and re-run validation.
