# APW Docs Portal

`website/` contains the in-repo Nextra documentation portal for APW.

The portal exists to make APW easier to navigate and more visual, especially for beginners and non-technical readers.

This directory is a local docs app, not a separate repository and not a second APW framework.

## Source of truth model

The source of truth remains inside this repository:

- repo-root governance files such as `AGENTS.md`, `PROJECT_RULES.md`, `AGENT_SYSTEM.md`, `COMMAND_POLICY.md`, and `PROJECT_BOOTSTRAP.md`
- canonical Markdown guides under `docs/`
- portal-facing MDX pages under `website/pages/`

Nextra is the presentation layer. It is not a second governance system.

Practical rule:

- if APW governance or contract wording changes, update the canonical root/docs source first
- then update the portal page if its beginner-facing summary, navigation, or framing also needs to change
- do not land a portal-only governance change that conflicts with the canonical source docs

For the fuller role model and editing rules, read `../docs/DOCS_SOURCE_OF_TRUTH.md`.

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
4. Keep the portal page focused on navigation, explanation, summaries, and approachable structure.
5. Link readers back to the relevant canonical docs when deeper accuracy or maintenance matters.
6. Make the page role obvious when helpful: beginner guide, summary/wrapper, or reference router.

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
