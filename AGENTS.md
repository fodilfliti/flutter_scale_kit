# Agent instructions — Flutter Scale Kit

This is a **published Flutter package** (`flutter_scale_kit` on pub.dev), not an application.

## Load context

1. Read `spec/README.md`, then the spec file that matches the task (`package.md`, `invariants.md`, `decisions.md`, `companion.md`).
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

## Companion (look)

`flutter_scale_theme_kit` is a **sibling folder** (`../flutter_scale_theme_kit`), same parent as this repo. **Size** stays here. Do **not** import theme-kit from `lib/` and do **not** add it as a runtime dependency.

If a **consumer app** lists `flutter_scale_theme_kit` in pubspec (or the user adds it), agents **must use it** for look: `STTheme` / `context.st`. Merge fonts with:

`appST.light.copyWith(textTheme: appST.light.createResponsiveTextTheme(appST.light.textTheme))`

(same for `dark`). Never `ResponsiveThemeData.create` as the full `theme:` (drops component themes). Keep `skills/flutter-scale-kit/` in sync with that recipe.

## Flutter SDK

The maintainer switches Flutter with **FVM** (`fvm`). This repo is pinned in `.fvmrc` to **3.35.7**. Use `fvm flutter` / `fvm dart`, not global `flutter`. Never run `flutter upgrade` / `flutter channel` on `C:\Users\lemsa\Documents\flutter`. Keep package constraints at Dart `^3.7.2` and Flutter `>=3.29.0`.

## Out of scope unless asked

Publishing to pub.dev, bumping version, or rewriting README marketing copy.
