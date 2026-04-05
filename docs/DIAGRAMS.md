# DIAGRAMS.md — Visual Guide to APW

> [!TIP]
> Read this if you understand APW better with diagrams than with long explanations.

## What this is

This document shows APW visually.

It does not replace the contract docs.
It gives you the mental picture first, so the rest of the framework is easier to understand.

## Why it matters

APW can feel abstract until you can see:

- how `.gsd/` and `.agent/` relate
- where bootstrap and validation fit
- how canonical state stays controlled
- how profiles differ
- how APW works in a monorepo

## When to use it

Use this when:

- you are a visual learner
- you want to explain APW to someone quickly
- you want a mental model before reading the deeper docs

## Diagram 1: The APW Big Picture

```mermaid
flowchart TB
    A[Human Operator] --> B[APW Workspace]
    B --> C[.gsd Memory Layer]
    B --> D[.agent Execution Layer]
    B --> E[scripts Enforcement Layer]

    C --> C1[SPEC.md]
    C --> C2[ROADMAP.md]
    C --> C3[STATE.md]
    C --> C4[TODO.md]
    C --> C5[JOURNAL.md]
    C --> C6[DECISIONS.md]

    D --> D1[agents]
    D --> D2[rules]
    D --> D3[scripts]
    D --> D4[workflows]
    D --> D5[skills]

    E --> E1[bootstrap.sh]
    E --> E2[validate.sh]
    E --> E3[ci-validate.sh]
```

### What it means

- `.gsd/` stores governed project memory
- `.agent/` stores execution support
- `scripts/` creates and enforces the workspace contract

## Diagram 2: Bootstrap to Delivery Flow

```mermaid
flowchart LR
    A[Choose Profile] --> B[Bootstrap]
    B --> C[Validate]
    C --> D[Initialize Canonical .gsd]
    D --> E[Scoped Execution Work]
    E --> F[Append Evidence to JOURNAL.md]
    F --> G[Orchestrator Sync]
    G --> H[Validate Again]
    H --> I[Merge or Roll Out]
    H --> J[CI Enforcement]
```

### What it means

This is the APW lifecycle in its simplest form.

Execution work happens in the middle, but governed state and validation surround it.

## Diagram 3: Controlled Canonical State Sync

```mermaid
flowchart TB
    A[Execution Agent] --> B[Code Changes]
    A --> C[Artifacts]
    A --> D[Append Evidence to JOURNAL.md]

    A -. not by default .-> E[STATE.md]
    A -. not by default .-> F[ROADMAP.md]
    A -. not by default .-> G[TODO.md]
    A -. not by default .-> H[DECISIONS.md]

    I[Orchestrator / Governance Pass] --> E
    I --> F
    I --> G
    I --> H
```

### What it means

Execution agents can move fast, but official summary state is synchronized deliberately.

That is how APW reduces project-memory drift.

## Diagram 4: Profile Comparison

```mermaid
flowchart TB
    A[APW Profiles] --> B[minimal]
    A --> C[base]
    A --> D[advanced]

    B --> B1[lightweight .gsd starter set]
    B --> B2[minimal or empty profile-local .agent content]

    C --> C1[canonical eight-file .gsd contract]
    C --> C2[full .agent namespace directories]
    C --> C3[default for most repos]

    D --> D1[same canonical .gsd contract as base]
    D --> D2[richer vendored agents and workflows]
    D --> D3[stronger execution layer, not heavier root state]
```

### What it means

The profile decision changes how much APW content is preloaded.
It does not change the core APW architecture.

## Diagram 5: Monorepo Pattern

```mermaid
flowchart TB
    A[Monorepo Root] --> B[Shared Governance]
    A --> C[apps/api APW Root]
    A --> D[apps/web APW Root]

    B --> B1[global rules]
    B --> B2[high-level roadmap]
    B --> B3[global architecture]

    C --> C1[apps/api/.gsd]
    C --> C2[apps/api/.agent]

    D --> D1[apps/web/.gsd]
    D --> D2[apps/web/.agent]
```

### What it means

Monorepos should not force one root execution state to describe every app equally well.
APW works best when each meaningful execution root is bootstrapped and validated intentionally.

## Example

Example:

If you are explaining APW to a teammate, show Diagram 1 and Diagram 3 first.

Those two diagrams usually make the model click:

- APW has distinct layers
- canonical state is controlled, not casually rewritten

## What to read next

1. [START_HERE.md](./START_HERE.md)
2. [HOW_APW_WORKS.md](./HOW_APW_WORKS.md)
3. [REAL_WORLD_SCENARIOS.md](./REAL_WORLD_SCENARIOS.md)
