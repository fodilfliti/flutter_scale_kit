# Flutter Scale Kit

Pub package `flutter_scale_kit` (current: **2.0.2**). High-performance responsive scaling for Flutter: phones, tablets, desktop, web. Positioned as a faster, more controllable alternative to `flutter_screenutil`.

Constraints: Dart `^3.7.2`, Flutter `>=3.29.0`. Do not raise the Dart floor to 3.13 — Flutter 3.29–3.47 apps must still resolve this package.

Design size is typically **375×812 mobile**. Apps wrap the tree with `ScaleKitBuilder` so every route inherits scale.

Look is a **sibling package** (`../flutter_scale_theme_kit`, pub `flutter_scale_theme_kit` **1.0.1**). Do not import it from `lib/`. If a consumer app depends on it, merge via `createResponsiveTextTheme` on `appST.light` / `dark`.

## What it is / is not

- **Is:** scale engine + drop-in `SK*` widgets + `SKit` helpers + design tokens + language-aware fonts + desktop/web lock knobs.
- **Is not:** a full design system, a layout engine, or a replacement for `MediaQuery` except for size/orientation-driven rebuilds.

## Layout

```
lib/flutter_scale_kit.dart          public barrel
lib/src/core/                      engine
lib/src/extensions/               .w/.h/.sp, context, theme, text style
lib/src/mixins/                    DeviceMetricsMixin
lib/src/widgets/                    ScaleKitBuilder, SK*, SKit, responsive
example/                           interactive demo (not shipped as library code)
test/                              package tests (thin today)
doc/                               user-facing deep-dive docs linked from README
```

## Documentation layout

**Core rule: `README.md` must be self-sufficient.** pub.dev users read the package page and rarely
click through to repo files, so no required knowledge may live only in `doc/`. A reader who scrolls
the README top to bottom and never follows a link must still be able to use every feature.

`README.md` (~1940 lines) carries the full narrative in one scroll:

1. Hero — pitch, device screenshots, live demo link (visual hook before any prose)
2. Before/after code comparison, then a "why developers pick it" table
3. "The whole package in 60 seconds" — a capability tour covering **every** major feature, grouped
   under Sizing / Widgets / Design system / Look / Responsive layout / Tuning the engine / Tooling.
   Each entry is 2–6 lines of code with a deep link to its full section. This exists so a reader who
   never scrolls past the fold still knows the package does responsive values and widgets, desktop
   locks, device queries, locale fonts, theming, engine tuning, and testing — not just `.w` scaling.
   **When a feature section is added below, add a tour entry for it too**; the tour's value is that
   it is exhaustive.
4. Agent-skill callout (`npx skills add …`) placed **above** the TOC, so readers learn the package
   can install itself before they commit to reading; it deep-links to the full section at the bottom
5. Table of contents (grouped: get running / core APIs / responsive / how it works / extras)
6. Install → **Starter app** → Quick start → decision table → gotchas

The starter app is a **top-level `##` section with a shields.io button and a file table**, not a
blockquote callout, sitting between Install and Quick start. It is the one place that points at a
runnable app rather than snippets, so it is deliberately the most visually prominent link on the
page; keep it that way.

Quick start has three numbered parts: (1) a complete runnable `main.dart`, (2) a table of **every**
`ScaleKitBuilder` parameter with defaults plus one tuned example, (3) four optional setup steps —
design tokens, `setDefault*` values, the full `FontConfig` language/group example, and a
`ScaleKitDesignValues` token set. The later Typography and Design-system sections deliberately do
**not** repeat those two examples; they link back to Quick start and add only what is new
(font resolution order, the remaining `ScaleKitDesignValues` fields).
5. Every API inline: extensions, `SK*` widgets, `SKit`, tokens, typography, theme, companion
6. Responsive, desktop/web, device queries, breakpoints
7. Engine: limits, boosts, auto-config, performance
8. Testing, runtime toggle, Device Preview, agent skill, screenutil migration
9. Advanced-guides table, FAQ, support

`doc/` files are **optional supplements** — exhaustive tables and deep math for readers who want
more, never a prerequisite:

| File | Holds |
| --- | --- |
| `doc/starter-app.md` | First-time setup with **both** packages: `pubspec.yaml`, `core/design.dart` (`STTheme`), `core/scale_kit.dart` (`initScaleKit`), `main.dart` wiring, one real screen, the four usage styles, and the size-vs-look rules |
| `doc/api-reference.md` | Exhaustive per-member reference (every property, method, enum) |
| `doc/scaling-engine.md` | Full formulas, per-device boost tuning, benchmark detail |
| `doc/design-system.md` | Extended token and font recipes |
| `doc/desktop-web.md` | Every lock/override/fallback combination |
| `doc/recipes.md` | Cards, grids, RTL, testing patterns |
| `doc/migration-screenutil.md` | Three migration strategies plus gotcha list |

Constraints when editing docs:

- **pub.dev in-page anchors:** linked sections must use plain `## Title` headings **without a leading
  emoji** (e.g. `## Extension methods`, not `## 📐 Extension methods`). pub.dev auto-generates IDs
  from heading text; emoji-first headings produce broken IDs like `#-install`. Do not use raw
  `<h2 id="...">` — it does not scroll reliably on pub.dev. Keep `doc/` links relative.
- Do **not** use `<details>` / `<summary>` for collapsing. pub.dev's HTML sanitizer does not render
  them reliably (open FIXME tests in `dart-lang/pub-dev`), so content inside would vanish.
- Repeating a concept between README and `doc/` is fine; repeating it **twice inside the README**
  is the failure mode that made the pre-2.0 version unreadable.
- Keep visual content near the top — Dart's own package-page guidance calls a wall of text
  intimidating.
- `README_old.md` is the pre-2.0 version, kept in git for history and excluded from the pub archive
  by `.pubignore`.

## Runtime architecture

```
ScaleKitBuilder
  listens MediaQuery.sizeOf + orientationOf (not viewInsets)
  init/update ScaleManager
        │
        ▼
ScaleManager (singleton)          ratios, clamps, boosts, device type, breakpoints
        │
        ▼
ScaleValueFactory (factory)       public create/resolve API
        │
        ▼
ScaleValueCache (flyweight, LRU 2000)
        │
        ▼
SKScaledValueTracker               Map-based “already scaled?” marks (FFI-safe)
```

Patterns: **Singleton** (`ScaleManager`, factory, cache, `FontConfig`), **Factory**, **Flyweight**.

## Public surface (map, not recipes)

| Area | Types / entry points |
| --- | --- |
| Bootstrap | `ScaleKitBuilder` (`designWidth/Height`, optional limits, boosts, locks, breakpoints, `enabled` / `enabledListenable`) |
| Engine | `ScaleManager.instance` |
| Extensions | `num`: `.w` `.h` `.sp` `.spf` `.r` `.rSafe` `.rFixed` `.sw` `.sh` + Min/Max/Clamp; also `EdgeInsets`, `BoxConstraints`, `Radius`, `BorderRadius`; `12.horizontalSpace` / `16.verticalSpace` |
| SK widgets | `SKContainer`, `SKText`, `SKPadding`, `SKMargin`, `SKIcon`, `SKCard`, `SKDivider`, `SKAppBar`, `SKListTile`, `SKSwitch`, `SKSwitchListTile`, `SKTextField`, `SKTextFormField`, `SKElevatedButton`, `SKTextButton`, `SKOutlinedButton`, `SKIconButton`, chips, `SKImage` |
| Helpers | `SKit.*`, `HSpace` / `VSpace` / `SSpace` / `SKSizedBox` |
| Responsive | `SKResponsive`, `SKResponsiveBuilder`, `SKit.responsiveInt` / `responsiveDouble` |
| Tokens | `ScaleKitDesignValues`, `SKSize`, `SKTextSize`, `setPaddingSizes` / `setDefaultPadding` (and margin/radius/spacing/text) |
| Fonts / theme | `FontConfig`, `ResponsiveThemeData.create` |
| Device | `DeviceMetricsMixin`, context helpers (`isMobile`, `isDesktopPlatform`, `screenSizeClass`, …) |

Public exports live in `lib/flutter_scale_kit.dart`. SK widgets are re-exported via `const_widgets.dart`.

## Device model

Three **different** questions; do not mix them:

1. **Responsive type** (`DeviceType`: mobile / tablet / desktop / web) — width + overrides + desktop lock.
2. **Platform** (`PlatformCategory`) — Android / iOS / desktop OS / web. Must stay web/Wasm-safe (`kIsWeb` first; no naive `dart:io`).
3. **Size class** (`DeviceSizeClass`) — width buckets from `ScaleBreakpoints`.

Default breakpoints: mobile ≤ **600**, tablet ≤ **1200**, desktop ≤ **1600**, large desktop ≤ **1920**.

**Device query cheat sheet** (agents + users): `skills/flutter-scale-kit/device-classification.md`.

| Goal | API |
| --- | --- |
| Phone OS | `context.isMobilePlatform` |
| Scaling / `SKResponsiveBuilder` | `context.isResponsiveMobile` / `isTypeOfMobile()` |
| Viewport width bucket | `context.isMobileViewport` (`isMobile` alias) — **false on landscape phones** |
| Layout by orientation | `SKResponsiveBuilder(mobile:, mobileLandscape:)` |

`designType` on `ScaleKitBuilder` is **not wired** — use `deviceTypeOverride` to force.

Desktop/web can be remapped with `lockDesktopPlatforms` + `lockDesktopAsTablet` / `lockDesktopAsMobile`. Remap still respects live window width (a wide locked-as-mobile window can stay desktop). Per-widget flags: `deviceTypeOverride`, `desktopAs`, lock flags.

## Scaling pipeline (defaults)

```
rawScale = screen / design
clamped  = clamp(rawScale, minScale, maxScale)   // auto per device if unset
boosted  = clamped × orientationBoost              // landscape on by default; portrait off
font     = boosted × systemTextScale              // for .sp / .spf
```

Smart default limits (approx.): mobile 0.85–1.15 portrait / 0.85–1.25 landscape; tablet wider; desktop 0.6–2.0. Default landscape boost **1.2×** on mobile/tablet (font and size); desktop **1.0×**. `sizeChangeThreshold`: **5%** mobile/tablet, **0%** desktop/web.

`ScalingStrategy` also adjusts for narrow/wide/standard aspect ratios.

## Rebuild / cache behavior

- Rebuild on size/orientation only; keyboard `viewInsets` must not invalidate scale.
- Cache keys include a device **context integer** (`cacheContextKey`).
- Cache + tracker clear on resize / orientation / disable.

## Example app

`example/` is the live playground (settings sheet toggles autoscale and package enable). Do not treat example code as the public API contract.
