# Agent instructions — Flutter Scale Kit

This is a **published Flutter package** (`flutter_scale_kit` on pub.dev), not an application.

## Load context

1. Read `spec/README.md`, then the spec file that matches the task (`package.md`, `invariants.md`, `decisions.md`).
2. Use **code** under `lib/` as implementation truth.
3. If Codebase Memory MCP is available: `list_projects` → use project `flutter_scale_kit` (index with `index_repository` if missing). Prefer `search_graph` / `get_architecture` / `trace_path` over dumping files.
4. Do **not** ingest `README.md` as working memory. It is user documentation. Open a section only when writing user-facing docs.

## Working rules

- Keep the public barrel (`lib/flutter_scale_kit.dart`) the only public API.
- Preserve double-scale detection, FFI-clean doubles, LRU cache cap, and web-safe platform checks (`spec/invariants.md`).
- No new runtime dependencies unless the user explicitly asks.
- Touch `example/` for demos only; do not import it from `lib/`.
- After behavior changes: update `spec/` (and `CHANGELOG.md` when it is a user-visible release change). README only if the user-facing API/docs changed.
- Public API changes must also update `skills/flutter-scale-kit/` (consumer Agent Skill used in other IDEs).

## Out of scope unless asked

Publishing to pub.dev, bumping version, or rewriting README marketing copy.
