# USER_ONBOARDING_VALIDATION_PLAN.md — Real User Onboarding Validation Plan

> [!IMPORTANT]
> Use this plan when APW is ready to be tested with real people and the goal is to learn where onboarding is clear, confusing, or blocking in practice.

## What this is

This is the practical APW plan for validating onboarding with real users.

It is meant to help maintainers run lightweight, repeatable sessions that answer a simple question:

"Can someone new to APW understand where to start, make reasonable choices, and keep moving without getting lost?"

## Why onboarding validation matters now

APW already has:

- strong governance and framework contracts
- operator and workflow guides
- beginner-friendly docs
- examples
- a visual docs portal
- onboarding helpers and routing pages
- cleaner navigation patterns

That changes the main risk.

The next major risk is not "APW has no documentation."
The next risk is "APW may still confuse real people even though the docs are good."

Real user onboarding validation matters before broader rollout because it helps APW learn:

- which pages people actually start from
- whether users understand what APW is in plain language
- whether profile and stack choices feel obvious or intimidating
- where users confuse guidance, governance, and execution
- where navigation breaks down when people are under real task pressure

## What this phase is trying to prove

This phase should show whether APW onboarding is usable enough for broader adoption.

In practical terms, APW should be able to show that real users can:

- find a sensible starting page
- explain APW in simple terms
- choose a likely profile with reasonable confidence
- understand the idea-to-project journey
- understand the bootstrap -> validate -> start flow
- understand where command and workflow docs fit
- tell the difference between orchestrator coordination and execution work
- recover when they are unsure instead of stalling completely

## What this phase is not

This is not a redesign phase.

Do not use this process to:

- invent new APW features
- rewrite core governance based on one user reaction
- turn onboarding validation into a heavyweight research program
- optimize for academic completeness over practical learning

The goal is to find real confusion early, fix the highest-value issues, and rerun the test.

## Current onboarding validation gaps

APW has strong onboarding materials, but the following gaps still exist:

1. There is no shared maintainer playbook for running real onboarding sessions.
2. There is no standard scenario set for comparing different users consistently.
3. There is no shared definition of onboarding success beyond "the docs seem good."
4. There is no standard feedback capture template for confusion, hesitation, skipped pages, or wrong turns.
5. There is no lightweight persona set for making sure APW is tested with more than one kind of user.
6. There is no explicit loop for turning onboarding evidence into prioritized APW improvements.

This validation plan closes those gaps.

## Who should be tested

APW should be tested with a small but mixed set of users.

Recommended personas:

- non-technical founder or idea-stage user
- developer who is new to APW
- solo builder
- team lead or project owner
- user migrating an existing repo into APW

For the persona definitions and likely confusion points, use [USER_PERSONAS.md](./USER_PERSONAS.md).

## What should be tested

Use real onboarding tasks that reflect how people actually arrive in APW.

At minimum, test whether users can:

- find the correct starting page in the repo or portal
- explain what APW is after a short reading pass
- choose a likely profile
- choose a likely stack direction
- understand the idea-to-project flow
- understand when to use command and workflow guides
- understand orchestrator vs execution agent responsibilities
- understand bootstrap, validate, and start order
- understand that `JOURNAL.md` is evidence, not canonical ownership
- figure out what to do next when they feel stuck

Use the concrete tasks in [ONBOARDING_TEST_SCENARIOS.md](./ONBOARDING_TEST_SCENARIOS.md).

## Recommended session format

Keep sessions practical.

Use this baseline format unless there is a strong reason to change it:

- 30 to 45 minutes total
- 1 participant
- 1 facilitator
- optional 1 observer or note-taker
- 4 to 6 scenarios per session
- screen share or in-person screen observation
- think-aloud encouraged

This is enough to expose major confusion without becoming a long workshop.

## Minimum setup before a session

Prepare these things:

- the current APW repo or docs portal
- the scenario list
- the feedback template
- a note-taking document
- a timer

Recommended environment:

- use a clean browser tab if testing the portal
- use a clean repo checkout or a neutral file browser if testing Markdown docs
- avoid pre-opening the "correct" pages for the participant

## How to run a session

### 1. Frame the session simply

Tell the participant:

- this is a test of APW onboarding, not a test of them
- confusion is useful evidence
- they should say what they are thinking out loud when possible

### 2. Start from a realistic entry point

Use one of these entry points:

- APW repo `README.md`
- docs portal home page
- a team-maintained APW adoption link set

Do not start from a deep page unless the scenario is intentionally testing recovery or team adoption.

### 3. Give one scenario at a time

Read the scenario prompt exactly as written.

Do not explain APW terms unless the scenario specifically allows help.

### 4. Observe before rescuing

Watch for:

- where the user clicks or reads first
- what they skip
- what language they use to explain APW back to you
- where confidence drops
- where they say "I don't know what to do next"

Only rescue when:

- the participant is fully blocked for too long
- the session would otherwise stop
- the goal is to test recovery after a hint

### 5. Capture evidence during the task

Record:

- pages visited
- time to first useful page
- wrong turns
- hesitation
- direct quotes when possible
- whether the participant completed the task

### 6. Debrief while the experience is fresh

Use [USER_FEEDBACK_TEMPLATE.md](./USER_FEEDBACK_TEMPLATE.md) immediately after the session.

Ask what felt:

- easy
- confusing
- unnecessary
- trustworthy
- intimidating

## Facilitator rules

Keep facilitation light and consistent.

Do:

- read prompts clearly
- ask neutral follow-up questions
- let the participant drive
- note exact confusion language
- note when confidence is high or low

Do not:

- coach the participant into the right answer too early
- defend APW while observing the session
- turn the session into a product pitch
- explain away confusion instead of recording it

## Success criteria

APW onboarding is working well when most target users can do the following with reasonable confidence.

### Core success signals

- The user can explain what APW is in simple terms.
- The user can identify a sensible next page without guessing wildly.
- The user can choose a likely profile with a clear reason.
- The user can describe the basic project journey from idea to working repo.
- The user understands bootstrap, validate, and start order.
- The user understands where command and workflow guides fit.
- The user does not confuse `JOURNAL.md` evidence with canonical state ownership.
- The user understands that APW helps structure work, not just generate code.

### Warning signals

- The user bounces between pages without building confidence.
- The user cannot tell whether APW is a docs set, a template, a workflow system, or all three.
- The user skips key routing pages because they look optional or unclear.
- The user thinks `advanced` is the safe default simply because it sounds more complete.
- The user believes any execution session can rewrite official state freely.
- The user cannot tell what to do after reading one onboarding page.

## How many users to test

Keep the first round small and real.

Recommended first pass:

- 5 to 8 users total
- at least 1 user from each primary persona if possible
- at least 2 users who are genuinely new to APW

That is enough to surface repeated confusion patterns without slowing the team down.

## Recommended test rounds

Use short rounds instead of one large study.

### Round 1: baseline confusion check

Goal:

- confirm whether first-time users can enter APW at all

### Round 2: targeted retest

Goal:

- retest the biggest issues found in round 1 after documentation or navigation updates

### Round 3: broader rollout confidence check

Goal:

- confirm APW is stable enough for wider onboarding across teams or downstream repos

## How to classify findings

After each session, classify findings by both severity and frequency.

### Severity

- `critical`: user cannot continue without facilitator rescue
- `high`: user completes the task, but only after major confusion or wrong turns
- `medium`: user completes the task with noticeable hesitation or partial misunderstanding
- `low`: user succeeds, but the experience is rougher than it should be

### Frequency

- `repeated`: seen in multiple users
- `isolated`: seen in one user so far

Repeated high-severity confusion should be treated first.

## What evidence to capture

Capture enough evidence to improve APW later.

Useful evidence includes:

- which page the user started from
- which pages they visited next
- which pages they skipped
- where they got stuck
- the language they used to describe APW
- whether portal navigation helped
- whether examples helped
- whether profile and stack selection felt easy or confusing
- whether workflow guidance felt clear
- what they expected that APW did not make obvious

## How to turn evidence into improvement

After each test round:

1. group findings by theme
2. identify repeated blockers
3. decide whether the issue is navigation, wording, sequencing, expectation-setting, or missing guidance
4. make the smallest high-value doc or portal fix first
5. rerun the affected scenarios with fresh users

Do not overreact to one comment when the broader pattern says otherwise.

## Suggested maintainer workflow

Use this lightweight loop:

1. choose 4 to 6 scenarios
2. run 1 session
3. fill out the feedback template
4. log the top 3 issues
5. run 2 to 4 more sessions
6. group repeated issues
7. fix the highest-value onboarding problems
8. retest

## Recommended outputs after a test round

Maintain a simple summary that includes:

- personas tested
- scenarios used
- top confusion points
- top success signals
- fixes chosen
- scenarios to rerun

This can live in team notes, a project board, or a future APW validation journal if the team wants one.

## Ready-for-broader-rollout checklist

APW is in a healthier place for broader onboarding when:

- users can consistently find a sensible starting point
- users can explain APW without major distortion
- profile selection is usually correct or at least reasonable
- the bootstrap -> validate -> start sequence is usually understood
- users know where to go next when unsure
- repeated critical confusion has been addressed and retested

## Related docs

- [ONBOARDING_TEST_SCENARIOS.md](./ONBOARDING_TEST_SCENARIOS.md)
- [USER_FEEDBACK_TEMPLATE.md](./USER_FEEDBACK_TEMPLATE.md)
- [USER_PERSONAS.md](./USER_PERSONAS.md)
- [TEAM_ADOPTION_GUIDE.md](./TEAM_ADOPTION_GUIDE.md)
- [PILOT_ADOPTION_PLAN.md](./PILOT_ADOPTION_PLAN.md)
