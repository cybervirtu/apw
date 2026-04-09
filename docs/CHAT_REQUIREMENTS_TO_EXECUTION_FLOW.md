# CHAT_REQUIREMENTS_TO_EXECUTION_FLOW.md — Chat Requirements to Execution Flow

> [!IMPORTANT]
> Use this when you want the end-to-end APW answer to: "A user gave requirements in chat. What happens next, all the way through execution?"

## What this guide is

This guide unifies APW's requirement flow from chat input to workflow-driven execution.

It exists so operators and maintainers do not have to stitch together the earlier requirement docs manually.

If you only want one APW requirement-flow page first, use this one.

Then open the focused detail docs only when you need deeper policy or workflow guidance.

APW uses one coherent route:

1. requirement-bearing chat arrives
2. APW classifies the chat
3. APW makes the persistence choice explicit
4. APW promotes or buffers the result safely
5. APW decomposes large requirements into modules when needed
6. APW turns active modules into atomic implementation slices
7. APW executes and verifies those slices with the right workflows

## The unified APW flow

Think of the full route like this:

```text
chat requirements
-> classification
-> persistence choice
-> project memory mapping
-> module breakdown when needed
-> atomic implementation planning
-> workflow-driven execution
-> orchestrator or governance sync when official state changes
```

This is not seven separate systems.

It is one APW requirement flow with different decision points.

## Step 1 — Recognize requirement-bearing chat

Treat chat as requirement-bearing when it introduces or changes:

- scope
- user needs
- behavior
- constraints
- decisions
- priorities
- concrete next work
- supporting notes or evidence worth keeping

APW treats chat as the main requirement intake layer.

APW does **not** treat chat as canonical memory by default.

## Step 2 — Classify the chat

Use this classification set:

- `new requirement`
- `requirement change`
- `clarification`
- `decision`
- `task request`
- `exploration only`
- `note / evidence only`

Classification is the first control point.

It tells APW what kind of project input arrived before any persistence or planning happens.

## Step 3 — Choose the persistence outcome

After classification, APW should make one explicit persistence choice:

1. save as notes / evidence only
2. promote into requirements and plan files
3. hand off to orchestrator for official cross-file sync
4. do not save yet

The safe default is still:

- a bounded summary in `.gsd/JOURNAL.md`

APW should state the outcome clearly:

- `Classification: ...`
- `Persistence choice: ...`
- `Saved to: ...`
- `Official project memory changed: yes / no / pending orchestrator`

## Step 4 — Map the result into project memory

Use this mapping:

| Outcome type | Canonical destination |
| :--- | :--- |
| requirement, scope, users, problem framing | `.gsd/SPEC.md` |
| next work items | `.gsd/TODO.md` |
| milestone or phase impact | `.gsd/ROADMAP.md` |
| decisions or tradeoffs | `.gsd/DECISIONS.md` |
| exploratory or evidence-only material | `.gsd/JOURNAL.md` |

Important note:

- `.gsd/STATE.md` is still for current implementation reality, blockers, and readiness
- this requirement flow is about how project input becomes durable planning and execution context
- official requirements should be registered in `.gsd/SPEC.md` with stable IDs so `TODO.md`, `STATE.md`, and verification evidence can trace back to what the user actually asked for

## Step 5 — Break large requirements into modules when needed

If the requirement set is too large to become one clean backlog directly:

- keep the high-level scope in `SPEC.md`
- break the requirement set into coherent modules or workstreams
- put module backlog and follow-up work in `TODO.md`
- put module order and milestone impact in `ROADMAP.md`
- put major decomposition rationale in `DECISIONS.md`

Use `/orchestrate` when:

- one requirement blob is too large for direct execution
- several domains or specialties are involved
- sequencing and sync matter across files

## Step 6 — Turn active modules into atomic slices

Once modules exist, APW should not jump straight into giant implementation passes.

Instead:

- identify the active module
- break it into bounded implementation slices
- keep those actionable slices in `TODO.md`
- keep sequencing and milestone placement visible in `ROADMAP.md`
- keep important planning rationale in `DECISIONS.md`

An atomic slice should be:

- small enough for one direct execution pass
- clear enough to verify
- narrow enough to review
- meaningful enough to move the project forward

## Step 7 — Execute with workflows

APW uses this practical workflow loop:

1. `/orchestrate` when decomposition or coordinated planning is still needed
2. `/create` for one bounded new implementation slice
3. `/debug` for one bounded failing slice or failure surface
4. `/test` to close the current slice with evidence
5. orchestrator or governance sync if official state changed

This is the execution rule:

- do not quietly roll several slices into one vague build step
- decompose first when needed
- execute one slice
- verify that slice
- only then open the next one

## When orchestrator or governance is required

Use orchestrator or governance when:

- more than one canonical `.gsd` file must change
- requirement, roadmap, backlog, and rationale must stay aligned
- a clarification affects several active slices
- a module decomposition must become official
- atomic slice planning must be synchronized across `TODO.md`, `ROADMAP.md`, and `DECISIONS.md`
- implementation or verification changed the official project story

The safe path remains:

1. bounded evidence first
2. deliberate canonical sync second

## Beginner version

If you want the shortest safe rule, use this:

1. recognize that the chat contains project input
2. classify it
3. save it safely if needed
4. break large work into modules
5. break active modules into atomic slices
6. use the right workflow on one slice at a time
7. use orchestrator when official project memory must change

## Operator version

If you are operating APW directly, use this mental model:

- intake is chat-first
- persistence is explicit
- `JOURNAL.md` is the safe buffer
- `SPEC.md`, `TODO.md`, `ROADMAP.md`, and `DECISIONS.md` are deliberate promotion targets
- `/orchestrate` handles large decomposition and coordinated planning
- `/create`, `/debug`, and `/test` operate on one bounded slice at a time
- official cross-file state stays under orchestrator or governance control

## How this guide relates to the earlier docs

Use the earlier Phase A-D docs for focused detail:

- [CHAT_FIRST_REQUIREMENT_INGESTION.md](./CHAT_FIRST_REQUIREMENT_INGESTION.md) for classification
- [CHAT_REQUIREMENT_PERSISTENCE_CHOICES.md](./CHAT_REQUIREMENT_PERSISTENCE_CHOICES.md) for explicit save / promote / sync outcomes
- [REQUIREMENT_MODULE_BREAKDOWN.md](./REQUIREMENT_MODULE_BREAKDOWN.md) for module decomposition
- [ATOMIC_IMPLEMENTATION_PLANNING.md](./ATOMIC_IMPLEMENTATION_PLANNING.md) for slice planning and execution boundaries

Use this guide when you want the whole route in one place.

## The one-sentence rule

In APW, requirements arrive through chat, are classified and persisted deliberately, become structured project memory through modules and slices, and are then executed one bounded workflow step at a time.
