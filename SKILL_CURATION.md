# SKILL_CURATION.md — APW Curation Policy

> [!TIP]
> This policy defines which Antigravity-Kit (AGK) agents, workflows, and skills are imported into the APW standard, preventing context noise and overlap with GSD governance.

## 1. Curation Philosophy

The APW standard uses a **minimal, high-leverage** curation strategy for the `.agent/` directories.
- We do not import everything from AGK.
- We only import tools that are broadly useful or provide specific, complex domain expertise.
- **Modularity**: We use a base "Core Set" for all projects, and "Add-on Sets" injected dynamically during project bootstrap based on the tech stack.

## 2. Namespace Conflict Logic

To maintain the ["GSD Documentation Wins"](AGENT_SYSTEM.md) principle:
- No AGK workflow may share a name with a GSD lifecycle concept. 
- Example: AGK's `plan.md` workflow is curated into APW as `design.md` to avoid conflicting with GSD's `/plan` command (which updates the roadmap).

---

## 3. Recommended Core Set (Included in All Projects)

These are baseline specialists and tools required for effective AI-assisted execution regardless of the tech stack.

### Agents
- `GSD.md` (Merged: Governance, planning, state management)
- `AGK.md` (Curated: Specialist execution, coding)

### Workflows (.agent/workflows/)
- `/design.md` (Technical architecture, previously "plan")
- `/test.md` (TDD, test generation)
- `/debug.md` (Error investigation, log analysis)
- `/status.md` (Current build/test execution status)

### Skills (.agent/skills/)
- `clean-code`: Universal formatting and refactoring standards.
- `git-expert`: Advanced version control operations.

---

## 4. Stack-Specific Add-on Sets (Opt-In during Bootstrap)

These skills are stored in `./apw/templates/stack/` and are only injected when a specific technology flag is passed to the bootstrap script.

### 🌐 Web App Add-on
- **Skills**: `react-expert`, `tailwind-master`, `accessibility-checker`, `nextjs-pro`
- **Why**: Deep knowledge of component lifecycles, CSS frameworks, and DOM accessibility is highly specific and adds noise to backend projects.

### ⚙️ Backend / API Add-on
- **Skills**: `database-architect`, `api-design`, `fastapi-guru`, `nodejs-expert`
- **Why**: Focuses on ORMs, database normalization, query optimization, and REST/GraphQL specs.

### 🤖 AI / ML Service Add-on
- **Skills**: `prompt-engineer`, `eval-expert`, `rag-architect`
- **Why**: Specific to vector databases, prompt templating, and LLM orchestration patterns.

### 📱 Mobile App Add-on
- **Skills**: `flutter-pro`, `react-native-guru`, `ios-expert`, `android-expert`
- **Why**: Native build tools, state management on devices, and app store compliance.

### 🏗️ Infra / DevOps Add-on
- **Skills**: `docker-expert`, `ci-cd-architect`, `terraform-pro`, `aws-specialist`
- **Why**: Handles infrastructure-as-code, pipeline configuration, and cloud provider specifics.

---

## 5. Maintenance Recommendation

- **Audit**: Run `./scripts/validate.sh` periodically to ensure projects haven't imported massive, undocumented skills outside these curated sets.
- **Updates**: When dragging new skills from the upstream AGK repository, place them in `./apw/templates/` first for security and namespace review before adding them to a core or add-on set.
