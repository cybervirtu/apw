# GLOSSARY.md — APW Glossary

## APW

**Agentic Project Workspace**.

The full framework that combines governance, execution, templates, and validation into one workspace standard.

## GSD

The governance and memory layer inside APW.

It owns lifecycle, planning, state tracking, verification, and canonical project memory.

## AGK

The execution and specialist layer inside APW.

It provides specialist agents, workflows, and reusable skills for implementation work.

## `.gsd/`

The memory layer for a project.

This is where lifecycle and state files live.

## `.agent/`

The execution layer for a project.

This is where agent definitions, rules, workflows, scripts, and skills live.

## Canonical state

The official summary of the project’s current condition.

In APW, this mostly lives in:

- `STATE.md`
- `ROADMAP.md`
- `TODO.md`
- `DECISIONS.md`

## Orchestrator

The human or agent pass responsible for synchronizing canonical `.gsd` files safely after execution work.

## Execution agent

An AI assistant or workflow focused on implementation work.

Execution agents may write code and append bounded evidence to `JOURNAL.md`, but they should not casually rewrite canonical summary files.

## Bounded evidence

Factual, scoped, append-only notes about work that was just performed.

In APW, bounded evidence goes into `JOURNAL.md`.

## Bootstrap

The process of creating or upgrading a repo using APW.

This is done with `scripts/bootstrap.sh`.

## Validate

The process of checking whether a repo still matches the APW contract.

This is done with `scripts/validate.sh` or `scripts/ci-validate.sh`.

## Profile

A selectable APW template level.

Current profiles are:

- `minimal`
- `base`
- `advanced`

## Stack

An optional layer for stack-specific skills.

It is passed with `--stack`.

## Drift

The repo slowly moving away from the APW contract.

Examples:

- reintroducing `.agents/`
- fragmenting advanced `.gsd` state again
- changing governance files casually

## Namespace

The directory structure APW uses for execution material.

The active namespace is `.agent/`, not `.agents/`.

## Greenfield project

A project that is starting fresh rather than being migrated from an existing codebase.

## Existing repo migration

Adopting APW inside a repo that already has code, habits, and project history.

## Monorepo

A repository with multiple applications or packages that may each need their own APW root.

## Compliance

A repo is APW-compliant when it still matches the required structure, content expectations, and governance ownership rules for its chosen profile.
