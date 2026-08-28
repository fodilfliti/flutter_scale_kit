# Scaling engine

How Scale Kit turns a design number into a pixel on screen, and every knob you can turn. Most apps need none of this — the defaults are tuned to work unmodified.

> Supplement to the [README](../README.md#scale-limits), which covers limits, boosts, and
> auto-configuration inline. Read this for the full formulas and per-device tuning.

- [The pipeline](#the-pipeline)
- [Scale limits](#scale-limits)
- [Orientation boosts](#orientation-boosts)
- [Auto-configuration](#auto-configuration)
- [Custom breakpoints](#custom-breakpoints)
- [Performance](#performance)
- [Architecture](#architecture)

---

## The pipeline

```
finalSize     = designValue × clampedScale × orientationSizeBoost
finalFontSize = designFontSize × clampedScale × orientationFontBoost × systemTextScale
```

Where:

```
scaleWidth       = screenWidth / designWidth
scaleHeight      = screenHeight / designHeight
clampedScale     = clamp(rawScale, minScale, maxScale)
```

Order matters: **limits clamp first, boosts multiply after.** Limits always win.

---

## Scale limits

`minScale` and `maxScale` are guard rails that stop a layout from exploding on a big screen or collapsing on a small one. You can leave them unset — Scale Kit picks a range per device type and orientation.

```dart
ScaleKitBuilder(
  designWidth: 375,
  designHeight: 812,
  minScale: 0.9, // optional override
  maxScale: 1.2, // optional override
  child: MaterialApp(home: HomePage()),
);
```

### Why they exist

Design `375×812` (iPhone 13 mini) shown on an iPad Pro portrait (`1024×1366`):

```
Without limits:
  scaleWidth  = 1024 / 375 = 2.73x  →  a 100px button becomes 273px (too big)
  scaleHeight = 1366 / 812 = 1.68x

With minScale 0.8, maxScale 1.2:
  clampedWidth  = clamp(2.73, 0.8, 1.2) = 1.2x  →  100px button becomes 120px
  clampedHeight = clamp(1.68, 0.8, 1.2) = 1.2x
```

### Override recipes

| Use case | `minScale` | `maxScale` | Why |
| --- | --- | --- | --- |
| Strict design match | `0.95` | `1.05` | Locks UI to spec for brand or compliance work |
| Extra accessibility | `0.6` | `2.0` | Lets system text scaling dominate |
| Locked tablet range | `0.9` | `1.2` | Makes tablets feel like large phones |
| Desktop cap | `0.7` | `1.3` | Stops desktop widgets from getting huge |

Starting point if you just want a gentle tablet clamp without touching phones: `minScale: 0.9`, `maxScale: 1.4`.

### Quick check

```dart
// Design 375×812, screen 1024×1366, maxScale 1.2
200.w; // 200 × 1.2 = 240   (would be 546 unclamped)
16.sp; // 16 × 1.2 × orientationBoost × systemTextScale
```

---

## Orientation boosts

Gentle multipliers applied **after** clamping, so content stays readable when a device rotates.

### Defaults

| Device | Orientation | Font boost | Size boost | Why |
| --- | --- | --- | --- | --- |
| Mobile | Portrait | 1.0× | 1.0× | Baseline |
| Mobile | Landscape | 1.2× | 1.2× | Wider view needs breathing room |
| Tablet | Portrait | 1.0× | 1.0× | Already spacious |
| Tablet | Landscape | 1.2× | 1.2× | Horizontal layouts feel airy |
| Desktop | Portrait | 1.0× | 1.0× | Rare |
| Desktop | Landscape | 1.0× | 1.0× | Desktops rarely need a boost |

Fonts and sizes use **separate** multipliers, so you can raise readability without inflating containers. System text scaling stacks on top of everything.

### Per-orientation switches

```dart
ScaleKitBuilder(
  designWidth: 375,
  designHeight: 812,
  autoScaleLandscape: true,  // default
  autoScalePortrait: false,  // default
  mobileLandscapeFontBoost: 1.2,
  mobileLandscapeSizeBoost: 1.2,
);
```

Portrait keeps your design intent by default. Set `autoScalePortrait: true` if you want portrait boosts too.

### Math in action

```dart
// iPhone 14 landscape (852×390) against a 375×812 design
// 1. Raw scale:       width 2.27x, height 0.48x
// 2. Auto limits:     width clamped to 1.25x, height clamped to 0.85x
// 3. Orientation:     1.2x (mobile landscape)

16.sp;  // 16  × 1.25 × 1.2 = 24.0
100.w;  // 100 × 1.25 × 1.2 = 150.0
50.h;   // 50  × 0.85 × 1.2 = 51.0
```

### Customization patterns

```dart
// Dashboard — stay dense in landscape
ScaleKitBuilder(
  designWidth: 375,
  designHeight: 812,
  mobileLandscapeFontBoost: 1.0,
  mobileLandscapeSizeBoost: 1.0,
);

// Reading app — text gets extra lift, layout does not
ScaleKitBuilder(
  designWidth: 375,
  designHeight: 812,
  mobileLandscapeFontBoost: 1.4,
  mobileLandscapeSizeBoost: 1.1,
);

// Portrait-first tablet (POS / kiosk)
ScaleKitBuilder(
  designWidth: 375,
  designHeight: 812,
  tabletPortraitFontBoost: 1.3,
  tabletPortraitSizeBoost: 1.3,
);
```

---

## Auto-configuration

Scale Kit detects the environment and picks limits and boosts for you. About 95% of projects never override anything.

### What it detects

**Device type** — phones, tablets, desktop (Windows/macOS/Linux), and web browsers with resizable windows.

**Screen properties** — width, height, orientation, aspect ratio, pixel density.

**Special cases** — foldables (Galaxy Fold and similar), ultra-wide monitors above 2560px, small windows under 800px, and tall notched screens around 21:9.

### What it chooses

**Scale limits**

| Device | Portrait | Landscape |
| --- | --- | --- |
| Mobile | 0.85 – 1.15× | 0.85 – 1.25× |
| Tablet | 0.8 – 1.3× | 0.75 – 1.4× |
| Desktop | 0.7 – 1.8× | 0.6 – 2.0× |

**Orientation boosts** — mobile and tablet landscape get 1.2× font and size; desktop and all portrait modes stay at 1.0×.

**Design adaptation** — a mobile design shown on a tablet widens the allowed range; on desktop it caps upscaling instead. Resizable windows are handled continuously.

### When to override

Only when you need tighter compliance than the defaults (for example ±5% variance on brand-critical screens), or when you want a deliberately different feel. See [Scale limits](#scale-limits).

---

## Custom breakpoints

Width thresholds drive both device detection and the derived size classes.

```dart
const customBreakpoints = ScaleBreakpoints(
  mobileMaxWidth: 540,
  tabletMaxWidth: 1100,
  desktopMaxWidth: 1650,
  largeDesktopMaxWidth: 2200,
);

ScaleKitBuilder(
  breakpoints: customBreakpoints,
  designWidth: 375,
  designHeight: 812,
  child: MaterialApp(home: HomePage()),
);
```

Defaults are `600 / 1200 / 1600 / 1920`.

`ScaleManager.screenSizeClass` and the `context.is*Size` helpers then report against your thresholds, from `smallMobile` up to `extraLargeDesktop`.

---

## Performance

### Hybrid caching

- **Direct math for scalars.** `.w`, `.h`, `.sp`, `.r` skip the Map cache entirely and use pre-calculated multipliers.
- **Integer cache keys.** Remaining cache operations use int keys instead of strings.
- **Calculate once.** A value like `12.sp` is computed and marked for auto-scale detection once, then served from cache.

### Memory safety

- **LRU eviction.** The cache is capped at 2000 entries and evicts least-recently-used items.
- **Automatic clearing.** Cache and auto-scale tracker both clear on resize or orientation change.
- **No unbounded growth**, even in long sessions with many dynamic styles.

### Rebuild optimization

- Listens to `MediaQuery.sizeOf` and `MediaQuery.orientationOf` specifically, not the whole `MediaQuery`.
- Keyboard insets (`viewInsets`) and system gesture insets do **not** trigger rebuilds.
- `sizeChangeThreshold` tunes sensitivity — default 0.05 (5%) on mobile and tablet, 0.0 on desktop and web.

```dart
ScaleKitBuilder(
  designWidth: 375,
  designHeight: 812,
  sizeChangeThreshold: 0.01, // rebuild after a 1% change
  // sizeChangeThreshold: 0.0, // rebuild on any change
);
```

### Benchmarks

```
Direct math (hybrid):  ~3x faster than Map cache
Map cache hit:         ~10x faster than recalculation
Widget rebuilds:       ~80% reduction using MediaQuery.sizeOf
```

---

## Architecture

| Pattern | Type | Role |
| --- | --- | --- |
| Singleton | `ScaleManager` | Global scale configuration and device state |
| Factory | `ScaleValueFactory` | Creates and resolves scaled values |
| Flyweight | `ScaleValueCache` | Reuses cached values, LRU-capped |

`ScaleKitBuilder` sits above your app, watches size and orientation, and updates `ScaleManager`. Everything else reads from that single source.
