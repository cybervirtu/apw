# APW Docs Portal

`website/` contains the in-repo Nextra documentation portal for APW.

The portal exists to make APW easier to navigate and more visual, especially for beginners and non-technical readers.

This directory is a local docs app, not a separate repository and not a second APW framework.

## Source of truth model

The source of truth remains inside this repository:

- repo-root governance files and canonical docs under `docs/` are the **canonical reference source of truth**
- portal-facing MDX pages under `website/pages/` are the **guided narrative / presentation layer**
- the portal summarizes, wraps, and routes with a "beginner-first" focus

Nextra is the presentation layer. It is not a second governance system.

Practical rule:

- if APW governance or contract wording changes, update the canonical root/docs source first
- then update the portal page if its beginner-facing summary, navigation, or framing also needs to change
- do not land a portal-only governance change that conflicts with the canonical source docs

For the fuller role model and editing rules, read `../docs/DOCS_SOURCE_OF_TRUTH.md`.
For the portal visual pattern system, read `../docs/DOCS_VISUAL_STYLE.md`.

## How to run the portal locally

From `website/`:

```bash
npm install
npm run dev
```

Then open the local URL printed by Next.js.

This installs dependencies locally into `website/node_modules`.
Do not install portal dependencies globally for normal APW work.

## How to build the portal

From `website/`:

```bash
npm run build
npm run start
```

Build artifacts such as `website/.next/` and local dependencies in `website/node_modules/` are local-only and should stay untracked.

## Where content lives

- `website/pages/`: portal pages and information architecture
- `website/pages/reference/`: deeper technical/reference portal entry pages
- `website/theme.config.jsx`: docs portal theme and navigation settings
- `website/next.config.mjs`: Nextra/Next.js wiring
- `website/package.json`: local portal scripts and dependencies
- `docs/`: canonical APW guides and reference material
- repo root: canonical APW governance documents
- `website/package-lock.json`: pinned local portal dependency graph for repeatable installs

## How to add or update portal pages

When adding a new page:

1. Decide whether the content is a portal-facing entry page or a canonical APW source doc.
2. If the change affects governance, compatibility, lifecycle, or validation rules, update the canonical root/docs source first.
3. Add or update the portal page in `website/pages/` only after the canonical wording is settled.
4. Keep the portal page focused on narrative, explanation, and approachable structure.
5. Use code paths like `PROJECT_RULES.md` or `docs/COMMAND_INVOCATION_GUIDE.md` when you need to point readers to canonical source files.
6. Avoid duplicating technical configuration logic or deep rule sets in the portal; keep those in the `docs/` source.

## APW Nextra visual pattern system

Use the portal components intentionally:

- `Cards` for homepage routing, chooser sections, and beginner path selection
- `Callout` for important rules, source-of-truth reminders, warnings, and beginner tips
- `Steps` for onboarding flows, workflow sequences, and "what to do next" guidance
- `Tabs` for compact comparisons such as profile choices or alternate paths
- tables for profile, workflow, and example comparisons
- Mermaid for architecture and process flows when a diagram is clearer than prose

Preferred page shape for beginner-facing pages:

1. What this page is
2. Why it matters
3. Main explanation
4. Visual guidance
5. Examples
6. What to do next

For the fuller visual guidance, read `../docs/DOCS_VISUAL_STYLE.md`.

## How to update docs going forward

1. Update the canonical Markdown source first when the APW contract or guidance changes.
2. Update the portal page if the beginner-facing summary, navigation, or framing also needs to change.
3. Keep the portal focused on high-value onboarding, examples, workflows, and discoverability.
4. Keep deeper reference material reachable without duplicating the entire handbook into a second full doc tree.
5. Prefer wrapping and routing over copying large governance documents into portal pages.

## Avoiding duplication and drift

Portal content should:

- explain
- route
- summarize
- make APW easier to learn

Portal content should not:

- redefine governance independently
- become the only place where critical APW rules live
- silently diverge from `docs/` or the repo-root operating files

When in doubt, treat the portal as the user-facing layer and the root/docs material as the canonical contract.

If you are unsure where something belongs, use `../docs/DOCS_SOURCE_OF_TRUTH.md` as the decision note.

If you are unsure how the page should look, use `../docs/DOCS_VISUAL_STYLE.md` as the formatting note.
