# Agent memory map

This folder is the **durable brain** for AI agents working on Flutter Scale Kit.
It is not user documentation. Do not copy `README.md` here.

| File | Read when |
| --- | --- |
| [package.md](package.md) | Starting a task: what the package is, layers, public surface |
| [invariants.md](invariants.md) | Changing scaling, widgets, cache, or platform detection |
| [decisions.md](decisions.md) | Changing architecture, cache, or FFI tracking |

## Truth order

1. **Code** in `lib/` — implementation truth.
2. **This folder** — product intent, invariants, and why.
3. **`CHANGELOG.md`** — what changed recently.
4. **`README.md`** — user-facing docs and recipes only. Do not load it as session memory.
5. **Codebase Memory MCP** — code graph (symbols, callers, clusters). Not a substitute for this folder.

When code and spec disagree, **fix the spec** after confirming the code is intentional.

## Consumer apps (other IDEs)

Agents **using** this package inside another Flutter app should load `skills/flutter-scale-kit/` (Agent Skills / `npx skills add fodilfliti/flutter_scale_kit`). That skill is usage + init, not package internals. If you change a public API, update the consumer skill in the same change.
