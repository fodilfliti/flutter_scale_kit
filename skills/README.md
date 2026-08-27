# Agent skill (consumers)

This is the **usage** skill for apps that depend on `flutter_scale_kit`. It follows the [Agent Skills](https://agentskills.io) format (`SKILL.md`), so Cursor, Claude Code, Codex, Copilot, OpenCode, and other compatible agents can load it.

Package authors: keep `spec/` for internals. When you change a public API, update `skills/flutter-scale-kit/` in the same change.

## Install (any compatible agent)

From GitHub (installs into the current project, or add `-g` for all projects):

```bash
npx skills add fodilfliti/flutter_scale_kit
```

One skill only:

```bash
npx skills add fodilfliti/flutter_scale_kit --skill flutter-scale-kit
```

Then ask the agent:

> Init Flutter Scale Kit with defaults.

If `scale_kit.yaml` is missing, the agent asks once for a **style** (`design_system` recommended, or `drop_in` / `extensions` / `hybrid`) and writes that file. See [flutter-scale-kit/styles.md](flutter-scale-kit/styles.md).
