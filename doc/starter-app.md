# Starter app — Scale Kit + Theme Kit together

A complete first-time setup for a real app, in four short files. Copy them in order.

**The split to keep in your head:**

| Package | Owns | You call |
| --- | --- | --- |
| `flutter_scale_kit` | **Size** — widths, padding, radius values, font sizes | `SK*`, `SKit`, `.w` / `.sp` |
| `flutter_scale_theme_kit` | **Look** — colors, light/dark, component styling | `context.st`, `appST.light` |

They don't depend on each other. Use either alone, or both like this.

- [1. pubspec.yaml](#1-pubspecyaml)
- [2. lib/core/design.dart — the look](#2-libcoredesigndart--the-look)
- [3. lib/core/scale_kit.dart — the size](#3-libcorescale_kitdart--the-size)
- [4. lib/main.dart — wire both](#4-libmaindart--wire-both)
- [5. A real screen](#5-a-real-screen)
- [Four ways to write the same widget](#four-ways-to-write-the-same-widget)
- [Rules that keep the two packages from fighting](#rules-that-keep-the-two-packages-from-fighting)

---

## 1. pubspec.yaml

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_scale_kit: ^2.0.0
  flutter_scale_theme_kit: ^1.0.1
  google_fonts: ^6.2.1 # optional, only if you want custom fonts
```

---

## 2. `lib/core/design.dart` — the look

Colors and radius tokens. `STColors` requires `primary`, `surface`, `background`, and `text`;
everything else is derived if you leave it out.

```dart
import 'package:flutter/material.dart';
import 'package:flutter_scale_theme_kit/flutter_scale_theme_kit.dart';

/// Every color carries both its light and dark value, so one definition
/// serves both themes.
final appST = STTheme(
  colors: STColors(
    primary: STColor(light: Color(0xFF6750A4), dark: Color(0xFFD0BCFF)),
    surface: STColor(light: Color(0xFFFFFFFF), dark: Color(0xFF1E1E1E)),
    background: STColor(light: Color(0xFFF7F7F7), dark: Color(0xFF121212)),
    text: STColor(light: Color(0xFF1C1B1F), dark: Color(0xFFE6E1E5)),

    // Optional — omit and these are derived from the four above
    secondary: STColor(light: Color(0xFF625B71), dark: Color(0xFFCCC2DC)),
    error: STColor(light: Color(0xFFB3261E), dark: Color(0xFFF2B8B5)),

    // Your own named colors, read later with context.st.color('brand')
    extra: {'brand': STColor(light: Color(0xFFFFB800), dark: Color(0xFFFFCB47))},
  ),

  // Keep these numbers equal to setRadiusSizes below.
  radius: const STRadius(sm: 8, md: 12, lg: 16),
);
```

---

## 3. `lib/core/scale_kit.dart` — the size

One function, called once before `runApp`.

```dart
import 'package:flutter_scale_kit/flutter_scale_kit.dart';
import 'package:google_fonts/google_fonts.dart';

void initScaleKit() {
  // What sm / md / lg mean in your app.
  setPaddingSizes(SizeValues.custom(xs: 4, sm: 8, md: 16, lg: 24, xl: 32, xxl: 48));
  setMarginSizes(SizeValues.custom(xs: 2, sm: 4, md: 8, lg: 12, xl: 16, xxl: 24));
  setSpacingSizes(SizeValues.custom(xs: 4, sm: 8, md: 16, lg: 24, xl: 32, xxl: 48));

  // Must match STRadius in design.dart.
  setRadiusSizes(SizeValues.custom(xs: 4, sm: 8, md: 12, lg: 16, xl: 24, xxl: 32));

  // Defaults for the bare helpers: SKit.pad(), SKit.rounded(), SKit.v() …
  setDefaultPadding(16);
  setDefaultRadius(12);
  setDefaultSpacing(8);
  setDefaultTextSize(14);

  // Optional. Applied to every scaled text style, picked by locale.
  FontConfig.instance
    ..setDefaultFont(googleFont: GoogleFonts.inter)
    ..setLanguageGroupFont(
      const LanguageGroupFontConfig(
        languageCodes: ['ar', 'fa', 'ur'],
        googleFont: GoogleFonts.almarai,
      ),
    );
}

/// Optional: tokens for screens that use many values at once.
const appDesign = ScaleKitDesignValues(
  textSm: 12, textMd: 14, textLg: 18,
  paddingMd: 16, spacingMd: 16, radiusMd: 12,
);
```

---

## 4. `lib/main.dart` — wire both

The nesting order matters: `ScaleKitBuilder` → `Builder` → `STThemeModeScope` → `MaterialApp`.

```dart
import 'package:flutter/material.dart';
import 'package:flutter_scale_kit/flutter_scale_kit.dart';
import 'package:flutter_scale_theme_kit/flutter_scale_theme_kit.dart';

import 'core/design.dart';
import 'core/scale_kit.dart';
import 'pages/home_page.dart';

void main() {
  initScaleKit();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. ScaleKitBuilder above MaterialApp, so every route inherits scaling.
    return ScaleKitBuilder(
      designWidth: 375,
      designHeight: 812,
      designType: DeviceType.mobile,

      // 2. Builder gives us a context BELOW ScaleKitBuilder, which the
      //    responsive text theme needs to read the active scale.
      child: Builder(
        builder: (context) {
          // 3. STThemeModeScope owns light/dark and rebuilds on toggle.
          return STThemeModeScope(
            builder: (context, mode) {
              return MaterialApp(
                title: 'My App',

                // 4. Theme Kit's full theme, with ONLY the text theme
                //    swapped for a scaled one. copyWith keeps every
                //    component style (cards, buttons, inputs) intact.
                theme: appST.light.copyWith(
                  textTheme: appST.light.createResponsiveTextTheme(
                    appST.light.textTheme,
                  ),
                ),
                darkTheme: appST.dark.copyWith(
                  textTheme: appST.dark.createResponsiveTextTheme(
                    appST.dark.textTheme,
                  ),
                ),
                themeMode: mode.mode,
                home: const HomePage(),
              );
            },
          );
        },
      ),
    );
  }
}
```

> ⚠️ Do **not** use `ResponsiveThemeData.create(...)` as `theme:` here. It builds a whole new theme
> and throws away Theme Kit's component styling. `copyWith(textTheme: …)` is the merge you want.

---

## 5. A real screen

Sizes come from Scale Kit, colors from Theme Kit, and the column count adapts per device.

```dart
import 'package:flutter/material.dart';
import 'package:flutter_scale_kit/flutter_scale_kit.dart';
import 'package:flutter_scale_theme_kit/flutter_scale_theme_kit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // 2 columns on phones, 4 on tablets, 6 on desktop.
    final columns = SKit.responsiveInt(
      context: context,
      mobile: 2,
      tablet: 4,
      desktop: 6,
    );

    return Scaffold(
      backgroundColor: context.st.background,
      appBar: SKAppBar(
        title: SKText('Dashboard', fontSize: 20, fontWeight: FontWeight.w600),
        toolbarHeight: 56,
        actions: [
          // Theme Kit owns the light/dark switch.
          IconButton(
            icon: Icon(context.stMode.isDark(context)
                ? Icons.light_mode
                : Icons.dark_mode),
            onPressed: () => context.stMode.toggle(),
          ),
        ],
      ),
      body: SKit.paddingSize(
        all: SKSize.md,
        child: GridView.count(
          crossAxisCount: columns,
          crossAxisSpacing: 12.w,
          mainAxisSpacing: 12.h,
          children: const [
            _StatCard(label: 'Revenue', value: r'$12.4k'),
            _StatCard(label: 'Orders', value: '318'),
            _StatCard(label: 'Users', value: '1,204'),
            _StatCard(label: 'Refunds', value: '7'),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return SKContainer(
      // Raw numbers — SKContainer scales them. No .w here.
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.st.surface,              // look
        borderRadius: BorderRadius.circular(12), // size, clamped via rSafe
        border: Border.all(color: context.st.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SKText(
            label,
            fontSize: 12,
            color: context.st.textSecondary,
          ),
          SKit.vSpaceSize(SKSize.xs),
          SKText(
            value,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: context.st.text,
          ),
        ],
      ),
    );
  }
}
```

That is the whole pattern: **`context.st.*` for every color, raw numbers inside `SK*` for every
size.** You never write `Colors.grey` and you never write `.w` inside an `SK*` widget.

---

## Four ways to write the same widget

Scale Kit does not force one style. Here is one card in each, so you can pick — and you can mix
them in the same file.

**`design_system`** — tokens, no raw numbers. Most consistent, recommended for new apps.

```dart
SKit.roundedContainerSize(
  all: SKSize.md,
  color: context.st.surface,
  child: SKit.paddingSize(
    all: SKSize.md,
    child: SKit.text('Revenue', textSize: SKTextSize.s16),
  ),
);
```

**`drop_in`** — `SK*` widgets with raw design numbers. Fastest migration from an existing app.

```dart
SKContainer(
  padding: EdgeInsets.all(16),
  decoration: BoxDecoration(
    color: context.st.surface,
    borderRadius: BorderRadius.circular(12),
  ),
  child: SKText('Revenue', fontSize: 16),
);
```

**`extensions`** — plain Flutter widgets with `.w` / `.sp`. Familiar if you come from
`flutter_screenutil`.

```dart
Container(
  padding: EdgeInsets.all(16.w),
  decoration: BoxDecoration(
    color: context.st.surface,
    borderRadius: BorderRadius.circular(12.rSafe),
  ),
  child: Text('Revenue', style: TextStyle(fontSize: 16.sp)),
);
```

**`hybrid`** — tokens for spacing, extensions for the odd Figma number. What most apps drift into.

```dart
SKit.paddingSize(
  all: SKSize.md,
  child: SizedBox(
    width: 73.w, // that one specific value from the design
    child: SKText('Revenue', fontSize: 16),
  ),
);
```

> Tell your AI agent which one you picked and it will stay consistent:
> `npx skills add fodilfliti/flutter_scale_kit`, then "Init Flutter Scale Kit with design_system".

---

## Rules that keep the two packages from fighting

**Never double-scale.** `SK*` widgets scale what you pass them.

```dart
SKContainer(width: 120)    // ✅
SKContainer(width: 120.w)  // ❌ scaled twice
```

**Keep radius numbers in sync.** `setRadiusSizes(...)` in `scale_kit.dart` and `STRadius(...)` in
`design.dart` should hold the same values, or a scaled card won't match a themed button.

**Know which radius you're reading.** `context.st.radius.md` is the raw token Theme Kit gives its
component themes — it is *not* scaled. Inside `SK*` widgets use `BorderRadius.circular(12)` and let
Scale Kit clamp it.

**Colors always come from Theme Kit.** If you're reaching for `Theme.of(context).colorScheme`, use
`context.st` instead — it carries your light and dark values together.

**Merge, don't replace.** Always `appST.light.copyWith(textTheme: …)`. Passing
`ResponsiveThemeData.create(...)` as `theme:` drops Theme Kit's component styling.

---

## Where to go next

- [Scale Kit README](../README.md) — every feature, one page
- [Design system guide](design-system.md) — deeper token and font recipes
- [Recipes](recipes.md) — grids, RTL, testing patterns
- [`example/`](../example) — the full interactive demo app in this repo
