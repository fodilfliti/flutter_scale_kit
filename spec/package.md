# Flutter Scale Kit

Pub package `flutter_scale_kit` (current: **1.5.3**). High-performance responsive scaling for Flutter: phones, tablets, desktop, web. Positioned as a faster, more controllable alternative to `flutter_screenutil`.

Design size is typically **375×812 mobile**. Apps wrap the tree with `ScaleKitBuilder` so every route inherits scale.

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
```

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
