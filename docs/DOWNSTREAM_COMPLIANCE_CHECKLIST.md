# DOWNSTREAM_COMPLIANCE_CHECKLIST.md — APW Compliance Checklist

> [!TIP]
> Use this checklist after bootstrap, before major implementation waves, and after APW upgrades.

## 1. Bootstrap Completion Checklist

- [ ] The repo was bootstrapped with an explicit `--profile` and `--stack`.
- [ ] The same `--profile` and `--stack` values were used for validation.
- [ ] `PROJECT_RULES.md`, `AGENT_SYSTEM.md`, `GSD-STYLE.md`, and `.gitmessage` exist at the repo root.
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

- [ ] No `.agents/` directory exists.
- [ ] No `.agents/skills/` path exists.
- [ ] `advanced` repos do not reintroduce legacy root files like `MILESTONE.md`, `SPRINT.md`, `PHASE-SUMMARY.md`, `STATE_SNAPSHOT.md`, or `TOKEN_REPORT.md`.
- [ ] Root governance files were not casually renamed, deleted, or replaced with local variants.
- [ ] Profile-specific expectations still match the selected profile.

## 4. Customization Boundary Checklist

- [ ] Project-specific implementation rules live in project-local materials such as `.agent/rules/PROJECT.md`.
- [ ] Teams customize `.gsd/` content for project reality without renaming the canonical files.
- [ ] APW contract changes are handled as intentional upgrades, not ad hoc edits during feature work.

## 5. Team Rollout Checklist

- [ ] The team knows which profile the repo uses.
- [ ] The team knows who performs orchestrator/governance sync when canonical state changes.
- [ ] CI runs `validate.sh` with the correct profile and stack.
- [ ] New contributors are pointed to [DOWNSTREAM_ADOPTION_GUIDE.md](./DOWNSTREAM_ADOPTION_GUIDE.md).

If any item fails, pause feature work long enough to restore the APW contract and re-run validation.
