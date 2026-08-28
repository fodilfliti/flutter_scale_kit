# Design system

Define spacing, radius, and text scales once, then use names instead of numbers everywhere. This is the recommended way to use Scale Kit on a new app.

> Supplement to the [README](../README.md#design-system), which covers the essentials inline. Read
> this for extended token and font recipes.

- [Configure your scales](#configure-your-scales)
- [Size enums](#size-enums)
- [Default values](#default-values)
- [ScaleKitDesignValues](#scalekitdesignvalues)
- [Typography](#typography)
- [Fonts](#fonts)
- [ThemeData integration](#themedata-integration)

---

## Configure your scales

Call the setters in `main()` **before** `runApp`, so every screen agrees on what `md` means.

```dart
void main() {
  setPaddingSizes(SizeValues.custom(xs: 4, sm: 8,  md: 16, lg: 24, xl: 32, xxl: 48));
  setMarginSizes(SizeValues.custom(xs: 2, sm: 4,  md: 8,  lg: 12, xl: 16, xxl: 24));
  setRadiusSizes(SizeValues.custom(xs: 2, sm: 4,  md: 8,  lg: 12, xl: 16, xxl: 24));
  setSpacingSizes(SizeValues.custom(xs: 4, sm: 8, md: 12, lg: 16, xl: 20, xxl: 24));
  setTextSizes(TextSizeValues.custom(s14: 15, s16: 17, s18: 20, s24: 26));

  runApp(const MyApp());
}
```

If you skip this, sensible defaults apply (`xs: 2, sm: 4, md: 8, lg: 12, xl: 16, xxl: 24`).

### Preset scales

```dart
setPaddingSizes(SizeValues.material3()); // xs 4, sm 8, md 12, lg 16, xl 24, xxl 32
setPaddingSizes(SizeValues.tailwind());
setTextSizes(TextSizeValues.material3());
```

Apply the same preset to `setMarginSizes`, `setRadiusSizes`, and `setSpacingSizes` for a consistent system.

---

## Size enums

Once configured, use `SKSize` instead of raw numbers:

```dart
SKit.paddingSize(all: SKSize.md, child: widget);
SKit.paddingSize(horizontal: SKSize.lg, vertical: SKSize.sm, child: widget);
SKit.marginSize(all: SKSize.md, child: widget);
SKit.roundedContainerSize(all: SKSize.lg, color: Colors.blue);
SKit.hSpaceSize(SKSize.md);
SKit.vSpaceSize(SKSize.sm);
```

Values: `xs`, `sm`, `md`, `lg`, `xl`, `xxl`.

Text uses `SKTextSize` (`s6` through `s52`):

```dart
SKit.text('Title', textSize: SKTextSize.s20, fontWeight: FontWeight.w600);
```

---

## Default values

Set app-wide defaults so the shorthand helpers need no arguments at all:

```dart
void main() {
  setDefaultPadding(16);
  setDefaultMargin(8);
  setDefaultRadius(12);
  setDefaultSpacing(8);
  setDefaultTextSize(14);

  runApp(const MyApp());
}
```

```dart
SKit.pad()      // padding 16
SKit.margin()   // margin 8
SKit.rounded()  // safe radius 12
SKit.h()        // horizontal gap 8
SKit.v()        // vertical gap 8
```

---

## ScaleKitDesignValues

For screens that use many tokens, compute the whole set **once per build** instead of scaling each value separately.

```dart
// 1. Define once — can be const, so put it in a shared file
const appDesign = ScaleKitDesignValues(
  textSm: 12, textMd: 14, textLg: 16, textXl: 24,
  paddingSm: 8, paddingMd: 16, paddingLg: 24,
  spacingSm: 8, spacingMd: 16, spacingLg: 24,
  radiusSm: 6, radiusMd: 12, radiusLg: 16,
);

// 2. Compute once per build
final v = appDesign.compute();

// 3. Use everywhere — already scaled
SKPadding(
  padding: v.paddingMd!,
  child: SKContainer(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: v.borderRadiusMd,
    ),
    child: Text('Hello', style: v.textMd),
  ),
);
```

`compute()` returns a `ScaleKitDesignValuesSet` holding ready `EdgeInsets`, `BorderRadius`, and `TextStyle` objects.

**Why:** one calculation per screen, centralized tokens, and type safety instead of magic numbers.

> `SKitTheme` and `SKitThemeValues` are the deprecated old names for `ScaleKitDesignValues` and `ScaleKitDesignValuesSet`. Existing code keeps compiling, but use the new names.

---

## Typography

### SKit.textFull()

Exposes every Flutter `Text` attribute with scaling applied:

```dart
SKit.textFull(
  'Hello World',
  fontSize: 18,           // scaled
  fontWeight: FontWeight.w600,
  color: Colors.blue,
  letterSpacing: 0.5,
  decoration: TextDecoration.underline,
  shadows: [Shadow(color: Colors.black26, offset: Offset(1, 1))],
  textAlign: TextAlign.center,
  maxLines: 2,
  overflow: TextOverflow.ellipsis,
);
```

Supported groups:

- **Style** — `fontSize`, `fontWeight`, `fontStyle`, `color`, `backgroundColor`, `fontFamily`
- **Spacing** — `letterSpacing`, `wordSpacing`, `height`
- **Decoration** — `decoration`, `decorationColor`, `decorationStyle`, `decorationThickness`
- **Layout** — `textAlign`, `textDirection`, `maxLines`, `overflow`, `softWrap`
- **Effects** — `shadows`, `foreground`, `background`

### SKit.textStyleFull()

Same attributes, returns a reusable `TextStyle`:

```dart
final headerStyle = SKit.textStyleFull(
  fontSize: 24,
  fontWeight: FontWeight.bold,
  color: Colors.white,
  letterSpacing: 1.2,
  height: 1.5,
);
```

### Which one

| Use | When |
| --- | --- |
| `SKText` | Drop-in replacement for `Text` |
| `SKit.text()` | Simple text with token sizes (`SKTextSize`) |
| `SKit.textFull()` | You need advanced `Text` widget features |
| `SKit.textStyleFull()` | You need a reusable style object |

---

## Fonts

`FontConfig` is optional. Without it, Flutter's default font is used. With it, **every** scaled text path picks up your font automatically — extensions, `SKText`, `SKit.text*`, and responsive themes.

```dart
import 'package:google_fonts/google_fonts.dart';

void main() {
  FontConfig.instance
    ..setDefaultFont(googleFont: GoogleFonts.inter)
    ..setLanguageFont(
      const LanguageFontConfig(
        languageCode: 'ja',
        googleFont: GoogleFonts.notoSansJp,
      ),
    )
    ..setLanguageGroupFont(
      const LanguageGroupFontConfig(
        languageCodes: ['ar', 'fa', 'ur'],
        googleFont: GoogleFonts.almarai,
      ),
    );

  runApp(const MyApp());
}
```

```dart
// No extra wiring needed at the call site
Text('Hello', style: TextStyle(fontSize: 16.sp)); // uses FontConfig
```

A custom family works the same way:

```dart
FontConfig.instance.setDefaultFont(customFontFamily: 'Cairo');
```

> `google_fonts` is **not** a dependency of this package. You pass `GoogleFonts.*` builders in yourself, so apps that do not need it carry no extra weight.

---

## ThemeData integration

### Scale Kit alone

Use `ResponsiveThemeData.create` when you are **not** using `flutter_scale_theme_kit`. The context must sit under `ScaleKitBuilder`, so wrap it in a `Builder`:

```dart
ScaleKitBuilder(
  designWidth: 375,
  designHeight: 812,
  child: Builder(
    builder: (context) {
      return MaterialApp(
        theme: ResponsiveThemeData.create(
          context: context,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomePage(),
      );
    },
  ),
);
```

### With flutter_scale_theme_kit

Keep the Theme Kit `ThemeData` and scale only the text theme. Replacing `theme:` with `ResponsiveThemeData.create` would drop Theme Kit's card, button, and input themes.

```dart
ScaleKitBuilder(
  designWidth: 375,
  designHeight: 812,
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

Keep radius aligned between the two packages: `setRadiusSizes(SizeValues.custom(md: 12))` and `STRadius(md: 12)`.
