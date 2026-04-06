# DOCS_SOURCE_OF_TRUTH.md — APW Documentation Source Of Truth

> [!IMPORTANT]
> Use this note when you need to decide where APW documentation should live, where to edit it, and how the Nextra portal relates to the canonical repo docs.

## Why this note exists

APW now has two documentation layers in the same repository:

- canonical Markdown docs and repo-root governance files
- a rendered Nextra portal under `website/`

That makes the docs easier to learn, but it also creates a maintenance risk if people are not clear about which layer is authoritative.

This note defines the practical model.

## The short version

- repo-root governance files and canonical docs under `docs/` are the source of truth
- `website/pages/` is the user-facing presentation and navigation layer
- the portal may summarize, wrap, and route
- the portal must not become a second governance system

## APW docs roles

APW documentation falls into these roles:

### 1. Canonical governance/reference

These files define the APW contract itself.

Examples:

- `AGENTS.md`
- `PROJECT_RULES.md`
- `AGENT_SYSTEM.md`
- `COMMAND_POLICY.md`
- `PROJECT_BOOTSTRAP.md`
- compatibility, validation, CI, migration, and reference docs under `docs/`

If the question is "what is the real rule?" this layer wins.

### 2. Beginner/onboarding

These docs explain APW simply and guide new readers into the system.

Examples:

- `docs/APW_FOR_BEGINNERS.md`
- `docs/APW_VISUAL_OVERVIEW.md`
- `docs/START_HERE.md`
- `docs/QUICK_START.md`

These can be more narrative and more teachable than the governance docs, but they should still align with the canonical contract.

### 3. Journey/examples

These docs help users map ideas to real APW usage.

Examples:

- `docs/IDEA_TO_PROJECT_GUIDE.md`
- `docs/TECH_STACK_SELECTION_GUIDE.md`
- `docs/REAL_WORLD_EXAMPLES.md`

### 4. Operator/workflow

These docs explain how to drive work inside APW.

Examples:

- `docs/WORKFLOW_SELECTION_GUIDE.md`
- `docs/COMMAND_INVOCATION_GUIDE.md`
- `docs/AGENT_PLUS_WORKFLOW_EXAMPLES.md`
- `docs/TOOLING_GUIDE.md`

### 5. Portal wrapper/navigation

These are the Nextra pages under `website/pages/`.

They exist to:

- improve discoverability
- provide a friendlier reading path
- summarize key ideas
- route readers to the right canonical docs

They should not independently define APW governance.

## What should be edited where

Use this rule of thumb:

| If the change is about... | Edit here first |
| --- | --- |
| APW rules, governance, compatibility, validation, bootstrap, CI, or lifecycle | repo-root files or canonical `docs/` files |
| beginner explanation, portal navigation, onboarding flow, or visual framing | `website/pages/` and related portal files |
| beginner guide content that is already canonical in `docs/` | canonical `docs/` file first, then update the portal wrapper if needed |

## Portal content strategy

Portal pages may do one or more of these:

- summarize
- explain
- wrap
- route

Portal pages should usually avoid:

- copying long governance documents verbatim
- becoming the only place where an APW rule is stated
- drifting away from the canonical wording in root/docs files

## Practical editing workflow

When updating APW docs:

1. Decide whether the change is a rule change or a presentation change.
2. If it is a rule change, update the canonical root/docs source first.
3. If the change affects beginner understanding or portal navigation, update the relevant `website/pages/` wrapper next.
4. If a portal page only needs to point more clearly to an existing canonical doc, prefer linking and summarizing over copying.

## Duplication rule

APW does not require zero repetition.

Useful repetition is allowed when it helps:

- onboarding
- examples
- operator clarity
- navigation

Confusing duplication is not allowed when it creates the impression that two pages have equal governance authority.

## Portal page labeling rule

When helpful, portal pages should make one of these roles obvious:

- beginner-friendly guide
- summary/wrapper
- reference router

That helps readers understand whether they are reading the canonical rule or a portal-facing explanation of it.

