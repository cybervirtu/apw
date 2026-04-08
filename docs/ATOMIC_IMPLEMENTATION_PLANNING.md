# ATOMIC_IMPLEMENTATION_PLANNING.md — Module to Atomic Implementation Planning

> [!IMPORTANT]
> Use this when you want the practical APW answer to: "We already have modules or workstreams. How should APW turn them into small implementation slices that are safe to execute and easy to review?"

## What this guide is

This guide defines APW's atomic implementation planning model.

It exists because module breakdown is not the end of planning.

After a project has coherent modules or workstreams, APW still needs a disciplined way to turn that planning into:

- small execution slices
- clear sequence
- evidence-backed completion
- safe workflow handoff

If you want the full route from requirement chat through classification, persistence, modules, slices, and execution, read [CHAT_REQUIREMENTS_TO_EXECUTION_FLOW.md](./CHAT_REQUIREMENTS_TO_EXECUTION_FLOW.md).

Without that step, teams often fall back into giant vague plans or giant vague prompts.

## What an atomic implementation slice means in APW

In APW, an atomic implementation slice is:

- one bounded unit of execution
- small enough for one direct implementation pass
- clear enough that `/create`, `/debug`, or `/test` can act on it without guessing
- narrow enough to review and verify cleanly
- large enough to produce one meaningful project step forward

An atomic slice is **not**:

- an entire module
- a whole milestone
- a cross-project initiative
- a giant "build everything for auth" instruction

Think in slices such as:

- add signup form validation
- implement password reset API endpoint
- add checkout tax calculation regression test
- fix dashboard query timeout in the reporting service

## The APW atomic planning model

APW uses one simple rule after module breakdown:

1. keep the high-level scope in `SPEC.md`
2. keep module or workstream planning visible at the roadmap level
3. turn the active module into small atomic implementation slices
4. store those actionable slices in `TODO.md`
5. place sequencing and milestone position in `ROADMAP.md`
6. record major planning rationale or tradeoffs in `DECISIONS.md`

This keeps the project memory understandable:

- `SPEC.md` explains what the project is trying to achieve
- `TODO.md` carries the next executable slices
- `ROADMAP.md` shows when those slices matter in the larger sequence
- `DECISIONS.md` records why the split or order was chosen

## How to break a module into atomic slices

Break the module at the smallest useful execution boundary.

Good slicing signals:

- one user-visible behavior
- one interface or contract change
- one bounded backend or frontend change
- one verification surface
- one bug or failure surface
- one clear acceptance target

A good atomic slice should usually have:

- a clear starting context
- a clear intended result
- an obvious verification method
- limited dependency spread
- a realistic chance of completion in one focused execution pass

Avoid weak slices:

- "finish auth"
- "build dashboard"
- "clean up the platform"
- "handle everything related to billing"

If a slice still needs several specialties, several sub-plans, or many independent verifications before anyone can begin, it is probably not atomic yet.

## Storage and sequencing model

Use this mapping for atomic planning:

| Outcome | Where it belongs |
| :--- | :--- |
| high-level project scope | `.gsd/SPEC.md` |
| actionable atomic slices and near-term work | `.gsd/TODO.md` |
| sequence, milestone placement, and phase order | `.gsd/ROADMAP.md` |
| important planning rationale or tradeoffs | `.gsd/DECISIONS.md` |

Practical rule:

- `TODO.md` should name the current and near-next slices clearly
- `ROADMAP.md` should explain which module or milestone those slices serve
- `DECISIONS.md` should explain important sequencing or boundary choices when they matter

## Workflow execution model

APW uses this execution loop:

1. `/orchestrate` prepares large work into modules and first atomic slices
2. `/create` executes one slice at a time when the work is new implementation
3. `/debug` repairs one failing slice or one bounded failure surface at a time
4. `/test` closes the slice with verification evidence
5. orchestrator or governance sync updates canonical state deliberately when official project memory changed

This is the practical loop:

- decompose large work first
- execute one slice
- verify that slice
- only then open the next slice

## When `/orchestrate` should be used

Use `/orchestrate` when:

- a module is still too large to execute directly
- one TODO item clearly hides several implementation slices
- sequence matters across frontend, backend, testing, or ops
- you need explicit first slices, dependencies, or ownership
- official sync across `TODO.md`, `ROADMAP.md`, and `DECISIONS.md` will likely be required

Use `/orchestrate` to produce:

- the module-to-slice breakdown
- the first executable slice
- likely follow-up slices
- dependency order
- milestone impact
- the sync recommendation for canonical files

## How `/create` should be used

Use `/create` when one atomic slice is already clear.

`/create` should:

- execute one slice at a time
- stay inside the current slice boundary
- report what changed
- report what still remains
- leave evidence for later sync

If `/create` starts to feel like a giant multi-domain plan, APW should stop and return to `/orchestrate`.

## How `/test` and `/debug` close the loop

Use `/test` to prove the current slice works.

Use `/debug` when the slice fails, regresses, or reveals a bounded defect.

The loop is:

- `/create` when building the slice
- `/debug` when the slice fails
- `/test` to verify the slice

That loop keeps execution evidence-first and prevents silent drift into the next slice before the current one is understood.

## Memory and governance boundaries

Atomic planning does **not** weaken APW's governance model.

Important rules still apply:

- execution output is not canonical by default
- bounded evidence should land in `.gsd/JOURNAL.md`
- official updates to `TODO.md`, `ROADMAP.md`, and `DECISIONS.md` stay deliberate
- orchestrator or governance owns cross-file synchronization when official project memory changes

## Example

Module:

```text
Seller onboarding
```

Bad slice:

```text
Build seller onboarding
```

Better APW slices:

- create seller onboarding entry route
- add company details form and validation
- persist onboarding draft server-side
- verify onboarding happy path with regression coverage

Memory impact:

- `SPEC.md`: seller onboarding remains a high-level module in project scope
- `TODO.md`: the four slices appear as actionable work
- `ROADMAP.md`: onboarding is sequenced before payouts activation
- `DECISIONS.md`: rationale explains why draft persistence was split before payouts

## Beginner-safe rule

If a module still feels too big to hand directly to `/create`:

- do not force one giant build step
- use `/orchestrate` to split it first
- put the atomic slices in `TODO.md`
- verify each slice before moving on

## The one-sentence rule

APW turns modules into small, verifiable implementation slices, executes one slice at a time, and uses orchestrator sync when official project memory must change.
