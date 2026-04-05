# CI_CD_MOCKUPS.md — Automating APW Compliance

> [!TIP]
> The effectiveness of the APW standard relies on consistent discipline. By integrating `validate.sh` into your CI/CD pipelines and local git hooks, you algorithmically enforce that no project loses its AI context memory.

## 1. Remote Enforcement: GitHub Actions (Strict Failure)

This GitHub Action should run on every Pull Request to the `main` or `develop` branches. It will strictly fail the build if the APW workspace layers (`.gsd/` and `.agent/`) are incomplete or mutated improperly.

Create this file at `.github/workflows/apw-compliance.yml` in your target repository:

```yaml
name: APW Compliance Check

on:
  pull_request:
    branches: [ "main", "develop" ]

jobs:
  validate-workspace:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout Code
        uses: actions/checkout@v4

      - name: Make Validation Script Executable
        run: chmod +x ./scripts/validate.sh

      - name: Run APW Validation
        run: ./scripts/validate.sh .
        # If validate.sh exits with code 1, the workflow will fail, 
        # blocking the PR from being merged until the developer 
        # populates the missing .gsd/ or root governance files.
```

---

## 2. Local Enforcement: Git Pre-Commit Hook (Warning Only)

To prevent developers from pushing non-compliant code in the first place, use a `pre-commit` hook. 
*Note: We recommend making this a "soft" check (warnings only) locally so developers can commit work-in-progress (WIP) code without friction.*

Create this file in `.git/hooks/pre-commit` and ensure it is executable (`chmod +x`):

```bash
#!/usr/bin/env bash

# APW Pre-Commit Hook
echo "🔍 Running Local APW Compliance Check..."

if [ -f "./scripts/validate.sh" ]; then
    ./scripts/validate.sh .
    RESULT=$?
    
    if [ $RESULT -ne 0 ]; then
        echo "⚠️  WARNING: Your workspace is out of APW compliance!"
        echo "⚠️  You are missing required .gsd tracking files or governance rules."
        echo "⚠️  This commit is allowed locally, but CI/CD will reject the Pull Request."
        echo "⚠️  Please update your STATE.md and run bootstrap.sh if you are missing core files."
        echo "--------------------------------------------------------"
    fi
else
    echo "⚠️  WARNING: ./scripts/validate.sh not found. Have you bootstrapped this repo?"
fi

# Exit 0 allows the commit to proceed even if validation threw a warning.
exit 0
```

---

## 3. Failure Definitions

### What Constitutes a Failure?
A build failure triggered by `validate.sh` means the repository lacks the necessary files for an AI Agent to successfully jump into the context. 

### Resolving a Failure
If a developer is blocked by the APW CI action, they must:
1. Ensure `.gsd/STATE.md` exists and is populated.
2. Ensure `.gsd/ROADMAP.md` and `.gsd/SPEC.md` have not been deleted.
3. If they accidentally deleted the `.agent/` folder, they must run `./scripts/bootstrap.sh --target .` to restore the execution layer.
