---
name: flutter-scale-kit
description: >
  Use flutter_scale_kit with a project style (design_system recommended, or drop_in,
  extensions, hybrid). Read scale_kit.yaml first; if missing, ask the user once and
  write it. Tokens + SK widgets by default; .w/.sp for tweaks; SKResponsive only when
  layout structure changes. Apply when adding flutter_scale_kit, initializing
  ScaleKitBuilder, writing responsive UI, migrating from flutter_screenutil, or when
  the user says init scale kit / setup responsive / design system.
license: MIT
metadata:
  author: fodilfliti
  version: "2.0.2"
  homepage: https://pub.dev/packages/flutter_scale_kit
  repo: https://github.com/fodilfliti/flutter_scale_kit
---

# Flutter Scale Kit (consumer)

You are implementing **usage** of the pub package `flutter_scale_kit`, not the package internals.

Read extra files only when needed:

- Init / `main.dart` wiring → [init.md](init.md)
- Style modes + examples → [styles.md](styles.md)
- API cheat sheet → [api.md](api.md)
- **Device classification (isMobile vs landscape)** → [device-classification.md](device-classification.md)
- Screen patterns → [patterns.md](patterns.md)

## Project style (check first)

1. Read `scale_kit.yaml` or `.scalekit.yaml` at the app root.
2. If `style` is set → follow that mode for **all** UI in this project (see [styles.md](styles.md)). Do not ask again.
3. If the file is **missing** and you are about to init or write Scale Kit UI → **ask once**, then write `scale_kit.yaml`.

Ask in one message. Recommend **design_system**. Include a one-line example per option:

```text
How should this project use Flutter Scale Kit? I recommend 1.

1. design_system (recommended) — tokens + SK widgets
   SKit.paddingSize(all: SKSize.md, child: SKText('Hi', fontSize: 16))
2. drop_in — SKContainer/SKText with raw px (fast migration)
3. extensions — keep Flutter widgets, use .w / .sp / .rSafe
4. hybrid — new UI = design_system, leftover widgets = .w

Reply with a number, or "defaults".
```

If they skip or say defaults → `style: design_system` and say you assumed that.

Also ask design size / fonts / desktop only when they did not say defaults (see [init.md](init.md)).

**Init immediately** after style is known when: user says init/setup, no `ScaleKitBuilder`, or first responsive widget.

If `ScaleKitBuilder` exists but yaml is missing: still ask style once, write yaml, **do not** re-wrap `main`.

## Recommended defaults (design system)

Use these unless the user overrides:

| Choice | Default |
| --- | --- |
| Design canvas | `375 × 812`, `DeviceType.mobile` (iPhone 13 mini / common Figma mobile) |
| Tokens | Material-like spacing: padding/spacing `4, 8, 16, 24, 32, 48`; radius `4, 8, 12, 16, 20, 28` |
| Text | `TextSizeValues.material3()` |
| Widgets | `SK*` drop-ins + `SKit` helpers; tokens via `SKSize` / `ScaleKitDesignValues` |
| Desktop/web | Auto-detect (no lock) |
| Fonts | Skip `FontConfig` unless they use `google_fonts` or named a family |
| Theme | `ResponsiveThemeData.create` only if they already have a `ThemeData` **and** do **not** use `flutter_scale_theme_kit`. If `pubspec.yaml` lists `flutter_scale_theme_kit`, **use it** (see below). |

Always:

1. `flutter_scale_kit` in `pubspec.yaml` (`flutter pub add flutter_scale_kit` if missing)
2. Call token setup in `main()` **before** `runApp`
3. Wrap the root app with `ScaleKitBuilder` **above** `MaterialApp` / `GetMaterialApp` / `CupertinoApp`
4. Create `lib/core/scale_kit.dart` (or `lib/app/scale_kit.dart`) so tokens live in one file

## Look companion (`flutter_scale_theme_kit`)

If the app `pubspec.yaml` contains **`flutter_scale_theme_kit`** (or the user asks to add look/theme tokens):

- **Use it.** Look = `STTheme` / `context.st` / `appST.light` / `appST.dark`. Size stays this package.
- **Merge** under `ScaleKitBuilder` + `Builder`:

```dart
child: Builder(
  builder: (context) {
    return MaterialApp(
      theme: appST.light.copyWith(
        textTheme: appST.light.createResponsiveTextTheme(appST.light.textTheme),
      ),
      darkTheme: appST.dark.copyWith(
        textTheme: appST.dark.createResponsiveTextTheme(appST.dark.textTheme),
      ),
      home: const HomePage(),
    );
  },
),
```

- **Do not** set `theme: ResponsiveThemeData.create(...)` — that **drops** card/button/input themes from Theme Kit.
- Align radius in the app: `setRadiusSizes(SizeValues.custom(md: 12))` and `STRadius(md: 12)`.
- Load the Theme Kit skill when present: `skills` from `flutter_scale_theme_kit` (`npx skills add fodilfliti/flutter_scale_theme_kit`).

The two packages live as **sibling folders** (`flutter_scale_kit` + `flutter_scale_theme_kit`). Neither `lib/` imports the other.

## Best strategy (small code, strongest APIs)

“Small path” means **few lines with the best of this package**, not `.w` everywhere and not a huge responsive tree.

**Canonical stack (use this unless a row below says otherwise):**

1. `ScaleKitBuilder` + tokens in `lib/core/scale_kit.dart` (once)
2. **Design system** — `SKSize` / `SKit.*Size` / `ScaleKitDesignValues.compute()` for padding, gaps, radius
3. **`SK*` drop-ins** — `SKContainer`, `SKText`, `SKPadding`, `SKTextField`, `SKElevatedButton` with **raw design-px**. One widget replaces `Container` + `.w` + `.h` + `.rSafe`
4. **`SKit.roundedContainerSize`** for cards (safe radius built in)

That combo is the smart default: short, consistent, and it uses the package’s real strengths (tokens, auto-scale widgets, no double-scale).

| Need | Best API (still small) | Do not |
| --- | --- | --- |
| Normal screen | Tokens + `SK*` | `.w` on every number, `SKResponsive` |
| Screen with many sizes | `final v = appDesign.compute()` then `v.paddingMd` | Repeating `16.w` |
| Card / section | `SKit.roundedContainerSize(all: SKSize.md, …)` | `BoxDecoration` + `.r` by hand |
| Odd Figma px (73) or leftover Flutter widget | `.w` / `.sp` / `.rSafe` | Converting the whole file only for one number |
| Width/font would get huge on desktop | `200.wMax(360)`, `16.spClamp(14, 20)` | Extra layout |
| Grid columns / item count | `SKit.responsiveInt` | `SKResponsive` wrapping the grid |
| Different **structure** (rail vs bottom bar, list vs split view) | `SKResponsive` / `SKResponsiveBuilder` | Responsive builder for padding/font |

```dart
// BEST default — tokens + SK (scales, consistent, short)
SKit.paddingSize(
  all: SKSize.md,
  child: SKit.roundedContainerSize(
    all: SKSize.md,
    child: Column(
      children: [
        SKText('Title', fontSize: 20, fontWeight: FontWeight.w600),
        SKit.vSpaceSize(SKSize.sm),
        SKText('Body', fontSize: 14),
      ],
    ),
  ),
);
```

```dart
// Escape hatch — one leftover widget or a clamp
SizedBox(width: 120.wMax(200), child: oldChild)
```

Never double-scale: `SKContainer(width: 120)` OK; `SKContainer(width: 120.w)` BAD.

Cards: `.rSafe` / `SKRadiusMode.safe`. Pills/avatars: `.r`.

## Do / don't

- Do search-replace drop-ins: `Container` → `SKContainer`, `Text` → `SKText`, `Padding` → `SKPadding`, etc.
- Do keep one design system: no magic `EdgeInsets.all(13)` when `SKSize.md` exists
- Do use **`context.isResponsiveMobile`** / **`isTypeOfMobile()`** for scaling and device-class branches; **`context.isMobilePlatform`** for OS chrome; **`SKResponsiveBuilder`** (`mobile` + `mobileLandscape`) for layout structure — see [device-classification.md](device-classification.md)
- Do **not** use `context.isMobile` / `isMobileViewport` for “is this a phone?” — width-only; **false in landscape** on many phones
- Do **not** rely on `designType:` on `ScaleKitBuilder` — not wired; use `deviceTypeOverride` only when forcing detection
- Don't copy `flutter_screenutil` `ScreenUtilInit` — use `ScaleKitBuilder`
- Don't add `google_fonts` unless the user wants it (pass `GoogleFonts.*` into `FontConfig`; the package does not depend on it)
- Don't subscribe to full `MediaQuery` for scaling; the builder already handles size/orientation
- Don't wrap a screen in `SKResponsive` just to change padding or font size — tokens + SK already scale
- Don't invent APIs. If unsure, read [api.md](api.md) or the installed package source

## After init

Follow `scale_kit.yaml` `style`. If it is `design_system` (recommended):

- Normal screens: tokens + `SK*` / `SKit.roundedContainerSize`
- Busy screens: `appDesign.compute()` once, reuse `v.*`
- Grids: `SKit.responsiveInt` (not `SKResponsive`)
- Split layouts: `SKResponsiveBuilder`
- Forms: `SKTextField` / `SKTextFormField` / `SKElevatedButton`

If `drop_in` / `extensions` / `hybrid`, use the matching snippets in [styles.md](styles.md).
