# APW Architecture & Governance

## 1. Top-Level APW Workspace Structure

The APW standard is maintained in a dedicated `./apw` directory within the master workspace. This directory serves as the template and source of truth for all project-level documentation, agents, and skills.

```text
./apw/
├── .agent/              # Global execution + capability namespace
│   ├── agents/          # Core agent personalities (GSD, AGK)
│   ├── rules/           # Global governing prompts (PROJECT.md)
│   ├── scripts/         # Task-level automation
│   ├── workflows/       # Shared slash command definitions
│   └── skills/          # Curated common skill library
├── .gsd/                # Lifecycle document templates
│   ├── SPEC.md          # Requirement definition template
│   ├── ROADMAP.md       # Phase and milestone template
│   └── STATE.md         # Narrative state tracking template
├── docs/                # APW standards, guides, and runbooks
├── scripts/             # Bootstrap, validation, and sync automation
├── AGENT_SYSTEM.md      # Operational model (GSD vs AGK)
├── GSD-STYLE.md         # Naming and formatting standards
└── PROJECT_RULES.md     # Mandatory governance rules
```

---

## 2. Recommended Per-Project Structure

Projects bootstrapped from APW should follow this canonical layout:

```text
[project-root]/
├── .agent/              # Project-specific AI context (Localized)
│   ├── agents/          # Specialist agent definitions
│   ├── rules/           # Governing prompts
│   ├── scripts/         # Task-level automation
│   ├── workflows/       # Execution flows / slash commands
│   └── skills/          # Project-specific or imported skills
├── .gsd/                # ACTIVE lifecycle documentation (Daily use)
├── docs/                # Project technical documentation
├── AGENT_SYSTEM.md      # (Symlinked or copied from APW)
├── GSD-STYLE.md         # (Symlinked or copied from APW)
├── PROJECT_RULES.md     # (Symlinked or copied from APW)
└── ...                  # Project source code
```

---

## 3. Upgrade & Sync Strategy

To ensure projects remain aligned with the evolving APW standard while allowing for upstream changes:

1. **Vendor Capture**: Upstream changes from GSD and AGK are reviewed in `./sources/`.
2. **Merge Point**: Curated changes are merged into `./apw/`.
3. **Validation**: The standard is validated against the pilot project.
4. **Standard Release**: Commit/Push to the APW `main` branch.
5. **Project Sync**: Projects re-run `./apw/scripts/bootstrap.sh --target . --profile [profile] --stack [stack]` and add `--force` only when they intentionally want to replace existing `.gsd` lifecycle files.

## 4. Template Ownership

- `templates/` is the canonical downstream bootstrap source.
- The repo-root `.gsd/` directory is the active governance layer for APW itself.
- `.gsd/templates/` is not part of the current downstream bootstrap path. If such a directory is introduced later, it must be treated as internal or transitional unless bootstrap logic explicitly adopts it.
- The operational bootstrap contract is documented in `PROJECT_BOOTSTRAP.md`.

---

## 5. Risks & Controls

| Risk | Impact | Control |
| :--- | :--- | :--- |
| **Project Drift** | Loss of governance and AI predictability | Regular `/audit` checks against APW standards. |
| **Upstream Breaking**| Disruption of active development | Mandatory "Merge → Validate" step in `./apw` before rollout. |
| **Shadow AI** | Inconsistent model behavior | Strict enforcement of `AGENT_SYSTEM.md` precedence. |
| **Over-Engineering**| High maintenance overhead | "Documentation-First, Code-Second" automation approach. |

---

## 6. Decision Rules summary
- **Documentation First**: No code changes allowed until SPEC Status is Finalized.
- **Verification Mandatory**: Captured evidence is the only proof of completion.
- **GSD Wins**: Documentation and lifecycle state are the ultimate authority.
