# MONOREPO_ADAPTATION.md — Using APW in Multi-Package Workspaces

> [!NOTE]
> Monorepos (e.g., Turborepo, Nx, Yarn Workspaces) present unique challenges for AI context windows. A single `.gsd/STATE.md` at the root will constantly thrash as the AI jumps between backend microservices and frontend clients.
> 
> To solve this, APW uses a **Global/Local Architecture**.

---

## 1. The Global / Local Split

The golden rule of the APW Monorepo pattern is:
**Governance acts globally; Execution acts locally.**

### Root Level (Global Governance)
The root of the monorepo holds the shared truth and rules that apply to all packages.
- `PROJECT_RULES.md`: Universal repository rules.
- `AGENT_SYSTEM.md`: Universal AI interaction rules.
- `.gsd/ROADMAP.md`: High-level milestones spanning front-to-back delivery.
- `.gsd/ARCHITECTURE.md`: The macro-architecture showing how packages communicate.
- `.gsd/DECISIONS.md`: Global ADRs (e.g., "We chose Turborepo").

### Package Level (Local Execution)
Every distinct deployable unit (e.g., `apps/web/`, `apps/api/`) operates as its own autonomous zone.
- `apps/web/.gsd/SPEC.md`: Requirements specific to the web app.
- `apps/web/.gsd/STATE.md`: Where the developer left off *specifically* in the frontend.
- `apps/web/.gsd/TODO.md`: Granular tasks for the frontend.
- `apps/web/.agent/rules/PROJECT.md`: Tech stack rules *only* for the frontend (React, Tailwind).

---

## 2. Navigating Context in IDEs (Cursor/Antigravity)

When a developer opens a monorepo, the AI can become easily confused if asked vague questions like "check my state."

**Always anchor the AI:**
> ❌ **Bad Prompt**: "Read the state and start working." (The AI might read the backend state while trying to fix the frontend).
> 
> ✅ **Good Prompt**: "Read `apps/web/.gsd/STATE.md` and `apps/web/.gsd/TODO.md` to understand where we are. Then implement the next task."

If you need a cross-cutting change (e.g., adding a field to the database in `apps/api` and surfacing it in `apps/web`), instruct the AI to execute it sequentially:
> "First, read `apps/api/.gsd/STATE.md` and implement the Backend phase. Once verified, update the API STATE, then read `apps/web/.gsd/STATE.md` and begin the Frontend phase."

---

## 3. Bootstrapping a Monorepo App

You do not run `./scripts/bootstrap.sh` once at the root and throw everything in.
Instead, bootstrap the root for governance, and then bootstrap each app dynamically:

```bash
# 1. Initialize the global root
./scripts/bootstrap.sh --target . --profile base --stack base

# 2. Initialize the backend
./scripts/bootstrap.sh --target ./apps/api --profile base --stack base

# 3. Initialize the frontend
./scripts/bootstrap.sh --target ./apps/web --profile base --stack base
```
*(If your APW repo later vendors stack packs under `templates/stack/<name>/`, replace `base` with the appropriate pack name.)*

## 4. Single Source of Truth
Never duplicate specifications. If an API schema is defined in `apps/api/swagger.yaml`, the frontend `apps/web/.gsd/SPEC.md` must read: 
> "Must conform to the endpoints defined in `../api/swagger.yaml`." 

Do not copy the schema directly into the `.gsd` layer, which risks synchronization drift.
