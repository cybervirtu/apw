# USER_PERSONAS.md — User Personas For Onboarding Validation

> [!NOTE]
> These personas are lightweight testing tools. They are not rigid categories and they do not replace real users.

## Why this file exists

APW onboarding should not only be tested with one kind of user.

These personas help maintainers choose realistic participants and scenario packs so validation is based on varied onboarding behavior, not a single preferred path.

## How to use these personas

Use these personas to:

- recruit a balanced first test round
- choose the right scenarios
- predict likely confusion points
- compare how different users experience the same APW docs

Do not treat them as exact user profiles.

They are practical guides for testing.

## Persona 1 — Non-technical founder or idea-stage user

### Typical background

- has a product idea
- may be comfortable with tools, but not with deep engineering terminology
- wants to know whether APW can help them start cleanly

### What this user is trying to do

- understand what APW is
- find a safe starting point
- avoid choosing the wrong setup

### Likely strengths

- clear product intent
- strong motivation to find a simple path

### Likely confusion points

- APW terminology may feel framework-heavy
- profile and stack language may blur together
- workflow and agent details may feel too deep too early

### Good scenarios

- Scenario 1
- Scenario 2
- Scenario 3
- Scenario 9

## Persona 2 — Developer new to APW

### Typical background

- comfortable reading docs and code
- new to APW concepts, naming, and operating model
- wants to get productive quickly

### What this user is trying to do

- understand the APW mental model fast
- choose a profile and setup path
- learn where commands and workflows live

### Likely strengths

- can move through docs quickly
- can tolerate some implementation detail

### Likely confusion points

- may skip beginner routing pages and jump into deeper docs too soon
- may assume they can start coding before validation
- may underestimate the orchestrator vs execution boundary

### Good scenarios

- Scenario 1
- Scenario 4
- Scenario 5
- Scenario 7
- Scenario 8

## Persona 3 — Solo builder

### Typical background

- both product owner and implementer
- wants enough structure to stay organized without slowing down
- often deciding alone and moving quickly

### What this user is trying to do

- choose a practical APW path fast
- understand which docs matter now versus later
- keep setup light but safe

### Likely strengths

- comfortable making decisions
- motivated to find the shortest useful path

### Likely confusion points

- may over-optimize for speed and skip important setup
- may choose too much or too little structure
- may not naturally separate evidence logging from canonical state

### Good scenarios

- Scenario 2
- Scenario 3
- Scenario 5
- Scenario 7
- Scenario 8

## Persona 4 — Team lead or project owner

### Typical background

- responsible for process clarity and team consistency
- cares about adoption risk, rollout shape, and maintainability
- may not be the daily implementer

### What this user is trying to do

- understand whether APW is safe for a team
- find adoption and migration guidance
- judge whether the framework is understandable enough for others

### Likely strengths

- thinks about coordination and repeatability
- notices missing rollout structure quickly

### Likely confusion points

- may need stronger pointers to team adoption and validation materials
- may wonder how APW changes existing team habits
- may want evidence that onboarding works for others, not just for them

### Good scenarios

- Scenario 2
- Scenario 5
- Scenario 6
- Scenario 8
- Scenario 9

## Persona 5 — Existing repo migration user

### Typical background

- already has a repository with history, habits, and active work
- wants APW to fit reality instead of forcing a restart
- may be skeptical of framework overhead

### What this user is trying to do

- find the adoption path for an active repo
- understand how APW changes current workflows
- judge rollout risk

### Likely strengths

- concrete sense of real project constraints
- quick to notice guidance that feels unrealistic

### Likely confusion points

- may assume APW is mostly for greenfield repos
- may not know whether quick start or migration docs come first
- may struggle to locate the exact adoption path from beginner-facing pages

### Good scenarios

- Scenario 1
- Scenario 6
- Scenario 7
- Scenario 9

## Suggested first-round coverage

For the first validation round, try to cover:

- 1 non-technical founder or equivalent
- 2 users who are new to APW but comfortable with software work
- 1 solo builder
- 1 team lead or project owner
- 1 existing repo adopter if possible

This is enough to surface cross-persona confusion without turning validation into a large recruiting effort.
