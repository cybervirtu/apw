# EXISTING_REPO_MIGRATION_GUIDE.md — Adopting APW in an Active Repository

> [!IMPORTANT]
> Use this guide when a repository already has active code, docs, and team habits before APW is introduced.

## 1. Pre-Migration Inventory

Before running bootstrap:

1. Identify existing AI instruction files such as `.cursorrules`, Copilot instructions, or local prompt docs.
2. Identify the current issue tracker or sprint board.
3. Identify the best current sources for architecture, stack, and deployment knowledge.
4. Identify the current owner who can act as the first orchestrator/governance pass.

Do not delete legacy material yet. Archive first, then remove only after the APW workflow is proven.

## 2. Safe Migration Sequence

1. Bootstrap the existing repo with the intended APW profile and stack.
2. Validate immediately with the same `--profile` and `--stack`.
3. Archive legacy AI configuration into a clearly named holding folder such as `legacy-ai/`.
4. Translate existing project knowledge into the canonical `.gsd/` files.
5. Run a single orchestrator/governance pass to establish the first clean canonical state.
6. Begin one APW-managed feature cycle before removing archived legacy AI materials.

## 3. Suggested File Mapping

Use this practical mapping:

- product requirements or ticket summaries -> `.gsd/SPEC.md`
- sprint board or milestone plan -> `.gsd/ROADMAP.md`
- current pause/resume context -> `.gsd/STATE.md`
- active implementation breakdown -> `.gsd/TODO.md`
- verification notes, debug notes, and session evidence -> `.gsd/JOURNAL.md`
- architecture notes or diagrams -> `.gsd/ARCHITECTURE.md`
- stack notes -> `.gsd/STACK.md`
- architectural rationale or tradeoffs -> `.gsd/DECISIONS.md`

Do not create parallel “shadow” state files if the canonical `.gsd/` set can hold the information with headings and sections.

## 4. First Canonical Sync

The first APW sync pass should:

1. establish the current project position in `STATE.md`
2. map active and next work into `ROADMAP.md`
3. create a usable canonical task list in `TODO.md`
4. capture any migration-specific rationale in `DECISIONS.md`
5. move supporting evidence and migration notes into `JOURNAL.md`

Use one orchestrator-style pass for this so the initial `.gsd` layer is coherent.

## 5. Migration Guardrails

During the first APW-backed delivery cycle:

- keep execution agents focused on code plus bounded `JOURNAL.md` evidence
- do not let multiple agents rewrite `STATE.md` independently
- validate before merge
- review warnings even if validation still passes
- keep the profile and stack values stable unless the migration intentionally changes them

## 6. When the Migration Is Complete

An existing repo has migrated cleanly when:

- the APW validator passes with the intended profile and stack
- the team is using the canonical `.gsd` files instead of legacy memory files
- orchestrator-controlled canonical state sync is being followed in practice
- archived legacy AI materials are no longer needed for normal work

For active-team rollout, pair this guide with [PILOT_ADOPTION_PLAN.md](./PILOT_ADOPTION_PLAN.md). For ongoing hygiene after migration, use [DOWNSTREAM_COMPLIANCE_CHECKLIST.md](./DOWNSTREAM_COMPLIANCE_CHECKLIST.md).
