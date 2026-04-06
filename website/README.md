# APW Docs Portal

`website/` contains the in-repo Nextra documentation portal for APW.

The portal exists to make APW easier to navigate and more visual, especially for beginners and non-technical readers.

## Source of truth model

The source of truth remains inside this repository:

- repo-root governance files such as `AGENTS.md`, `PROJECT_RULES.md`, `AGENT_SYSTEM.md`, `COMMAND_POLICY.md`, and `PROJECT_BOOTSTRAP.md`
- canonical Markdown guides under `docs/`
- portal-facing MDX pages under `website/pages/`

Nextra is the presentation layer. It is not a second governance system.

## How to run the portal locally

From `website/`:

```bash
npm install
npm run dev
```

Then open the local URL printed by Next.js.

## How to build the portal

From `website/`:

```bash
npm run build
npm run start
```

## Where content lives

- `website/pages/`: portal pages and information architecture
- `website/theme.config.jsx`: docs portal theme and navigation settings
- `website/next.config.mjs`: Nextra/Next.js wiring
- `docs/`: canonical APW guides and reference material
- repo root: canonical APW governance documents

## How to update docs going forward

1. Update the canonical Markdown source first when the APW contract or guidance changes.
2. Update the portal page if the beginner-facing summary, navigation, or framing also needs to change.
3. Keep the portal focused on high-value onboarding, examples, workflows, and discoverability.
4. Keep deeper reference material reachable without duplicating the entire handbook into a second full doc tree.

