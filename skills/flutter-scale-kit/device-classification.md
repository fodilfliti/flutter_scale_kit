# Device classification — which API when?

Scale Kit answers **three different questions**. Mixing them causes bugs (e.g. iPhone landscape: `context.isMobile` is `false` while `SKResponsiveBuilder` still uses `mobileLandscape`).

## Cheat sheet

| Goal | API | Landscape iPhone (~914×411) |
| --- | --- | --- |
| **Phone OS** (Android/iOS) | `context.isMobilePlatform` | `true` |
| **Scaling + `SKText` / limits** | `context.isResponsiveMobile` or `context.isTypeOfMobile()` | `true` |
| **Same as `ScaleManager.deviceType`** | `ScaleManager.instance.deviceType` | `DeviceType.mobile` |
| **`SKResponsiveBuilder` device arg** | `builder: (ctx, device, orientation) => …` | `DeviceType.mobile` |
| **Viewport width bucket** (CSS-like) | `context.isMobileViewport` / `context.isMobileSize` | `false` (width > 600) |
| **Layout portrait vs landscape** | `SKResponsive` / `SKResponsiveBuilder` with `mobileLandscape:` | use builders, not `if (isMobile)` |
| **Force detection** | `deviceTypeOverride: DeviceType.mobile` on `ScaleKitBuilder` or `SKResponsiveBuilder` | only when you must override |

## Three sources (`DeviceClassificationSource`)

```dart
context.isTypeOfMobile(); // responsive — default for scaling & SKResponsiveBuilder
context.isTypeOfMobile(source: DeviceClassificationSource.platform); // iOS/Android shortest-side phone vs tablet
context.isTypeOfMobile(source: DeviceClassificationSource.size); // current width only — same as isMobileViewport
```

| Source | What it uses |
| --- | --- |
| `responsive` | Platform detection + overrides + desktop lock fallback |
| `platform` | OS device class (phones use shortest side on iOS/Android) |
| `size` | Current **width** vs breakpoints only |

## Common mistakes

### ❌ `if (context.isMobile)` for “is this a phone?”

`context.isMobile` / `isMobileViewport` = **width ≤ mobileMaxWidth** (default 600). A phone in landscape often has width 800–900 → `false`.

```dart
// BAD — flips when user rotates
if (context.isMobile) { ... }

// GOOD — phone hardware
if (context.isMobilePlatform) { ... }

// GOOD — scaling / responsive device class
if (context.isResponsiveMobile) { ... }
```

### ❌ `designType: DeviceType.mobile` to force mobile scaling

`designType` on `ScaleKitBuilder` is **accepted but not applied** by `ScaleManager` today. It does **not** change detection or scale limits.

```dart
// BAD — no effect on detection/scaling
ScaleKitBuilder(designType: DeviceType.mobile, ...);

// GOOD — when you must force
ScaleKitBuilder(deviceTypeOverride: DeviceType.mobile, ...);
```

### ❌ Manual orientation + `isMobile` for layout

Use dedicated builders instead:

```dart
SKResponsiveBuilder(
  mobile: (_) => portraitLayout,
  mobileLandscape: (_) => landscapeLayout,
)
```

### ❌ Expecting `DeviceMetricsMixin.isMobile` to mean phone

`DeviceMetricsMixin` uses **width-only** detection (`DeviceDetector.detectDeviceType(width)`). Same landscape caveat as `context.isMobile`. Prefer `context` under `ScaleKitBuilder` or `ScaleManager.instance.deviceType`.

## Portrait design artboard (402×874) on landscape phone

Scaling swaps effective design width/height when screen orientation ≠ design orientation, so fonts do not shrink to ~half size. Users still need the right **classification** API for `if` branches.

## Quick copy for support replies

> `context.isMobile` is viewport **width**, not phone vs tablet. In landscape, width is large so it can be `false` on iPhone. Use `context.isResponsiveMobile` or `SKResponsiveBuilder` for layout/scaling. `designType` does not change detection — use `deviceTypeOverride` only if you need to force it.
