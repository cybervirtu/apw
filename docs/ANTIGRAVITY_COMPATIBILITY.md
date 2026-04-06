# ANTIGRAVITY_COMPATIBILITY.md — APW and Newer Antigravity Workflows

> [!TIP]
> Read this if you want the practical answer to: "What do `AGENTS.md`, `GEMINI.md`, `.agent/`, and `.agents/` mean in APW?"

This document describes Antigravity compatibility inside one shared APW framework. It is not a separate framework branch.

## 1. What Changed in Antigravity

Newer Antigravity releases added support for reading rules from `AGENTS.md` in addition to `GEMINI.md`.

At the same time, newer Antigravity teaching materials also show a more Antigravity-native workflow style built around files like `agents.md`, `skills.md`, and `.agents/...`.

That means two things can now be true at once:

- `AGENTS.md` is a real, supported entrypoint
- `GEMINI.md` is not removed or invalid

## 2. What `AGENTS.md` Means

`AGENTS.md` is best understood as a repo-root entrypoint for tools and collaborators.

In practical terms, it should:

- explain what system the repo is using
- state the main operating rule in simple language
- point people and tools to the real governing files

It should usually stay short.

If `AGENTS.md` tries to restate every rule in the repo, it becomes a second source of truth and drifts out of date.

## 3. How APW Uses `AGENTS.md`

APW now treats root `AGENTS.md` as the modern front door.

That means:

- the APW repo itself ships a root `AGENTS.md`
- `bootstrap.sh` generates a root `AGENTS.md` in downstream repos by default
- that file tells tools and people where APW's real rules live

In APW, `AGENTS.md` is intentionally an entrypoint, not the full framework.

APW uses the same front door for Codex too. Antigravity is a compatibility path inside the same framework, not a separate APW variant.

## 4. Why APW Treats `AGENTS.md` as a Front Door

APW already has a real operating model.

That operating model is spread across a small set of purpose-specific files:

- `PROJECT_RULES.md`
- `AGENT_SYSTEM.md`
- `COMMAND_POLICY.md`
- `PROJECT_BOOTSTRAP.md`
- APW docs, templates, and validators

Those files do different jobs:

- `PROJECT_RULES.md` defines the mandatory governance rules
- `AGENT_SYSTEM.md` explains the GSD versus AGK precedence model
- `COMMAND_POLICY.md` explains who owns which commands
- `PROJECT_BOOTSTRAP.md` explains what bootstrap actually creates and updates

APW uses `AGENTS.md` to route into that system because duplicating all of that logic inside one file would make the contract harder to trust.

## 5. What `GEMINI.md` Means Now

`GEMINI.md` still matters.

It now means "older or compatibility-oriented entrypoint," not "invalid file."

APW does **not** describe `GEMINI.md` as removed.

APW's current position is:

- `AGENTS.md` is the default modern front door
- `GEMINI.md` is a compatibility option when a repo, toolchain, or team still wants it

APW does not generate `GEMINI.md` by default, but teams may keep or add it deliberately when they need backward compatibility.

## 6. What `.agents/...` Means in the Newer Antigravity-Native Style

In newer Antigravity-native examples, `.agents/...` usually represents a more autonomous pipeline layout for agent definitions, skills, or related orchestration materials.

That is a real style, and APW should describe it honestly.

At the same time, APW's current contract still uses:

- `.agent/` as the execution namespace
- `.agent/agents/`
- `.agent/rules/`
- `.agent/scripts/`
- `.agent/workflows/`
- `.agent/skills/`

So the important distinction is:

- `.agents/...` is a possible Antigravity-native architecture
- `.agent/...` is the current APW architecture

Those are not the same thing, and APW should not pretend they are.

## 7. Why APW Is Not Doing a Silent Hard Migration

A move from APW's current `.agent/` contract to a fuller `.agents/...` architecture would affect:

- bootstrap behavior
- validation rules
- documentation
- CI expectations
- downstream repo layouts
- migration guidance for already-bootstrapped projects

That is a real migration project, not a wording tweak.

So APW's current position is simple:

- adopt root `AGENTS.md` now as the modern entrypoint
- remain accurate about `GEMINI.md`
- acknowledge newer `.agents/...` workflows honestly
- do not silently rewrite the APW architecture without an explicit migration plan

## 8. Practical Summary

| Item | What It Means In APW |
| :--- | :--- |
| `AGENTS.md` | Modern root entrypoint |
| `GEMINI.md` | Compatibility entrypoint when needed |
| `.agent/` | Current APW execution namespace |
| `.agents/` | Possible future Antigravity-native migration path, not the current APW default |

## 9. What To Do In Practice

If you are using APW today:

1. Start from root `AGENTS.md`.
2. Follow it into `PROJECT_RULES.md` and `AGENT_SYSTEM.md`.
3. Treat `COMMAND_POLICY.md` and `PROJECT_BOOTSTRAP.md` as part of the real APW operating model.
4. Keep using the current APW `.agent/` execution layout unless your team intentionally plans a migration.

For the bigger picture, also read `docs/COMPATIBILITY_MODEL.md`.
