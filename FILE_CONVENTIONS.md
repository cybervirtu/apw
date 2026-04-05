# FILE_CONVENTIONS.md — Structural and Naming Standards

## Overview
This document outlines the standard file naming and structural conventions for projects bootstrapped using the APW standard. Consistency across the workspace ensures predictability for AI agents and human developers alike.

## 1. Naming Conventions

### Documentation & Governance
- **Root Files**: All uppercase with underscores (e.g., `PROJECT_RULES.md`, `COMMAND_POLICY.md`).
- **GSD Files**: All uppercase (e.g., `SPEC.md`, `ROADMAP.md`).
- **Agent Context**: Kebab-case (e.g., `clean-code.md`, `react-expert.md`).

### Source Code
- **General Rule**: Default to `kebab-case` for file names and directories unless framework conventions strictly dictate otherwise.
  - ✅ `user-profile-component.tsx`
  - ❌ `UserProfileComponent.tsx`
- **React / Next.js**: Stick to `kebab-case` for file names. React component exports should be `PascalCase`.
- **Python / FastAPI**: Use `snake_case` for python modules and file names.
- **Constant Files**: Use uppercase for files exporting only constants (e.g., `CONSTANTS.ts`, `ERROR_CODES.py`).

## 2. Directory Structures

### The `docs/` Folder
Instead of polluting the root directory, feature documentation, API specs, and runbooks should live in `docs/`:
- `docs/architecture/`
- `docs/api/`
- `docs/runbooks/`

### The `.agent/` Folder
This is reserved exclusively for the active AI context layer. Do not store application configuration (like Docker or ESLint) here.
- `.agent/rules/`: Machine readable prompts.
- `.agent/workflows/`: Executable slash commands.

## 3. Temporary and Scratch Files
- Any temporary scripting, data dumping, or exploratory logging should be done in `/tmp/` or explicitly ignored directories to prevent polluting the version control or context window.
