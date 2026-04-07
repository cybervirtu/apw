# DOCUMENTATION_LEVELS.md — APW Documentation Levels

> [!IMPORTANT]
> Use this page when you want the simple APW reading model: what to read now, what to use next, and what to ignore until you actually need it.

## The short version

APW uses three documentation levels:

1. `Level 1 — Start now`
2. `Level 2 — Use APW better`
3. `Level 3 — Deep reference`

The goal is simple:

- keep APW complete
- make the first-use path lighter
- help users ignore deep material until it is actually useful

This is a routing model, not a second source of truth.

The canonical rules still live in the repo-root governance files and the canonical docs under `docs/`.

## Level 1 — Start now

Use this level if you are:

- new to APW
- opening a downstream project for the first time
- trying to create a project and get moving safely

Read these now:

- `AGENTS.md`
- `COMMAND_CHEATSHEET.md`
- `docs/INSTALLATION_GUIDE.md`
- `docs/BASIC_USAGE_GUIDE.md`
- `docs/BASIC_ONBOARDING_PROCEDURE.md`
- `docs/FIRST_RUN_IN_IDE.md`
- `docs/START_HERE.md`
- `docs/QUICK_START.md`
- `docs/APW_ACTION_MODEL.md`

What this level should answer:

- what APW is
- where you should work
- how to create a project
- what to do first in the IDE
- which first workflow to choose
- where to find the fast command list

What you can ignore for now:

- deep governance rules
- compatibility internals
- template structure details
- CI/reference details that do not block first use

## Level 2 — Use APW better

Use this level once the project exists and you want better support, not just a first-use path.

Read these when needed:

- `docs/IDEA_TO_PROJECT_GUIDE.md`
- `docs/TECH_STACK_SELECTION_GUIDE.md`
- `docs/WORKFLOW_SELECTION_GUIDE.md`
- `docs/COMMAND_INVOCATION_GUIDE.md`
- `docs/WHERE_DO_I_WORK.md`
- `docs/SAFE_CONTEXT_SWITCHING.md`
- `docs/GUIDED_PROJECT_STATE_INITIALIZATION.md`
- `docs/DOWNSTREAM_PROJECT_UPGRADE.md`
- `docs/BRAINSTORM_PERSISTENCE_AND_PROMOTION.md`
- `docs/WORKFLOW_PERSISTENCE_POLICY.md`
- `docs/AGENT_PLUS_WORKFLOW_EXAMPLES.md`
- `docs/REAL_WORLD_EXAMPLES.md`

What this level should answer:

- how to choose a better path
- how to use workflows more intentionally
- how to initialize or upgrade a project safely
- how to switch context without getting lost
- how evidence and canonical state relate

## Level 3 — Deep reference

Use this level if you are:

- maintaining APW itself
- reviewing framework behavior
- debugging policy, compatibility, CI, or template details
- making framework-level changes

Read these when you need the real contract or deeper internals:

- `PROJECT_RULES.md`
- `AGENT_SYSTEM.md`
- `COMMAND_POLICY.md`
- `PROJECT_BOOTSTRAP.md`
- `docs/COMPATIBILITY_MODEL.md`
- `docs/CODEX_COMPATIBILITY.md`
- `docs/ANTIGRAVITY_COMPATIBILITY.md`
- `docs/CI_CD_ENFORCEMENT.md`
- `docs/TEMPLATE_STRUCTURE.md`
- `docs/UPGRADE_STRATEGY.md`
- `docs/DOWNSTREAM_COMPLIANCE_CHECKLIST.md`
- `docs/DOCS_SOURCE_OF_TRUTH.md`
- `docs/HOW_APW_WORKS.md`
- `docs/APW_HANDBOOK.md`

What this level should answer:

- what the real rule is
- how APW compatibility works
- how validation and CI enforcement work
- how templates, upgrades, and framework evolution are controlled

## The practical beginner path

If you are brand new, this is enough:

1. `docs/INSTALLATION_GUIDE.md`
2. `docs/BASIC_USAGE_GUIDE.md`
3. `AGENTS.md`
4. `docs/BASIC_ONBOARDING_PROCEDURE.md`
5. `COMMAND_CHEATSHEET.md`
6. `docs/FIRST_RUN_IN_IDE.md`

Optional next:

7. `docs/QUICK_START.md`
8. `docs/WHERE_DO_I_WORK.md`
9. `docs/GUIDED_PROJECT_STATE_INITIALIZATION.md`

Only if needed:

10. `docs/WORKFLOW_SELECTION_GUIDE.md`
11. `docs/COMMAND_INVOCATION_GUIDE.md`
12. `docs/DOWNSTREAM_PROJECT_UPGRADE.md`

Ignore for now:

13. `PROJECT_RULES.md`
14. `AGENT_SYSTEM.md`
15. `COMMAND_POLICY.md`
16. `docs/COMPATIBILITY_MODEL.md`
17. `docs/CI_CD_ENFORCEMENT.md`

## Documentation levels table

| Level | Who it is for | Read this when | Typical docs |
| :--- | :--- | :--- | :--- |
| `Level 1 — Start now` | first-time users and beginners | you need the minimum safe path | `AGENTS.md`, `COMMAND_CHEATSHEET.md`, `INSTALLATION_GUIDE.md`, `BASIC_USAGE_GUIDE.md`, `BASIC_ONBOARDING_PROCEDURE.md`, `FIRST_RUN_IN_IDE.md`, `START_HERE.md`, `QUICK_START.md` |
| `Level 2 — Use APW better` | users already working in APW | you need guidance, not just orientation | workflow selection, switching, guided initialization, upgrade, persistence, examples |
| `Level 3 — Deep reference` | maintainers, advanced users, reviewers | you need the real framework contract or internals | governance, compatibility, CI, template, upgrade, and architecture docs |

## How to use this model in practice

- If a page says `Read this now`, treat it as Level 1.
- If a page says `Optional next` or `Only if needed`, treat it as Level 2.
- If a page says `Advanced reference` or `Maintainer/reference level`, treat it as Level 3.

The key idea is simple:

- start light
- go deeper only when the next question actually appears
- keep the full APW system available without making beginners read all of it first
