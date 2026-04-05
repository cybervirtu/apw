# PROJECT_INSTANTIATION_PROMPT.md

> [!TIP]
> Use this prompt template to kick off a brand new APW project.
> 
> **How to use:**
> 1. Run `./scripts/bootstrap.sh --target [your-new-project-dir] --stack [stack-name]`
> 2. Open your new project in your AI IDE (Antigravity, Cursor, etc.).
> 3. Copy the text below, fill in the bracketed `[ ]` variables, and submit it to the AI agent to generate your initial documentation layer.
> 4. Ensure you save the AI's output into the respective `.gsd/` files.

---

## The Prompt

```text
Please instantiate the APW workspace standard for this new project based on the constraints provided below. 

Note: I have already bootstrapped the APW directory structure and templates using the CLI script. 
Your job is to generate the initial content for the memory templates.

Project type:
[e.g., FastAPI backend / Next.js web app / Monorepo / React Native app]

Project name:
[e.g., Acme E-Commerce Platform]

Tech stack:
[e.g., Python 3.12, FastAPI, PostgreSQL, SQLAlchemy, Docker]

Business goal:
[e.g., To provide a high-performance, secure backend API for our new e-commerce storefront]

Constraints:
[e.g., Must use JWT authentication, no third-party ORMs allowed, must deploy to AWS via Terraform]

Please generate the following and write them explicitly to the file system using your editing tools:
1. `PROJECT_RULES.md` - Append any project-specific tech stack limits to the existing rules.
2. `.gsd/SPEC.md` - Formalize the business goal and constraints into structured requirements.
3. `.gsd/STACK.md` - Formalize the technology stack provided.
4. `.gsd/ROADMAP.md` - Break the implementation down into at least 3 logical milestones.
5. `.gsd/TODO.md` - Generate the granular task list for Milestone 1.
6. A brief "First-Week Implementation Plan" summary for me to review.
```
