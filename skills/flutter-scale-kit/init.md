# Init Scale Kit in the user's app

## Detect

1. Read `scale_kit.yaml` or `.scalekit.yaml` at the app root (style + design size).
2. Already wired if `ScaleKitBuilder(` exists under `lib/`. Then do not re-wrap `main`; still write yaml if style was missing.
3. Otherwise run init after the interview.

## Interview (one message)

Always include **style** if yaml is missing. Recommend **design_system**. Ask the rest only if they did not say “defaults”.

1. **Style** (required if no yaml) — `design_system` recommended / `drop_in` / `extensions` / `hybrid`  
   See [styles.md](styles.md) for one-line examples to paste in the question.
2. **Design size** — Mobile 375×812 (default) / Tablet 768×1024 / Desktop 1440×900 / custom W×H from Figma
3. **Token scale** — Scale Kit recommended 4–48 (default) / `SizeValues.material3()` / `SizeValues.tailwind()` / paste Figma values
4. **Fonts** — Skip (default) / Inter via `google_fonts` / custom family name / extra languages (e.g. `ar` → Almarai)
5. **Desktop/web** — Auto (default) / lock as tablet / lock as mobile
6. **Dart config path** — `lib/core/scale_kit.dart` (default)

If they ignore the questions, use `design_system` + other defaults and list assumptions.

After answers (or defaults), **write `scale_kit.yaml`** at the app root using [scale_kit.yaml.example](scale_kit.yaml.example).

## Steps

1. Add dependency: `flutter pub add flutter_scale_kit`  
   If fonts = Inter: `flutter pub add google_fonts`
2. Write `scale_kit.yaml` at the app root (from [scale_kit.yaml.example](scale_kit.yaml.example))
3. Write `lib/core/scale_kit.dart` (template below)
4. Call `initScaleKit()` at the top of `main()` before `runApp`
5. Wrap the existing root widget with `ScaleKitBuilder` — do not replace routing/state. Keep their `MaterialApp` as the child
6. Theme — if `pubspec.yaml` lists **`flutter_scale_theme_kit`**, use Theme Kit merge ([Merge with Theme Kit](#merge-with-theme-kit)); skip `ResponsiveThemeData.create`. Otherwise, optionally set `theme: ResponsiveThemeData.create(context: context, ...)` **inside** a `Builder` under `ScaleKitBuilder` (context must see Scale Kit). If you keep their existing theme, `.sp` / `SKText` still scale.

## Template — `lib/core/scale_kit.dart`

```dart
import 'package:flutter_scale_kit/flutter_scale_kit.dart';
// import 'package:google_fonts/google_fonts.dart'; // only if user chose Google Fonts

/// Call from main() before runApp.
void initScaleKit() {
  setPaddingSizes(SizeValues.custom(xs: 4, sm: 8, md: 16, lg: 24, xl: 32, xxl: 48));
  setMarginSizes(SizeValues.custom(xs: 4, sm: 8, md: 12, lg: 16, xl: 24, xxl: 32));
  setRadiusSizes(SizeValues.custom(xs: 4, sm: 8, md: 12, lg: 16, xl: 20, xxl: 28));
  setSpacingSizes(SizeValues.custom(xs: 4, sm: 8, md: 16, lg: 24, xl: 32, xxl: 48));
  setTextSizes(TextSizeValues.material3());

  setDefaultPadding(16);
  setDefaultMargin(8);
  setDefaultRadius(12);
  setDefaultSpacing(8);
  setDefaultTextSize(14);

  // Optional fonts:
  // FontConfig.instance
  //   ..setDefaultFont(googleFont: GoogleFonts.inter)
  //   ..setLanguageGroupFont(LanguageGroupFontConfig(
  //     languageCodes: ['ar', 'fa', 'ur'],
  //     googleFont: GoogleFonts.almarai,
  //   ));
}

/// Compute-once tokens for a screen. Call inside build().
const appDesign = ScaleKitDesignValues(
  textXs: 12,
  textSm: 14,
  textMd: 16,
  textLg: 18,
  textXl: 24,
  textXxl: 32,
  paddingSm: 8,
  paddingMd: 16,
  paddingLg: 24,
  radiusSm: 8,
  radiusMd: 12,
  radiusLg: 16,
  spacingSm: 8,
  spacingMd: 16,
  spacingLg: 24,
);
```

Token scale alternatives:

- Material 3: `setPaddingSizes(SizeValues.material3());` (and the other `set*Sizes`)
- Tailwind: `SizeValues.tailwind()`

## Template — `main.dart` wrap

```dart
import 'package:flutter/material.dart';
import 'package:flutter_scale_kit/flutter_scale_kit.dart';
import 'core/scale_kit.dart';

void main() {
  initScaleKit();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaleKitBuilder(
      designWidth: 375,
      designHeight: 812,
      designType: DeviceType.mobile,
      // lockDesktopPlatforms: true,
      // lockDesktopAsTablet: true,
      child: MaterialApp(
        title: 'App',
        home: const HomePage(),
      ),
    );
  }
}
```

Custom design size: set `designWidth` / `designHeight` from the interview. `designType` is optional
(documentation only today — does **not** change detection; use `deviceTypeOverride` to force).

Device queries: see [device-classification.md](device-classification.md) — do not use `context.isMobile`
for “phone vs tablet” (width-only; false in landscape).

Desktop lock examples:

- Tablet-like desktop: `lockDesktopPlatforms: true, lockDesktopAsTablet: true`
- Mobile-like desktop: `lockDesktopPlatforms: true, lockDesktopAsMobile: true`

## Material 3 tokens shortcut

If they chose Material 3 scale:

```dart
setPaddingSizes(SizeValues.material3());
setMarginSizes(SizeValues.material3());
setRadiusSizes(SizeValues.material3());
setSpacingSizes(SizeValues.material3());
```

(`material3` = xs=4, sm=8, md=12, lg=16, xl=24, xxl=32)

## Merge with Theme Kit

When the app also has `flutter_scale_theme_kit`, **use it** for look. Keep `initScaleKit()` + `ScaleKitBuilder`. Define `appST` in `lib/core/design.dart` (`STTheme` + `STColors` + `STRadius`). Pass Theme Kit `ThemeData` and scale the **text theme** (not a second ColorScheme):

```dart
import 'package:flutter_scale_theme_kit/flutter_scale_theme_kit.dart';
import 'core/design.dart'; // appST

return ScaleKitBuilder(
  designWidth: 375,
  designHeight: 812,
  designType: DeviceType.mobile,
  child: Builder(
    builder: (context) {
      return STThemeModeScope(
        builder: (context, mode) {
          return MaterialApp(
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
```

Prefer wrapping `MaterialApp` with Theme Kit’s `STThemeModeScope` when the user wants in-app light/dark switch (`context.stMode`).

**Do not** use `ResponsiveThemeData.create(colorScheme: appST.light.colorScheme)` as `theme:` — component themes (Card, buttons, inputs) disappear.

Align `setRadiusSizes(SizeValues.custom(md: …))` with `STRadius(md: …)`.

## Checklist

- [ ] `scale_kit.yaml` at app root (`style` set)
- [ ] `flutter_scale_kit` in pubspec
- [ ] `initScaleKit()` before `runApp`
- [ ] `ScaleKitBuilder` above the app widget
- [ ] No second builder nested later
- [ ] Existing `MediaQuery` / Router / localization unchanged
- [ ] If Theme Kit is installed: `theme:` is `appST.light.copyWith(textTheme: …createResponsiveTextTheme…)` (same for dark), not `ResponsiveThemeData.create` alone
