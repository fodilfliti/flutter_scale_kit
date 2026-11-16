# Invariants

Break these and the package lies to users. Tests should cover them when you touch the related code.

## Double-scaling

SK widgets **inspect** incoming numbers. If a value is already marked (`.w`, `.h`, `.sp`, `.r`, `.swClamp`, …), **do not scale again**.

```dart
SKContainer(width: 120)           // SK scales
SKContainer(width: 120.w)        // already scaled — pass through
SKContainer(width: 0.5.swClamp(200, 360))  // already scaled
```

`ScaleValueFactory.resolveWidth/Height/Radius/EdgeInsets/...` is the shared gate. New SK widgets must use `resolve*`, not raw `getWidth`.

## FFI-safe returns

Extension results must be **plain doubles**. Do **not** attach Expando (or any object identity metadata) to the returned number. Google Fonts and other FFI APIs throw if the object is not a clean double.

Tracking lives in `SKScaledValueTracker` as a **Map** keyed independently of the double instance. All platforms (VM, web, Wasm) use this path.

## Cache safety

- `ScaleValueCache` cap is **2000** entries with LRU eviction. Do not introduce unbounded maps.
- Tracker and value caches **must** clear together on resize, orientation change, and enable/disable.
- Constraint helpers (`.wMax`, `.spClamp`, …) are cached; they must invalidate with the same context key as base scalars.

## Init order

Scale multipliers are precomputed in `ScaleManager._calculateScaleFactors()` (D1). The `set*` config methods (`setAutoScaleOrientation`, `setBoosts`, `setDeviceOverride`, …) only store values and do **not** recalculate.

- `ScaleKitBuilder` applies every setting **before** `ScaleManager.init()`, which runs the first calculation. Otherwise the first frame uses the singleton defaults (e.g. the landscape boost despite `autoScaleLandscape: false`).
- Any setter called after init must be followed by `updateFromContext` (`didUpdateWidget` does this via `_onSizeOrOrientationChange`).

## Rebuild noise

`ScaleKitBuilder` listens to `MediaQuery.sizeOf` and `MediaQuery.orientationOf` only. Do not subscribe to full `MediaQuery` (keyboard, padding, gesture insets would rebuild the whole app).

## Web / Wasm safety

Platform helpers (`isAndroidPlatform`, `isIOSPlatform`, `isMobilePlatform`, `isDesktopPlatform`, mixin equivalents, `ScaleManager.platformCategory`) must check `kIsWeb` (or equivalent) **before** any IO/platform channel that breaks on web.

`ScaleManager.setDevicePreviewPlatformGetter` is optional and must no-op safely when preview is off (getter returns null).

## Desktop lock

- Locks apply to **desktop/web platforms only**, not Android/iOS.
- `lockDesktopAsTablet` / `lockDesktopAsMobile` only remap when window width makes that fallback sensible.
- `deviceTypeOverride` bypasses detection for that widget/value.
- Fallback chain for builders/values: desktop → tablet → mobile; landscape → portrait of same device, then mobile landscape, then mobile.

## Radius

- Default rounded containers use **`rSafe`** (`SKRadiusMode.safe`), not full `.r`.
- Flutter cannot combine **non-uniform border colors** with `borderRadius`. Omit radius in that case (documented FAQ). Do not “fix” this by forcing both.

## Fonts

`FontConfig` is optional. If unset, Flutter defaults. If set, `SKit` text helpers, cached text styles, and `ResponsiveThemeData` must apply it. Do not require `google_fonts` as a package dependency (callers pass `GoogleFonts.*` themselves).

## Enable/disable

When `enabled` / `enabledListenable` is false: `.w/.h/.sp` and `ScaleManager` getters return **unmodified** design values. Re-enable restores scaling without a restart.

## Size system

`setPaddingSizes` / `setDefaultPadding` (and siblings) are process-wide. Configure in `main()` **before** first frame. Do not silently change defaults inside widgets.

## Package boundary

- Public API = what `lib/flutter_scale_kit.dart` exports.
- Do not add heavy dependencies. This package’s only runtime dep is Flutter SDK.
- `example/` and `screenshots/` are not library code. Do not import example from `lib/`.

## Tests to extend when you touch

`test/flutter_scale_kit_test.dart`, `test/leak_rebuild_test.dart`, `test/tracker_leak_test.dart`. If you change cache, tracker, or builder listeners, add/adjust tests there — coverage is currently thin.
