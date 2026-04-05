# PILOT_ADOPTION_PLAN.md — Migrating a Repository to APW

> [!NOTE]
> This guide outlines the safe, phased approach to onboarding an existing active product repository onto the APW standard without disrupting ongoing development.

Use this guide together with [EXISTING_REPO_MIGRATION_GUIDE.md](./EXISTING_REPO_MIGRATION_GUIDE.md) for the exact migration sequence and [DOWNSTREAM_COMPLIANCE_CHECKLIST.md](./DOWNSTREAM_COMPLIANCE_CHECKLIST.md) for post-adoption anti-drift checks.

## 1. Pre-Flight Gap Analysis Checklist

Before running any automation scripts, audit the target repository to understand the delta:

- [ ] Does the project have an existing documented architecture or is it all tribal knowledge?
- [ ] Are there existing AI configurations (e.g., `.cursorrules`, `.github/copilot-instructions.md`)?
- [ ] What is the current issue tracker (Jira, Linear, GitHub Issues)?
- [ ] How is the current deployment process documented?

---

## 2. File Mapping Strategy

The fundamental shift in APW is moving from disparate documentation into a cohesive, AI-readable `.gsd` memory layer.

| Legacy Source | APW Destination | Action Required |
| :--- | :--- | :--- |
| `README.md` (Architecture) | `.gsd/ARCHITECTURE.md` | Extract system diagrams and technical descriptions. Leave `README.md` for simple onboarding/setup instructions. |
| Tech Stack Notes | `.gsd/STACK.md` | List all core dependencies and libraries explicitly. |
| Sprint Board / Jira | `.gsd/ROADMAP.md` | Map the current and next sprint into M1 and M2 phases. |
| Current Active Ticket | `.gsd/TODO.md` | Break the active ticket down into granular checkboxes. |
| Active Developer Brain | `.gsd/STATE.md` | The lead developer must write 2-3 paragraphs describing exactly where development paused before the adoption. |

---

## 3. Phased Rollout Sequence

### Phase 1: Installation & Archival
1. Run `cd [project-root] && /path/to/apw/scripts/bootstrap.sh --target . --profile base --stack base --force`.
2. Move any legacy AI rules (e.g., `.cursorrules`) into a newly created `legacy-ai/` folder. Do not delete them yet.

### Phase 2: Translation
1. Populate `.gsd/SPEC.md` for the current feature being built.
2. Ensure the developer sets the baseline in `.gsd/STATE.md` (e.g., "We are migrating to APW. The app currently builds, but the auth module is incomplete").

### Phase 3: Execution
1. The developer begins work using the newly injected APW workflows (e.g., Cursor Composer with `/design`).
2. Adhere strictly to the APW rule: append evidence to `.gsd/JOURNAL.md` after a major debugging session, then run an orchestrator or governance sync to update canonical files such as `.gsd/STATE.md` and `.gsd/TODO.md`.

### Phase 4: Review
After one complete feature cycle or sprint:
1. Run `/path/to/apw/scripts/validate.sh . --profile base --stack base`.
2. Verify that no "shadow architecture" was created.
3. Re-run the downstream compliance checklist to confirm the repo still matches the intended APW contract.
4. If successful, safely delete the `legacy-ai/` folder.

---

## 4. Validation: Criteria for a Successful Pilot
The pilot is considered successful when:
- [ ] At least one feature has been completely designed, executed, and verified utilizing the APW `SPEC -> PLAN -> EXECUTE -> VERIFY` loop.
- [ ] A new developer (or an AI agent with a blank context) can read `.gsd/STATE.md` and immediately understand the project's current status and blockers without human assistance.
- [ ] No namespace collisions occurred between GSD lifecycle commands and AGK execution workflows.
