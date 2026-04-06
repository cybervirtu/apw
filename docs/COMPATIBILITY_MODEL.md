# COMPATIBILITY_MODEL.md — One APW Standard, Multiple Tool Entry Paths

> [!TIP]
> Read this if you want the short architectural answer to: "How does APW support both Codex and Antigravity without splitting into separate framework branches?"

## 1. The Core Decision

APW is one canonical framework.

It does **not** maintain separate `codex` and `antigravity` branches.

That means APW keeps:

- one source of truth
- one bootstrap contract
- one validator
- one documentation system
- one template system

Tool-specific behavior is additive and documented. It is not implemented as two separate framework variants.

## 2. The Shared Core Contract

The real APW contract lives in:

- `PROJECT_RULES.md`
- `AGENT_SYSTEM.md`
- `COMMAND_POLICY.md`
- `PROJECT_BOOTSTRAP.md`
- APW docs, templates, and validators

These files define the framework itself.

Tool-specific entrypoints should route into them, not replace them.

## 3. The Common Entry Point

APW uses root `AGENTS.md` as the common modern front door.

That file should stay:

- short
- routing-focused
- tool-friendly
- free of duplicated governance detail

Its job is to tell tools and people:

- what APW is
- the core operating rule
- which files to read next
- what not to bypass

## 4. How Codex Fits

Codex compatibility works through the shared entrypoint plus the shared APW contract.

In practice:

- Codex starts from root `AGENTS.md`
- `AGENTS.md` routes Codex into APW's real governance files
- Codex then works inside the same `.gsd/` and `.agent/` contract as every other APW-compatible tool

APW does not need a separate Codex branch for this.

## 5. How Antigravity Fits

Antigravity compatibility follows the same model.

In practice:

- Antigravity starts from root `AGENTS.md`
- APW documents `GEMINI.md` as compatibility support when needed
- APW documents `.agents/...` as a possible future migration path, not as the silent current contract

So Antigravity compatibility is also handled inside the same framework, not in a fork.

## 6. What Counts as Compatibility vs Contract

Use this split:

- **Core contract**: `PROJECT_RULES.md`, `AGENT_SYSTEM.md`, `COMMAND_POLICY.md`, `PROJECT_BOOTSTRAP.md`, docs, templates, validator
- **Shared entrypoint**: root `AGENTS.md`
- **Compatibility layer**: tool-specific notes such as Codex guidance, `GEMINI.md` compatibility positioning, and future `.agents/...` migration planning

This keeps APW understandable while avoiding a second source of truth.

## 7. Branch Strategy

APW's branch strategy is simple:

- maintain one canonical framework branch line
- evolve compatibility inside that shared framework
- document tool differences explicitly
- do not fork governance, bootstrap, validation, or templates by tool

## 8. Future Migration Considerations

APW is designed to evolve without fragmenting into multiple competing framework variants.

### Current contract

The active APW contract is the current documented structure, bootstrap behavior, validation model, and governance system.

### Migration rule

Any future structural migration must be explicit, versioned, and coordinated.

No silent path or namespace change should be introduced into APW.

### `.agents/...` migration rule

A fuller `.agents/...` migration must be treated as an APW contract change, not a small internal refactor.

If adopted, it must be coordinated across:

- bootstrap
- validation
- documentation
- CI enforcement
- templates
- downstream migration guidance
- compatibility notes

### `GEMINI.md` compatibility rule

If `GEMINI.md` is still supported for compatibility, it must remain compatibility-only.

It must not become a parallel governance source or compete with root `AGENTS.md` and the core APW governance documents.

### Future tool support rule

If APW adds support for additional tools in the future, those integrations must follow the same pattern:

- one shared root `AGENTS.md` front door
- one canonical APW framework
- thin tool-specific compatibility documentation or adapters
- no framework forks unless a true structural incompatibility is proven

### Single source of truth rule

APW must preserve a single source of truth for governance.

Compatibility files may route into APW, but they must not redefine APW independently.

## 9. Practical Summary

If you are using APW with either Codex or Antigravity:

1. Start from root `AGENTS.md`.
2. Follow the routing into the core APW contract.
3. Use tool-specific compatibility docs only as adapters, not as substitute governance.
