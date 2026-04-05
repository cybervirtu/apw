# TOOLING_NOTES.md — IDE and Agent Compatibility

> [!NOTE]
> This is a preliminary guide on tooling interactions. A comprehensive guide will be developed during the Tooling Guidance phase.

## IDE Context (Cursor / Antigravity / Codex)

The APW standard is designed to be IDE-agnostic, yet heavily optimized for agentic workflows. 

1. **Context Loading**: 
   - Always load `.gsd/STATE.md` to understand your current position before executing a prompt.
   - For specific tech stack rules, reference `.agent/rules/PROJECT.md` instead of the root `PROJECT_RULES.md` as it contains tailored prompts.

2. **Workflow Invocation**:
   - If your IDE supports native workflow parsing (reading `/commands` from `.agent/workflows`), use them strictly as defined.
   - If not, invoke workflows by asking the agent to "Follow the execution steps defined in `.agent/workflows/[name].md`".

3. **Avoiding Context Drift**:
   - Do not trust long-running chat threads. If an agent fails a debugging loop more than 3 times, reset the session.
   - Use `.gsd/STATE.md` and `.gsd/JOURNAL.md` as persistence layers so a new chat session can pick up immediately where the last one left off.
