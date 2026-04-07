# AGENT_PLUS_WORKFLOW_EXAMPLES.md — Real Agent + Workflow Invocation Examples

> [!TIP]
> Read this when you want to see the actual APW operator pattern in plain language.

## The pattern

Use this structure:

```text
@agent /workflow task description
```

Why this matters:

- the **agent** gives you the right domain expertise
- the **workflow** gives you the right operating pattern
- the **task description** tells the agent what bounded work to perform

For downstream repos bootstrapped with `base` or `advanced`, the core workflows in these examples are expected to exist directly under `.agent/workflows/`.

## Example 1: Re-orient after time away

```text
@orchestrator /status summarize current state and the next best action after five days away
```

### Why this combination is correct

The orchestrator is the best choice when you need a high-level briefing without jumping straight into code.

### What it should read

- `AGENTS.md`
- `.gsd/STATE.md`
- `.gsd/ROADMAP.md`
- `.gsd/TODO.md`
- recent `.gsd/JOURNAL.md` entries if needed

### What it should produce

- a short briefing
- current milestone
- blockers
- recommended next command
- optional bounded summary in `.gsd/JOURNAL.md` when the orientation should be preserved

### Orchestrator sync after

Usually no.

This is primarily a read-and-brief step unless it discovers that canonical state itself is stale.

If it reveals real drift, keep evidence first and then use orchestrator for official sync.

## Example 2: Explore options before implementation

```text
@product-manager /brainstorm compare three onboarding flows for first-time sellers
```

### Why this combination is correct

The product manager is strong at tradeoffs and user value, and `/brainstorm` keeps the session in option-exploration mode rather than premature coding.

### What it should read

- `AGENTS.md`
- current product constraints from `.gsd/SPEC.md`
- `.gsd/ROADMAP.md` or `.gsd/TODO.md` if the work already exists in scope

### What it should produce

- multiple approaches
- pros and cons
- a recommendation
- a clear persistence recommendation

### Orchestrator sync after

Not by default.

The safe default is to capture a bounded summary in `.gsd/JOURNAL.md`.

Use orchestrator when the chosen direction should become official project memory in `SPEC.md`, `TODO.md`, `ROADMAP.md`, or `DECISIONS.md`.

## Example 3: Build a new backend feature

```text
@backend-specialist /create implement password reset API from TODO.md
```

### Why this combination is correct

The backend specialist owns API and server-side work, and `/create` is the right workflow once the feature is already planned.

### What it should read

- `AGENTS.md`
- `.gsd/STATE.md`
- `.gsd/TODO.md`
- `.gsd/SPEC.md`
- `.gsd/ARCHITECTURE.md`
- `.agent/rules/PROJECT.md` when present

### What it should produce

- the endpoint or service implementation
- related tests or verification notes
- bounded evidence in `.gsd/JOURNAL.md`
- promotion candidates for `TODO.md`, `STATE.md`, `ROADMAP.md`, or `DECISIONS.md` when official project memory changed

### Orchestrator sync after

Yes if the completed feature changes official status or backlog state.

## Example 4: Improve existing code without new scope

```text
@code-archaeologist /enhance simplify invoice calculation logic without changing behavior
```

### Why this combination is correct

The code archaeologist is ideal for existing messy code, and `/enhance` is the right workflow for bounded improvement instead of net-new scope.

### What it should read

- `AGENTS.md`
- `.gsd/STATE.md`
- `.gsd/TODO.md`
- the existing implementation
- current tests

### What it should produce

- cleaner code
- preserved behavior
- updated tests or proof
- bounded evidence in `.gsd/JOURNAL.md`

### Orchestrator sync after

Only if the cleanup changes blockers, next steps, or design rationale.

## Example 5: Fix a scoped bug

```text
@frontend-specialist /debug login button throws 500 on click
```

### Why this combination is correct

The frontend specialist is the right domain owner when the visible symptom starts in the UI, and `/debug` forces a root-cause workflow.

### What it should read

- `AGENTS.md`
- `.gsd/STATE.md`
- `.gsd/TODO.md`
- reproduction steps
- logs, screenshots, or network traces

### What it should produce

- root cause
- targeted fix
- verification proof
- ideally a regression test or explicit follow-up
- bounded debugging evidence in `.gsd/JOURNAL.md`

### Orchestrator sync after

Yes if the bug fix clears a blocker or changes release readiness.

## Example 6: Verify an important flow

```text
@qa-automation-engineer /test verify checkout integration flow
```

### Why this combination is correct

The QA automation engineer is a strong fit when the work needs system-level verification rather than just a small unit test patch.

### What it should read

- `AGENTS.md`
- `.gsd/SPEC.md`
- `.gsd/TODO.md`
- changed checkout code
- existing tests and test runner configuration

### What it should produce

- test coverage for the flow
- execution results
- clear pass/fail evidence
- bounded verification evidence in `.gsd/JOURNAL.md`

### Orchestrator sync after

Yes if the passing verification is what allows the task or milestone to move forward officially.

## Example 7: Plan structure before UI build

```text
@frontend-specialist /design map the reporting dashboard layout and component boundaries before implementation
```

### Why this combination is correct

The frontend specialist understands layout and component structure, and `/design` is the correct workflow when the team needs technical UI structure before coding.

### What it should read

- `AGENTS.md`
- `.gsd/SPEC.md`
- `.gsd/STATE.md`
- `.gsd/TODO.md`
- `.gsd/ARCHITECTURE.md`
- existing page or component files if present

### What it should produce

- layout structure
- component/file boundaries
- implementation guidance for the next build step

### Orchestrator sync after

Only if the design changes official architecture or rationale.

## Example 8: Push a UI from good to polished

```text
@frontend-specialist /ui-ux-pro-max polish the onboarding flow for accessibility, hierarchy, and mobile delight
```

### Why this combination is correct

The frontend specialist owns the implementation surface, and `/ui-ux-pro-max` is the APW workflow for high-polish visual and interaction refinement.

### What it should read

- `AGENTS.md`
- `.gsd/SPEC.md`
- current onboarding screens
- any design system or brand guidance

### What it should produce

- more polished UI behavior
- improved visual hierarchy and responsiveness
- concrete refinement changes in code

### Orchestrator sync after

Usually no unless this work changes official architecture or decisions.

## Example 9: Start a review-ready build

```text
@devops-engineer /preview start a review-ready preview for the settings refactor
```

### Why this combination is correct

The devops engineer is strong at runtime and environment handling, and `/preview` is the right workflow when you need a safe local review target.

### What it should read

- `AGENTS.md`
- project run instructions
- relevant preview scripts
- changed files

### What it should produce

- preview URL or status
- startup health result
- next-step guidance if the preview fails

### Orchestrator sync after

Usually no.

Preview is normally a review or verification step, not a canonical state update step.

## Example 10: Prepare a release

```text
@devops-engineer /deploy run preflight checks and deploy the tagged release to preview
```

### Why this combination is correct

The devops engineer owns deployment workflows, and `/deploy` is the right command when release preparation and rollout checks are the actual task.

### What it should read

- `AGENTS.md`
- `.gsd/STATE.md`
- verification evidence
- deployment configuration
- CI/CD notes

### What it should produce

- pre-flight results
- deployment outcome
- health checks
- rollback notes if needed

### Orchestrator sync after

Usually yes.

Release work often changes official status and should be synchronized deliberately.

## Example 11: Break down a task that is too large

```text
@orchestrator /orchestrate split reporting module work from TODO.md into backend, frontend, and tests
```

### Why this combination is correct

The orchestrator is the right choice when the work crosses multiple specialties and needs decomposition, sequencing, synthesis, and eventual canonical state sync.

### What it should read

- `AGENTS.md`
- `.gsd/STATE.md`
- `.gsd/ROADMAP.md`
- `.gsd/TODO.md`
- `.gsd/SPEC.md`
- `.gsd/ARCHITECTURE.md`
- `.gsd/DECISIONS.md`
- recent `.gsd/JOURNAL.md`

### What it should produce

- sub-task breakdown
- agent assignments
- execution sequence
- verification expectations
- orchestration report
- bounded orchestration evidence in `.gsd/JOURNAL.md`

### Orchestrator sync after

Yes.

This workflow is the practical orchestrator handoff and should own or explicitly coordinate canonical state synchronization.

## The simple rule to remember

If you are unsure which agent/workflow pair to use:

1. start with `@orchestrator /status ...`
2. then choose the specialist and workflow based on the actual job

## What to read next

- If you want the command-level rules behind these examples, read [COMMAND_INVOCATION_GUIDE.md](./COMMAND_INVOCATION_GUIDE.md).
- If you want the APW-wide save/promote model behind the workflows, read [WORKFLOW_PERSISTENCE_POLICY.md](./WORKFLOW_PERSISTENCE_POLICY.md).
- If you want the faster chooser for "which workflow now?", read [WORKFLOW_SELECTION_GUIDE.md](./WORKFLOW_SELECTION_GUIDE.md).
- If you want the full beginner map again, read [START_HERE.md](./START_HERE.md).
