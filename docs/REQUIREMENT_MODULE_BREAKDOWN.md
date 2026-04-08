# REQUIREMENT_MODULE_BREAKDOWN.md — Requirement to Module Decomposition

> [!IMPORTANT]
> Use this when you want the practical APW answer to: "We have a large requirement set. How should APW break it into modules or workstreams so planning and execution stay clean?"

## What this guide is

This guide defines APW's module-breakdown model.

It exists because long requirements often arrive as one large block of text through chat or project memory.

APW should not leave that material as one giant blob.

APW should turn it into a practical module or workstream structure that is easier to:

- understand
- sequence
- plan
- execute
- verify

If you want the full route from requirement chat through modules, slices, and execution, read [CHAT_REQUIREMENTS_TO_EXECUTION_FLOW.md](./CHAT_REQUIREMENTS_TO_EXECUTION_FLOW.md).

## What a module or workstream means in APW

In APW, a module or workstream is:

- a coherent slice of the project
- grouped around one capability, problem area, user flow, or delivery concern
- large enough to matter for planning
- small enough to sequence and execute in bounded slices

A module is **not** just:

- one file
- one ticket
- one random technical layer
- one huge product vision paragraph

Think of a module as a planning-friendly chunk such as:

- authentication and account access
- seller onboarding
- product catalog management
- checkout and payments
- reporting and analytics
- notifications and messaging

## The APW module model

APW uses one simple decomposition rule:

1. keep the high-level project story in `SPEC.md`
2. group long requirements into a small set of coherent modules or workstreams
3. break each module into practical backlog slices in `TODO.md`
4. sequence those modules and slices in `ROADMAP.md`
5. record major decomposition tradeoffs in `DECISIONS.md`

This keeps the model practical:

- `SPEC.md` says what the project is
- `ROADMAP.md` says what comes first and later
- `TODO.md` says what to do next
- `DECISIONS.md` says why the shape was chosen

## How to group long requirements into modules

When a long requirement set arrives, group it by the smallest useful planning boundaries.

Good grouping signals:

- shared user outcome
- shared business capability
- shared workflow or journey
- shared dependency boundary
- shared verification surface
- shared specialty boundary when coordination matters

Good examples:

- "buyer checkout" and "seller payouts" are separate modules because they differ in user flow, risk, and verification
- "reporting dashboard" and "event ingestion" are separate modules because they have different technical surfaces and milestones
- "admin moderation" and "public catalog browsing" are separate modules because they serve different actors and readiness goals

Avoid weak grouping:

- splitting only by folder names when the user-facing problem is one flow
- mixing several user journeys into one "platform" module
- creating dozens of tiny modules that are really just TODO items

## Practical decomposition rules

Use this rule of thumb:

- if it is still product shape or scope, it belongs in `SPEC.md`
- if it is a meaningful planning chunk, it can become a module or workstream
- if it is already concrete next work, it belongs in `TODO.md`

Keep module counts practical:

- prefer a small set of meaningful modules
- avoid academic taxonomy
- avoid one mega-module called "core app"

For most projects, the first useful breakdown is often:

- 3 to 7 modules

That is usually enough to make the project understandable without over-fragmenting it.

## Memory impact

Use this mapping for module decomposition:

| Outcome | Where it belongs |
| :--- | :--- |
| high-level project scope and module-facing product shape | `.gsd/SPEC.md` |
| module backlog, implementation slices, and follow-up work | `.gsd/TODO.md` |
| module sequencing, milestones, and dependency order | `.gsd/ROADMAP.md` |
| major tradeoffs behind the decomposition | `.gsd/DECISIONS.md` |

Important boundary:

- `SPEC.md` should keep the high-level module map and scope story
- `TODO.md` should carry the actionable backlog under those modules
- `ROADMAP.md` should carry the sequencing and milestone implications
- `DECISIONS.md` should carry the "why this split" rationale when it matters

## What should stay out of each file

Avoid this drift:

- do not turn `SPEC.md` into a giant checklist
- do not turn `TODO.md` into vague product prose
- do not turn `ROADMAP.md` into a duplicate of the backlog
- do not use `DECISIONS.md` for every minor grouping choice

## When `/orchestrate` should be used

`/orchestrate` is the practical APW command for module decomposition when:

- the requirement set is large
- the work crosses several domains or specialties
- one requirement blob must become several bounded workstreams
- one TODO item clearly needs decomposition before execution
- coordinated planning and later sync are required

Use `/orchestrate` to produce:

- the proposed module list
- the dependency and sequencing view
- the first backlog slices per module
- the specialist or workflow assignment pattern when useful
- the sync recommendation for `SPEC.md`, `TODO.md`, `ROADMAP.md`, and `DECISIONS.md`

## Expected output of module decomposition

A good APW module breakdown should give you:

- a short module list
- one-line purpose for each module
- major dependencies between modules
- the likely earliest module to start
- the first implementation slice for each active module

If the output is too abstract to create `TODO.md` slices, it is not decomposed enough.

If the output is just a long checklist with no grouping, it is not modular enough.

## Example

Large requirement set:

```text
We need user signup, team invites, role-based access, billing, usage tracking, an analytics dashboard, support chat, and admin moderation.
```

Possible APW module breakdown:

- access and identity
- team and permissions
- billing and subscriptions
- usage tracking and analytics
- support and moderation

Memory impact:

- `SPEC.md`: high-level capability map and scope boundaries
- `ROADMAP.md`: which modules come first and which depend on others
- `TODO.md`: first slices inside access, billing, and analytics
- `DECISIONS.md`: why analytics was split from support and why billing starts after access

## Beginner-safe rule

If the requirement set feels too large to turn directly into one backlog:

- do not write one giant `TODO.md` blob
- use `/orchestrate` to decompose it into modules or workstreams
- keep the high-level scope in `SPEC.md`
- move slices into `TODO.md`
- move sequencing into `ROADMAP.md`
- log important decomposition rationale in `DECISIONS.md`

## The one-sentence rule

APW turns long requirements into a small set of coherent modules, then turns those modules into sequenced roadmap items and practical TODO slices.
