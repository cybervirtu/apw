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

## 3. Recommended GitHub Actions Workflow

Create `.github/workflows/apw-compliance.yml` in the downstream repository:

```yaml
name: APW Compliance Check

on:
  pull_request:
    branches: ["main", "develop"]

jobs:
  validate-workspace:
    runs-on: ubuntu-latest
    env:
      APW_PROFILE: base
      APW_STACK: base
    steps:
      - name: Checkout downstream repo
        uses: actions/checkout@v4

      - name: Checkout APW standard
        uses: actions/checkout@v4
        with:
          repository: cybervirtu/apw
          path: .apw-standard

      - name: Run APW validation
        run: ./.apw-standard/scripts/validate.sh . --profile "$APW_PROFILE" --stack "$APW_STACK"
```

Use repository-level environment variables when different apps or repos need different APW profiles.

## 4. Monorepo Validation Pattern

If a monorepo bootstraps multiple package roots independently, validate each root explicitly instead of validating only the repository top-level:

```yaml
jobs:
  validate-root:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/checkout@v4
        with:
          repository: cybervirtu/apw
          path: .apw-standard
      - run: ./.apw-standard/scripts/validate.sh . --profile base --stack base

  validate-api:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/checkout@v4
        with:
          repository: cybervirtu/apw
          path: .apw-standard
      - run: ./.apw-standard/scripts/validate.sh ./apps/api --profile base --stack base

  validate-web:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/checkout@v4
        with:
          repository: cybervirtu/apw
          path: .apw-standard
      - run: ./.apw-standard/scripts/validate.sh ./apps/web --profile base --stack base
```

The important rule is simple: validate every location that was bootstrapped as an APW root.

## 5. Local Pre-Commit Hook

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

## 6. Failure Triage

### Hard failure

Common causes:

- missing `PROJECT_RULES.md`, `AGENT_SYSTEM.md`, or `GSD-STYLE.md`
- missing `.gitmessage`
- missing required `.gsd` files for the selected profile
- missing `.agent/` namespace directories
- missing vendored profile files in `advanced`

Recommended recovery path:

1. Confirm the intended bootstrap inputs for the repo.
2. Re-run bootstrap from the APW checkout with the matching profile and stack.
3. Re-run validation from the APW checkout with the same profile and stack.
4. Only use `--force` if you intend to replace lifecycle templates in `.gsd/`.

### Warning-only result

Common causes:

- legacy `.agents/` drift
- legacy `.agents/skills/` drift
- requested stack pack not vendored in `templates/stack/`

Warnings should be reviewed and cleaned up, but they do not currently block the repository.

## 7. Recommended Downstream Defaults

For most product repos:

- bootstrap with `--profile base --stack base`
- validate with `--profile base --stack base`
- treat PR validation as blocking
- treat local hooks as warning-only

For repos that intentionally use the advanced profile:

- bootstrap with `--profile advanced --stack base`
- validate with `--profile advanced --stack base`
- expect more `.agent` file-level enforcement, not a larger root `.gsd` state set

## 8. Policy Connection

This enforcement guide depends on:

- [PROJECT_BOOTSTRAP.md](../PROJECT_BOOTSTRAP.md)
- [docs/TEMPLATE_STRUCTURE.md](./TEMPLATE_STRUCTURE.md)
- [COMMAND_POLICY.md](../COMMAND_POLICY.md)
- [PROJECT_RULES.md](../PROJECT_RULES.md)
