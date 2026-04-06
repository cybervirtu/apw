# APW Docs Visual Style

This note defines the small visual pattern system for the APW Nextra portal.

It is intentionally short. The goal is consistency and clarity, not a giant design manual.

## Purpose

Use the portal to make APW easier to understand, especially for beginners.

Use visual components when they improve comprehension, scanning, or navigation.

Do not add components just for decoration.

## Preferred page pattern

For beginner-facing portal pages, use this structure when it fits:

1. What this page is
2. Why it matters
3. Main explanation
4. Visual guidance
5. Examples
6. What to do next

Not every page needs every section, but pages should feel guided and intentional.

## Component rules

### Cards

Use `Cards` for:

- homepage entry paths
- choose-your-path sections
- beginner routing options
- project type choices
- profile choices

### Callout

Use `Callout` for:

- important rules
- beginner tips
- source-of-truth reminders
- compatibility notes
- warnings and "do not do this" guidance

Keep callouts short. If the page is mostly callouts, the page is too noisy.

### Steps

Use `Steps` for:

- onboarding flows
- bootstrap flow
- idea-to-project sequences
- what-to-do-next sequences
- workflow handoff patterns

### Tabs

Use `Tabs` for:

- profile comparison
- alternate paths
- tool-specific compatibility views
- short compare-and-choose content

Use tabs when the content would otherwise become repetitive. Do not hide core rules in tabs.

### Tables

Use tables for:

- profile comparison
- project-type to stack-direction mapping
- workflow comparison
- example comparisons
- beginner vs advanced tradeoffs

### Mermaid

Use Mermaid for:

- architecture diagrams
- idea-to-project flow
- execution vs orchestrator flow
- workflow decision trees
- bootstrap to validate to build to sync to CI flows

If a simple table or `Steps` block explains it better, prefer that instead.

## Source-of-truth reminder

Portal pages are the presentation layer.

Canonical governance and reference rules still live in:

- repo-root APW governance files
- canonical docs under `docs/`
- scripts and workflow assets that define APW behavior

Portal pages may summarize and route, but they should not redefine APW independently.

## Practical authoring rules

- Write in plain English first.
- Prefer one strong visual pattern over many mixed patterns.
- Add a short "What to do next" section on guided pages.
- Use code paths like `docs/FILE.md` for canonical references instead of awkward raw filesystem links.
- When governance wording changes, update the canonical source first, then update the portal summary.
