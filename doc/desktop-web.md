# Desktop & web

Desktop and web are harder than phones: users resize windows constantly, ultrawide monitors sit next to tiny browser panes, and some screens read better borrowing a tablet or even a mobile layout. Scale Kit gives you switches instead of locking you into one breakpoint.

> Supplement to the [README](../README.md#desktop-web), which covers the essentials inline. Read
> this for every lock, override, and fallback combination.

- [Desktop locks](#desktop-locks)
- [Per-widget overrides](#per-widget-overrides)
- [Platform-aware layouts](#platform-aware-layouts)
- [Size-only decisions](#size-only-decisions)
- [Responsive builders](#responsive-builders)
- [Responsive values](#responsive-values)
- [Fallback rules](#fallback-rules)

---

## Desktop locks

Set globally on `ScaleKitBuilder`:

| Flag | Effect |
| --- | --- |
| `lockDesktopPlatforms` | Pin desktop and web platforms to a chosen breakpoint |
| `lockDesktopAsTablet` | While locked, use the tablet branch |
| `lockDesktopAsMobile` | While locked, use the mobile branch |

```dart
ScaleKitBuilder(
  designWidth: 375,
  designHeight: 812,
  lockDesktopPlatforms: true,
  lockDesktopAsTablet: true,
  child: MaterialApp(home: HomePage()),
);
```

Locks still respect live window width. `lockDesktopAsMobile` only routes to the mobile branch when the window is actually below the mobile breakpoint — a wide window keeps rendering the desktop builder.

---

## Per-widget overrides

`SKResponsive`, `SKResponsiveBuilder`, `SKit.responsiveInt`, and `SKit.responsiveDouble` all accept the same flags, so one route can deviate from the global setting.

```dart
SKResponsiveBuilder(
  desktop: (_) => DesktopDashboard(),
  tablet: (_) => TabletDashboard(),
  mobile: (_) => MobileDashboard(),
  // Reuse the tablet experience on smaller desktop windows
  lockDesktopAsTablet: true,
  // Or force one classification regardless of width
  deviceTypeOverride: DeviceType.desktop,
);
```

Use this to keep a dense data table on desktop while the settings screen reuses the tablet layout.

---

## Platform-aware layouts

Device type is only half the story. Two devices can share a width and still deserve different chrome.

```dart
Widget buildToolbar(BuildContext context) {
  if (context.isAndroidPlatform) return const AndroidToolbar();
  if (context.isIOSPlatform) return const IOSToolbar();
  if (context.isDesktopPlatform) return const DesktopToolbar();
  if (context.isWebPlatform) return const WebToolbar();
  return const UniversalToolbar();
}
```

Available: `context.isMobilePlatform`, `isAndroidPlatform`, `isIOSPlatform`, `isDesktopPlatform`, `isWebPlatform`, and `ScaleManager.platformCategory`. All are web and Wasm safe.

Pair these with `deviceTypeOverride` to ship an iOS-style sheet on tablets or a Windows-style toolbar on large monitors without duplicating layout logic.

---

## Size-only decisions

Sometimes you want to tweak spacing for ultrawide monitors **without** swapping the widget tree.

```dart
if (context.isDesktopAtLeastTablet) {
  // widen the content column, keep the same layout
}
```

Use `context.isDesktopSize`, `isDesktopAtLeastTablet`, `isDesktopAtLeastDesktop`, `isDesktopMobileSize`, `isDesktopTabletSize`, `isDesktopDesktopOrLarger`, or `ScaleManager.screenSizeClass`. These read pure width classes even after you lock the device type.

---

## Responsive builders

### SKResponsive

Separate builder per device and orientation:

```dart
SKResponsive(
  mobile: (_) => Text('Mobile portrait'),
  mobileLandscape: (_) => Text('Mobile landscape'),
  tablet: (_) => Text('Tablet portrait'),
  tabletLandscape: (_) => Text('Tablet landscape'),
  desktop: (_) => Text('Desktop'),
  // Optional
  deviceTypeOverride: DeviceType.desktop,
  lockDesktopAsTablet: true,
);
```

### SKResponsiveBuilder

Supports two styles.

**Style 1 — one builder with device and orientation:**

```dart
SKResponsiveBuilder(
  builder: (context, device, orientation) {
    if (device == DeviceType.mobile && orientation == Orientation.landscape) {
      return const MobileLandscapeView();
    }
    if (device == DeviceType.tablet) return const TabletView();
    return const DesktopView();
  },
  desktopAs: DesktopAs.tablet,
  deviceTypeOverride: DeviceType.desktop,
  lockDesktopAsMobile: true,
);
```

**Style 2 — separate builders, same as `SKResponsive`:**

```dart
SKResponsiveBuilder(
  mobile: (_) => const MobileView(),
  tablet: (_) => const TabletView(),
  desktop: (_) => const DesktopView(),
  mobileLandscape: (_) => const MobileLandscapeView(),
  tabletLandscape: (_) => const TabletLandscapeView(),
);
```

If you supply both, device-specific builders take priority over the general `builder`.

> Reach for these only when the layout **structure** changes — a navigation rail instead of a bottom bar, a split view instead of a list. For padding and font size, tokens and `SK*` widgets already scale.

---

## Responsive values

For numbers rather than widgets — grid columns, item counts, spacing:

```dart
final columns = SKit.responsiveInt(
  context: context,
  mobile: 2,          // required base
  tablet: 4,          // optional
  desktop: 6,         // optional
  mobileLandscape: 3, // optional
  // Optional desktop controls, same as the widgets:
  // deviceTypeOverride: DeviceType.tablet,
  // lockDesktopAsTablet: true,
  // lockDesktopAsMobile: true,
  // desktopAs: DesktopAs.tablet,
);

GridView.count(crossAxisCount: columns, children: [...]);
```

```dart
final spacing = SKit.responsiveDouble(
  context: context,
  mobile: 8.0,
  tablet: 16.0,
  desktop: 24.0,
);
```

Always pass `context` so values refresh when the window resizes or rotates.

---

## Fallback rules

Shared by every responsive widget and value helper:

- **Device:** desktop → tablet → mobile; tablet → mobile
- **Orientation:** landscape → portrait of the same device
- **`mobileLandscape`** → falls back to `mobile`
- **`tabletLandscape`** → falls back to `tablet` → `mobileLandscape` → `mobile`

### CSS-like desktop behavior

- On Android and iOS, devices classify as mobile or tablet by width only; desktop logic does not apply.
- On desktop (width ≥ 1200 by default), desktop values apply. Opt into tablet or mobile values to mimic CSS breakpoints.
- `desktopAs` reuses tablet or mobile fallbacks without toggling the global lock.

```dart
// Desktop behaves like tablet for this layout
SKResponsive(
  mobile: (_) => MobileView(),
  tablet: (_) => TabletView(),
  desktop: (_) => DesktopView(),
  desktopAs: DesktopAs.tablet,
);

// Same idea for a value: 2 / 4 / 8 columns, desktop reuses tablet
final cols = SKit.responsiveInt(
  context: context,
  mobile: 2,
  tablet: 4,
  desktop: 8,
  desktopAs: DesktopAs.tablet,
);
```

This gives you CSS-media-query control while staying in Flutter idioms.
