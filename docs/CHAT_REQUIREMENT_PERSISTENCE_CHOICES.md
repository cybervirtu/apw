# CHAT_REQUIREMENT_PERSISTENCE_CHOICES.md — Chat Requirement Save / Promote / Sync

> [!IMPORTANT]
> Use this when you want the practical APW answer to: "A meaningful requirement arrived through chat. What did APW save, where did it go, and did official project memory change?"

## What this guide is

This guide defines APW's persistence choices for requirement-bearing chat after the intake and classification step.

It exists because once chat becomes the main requirement input channel, APW must make persistence explicit.

The user should not have to guess:

- whether anything was saved
- where it was saved
- whether canonical project memory changed
- whether orchestrator still needs to act

If you want the full route from requirement chat to execution, read [CHAT_REQUIREMENTS_TO_EXECUTION_FLOW.md](./CHAT_REQUIREMENTS_TO_EXECUTION_FLOW.md).

## The four persistence choices

After meaningful requirement-bearing chat, APW should make one of these choices explicit:

1. **Save as notes / evidence only**
2. **Promote into requirements and plan files**
3. **Hand off to orchestrator for official cross-file sync**
4. **Do not save yet**

## The safe default

The recommended APW safe default is:

- save a bounded summary to `.gsd/JOURNAL.md`

Why:

- it preserves the requirement-bearing chat
- it avoids silently rewriting canonical files
- it keeps the result visible and beginner-safe
- it leaves room for deliberate promotion later

Use this as the default answer whenever APW is unsure whether requirement-bearing chat should become canonical memory immediately.

## Choice 1 — Save as notes / evidence only

Use this when:

- the chat is useful but still exploratory
- the requirement is not yet agreed
- the input is supportive context or evidence
- the official destination is not settled yet

What happens:

- save a bounded summary to `.gsd/JOURNAL.md`
- do not rewrite canonical summary files

User-facing meaning:

- the input was saved
- official project memory did **not** change yet

## Choice 2 — Promote into requirements and plan files

Use this when:

- the chat result is concrete enough to be official
- the destination is clear
- the change is narrow enough to apply deliberately without hidden cross-file drift

Promotion targets:

- requirements, scope, users, problem framing -> `.gsd/SPEC.md`
- next work items -> `.gsd/TODO.md`
- milestone or phase changes -> `.gsd/ROADMAP.md`
- decisions or tradeoffs -> `.gsd/DECISIONS.md`
- exploratory or evidence-only notes -> `.gsd/JOURNAL.md`

What happens:

- the relevant official file or files are updated deliberately
- APW states which canonical files changed

User-facing meaning:

- the input was saved
- official project memory **did** change

## Choice 3 — Hand off to orchestrator for official cross-file sync

Use this when:

- the chat changes more than one canonical file
- the impact crosses requirement, roadmap, backlog, or decision boundaries
- the safe result needs coordinated synchronization

What happens:

- save a bounded summary to `.gsd/JOURNAL.md` first
- hand the result to orchestrator or governance for official synchronization

User-facing meaning:

- the input was saved
- official project memory is **pending orchestrator sync**
- APW should say which files are expected sync targets

## Choice 4 — Do not save yet

Use this when:

- the chat is still too fuzzy
- the user is still thinking aloud
- there is not enough signal to classify the input safely

What happens:

- no project files change

User-facing meaning:

- nothing was saved yet
- the chat remains session-local for now

## The explicit response model

After meaningful requirement-bearing chat, APW should respond with an explicit persistence summary that answers four things:

1. **classification**
2. **persistence choice**
3. **saved location or target files**
4. **whether official project memory changed**

Use this practical response shape:

- `Classification: ...`
- `Persistence choice: ...`
- `Saved to: ...`
- `Official project memory changed: yes / no / pending orchestrator`

## The save / promote / sync flow

APW uses this sequence:

1. classify the requirement-bearing chat
2. choose one of the four persistence outcomes
3. say the choice explicitly
4. save the bounded summary or promote deliberately
5. use orchestrator when official cross-file sync is required

## When orchestrator handoff is required

Orchestrator is the right path when:

- `SPEC.md` and `TODO.md` both need to change
- roadmap implications and rationale must stay aligned
- a clarification changes both scope and current work
- more than one canonical `.gsd` summary file must be updated safely

In those cases, APW should prefer:

1. bounded `JOURNAL.md` persistence first
2. orchestrator or governance sync second

Think of orchestrator handoff as the safe answer whenever one requirement-bearing chat message would otherwise require several canonical files to change together.

## Beginner-safe rule

If you are unsure which choice to use after meaningful requirement chat:

- choose **Save as notes / evidence only**
- store a bounded summary in `JOURNAL.md`
- escalate to orchestrator only after the official impact is clear

That is the safe APW default.

## Simple examples

### Example 1 — Notes only

Chat:

```text
Keep in mind that seller interviews keep mentioning trust and fraud concerns.
```

APW result:

- `Classification: note / evidence only`
- `Persistence choice: save as notes / evidence only`
- `Saved to: .gsd/JOURNAL.md`
- `Official project memory changed: no`

### Example 2 — Direct promotion

Chat:

```text
The first release is invite-only. Add that to the product requirements.
```

APW result:

- `Classification: requirement change`
- `Persistence choice: promote into requirements and plan files`
- `Saved to: .gsd/SPEC.md`
- `Official project memory changed: yes`

### Example 3 — Orchestrator handoff

Chat:

```text
Move the launch from public signup to partner-only onboarding and break the work into the next milestone.
```

APW result:

- `Classification: requirement change`
- `Persistence choice: hand off to orchestrator for official cross-file sync`
- `Saved to: .gsd/JOURNAL.md first; sync targets .gsd/SPEC.md, .gsd/TODO.md, .gsd/ROADMAP.md`
- `Official project memory changed: pending orchestrator`

### Example 4 — Do not save yet

Chat:

```text
Maybe we should do a marketplace, or maybe a managed service. I am not sure yet.
```

APW result:

- `Classification: exploration only`
- `Persistence choice: do not save yet`
- `Saved to: nothing yet`
- `Official project memory changed: no`

## The one-sentence rule

After meaningful requirement chat, APW must make the persistence outcome explicit:

save, promote, sync, or do not save yet.
