# ONBOARDING_TEST_SCENARIOS.md — Real User Onboarding Test Scenarios

> [!TIP]
> Use these scenarios during real APW onboarding sessions. Pick the scenarios that match the participant persona instead of forcing every user through every task.

## How to use this file

Each scenario is designed to be practical, observable, and easy to run.

For each scenario:

- read the prompt exactly
- let the participant work without heavy coaching
- record pages visited, hesitation, confidence, and confusion
- use [USER_FEEDBACK_TEMPLATE.md](./USER_FEEDBACK_TEMPLATE.md) after the scenario or at the end of the session

Recommended session size:

- 4 to 6 scenarios per participant
- 30 to 45 minutes total

## Scenario 1 — First-time orientation

### Best for

- non-technical founder
- developer new to APW
- solo builder

### What the participant is told

"You are opening APW for the first time. Figure out where you would start."

### What they should try to do

- find the first page they would trust
- explain why they chose it
- identify what they would read next

### Success looks like

- the participant finds a sensible entry page such as `README.md`, `Start Here`, `What Is APW?`, or `Help Me Get Started`
- the participant can explain why that page feels like the right starting point
- the participant can name a likely next page instead of stopping after one read

### The facilitator should observe

- whether the participant uses the repo or portal naturally
- whether homepage and navigation labels are clear
- whether the user can distinguish beginner pages from reference material
- whether the participant gets stuck choosing between too many plausible starting points

## Scenario 2 — Explain APW in simple language

### Best for

- non-technical founder
- developer new to APW
- team lead

### What the participant is told

"Spend a few minutes reading enough APW material to explain what APW is to a teammate in simple terms."

### What they should try to do

- read only what they think they need
- explain APW back in plain language
- say what APW seems to help with

### Success looks like

- the participant gives a simple explanation that includes structure, guidance, or project organization
- the participant does not reduce APW to only a prompt pack or only a code generator
- the participant can name at least one reason APW exists

### The facilitator should observe

- which page the participant uses to form their mental model
- whether the explanation sounds confident or fragile
- whether the participant confuses governance, execution, and docs navigation

## Scenario 3 — Choose a profile for a simple portfolio site

### Best for

- non-technical founder
- solo builder
- developer new to APW

### What the participant is told

"You have an idea for a small portfolio site. Figure out how you would start with APW and choose the profile that seems most likely."

### What they should try to do

- identify a likely APW profile
- identify a likely stack direction
- explain which page helped them decide

### Success looks like

- the participant chooses `minimal` or `base` with a reasonable explanation
- the participant avoids overcomplicating the project by default
- the participant can identify the next APW page they would use after making the choice

### The facilitator should observe

- whether the participant finds profile and stack guidance easily
- whether the user defaults to `advanced` because it sounds more complete
- whether examples help confidence

## Scenario 4 — Choose a path for an AI support assistant

### Best for

- developer new to APW
- solo builder
- team lead

### What the participant is told

"You want to build an AI support assistant. Choose a likely APW path and explain how you would get started."

### What they should try to do

- identify a likely project type
- choose a likely profile
- describe the first few APW docs or steps they would follow

### Success looks like

- the participant finds a reasonable project type and profile
- the participant can describe a sensible onboarding path through APW
- the participant understands that APW is helping structure the project, not define the product for them

### The facilitator should observe

- whether the participant relies on examples, project-type guidance, or profile docs
- whether the user feels confident choosing a path for an AI-flavored project
- whether APW language feels accessible or too framework-heavy

## Scenario 5 — Bootstrap, validate, and start safely

### Best for

- developer new to APW
- solo builder
- team lead

### What the participant is told

"You are ready to start a real project. Show how you think APW wants you to begin, from setup to first work."

### What they should try to do

- identify the bootstrap step
- identify the validation step
- explain what should happen before routine implementation starts

### Success looks like

- the participant understands the order: choose profile -> bootstrap -> validate -> start from `AGENTS.md` -> initialize `.gsd` -> begin work
- the participant does not jump straight into coding or workflow commands
- the participant can point to the page or doc that made this clear

### The facilitator should observe

- whether the participant understands the difference between starting APW and operating APW
- whether the user thinks validation is optional
- whether quick start and workflow docs are sequenced clearly enough

## Scenario 6 — Existing repo adoption

### Best for

- team lead
- project owner
- user migrating an existing repo into APW

### What the participant is told

"You already have an active repository and want to understand how APW fits without disrupting ongoing development."

### What they should try to do

- find the right adoption or migration guidance
- explain the safest path they would follow
- identify whether this is different from a brand-new repo flow

### Success looks like

- the participant finds migration or adoption guidance quickly
- the participant understands that existing-repo adoption should not follow the brand-new project path blindly
- the participant can identify one or two follow-up docs they would use next

### The facilitator should observe

- whether migration guidance is discoverable enough
- whether the user feels APW can fit an existing repo without a forced reset
- whether portal routing helps or hides the canonical docs they need

## Scenario 7 — Choose the right command or workflow when debugging

### Best for

- developer new to APW
- solo builder
- team lead

### What the participant is told

"You are debugging a problem in an APW-managed repo. Figure out where you would go to understand which command or workflow to use."

### What they should try to do

- find the workflow and command guidance
- explain which docs they would read first
- describe how they would decide what to run

### Success looks like

- the participant finds command and workflow docs without wandering through unrelated reference material
- the participant understands that APW has operator guidance instead of expecting vague prompting
- the participant can explain where workflow guidance fits in the larger APW journey

### The facilitator should observe

- whether "commands" and "workflows" feel discoverable to new users
- whether the participant knows this belongs after setup and validation
- whether the user expects a single cheat sheet and becomes lost in doc layering

## Scenario 8 — Understand orchestrator vs execution agent

### Best for

- developer new to APW
- solo builder
- team lead

### What the participant is told

"You want to understand how APW handles project state. Figure out the difference between orchestrator work and execution work."

### What they should try to do

- explain what the orchestrator is responsible for
- explain what execution agents are responsible for
- explain what belongs in `JOURNAL.md` versus canonical state files

### Success looks like

- the participant understands that execution work may add bounded evidence to `JOURNAL.md`
- the participant understands that canonical state updates are more controlled
- the participant does not claim that all agents should rewrite official project state freely

### The facilitator should observe

- whether APW's state model feels clear or intimidating
- whether the participant understands the difference between evidence and canonical ownership
- whether the relevant docs are easy to find from onboarding pages

## Scenario 9 — Recover when stuck

### Best for

- all personas

### What the participant is told

"You are unsure what to do next in APW. Show where you would go to recover and keep moving."

### What they should try to do

- find a routing or recovery page
- explain how they would decide the next step
- show whether APW gives them a clear fallback path

### Success looks like

- the participant finds a routing page such as `Start Here`, `Help Me Get Started`, or a clear README path
- the participant can re-enter the onboarding flow instead of freezing
- the participant can identify a likely next action

### The facilitator should observe

- whether APW supports recovery well after partial confusion
- whether the participant trusts the routing pages
- whether the portal and canonical docs feel connected enough

## Suggested scenario packs by persona

### Non-technical founder

- Scenario 1
- Scenario 2
- Scenario 3
- Scenario 9

### Developer new to APW

- Scenario 1
- Scenario 4
- Scenario 5
- Scenario 7
- Scenario 8

### Solo builder

- Scenario 2
- Scenario 3
- Scenario 5
- Scenario 7
- Scenario 8

### Team lead or project owner

- Scenario 2
- Scenario 5
- Scenario 6
- Scenario 8
- Scenario 9

### Existing repo migration user

- Scenario 1
- Scenario 6
- Scenario 7
- Scenario 9

## Facilitator note

If a participant struggles badly in multiple scenarios, stop early and debrief instead of forcing all remaining tasks.

The goal is to learn where APW onboarding breaks, not to exhaust the participant.
