# API Reference

Exhaustive reference for every public API.

> Supplement to the [README](../README.md), which already documents every feature inline. Read this
> when you want the complete per-member listing.

- [Extension methods (on `num`)](#extension-methods-on-num)
- [Extensions on Flutter types](#extensions-on-flutter-types)
- [SK widgets](#sk-widgets)
- [SKit helpers](#skit-helpers)
- [Spacing widgets](#spacing-widgets)
- [Context extensions](#context-extensions)
- [DeviceMetricsMixin](#devicemetricsmixin)
- [ScaleManager](#scalemanager)
- [FontConfig](#fontconfig)
- [Enums](#enums)

---

## Extension methods (on `num`)

### Base scaling

| Extension | Meaning | Example |
| --- | --- | --- |
| `.w` | Scaled width | `200.w` |
| `.h` | Scaled height | `100.h` |
| `.sp` | Scaled font size | `16.sp` |
| `.spf` | Font size × system text scale factor | `16.spf` |
| `.r` | Fully responsive radius | `12.r` |
| `.rSafe` | Radius with gentle clamping | `12.rSafe` |
| `.rFixed` | Radius, never scaled | `12.rFixed` |
| `.sw` | Percentage of screen width | `0.5.sw` = 50% width |
| `.sh` | Percentage of screen height | `0.25.sh` = 25% height |

### Constraint variants

Every base extension has `Min`, `Max`, and `Clamp` forms:

- `.wMax(max)`, `.wMin(min)`, `.wClamp(min, max)`
- `.hMax(max)`, `.hMin(min)`, `.hClamp(min, max)`
- `.spMax(max)`, `.spMin(min)`, `.spClamp(min, max)`
- `.rMax(max)`, `.rMin(min)`, `.rClamp(min, max)`
- `.rSafeClamp(min, max)`
- `.swMax(max)`, `.swMin(min)`, `.swClamp(min, max)`
- `.shMax(max)`, `.shMin(min)`, `.shClamp(min, max)`

```dart
200.wMax(300);          // Scaled width, never above 300
100.hClamp(50, 150);    // Scaled height, kept in 50–150
16.spClamp(12, 24);     // Font size, kept in 12–24
0.5.swClamp(200, 400);  // 50% of width, kept in 200–400
```

All constraint results are cached with the same system as the base extensions, so repeated rebuilds do not recalculate. The cache clears on resize and orientation change.

### Gap extensions

| Extension | Produces |
| --- | --- |
| `12.horizontalSpace` | `HSpace(12.w)` |
| `16.verticalSpace` | `VSpace(16.h)` |

---

## Extensions on Flutter types

Apply `.w`, `.h`, or `.r` directly to geometry objects instead of converting each field:

```dart
EdgeInsets.only(left: 12, right: 12).w;          // both sides scaled with .w
EdgeInsetsDirectional.only(start: 16).h;         // RTL-aware, height scaling
BoxConstraints(maxWidth: 200, minHeight: 80).r;  // radius-aware scaling
Radius.circular(24).w;
BorderRadius.circular(16).h;
```

Supported types: `EdgeInsets`, `EdgeInsetsDirectional`, `BoxConstraints`, `Radius`, `BorderRadius`.

---

## SK widgets

Drop-in replacements for Flutter widgets. **Pass raw design numbers** — they scale internally.

`SKPadding`, `SKMargin`, `SKContainer`, `SKText`, `SKIcon`, `SKCard`, `SKDivider`, `SKAppBar`, `SKListTile`, `SKSwitch`, `SKSwitchListTile`, `SKTextField`, `SKTextFormField`, `SKElevatedButton`, `SKTextButton`, `SKOutlinedButton`, `SKIconButton`, `SKActionChip`, `SKFilterChip`, `SKChoiceChip`, `SKInputChip`, `SKImage`.

### What each widget scales

| Widget | Scaled properties |
| --- | --- |
| `SKContainer` | `width`, `height`, `padding`, `margin`, `borderRadius` (via `rSafe`), `boxShadow`, border width, `constraints` |
| `SKPadding` | `EdgeInsets` and `EdgeInsetsDirectional` values |
| `SKMargin` | `EdgeInsets` and `EdgeInsetsDirectional` values |
| `SKText` | `fontSize`, plus `FontConfig` font if configured |
| `SKIcon` | `size` |
| `SKCard` | `margin`, `elevation`, `shape.borderRadius` |
| `SKDivider` | `thickness`, `indent`, `endIndent`, `height` |
| `SKAppBar` | `toolbarHeight`, `elevation`, `titleSpacing`, `leadingWidth` |
| `SKListTile` | `contentPadding`, `minLeadingWidth`, `minVerticalPadding` |
| `SKSwitch` | `splashRadius` |
| `SKSwitchListTile` | `contentPadding`, `splashRadius` |
| `SKTextField` | `fontSize`, `InputDecoration` padding, `borderRadius`, `cursorWidth`, `cursorHeight` |
| `SKTextFormField` | Same as `SKTextField`, plus form validation |
| `SKElevatedButton` | `padding`, `minimumSize`, `fixedSize`, `borderRadius`, `elevation` |
| `SKTextButton` | `padding`, `minimumSize`, `fixedSize`, `borderRadius` |
| `SKOutlinedButton` | `padding`, `minimumSize`, `fixedSize`, `borderRadius` |
| `SKIconButton` | `iconSize`, `padding`, `constraints` |
| `SKActionChip` | `padding`, `labelPadding`, `avatarPadding`, `borderRadius`, `elevation`, `deleteIconSize` |
| `SKFilterChip` | Same as `SKActionChip` |
| `SKChoiceChip` | `padding`, `labelPadding`, `avatarPadding`, `borderRadius`, `elevation` |
| `SKInputChip` | Same as `SKActionChip` |
| `SKImage` | `width`, `height` |

### Example

```dart
SKPadding(
  padding: EdgeInsets.all(16),
  child: SKContainer(
    width: 200,
    height: 100,
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: BoxDecoration(
      color: Colors.blue.shade50,
      borderRadius: BorderRadius.circular(12), // uses rSafe automatically
    ),
    child: SKText('Everything here scales', fontSize: 14),
  ),
)
```

### SKImage constructors

```dart
SKImage.asset('assets/images/logo.png', width: 100, height: 100, fit: BoxFit.cover);

SKImage.network(
  'https://example.com/image.jpg',
  width: 200,
  height: 200,
  headers: {'Authorization': 'Bearer token'},
  cacheWidth: 400,   // memory optimization
  cacheHeight: 400,
);

SKImage.file(File('/path/to/image.png'), width: 150, height: 150);

SKImage.memory(imageBytes, width: 120, height: 120);
```

> **Mixing is safe.** Every SK widget inspects incoming numbers and only scales unmarked ones. `width: 120`, `width: 120.wMax(240)`, and `borderRadius: BorderRadius.circular(24.r)` all work on the same widget without double-scaling.

---

## SKit helpers

### Padding and margin

```dart
SKit.padding(all: 16, child: widget);
SKit.padding(horizontal: 24, vertical: 12, child: widget);
SKit.paddingSize(all: SKSize.md, child: widget);
SKit.paddingSize(horizontal: SKSize.lg, vertical: SKSize.sm, child: widget);

SKit.margin(12, child: widget);
SKit.marginSize(all: SKSize.md, child: widget);

// Raw EdgeInsets for your own widgets
final insets = SKit.paddingEdgeInsets(all: 16);
final marginInsets = SKit.marginEdgeInsetsSize(all: SKSize.md);
```

`padding` and `margin` accept `start` / `end`, which resolve against `Directionality`. One layout definition serves both LTR and RTL.

### Rounded containers

```dart
SKit.roundedContainer(
  all: 12,
  color: Colors.blue.shade50,
  borderColor: Colors.blue,
  borderWidth: 2,
  radiusMode: SKRadiusMode.safe, // default
  child: Text('Content'),
);

SKit.roundedContainerSize(all: SKSize.md, color: Colors.blue.shade50);
```

Border parameters:

| Parameter | Purpose |
| --- | --- |
| `borderColor` | Color for all sides when individual sides are unset |
| `borderWidth` | Width for all sides (scaled) |
| `borderTop` / `borderBottom` / `borderLeft` / `borderRight` | Enable a specific side |
| `borderTopColor` / `borderBottomColor` / `borderLeftColor` / `borderRightColor` | Per-side colors |
| `borderTopWidth` / `borderBottomWidth` / `borderLeftWidth` / `borderRightWidth` | Per-side widths (scaled) |

```dart
// Border on specific sides
SKit.roundedContainer(
  all: 12,
  color: Colors.green.shade50,
  borderTop: true,
  borderBottom: true,
  borderColor: Colors.green,
  borderWidth: 2,
  child: Text('Content'),
);

// Different color and width per side
SKit.roundedContainer(
  all: 12,
  borderTop: true,
  borderTopColor: Colors.red,
  borderTopWidth: 3,
  borderBottom: true,
  borderBottomColor: Colors.blue,
  borderBottomWidth: 2,
  child: Text('Content'),
);
```

> When individual sides use different colors, Flutter's `BoxDecoration` cannot combine a non-uniform border with `borderRadius`. Scale Kit drops `borderRadius` in that case to avoid a render error.

### Shorthand (uses `setDefault*` values)

```dart
SKit.pad()      // default padding (16)
SKit.margin()   // default margin (8)
SKit.rounded()  // default safe radius (12)
SKit.h()        // default spacing (8), horizontal
SKit.v()        // default spacing (8), vertical
```

`SKit.rounded` takes positional arguments: `rounded([size, child, color, borderColor, borderWidth, radiusMode])`.

```dart
SKit.rounded(
  null,                    // size → default radius
  const Text('Content'),
  Colors.blue.shade50,     // color
  Colors.blue,             // borderColor
  2,                       // borderWidth
);
```

### Spacing

```dart
SKit.hSpace(8);            // horizontal gap
SKit.vSpace(8);            // vertical gap
SKit.sSpace(8);            // square gap
SKit.hSpaceSize(SKSize.md);
SKit.vSpaceSize(SKSize.sm);
```

### Text

```dart
SKit.text('Hello', textSize: SKTextSize.s16, fontWeight: FontWeight.w600);
SKit.textFull('Hello', fontSize: 18, maxLines: 2, overflow: TextOverflow.ellipsis);
final style = SKit.textStyleFull(fontSize: 24, fontWeight: FontWeight.bold);
```

See [Design system](design-system.md#typography) for the full attribute list.

### Responsive values

```dart
SKit.responsiveInt(context: context, mobile: 2, tablet: 4, desktop: 6);
SKit.responsiveDouble(context: context, mobile: 8.0, tablet: 16.0, desktop: 24.0);
```

See [Desktop & web](desktop-web.md#responsive-values) for fallback rules and desktop flags.

---

## Spacing widgets

Const-friendly widgets for precomputed values:

| Widget | Purpose |
| --- | --- |
| `SKSizedBox({width, height})` | `SizedBox` wrapper usable in const contexts |
| `HSpace(double width)` | Horizontal gap |
| `VSpace(double height)` | Vertical gap |
| `SSpace(double size)` | Square gap on both axes |

```dart
Row(
  children: [
    Container(width: 32.w, height: 32.w, color: Colors.purple),
    12.horizontalSpace,
    Container(width: 32.w, height: 32.w, color: Colors.green),
  ],
);
```

These share the `ScaleValueFactory` cache with `.w` / `.h`, so they stay cheap inside long lists.

---

## Context extensions

### Scaling

```dart
context.scaleWidth(200);
context.scaleHeight(100);
context.scaleFontSize(16);
context.scaleSize(12);
context.scalePadding(start: 24, end: 12, vertical: 16);
context.scaleMargin(all: 8);
context.scaleBorderRadius(all: 12);
```

`start` / `end` resolve to the correct physical side based on `Directionality`.

### Device type

| Getter | Meaning |
| --- | --- |
| `context.isMobile` | Responsive classification is mobile |
| `context.isTablet` | Responsive classification is tablet |
| `context.isDesktop` | Responsive classification is desktop |

For layout **structure** decisions, use these. They respect `deviceTypeOverride` and desktop locks.

### Platform

| Getter | True when |
| --- | --- |
| `context.isMobilePlatform` | Android or iOS |
| `context.isAndroidPlatform` | Android |
| `context.isIOSPlatform` | iOS |
| `context.isDesktopPlatform` | Windows, macOS, Linux, or web |
| `context.isWebPlatform` | Running on the web |

All platform checks are web and Wasm safe (they test `kIsWeb` before touching `dart:io`).

### Size classes

```dart
context.screenSizeClass; // DeviceSizeClass
```

Convenience flags: `isSmallMobileSize`, `isMobileSize`, `isLargeMobileSize`, `isTabletSize`, `isLargeTabletSize`, `isDesktopSize`, `isLargeDesktopSize`, `isExtraLargeDesktopSize`.

Desktop/web-only flags: `isDesktopMobileSize`, `isDesktopTabletSize`, `isDesktopDesktopOrLarger`, `isDesktopAtLeastTablet`, `isDesktopAtLeastDesktop` (CSS-style `min-width` behavior).

`context.scaleBreakpoints` returns the active `ScaleBreakpoints`.

### Classification source

```dart
context.isTypeOfMobile(source: DeviceClassificationSource.responsive);
context.isTypeOfTablet(source: DeviceClassificationSource.platform);
context.isTypeOfDesktop(source: DeviceClassificationSource.size, includeWeb: true);
```

`DeviceClassificationSource` picks which answer you want: the responsive result (default), the raw platform, or width-only size classification.

---

## DeviceMetricsMixin

Mix into a `State` when you need device info without threading `BuildContext` around:

```dart
class DashboardState extends State<Dashboard>
    with DeviceMetricsMixin<Dashboard> {
  @override
  Widget build(BuildContext context) {
    if (isDesktop) return const DesktopDashboard();
    if (isTablet) return const TabletDashboard();
    return const MobileDashboard();
  }

  @override
  void onDeviceMetricsChanged(Size previous, Size current) {
    debugPrint('Metrics changed: $current');
  }
}
```

Exposes `logicalScreenSize`, `devicePixelRatio`, `isMobile`, `isTablet`, `isDesktop`, `isMobilePlatform`, `isDesktopPlatform`, `isWeb`, `isAndroidPlatform`, `isIOSPlatform`, and the `onDeviceMetricsChanged` hook. Values stay in sync with `WidgetsBinding`.

---

## ScaleManager

Singleton engine. Most apps never touch it directly, but it is available.

```dart
final scale = ScaleManager.instance;

Container(
  width: scale.getWidth(200),
  height: scale.getHeight(100),
  child: Text('Hi', style: TextStyle(fontSize: scale.getFontSize(16))),
);
```

### Methods

| Method | Returns |
| --- | --- |
| `getWidth(double)` | Scaled width |
| `getHeight(double)` | Scaled height |
| `getFontSize(double)` | Scaled font size |
| `getFontSizeWithFactor(double)` | Scaled font size including system text scale |
| `getRadius(double)` | Scaled radius |
| `getScreenWidth(double percentage)` | Percentage of screen width |
| `getScreenHeight(double percentage)` | Percentage of screen height |
| `deviceTypeFor(DeviceClassificationSource)` | Responsive, platform, or size classification |

### Properties

| Property | Meaning |
| --- | --- |
| `screenWidth` / `screenHeight` | Logical pixel size |
| `pixelRatio` / `devicePixelRatio` | Physical pixels per logical pixel |
| `scaleWidth` / `scaleHeight` | Actual size ÷ design size, after clamping |
| `orientation` | Portrait or landscape |
| `textScaleFactor` | System font scaling |
| `statusBarHeight` | Status bar height, notch included |
| `bottomBarHeight` | Bottom safe zone |
| `topSafeHeight` / `bottomSafeHeight` | Safe area insets |
| `safeAreaHeight` / `safeAreaWidth` | Total safe area |
| `deviceType` | Current `DeviceType`, respecting overrides and locks |
| `platformCategory` | Underlying platform, without `dart:io` (web safe) |
| `screenSizeClass` | Current `DeviceSizeClass` |
| `desktopLockFallback` | Breakpoint desktop/web mimics when the lock is active |

### Device Preview integration

If you use [`device_preview`](https://pub.dev/packages/device_preview), share its simulated platform so detection stays correct inside the preview surface:

```dart
import 'package:device_preview/device_preview.dart';

void main() {
  ScaleManager.setDevicePreviewPlatformGetter((context) {
    try {
      return DevicePreview.platformOf(context);
    } catch (_) {
      return null; // fall back to normal detection when preview is off
    }
  });

  runApp(const MyApp());
}
```

Returning `null` keeps default logic when preview mode is off. This is optional — the package works fine without it.

---

## FontConfig

| Member | Purpose |
| --- | --- |
| `FontConfig.instance` | Singleton |
| `setDefaultFont({googleFont, customFontFamily})` | App-wide default font |
| `setLanguageFont(LanguageFontConfig)` | Font for one language |
| `setLanguageGroupFont(LanguageGroupFontConfig)` | Font shared by several languages |
| `setLanguagesFonts(List<LanguageFontConfig>)` | Several languages at once |
| `setLanguageGroupsFonts(List<LanguageGroupFontConfig>)` | Several groups at once |
| `getTextStyle({languageCode, baseTextStyle})` | Resolved `TextStyle` |
| `currentLanguageCode` | Active language code |
| `clear()` | Remove all font configuration |

See [Design system → Fonts](design-system.md#fonts) for usage.

---

## Enums

| Enum | Values |
| --- | --- |
| `DeviceType` | `mobile`, `tablet`, `desktop`, `web` |
| `DeviceSizeClass` | `smallMobile` … `extraLargeDesktop` |
| `DeviceClassificationSource` | `responsive`, `platform`, `size` |
| `SKSize` | `xs`, `sm`, `md`, `lg`, `xl`, `xxl` |
| `SKTextSize` | `s6` … `s52` |
| `SKRadiusMode` | `scaled`, `safe` (default), `fixed` |
| `DesktopAs` | `desktop`, `tablet`, `mobile` |

`DeviceType` also exposes checks directly on the enum: `.isTypeOfMobile`, `.isTypeOfTablet`, `.isTypeOfDesktop`, `.isTypeOfWeb`.
