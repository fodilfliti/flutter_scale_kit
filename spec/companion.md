# Companion: flutter_scale_theme_kit

Look lives in the **sibling** repo `../flutter_scale_theme_kit` (pub **1.0.1**). This package is **size** only (**2.0.1**).

Do **not** import theme-kit from `lib/`. Do **not** add it as a runtime dependency.

If a **consumer app** lists `flutter_scale_theme_kit`, agents **must use it** for look. Merge:

```dart
appST.light.copyWith(
  textTheme: appST.light.createResponsiveTextTheme(appST.light.textTheme),
)
```

Same for `appST.dark`. Requires `ScaleKitBuilder` + `Builder`. Never `ResponsiveThemeData.create` as the full `theme:`.

Radius alignment uses `setRadiusSizes(SizeValues.custom(md: 12))` (a `SizeValues`, not named params) + `STRadius(md: 12)`.

## Verified theme-kit API (read from source, do not guess)

- `context.st` returns `STResolved` with colors **flat**: `context.st.primary`, `.secondary`,
  `.surface`, `.background`, `.border`, `.divider`, `.text`, `.textSecondary`, `.error`,
  `.success`, `.warning`, `.info`. There is **no** `context.st.colors.*` — that form is wrong.
  Also on it: `.radius` (`STRadius`), `.shadow` (singular), component getters (`.card`, `.button`,
  `.input`, …), and `color('name')` for `STColors.extra` entries.
- `STColors({required primary, required surface, required background, required text, ...})` — the
  other twelve are optional and derived. Values are `STColor(light:, dark:)`. Not const.
- `STTheme({required colors, radius, shadows, typography, components, extras})`; `.light` / `.dark`
  are `ThemeData` getters.
- `STRadius({xs = 4, sm = 8, md = 12, lg = 16, xl = 24})`; `.md` is a `BorderRadius`, `.mdValue` a
  `double`. These tokens are **not** scaled by Scale Kit — inside `SK*` widgets use a raw number.
- `STThemeModeScope({initialMode, controller, required builder})` where builder is
  `(BuildContext, STThemeModeController)`. Controller: `mode`, `setMode`, `setDark`, `toggle`,
  `cycle`, `isDark(context)`. Reachable as `context.stMode`.
- `createResponsiveTextTheme` belongs to **this** package (`ScaleThemeDataExtension` on `ThemeData`),
  not theme-kit.
- `STScope` exists but normal apps do not need it.

Consumer skill: `skills/flutter-scale-kit/` plus Theme Kit’s `skills/flutter-scale-theme-kit/`.

Worked example of both packages together: `doc/starter-app.md`.
