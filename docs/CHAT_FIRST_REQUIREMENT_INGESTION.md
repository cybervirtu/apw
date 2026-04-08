# CHAT_FIRST_REQUIREMENT_INGESTION.md — Chat-First Requirement Ingestion

> [!IMPORTANT]
> Use this when you want the practical APW answer to: "A requirement, change, clarification, or direction arrived in chat. What is it, and where does it go?"

## What this guide is

This guide defines APW's chat-first requirement-ingestion model.

It exists because, in real APW usage, most important project input will arrive through chat:

- initial project details
- new requirements
- scope or behavior changes
- architecture preferences
- implementation directions
- corrections and clarifications

APW treats chat as the main intake layer for project requirements.

APW does **not** treat chat as canonical project memory by default.

If you want the full route from chat intake through persistence, decomposition, atomic planning, and workflow execution, read [CHAT_REQUIREMENTS_TO_EXECUTION_FLOW.md](./CHAT_REQUIREMENTS_TO_EXECUTION_FLOW.md).

## The APW ingestion model

APW uses one simple rule:

1. chat is the main input layer
2. requirement-bearing chat must be classified
3. classification decides the persistence path
4. `JOURNAL.md` is the safe default buffer
5. orchestrator or governance owns official cross-file synchronization

Think of it this way:

- chat is where project information arrives
- classification decides what kind of information it is
- persistence decides what should be saved now
- governance decides what becomes official project memory

## How APW recognizes requirement-bearing chat

Treat chat as requirement-bearing when it does one or more of the following:

- introduces a new user need, goal, or feature
- changes an existing behavior, constraint, or scope boundary
- clarifies who the user is, what problem matters, or what outcome is expected
- settles a tradeoff, rationale, or architectural direction
- requests concrete next work
- provides useful exploration, supporting notes, or evidence that should not be lost

Common examples:

- "Add a vendor approval flow before listings go live."
- "Actually, this should work for admins only in v1."
- "The mobile flow matters more than desktop for the first release."
- "Use Postgres, not SQLite."
- "Break this into the next three implementation slices."
- "These interview notes are only context for now."

## The classification model

Classify requirement-bearing chat into one of these categories first:

| Category | What it means | Default persistence posture |
| :--- | :--- | :--- |
| `new requirement` | new product need, feature, user need, scope, or problem statement | usually `JOURNAL.md` first, then promote deliberately |
| `requirement change` | change to existing scope, behavior, priority, or constraint | usually `JOURNAL.md` first, then orchestrator or governance sync |
| `clarification` | removes ambiguity without necessarily changing scope | may stay in `JOURNAL.md` or promote to canonical memory if now official |
| `decision` | chosen tradeoff, rationale, architecture, policy, or approach | usually candidate for `DECISIONS.md` after deliberate sync |
| `task request` | asks for concrete next work, backlog slices, or implementation actions | usually candidate for `TODO.md` after deliberate sync |
| `exploration only` | idea shaping, options, hypotheses, or open questions | `JOURNAL.md` only by default |
| `note / evidence only` | factual notes, findings, verification, interview notes, or supporting context | `JOURNAL.md` only by default |

If the category is unclear, use the safe APW default:

- capture a bounded summary in `JOURNAL.md`
- escalate to orchestrator or governance only after the project impact is clear

## What is not canonical by default

These do not become official project memory automatically:

- raw chat transcript
- chat reasoning or exploratory back-and-forth
- unpersisted requirement suggestions
- draft directions that were not deliberately saved

They become APW project memory only through deliberate persistence into `JOURNAL.md` or deliberate promotion into canonical `.gsd` files.

## The mapping model

Use this mapping once the chat has been classified:

| Classified outcome | Canonical destination |
| :--- | :--- |
| requirement, scope, users, problem framing | `.gsd/SPEC.md` |
| next work items | `.gsd/TODO.md` |
| milestone or phase impact | `.gsd/ROADMAP.md` |
| decision or tradeoff | `.gsd/DECISIONS.md` |
| exploratory or evidence-only material | `.gsd/JOURNAL.md` |

Important note:

- `STATE.md` is still for current implementation status, blockers, readiness, and session reality
- this ingestion guide focuses on requirement-bearing chat, not general execution-state sync

## The safe persistence path

When requirement-bearing chat arrives, APW should follow this order:

1. recognize that the chat contains project input
2. classify it
3. state the likely destination clearly
4. persist a bounded summary safely
5. promote to canonical files deliberately when the project understanding is official

The safe default is still:

- save the useful result to `.gsd/JOURNAL.md`

That keeps the chat from being lost without pretending it already became canonical memory.

For the explicit save / promote / sync choices that should be shown to the user after this step, read [CHAT_REQUIREMENT_PERSISTENCE_CHOICES.md](./CHAT_REQUIREMENT_PERSISTENCE_CHOICES.md).

## When direct promotion is appropriate

Promotion beyond `JOURNAL.md` becomes appropriate when the chat result is concrete and agreed, such as:

- a confirmed scope change
- a clarified user or problem statement
- an agreed next backlog slice
- a chosen architecture direction
- an accepted milestone implication

Even then, APW still treats promotion as deliberate.

## When orchestrator or governance is required

Use orchestrator or an explicit governance pass when the ingested chat changes official project memory across files or across memory types.

This is especially appropriate when chat affects more than one of:

- `SPEC.md`
- `TODO.md`
- `ROADMAP.md`
- `DECISIONS.md`

It is also the right path when:

- the requirement changes scope and milestone planning together
- the change creates both backlog updates and rationale updates
- a clarification affects multiple active tasks
- one chat session will be handed off to another tool, agent, or teammate

## The beginner-safe rule

If a meaningful project detail arrives in chat and you are unsure what to do:

- classify it first
- save a bounded summary to `JOURNAL.md`
- if the official project story changed, hand off to orchestrator or governance

That is the safe APW path.

## Simple examples

### Example 1 — New requirement

Chat:

```text
The app needs an invite-only beta mode for the first launch.
```

Classification:

- `new requirement`

Likely persistence:

- bounded summary in `JOURNAL.md`
- promote requirement wording into `SPEC.md`
- update `ROADMAP.md` if the launch plan changes

### Example 2 — Change request

Chat:

```text
Do not build public signup yet. Admins should create accounts manually in v1.
```

Classification:

- `requirement change`

Likely persistence:

- bounded summary in `JOURNAL.md`
- update `SPEC.md`
- update `TODO.md` and possibly `ROADMAP.md`
- orchestrator is appropriate if several files must stay aligned

### Example 3 — Decision

Chat:

```text
Use Postgres from the start because reporting and filtering will matter early.
```

Classification:

- `decision`

Likely persistence:

- bounded summary in `JOURNAL.md`
- chosen rationale in `DECISIONS.md`

### Example 4 — Exploration only

Chat:

```text
Compare three onboarding options for first-time sellers, but do not lock one in yet.
```

Classification:

- `exploration only`

Likely persistence:

- `JOURNAL.md` only by default

## The one-sentence rule

Chat is APW's main requirement intake layer.

Classification determines persistence.

`JOURNAL.md` is the safe buffer.

Orchestrator or governance decides what becomes official project memory.

When the classification step is done, APW should still make the persistence result explicit using the four outcomes defined in [CHAT_REQUIREMENT_PERSISTENCE_CHOICES.md](./CHAT_REQUIREMENT_PERSISTENCE_CHOICES.md).
