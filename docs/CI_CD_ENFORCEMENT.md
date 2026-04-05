# CI_CD_ENFORCEMENT.md — Downstream Enforcement Guide

> [!TIP]
> APW only stays useful if downstream repositories continuously enforce the same bootstrap and validation contract that created them.

## 1. Enforcement Model

Use APW enforcement in two layers:

- **Local warning layer**: catch drift before code leaves a developer machine.
- **Remote blocking layer**: fail pull requests when required APW structure is missing or legacy drift has appeared.

The authoritative enforcement command is:

```bash
/path/to/apw/scripts/validate.sh [repo-root] --profile base --stack base
```

Always run validation with the same `--profile` and `--stack` values used during bootstrap.
The validator runs from an APW checkout against a target repository path; bootstrapped downstream repos are not expected to carry their own second copy of the APW templates and validator.
Human operators should still use [DOWNSTREAM_COMPLIANCE_CHECKLIST.md](./DOWNSTREAM_COMPLIANCE_CHECKLIST.md); CI complements that checklist, but does not replace day-to-day APW hygiene.

For CI usage, prefer the thin wrapper:

```bash
/path/to/apw/scripts/ci-validate.sh [repo-root] --profile base --stack base
```

`ci-validate.sh` still delegates all compliance logic to `validate.sh`. Its job is only to:

- preserve the validator as the single compliance engine
- keep blocking versus warning behavior explicit in CI
- emit a short CI-friendly summary
- optionally treat warnings as blocking when a repo chooses stricter enforcement

## 2. What Validation Enforces

The current validator checks:

- required root governance files
- profile-selected `.gsd` lifecycle files
- minimum content shape for key lifecycle and governance files
- the full `.agent/` directory namespace
- profile-vendored `.agent` files when the chosen profile includes them
- stack-vendored skill files when the chosen stack pack exists
- warnings for legacy drift such as `.agents/` and `.agents/skills/`
- warnings for ownership drift that weakens the orchestrator-controlled state model

This means CI should treat exit code `1` as a hard failure, while warnings can remain visible without blocking the build.

## 3. Blocking vs Warning Policy

Use the following enforcement model:

### Blocking

These should fail CI immediately:

- missing required root governance files
- missing required profile-backed `.gsd` files
- missing required `.agent/` namespace paths
- missing vendored advanced-profile execution files
- broken content shape for key lifecycle/governance files
- APW source-contract failures when maintaining the APW repo itself

### Warning-only by default

These should stay visible but non-blocking unless the repo opts into stricter enforcement:

- legacy `.agents/` namespace drift
- legacy `.agents/skills/` drift
- legacy advanced root `.gsd` fragmentation files
- ownership-drift guidance that weakens orchestrator-controlled canonical state
- requested stack pack not currently vendored in APW

### Advisory

These are not enforced directly by CI, but should still be part of team operations:

- completion of the downstream compliance checklist
- use of a single orchestrator/governance pass for canonical state sync
- profile selection discipline during migration or rollout

Set `APW_FAIL_ON_WARNINGS=1` or pass `--fail-on-warnings` when a repo wants warning-level issues to block merges.

## 4. Recommended GitHub Actions Workflow

Copy [examples/github/apw-validate.yml](../examples/github/apw-validate.yml) into `.github/workflows/apw-compliance.yml` in the downstream repository:

```yaml
name: APW Compliance

on:
  pull_request:
    branches:
      - main
      - develop
  push:
    branches:
      - main

jobs:
  validate-apw:
    runs-on: ubuntu-latest
    env:
      APW_PROFILE: base
      APW_STACK: base
      APW_FAIL_ON_WARNINGS: "0"
    steps:
      - name: Checkout downstream repository
        uses: actions/checkout@v4

      - name: Checkout APW standard
        uses: actions/checkout@v4
        with:
          repository: cybervirtu/apw
          path: .apw-standard
          ref: main

      - name: Run APW CI validation
        run: ./.apw-standard/scripts/ci-validate.sh . --profile "$APW_PROFILE" --stack "$APW_STACK"
```

Use repository-level environment variables when different apps or repos need different APW profiles.
Prefer pinning the APW checkout to a release tag or commit SHA once your rollout process is stable.

## 5. Monorepo Validation Pattern

If a monorepo bootstraps multiple package roots independently, validate each root explicitly instead of validating only the repository top-level:

```yaml
jobs:
  validate-root:
    runs-on: ubuntu-latest
    env:
      APW_PROFILE: base
      APW_STACK: base
    steps:
      - uses: actions/checkout@v4
      - uses: actions/checkout@v4
        with:
          repository: cybervirtu/apw
          path: .apw-standard
      - run: ./.apw-standard/scripts/ci-validate.sh . --profile "$APW_PROFILE" --stack "$APW_STACK"

  validate-api:
    runs-on: ubuntu-latest
    env:
      APW_PROFILE: base
      APW_STACK: base
    steps:
      - uses: actions/checkout@v4
      - uses: actions/checkout@v4
        with:
          repository: cybervirtu/apw
          path: .apw-standard
      - run: ./.apw-standard/scripts/ci-validate.sh ./apps/api --profile "$APW_PROFILE" --stack "$APW_STACK"

  validate-web:
    runs-on: ubuntu-latest
    env:
      APW_PROFILE: base
      APW_STACK: base
    steps:
      - uses: actions/checkout@v4
      - uses: actions/checkout@v4
        with:
          repository: cybervirtu/apw
          path: .apw-standard
      - run: ./.apw-standard/scripts/ci-validate.sh ./apps/web --profile "$APW_PROFILE" --stack "$APW_STACK"
```

The important rule is simple: validate every location that was bootstrapped as an APW root.

## 6. Post-Bootstrap CI Enablement

After a downstream repo passes its first manual validation:

1. Copy the example workflow into `.github/workflows/apw-compliance.yml`.
2. Set `APW_PROFILE` and `APW_STACK` to match the bootstrap inputs used by that repo.
3. Decide whether warnings stay non-blocking or whether `APW_FAIL_ON_WARNINGS=1` is appropriate.
4. Open a pull request and confirm the workflow passes before declaring the repo rollout-ready.

For most repos, keep warnings non-blocking at first. For advanced-profile repos with stricter governance expectations, protected branches may choose to block on warnings once the workspace is already clean.

## 7. Local Pre-Commit Hook

Use a soft local hook so developers see drift early without blocking work-in-progress commits:

```bash
#!/usr/bin/env bash

echo "🔍 Running local APW compliance check..."

PROFILE="${APW_PROFILE:-base}"
STACK="${APW_STACK:-base}"
APW_ROOT="${APW_ROOT:-../apw}"

if [[ -x "$APW_ROOT/scripts/validate.sh" ]]; then
  "$APW_ROOT/scripts/validate.sh" . --profile "$PROFILE" --stack "$STACK"
  RESULT=$?

  if [[ $RESULT -ne 0 ]]; then
    echo "⚠️  Local APW validation failed."
    echo "⚠️  Fix the missing files above or re-run bootstrap with the intended profile."
    echo "⚠️  The commit is allowed locally, but CI should block the pull request."
  fi
else
  echo "⚠️  APW validator not found at $APW_ROOT/scripts/validate.sh."
  echo "⚠️  Set APW_ROOT or install a local checkout of the APW standard."
fi

exit 0
```

## 8. Failure Triage

### Hard failure

Common causes:

- missing `PROJECT_RULES.md`, `AGENT_SYSTEM.md`, or `GSD-STYLE.md`
- missing `.gitmessage`
- missing required `.gsd` files for the selected profile
- missing `.agent/` namespace directories
- missing vendored profile files in `advanced`
- content-shape failures in `SPEC.md`, `ROADMAP.md`, `STATE.md`, `TODO.md`, `PROJECT_RULES.md`, or `AGENT_SYSTEM.md`

Recommended recovery path:

1. Confirm the intended bootstrap inputs for the repo.
2. Re-run bootstrap from the APW checkout with the matching profile and stack.
3. Re-run validation from the APW checkout with the same profile and stack.
4. Only use `--force` if you intend to replace lifecycle templates in `.gsd/`.

### Warning-only result

Common causes:

- legacy `.agents/` drift
- legacy `.agents/skills/` drift
- legacy advanced `.gsd` fragmentation
- ownership-drift guidance in governance docs
- requested stack pack not vendored in `templates/stack/`

Warnings should be reviewed and cleaned up, but they do not currently block the repository.

### Strict-warning mode

If a repo has already cleaned up warning-level drift and wants a stricter gate:

- set `APW_FAIL_ON_WARNINGS=1` in CI
- or run `ci-validate.sh --fail-on-warnings`

This is recommended only after the baseline workspace is already warning-free.

## 9. Migration Guidance for Existing Repos

When adding CI enforcement to an already-active repo:

1. Migrate the repo into APW first.
2. Run manual bootstrap and validation until the workspace is clean.
3. Add the CI workflow in warning-tolerant mode first.
4. Clean up any warning-level drift that appears.
5. Only then consider switching protected branches to strict-warning mode.

Pair this with [EXISTING_REPO_MIGRATION_GUIDE.md](./EXISTING_REPO_MIGRATION_GUIDE.md) and [PILOT_ADOPTION_PLAN.md](./PILOT_ADOPTION_PLAN.md).

## 10. Recommended Downstream Defaults

For most product repos:

- bootstrap with `--profile base --stack base`
- validate in CI with `ci-validate.sh --profile base --stack base`
- treat PR validation as blocking
- treat local hooks as warning-only

For repos that intentionally use the advanced profile:

- bootstrap with `--profile advanced --stack base`
- validate in CI with `ci-validate.sh --profile advanced --stack base`
- expect more `.agent` file-level enforcement, not a larger root `.gsd` state set
- consider strict-warning mode only after the repo is clean and the team is ready for tighter enforcement

## 11. Policy Connection

This enforcement guide depends on:

- [PROJECT_BOOTSTRAP.md](../PROJECT_BOOTSTRAP.md)
- [docs/TEMPLATE_STRUCTURE.md](./TEMPLATE_STRUCTURE.md)
- [COMMAND_POLICY.md](../COMMAND_POLICY.md)
- [PROJECT_RULES.md](../PROJECT_RULES.md)
- [examples/github/apw-validate.yml](../examples/github/apw-validate.yml)
