# Companion: flutter_scale_theme_kit

Look lives in the **sibling** repo `../flutter_scale_theme_kit` (pub **1.0.1**). This package is **size** only (**2.0.0**).

Do **not** import theme-kit from `lib/`. Do **not** add it as a runtime dependency.

If a **consumer app** lists `flutter_scale_theme_kit`, agents **must use it** for look. Merge:

```dart
appST.light.copyWith(
  textTheme: appST.light.createResponsiveTextTheme(appST.light.textTheme),
)
```

Same for `appST.dark`. Requires `ScaleKitBuilder` + `Builder`. Never `ResponsiveThemeData.create` as the full `theme:`.

Consumer skill: `skills/flutter-scale-kit/` plus Theme Kit’s `skills/flutter-scale-theme-kit/`.
