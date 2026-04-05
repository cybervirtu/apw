# PROJECT_BOOTSTRAP.md — Standard Initialization

## Overview
This file defines how the APW standard is instantiated into a new or existing repository.

## Bootstrap Steps
1. **Initialize Root**: Create `PROJECT_RULES.md`, `AGENT_SYSTEM.md`, and `GSD-STYLE.md`.
2. **Setup Memory**: Create the `.gsd/` folder with standard templates (SPEC, ROADMAP, STATE).
3. **Setup Execution**: Create the `.agent/` folder for local context and `.agents/skills/` for the curated library.
4. **Initialize Docs**: Create a boilerplate `docs/` structure.
5. **Validation**: Run `./scripts/validate.sh` to ensure the environment is compliant.

## Configuration Options
- **Monorepo Mode**: Enable module-specific `.gsd/` or `.agent/` overrides.
- **Stack-Specific**: Inject templates for FastAPI, React, etc.
