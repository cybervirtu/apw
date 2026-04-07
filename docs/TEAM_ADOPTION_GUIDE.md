# TEAM_ADOPTION_GUIDE.md — Team Adoption Guide

## 1. Who This Is For

This guide is for teams that want APW to be more than a solo workflow.

Use it when:

- multiple developers touch the same repo
- multiple AI tools or agents are in play
- you want consistent onboarding and handoff behavior

## 2. Start With One Shared Decision

Before rollout, agree on:

- the APW profile
- the stack value used for bootstrap and validation
- who owns orchestrator/governance sync
- whether CI warnings are blocking or non-blocking

If the team does not make those decisions explicitly, APW will feel inconsistent in practice.

## 3. Recommended Team Baseline

For most teams:

- use `base`
- use APW validation in CI
- keep warnings non-blocking at first
- move to stricter enforcement after the repo is clean

Use `advanced` only when the richer vendored execution layer is genuinely useful.

## 4. Shared Team Rules

Teams should agree to these habits:

1. Start work from `STATE.md` and `TODO.md`.
2. Keep execution agents scoped.
3. Use `JOURNAL.md` for evidence, not for replacing canonical summaries.
4. Run orchestrator/governance sync when canonical state changes.
5. Validate before merge.

## 5. Suggested Team Roles

You do not need formal job titles.

You do need role clarity:

| Role | Typical responsibility |
| :--- | :--- |
| Repo owner or tech lead | profile choice, rollout decisions, enforcement policy |
| Orchestrator owner | canonical state synchronization |
| Contributors | implementation work and bounded evidence |
| CI owner | workflow setup and branch protection |

One person can hold multiple roles on a small team.

## 6. Team Rollout Sequence

1. Pick one repo.
2. Bootstrap it with `base` unless there is a strong reason not to.
3. Validate manually.
4. Initialize `.gsd` with one orchestrator-style pass.
5. Deliver one feature or bug-fix cycle with APW.
6. Turn on CI enforcement.
7. Onboard the rest of the team to the same pattern.

## 7. Onboarding New Team Members

Give new contributors this reading order:

1. [QUICK_START.md](./QUICK_START.md)
2. [APW_HANDBOOK.md](./APW_HANDBOOK.md)
3. [WORKFLOW_REFERENCE.md](./WORKFLOW_REFERENCE.md)
4. [DOWNSTREAM_COMPLIANCE_CHECKLIST.md](./DOWNSTREAM_COMPLIANCE_CHECKLIST.md)

Then show them:

- the chosen profile
- the validator command
- the CI workflow
- who owns orchestrator sync

If you are preparing for broader team rollout, also run the real-user onboarding validation set:

1. [USER_ONBOARDING_VALIDATION_PLAN.md](./USER_ONBOARDING_VALIDATION_PLAN.md)
2. [ONBOARDING_TEST_SCENARIOS.md](./ONBOARDING_TEST_SCENARIOS.md)
3. [USER_FEEDBACK_TEMPLATE.md](./USER_FEEDBACK_TEMPLATE.md)
4. [USER_PERSONAS.md](./USER_PERSONAS.md)

## 8. Team Handoffs

Healthy team handoffs look like this:

- the work is verified
- the evidence is in `JOURNAL.md`
- canonical state has been synchronized if needed
- the next contributor can start from `STATE.md` and `TODO.md`

Unhealthy handoffs usually mean one of those steps was skipped.

## 9. Common Team Pitfalls

### Too many people editing summary files

Fix:

- restrict routine summary rewrites
- use orchestrator sync deliberately

### Profile confusion

Fix:

- record the chosen profile in team docs and CI env vars

### CI exists but is ignored

Fix:

- make the APW check part of branch protection
- review warnings intentionally

### AI tools used without role boundaries

Fix:

- treat some sessions as execution
- treat some sessions as orchestrator/governance

## 10. When a Team Is Using APW Well

You can usually tell because:

- the repo state is understandable from files, not from memory
- contributors can resume work quickly
- AI sessions are less chaotic
- validation catches drift before merge
- project history is easier to follow
