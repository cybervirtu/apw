# OPERATING_MODEL.md — Operating Model

## 1. Plain-English Summary

APW works by separating:

- planning and memory
- implementation work
- controlled synchronization of canonical state

That means the system is designed so execution can move quickly without letting the project’s official memory become noisy or inconsistent.

## 2. The Core Rule

The operating rule is simple:

- **GSD governs lifecycle and memory**
- **AGK executes**
- **APW integrates and enforces**

If there is a conflict, the governed `.gsd` state wins.

## 3. Who Does What

| Role | Main job | Typical writes |
| :--- | :--- | :--- |
| Human operator | chooses profile, reviews changes, controls rollout | commands, prompts, approvals, repo decisions |
| Execution agent | implements scoped work | code, artifacts, bounded `JOURNAL.md` evidence |
| Orchestrator/governance pass | synchronizes canonical project memory | `STATE.md`, `ROADMAP.md`, `TODO.md`, `DECISIONS.md` |

## 4. Canonical State Ownership

These files are controlled summary files:

- `.gsd/STATE.md`
- `.gsd/ROADMAP.md`
- `.gsd/TODO.md`
- `.gsd/DECISIONS.md`

Routine execution agents do not freely rewrite them by default.

These files support execution more directly:

- `.gsd/JOURNAL.md`
- `.gsd/SPEC.md`
- `.gsd/ARCHITECTURE.md`
- `.gsd/STACK.md`

Even there, teams should still write deliberately and avoid creating overlapping shadow files.

## 5. Session Flow

Use this pattern for normal work:

1. Read `STATE.md` and `TODO.md`.
2. Read `SPEC.md` if the change affects behavior.
3. Read project-local rules in `.agent/rules/`.
4. Execute scoped work.
5. Log bounded evidence in `JOURNAL.md`.
6. Run orchestrator/governance sync if canonical state changed.
7. Validate before merge or release.

## 6. When to Run Orchestrator Sync

Run an orchestrator or explicit governance pass when:

- current status changed meaningfully
- blockers or next steps changed
- phase or milestone status changed
- follow-up items must be promoted into canonical `TODO.md`
- design rationale changed and must be recorded in `DECISIONS.md`
- you are handing off the project to another person, agent, or day

## 7. Execution Boundaries

Execution agents may:

- implement features
- fix bugs
- write tests
- generate artifacts
- append bounded `JOURNAL.md` evidence

Execution agents should not by default:

- casually rewrite canonical summary files
- invent new project scope without governance
- create alternate memory systems outside the APW contract

## 8. Tool Roles

APW works well with several kinds of AI tooling.

The operating model usually looks like this:

| Tool style | Best use |
| :--- | :--- |
| Orchestration-heavy tool | multi-step execution and governance sync |
| Interactive editor assistant | scoped implementation and iteration |
| Terminal-first agent | bootstrap, validation, CI, and repo-wide maintenance |

For concrete tool guidance, see [TOOLING_GUIDE.md](./TOOLING_GUIDE.md).

## 9. What Good APW Usage Looks Like

Healthy APW usage usually looks like this:

- one clear project state
- scoped execution passes
- evidence in `JOURNAL.md`
- controlled updates to canonical summary files
- validation as a normal part of workflow
- CI catching structural drift before merge

## 10. What Bad APW Usage Looks Like

Warning signs:

- multiple people or agents editing `STATE.md` freely
- parallel shadow files for milestones, snapshots, or sprint state
- `.agents/` appearing again
- validation being skipped
- profile and stack choices being forgotten

## 11. Minimum Safe Operating Pattern

If a team wants the smallest reliable APW habit set, keep these rules:

1. Start from `STATE.md` and `TODO.md`.
2. Keep execution scoped.
3. Put evidence into `JOURNAL.md`.
4. Sync canonical state through orchestrator/governance.
5. Validate before merge.
