# Flutter Scale Kit

[![Pub Version](https://img.shields.io/pub/v/flutter_scale_kit)](https://pub.dev/packages/flutter_scale_kit)
[![Pub Likes](https://img.shields.io/pub/likes/flutter_scale_kit)](https://pub.dev/packages/flutter_scale_kit)
[![Pub Points](https://img.shields.io/pub/points/flutter_scale_kit)](https://pub.dev/packages/flutter_scale_kit/score)
[![Popularity](https://img.shields.io/pub/popularity/flutter_scale_kit)](https://pub.dev/packages/flutter_scale_kit/score)

A high-performance responsive design package for Flutter that helps you create adaptive UIs across different screen sizes with easy-to-use scaling utilities.

> If this package helps you, please click “Like” on the pub.dev page — it improves discoverability and ranking.

## Screenshots

<table style="width:100%;">
  <tr>
    <td align="center" width="40%">
      <strong>Mobile</strong><br/>
      <img src="screenshots/mobile.png" alt="Flutter Scale Kit - Mobile" style="height:420px; width:100%; object-fit:cover; display:block;"/>
    </td>
    <td align="center" width="60%">
      <strong>Tablet</strong><br/>
      <img src="screenshots/table.png" alt="Flutter Scale Kit - Tablet" style="height:420px; width:100%; object-fit:cover; display:block;"/>
    </td>
  </tr>
</table>

### Desktop

<img src="screenshots/desctop.png" alt="Flutter Scale Kit - Desktop" style="max-height:420px; object-fit:contain;"/>

### Autoscale and Enable/Disable Examples

<table style="width:100%;">
  <tr>
    <td align="center" width="50%">
      <strong>Autoscale: Enabled</strong><br/>
      <img src="screenshots/autoscale_enable.png" alt="Autoscale Enabled" style="height:420px; width:100%; object-fit:cover; display:block;"/>
    </td>
    <td align="center" width="50%">
      <strong>Autoscale: Disabled</strong><br/>
      <img src="screenshots/auto_scale_disable.png" alt="Autoscale Disabled" style="height:420px; width:100%; object-fit:cover; display:block;"/>
    </td>
  </tr>
  <tr>
    <td align="center" width="50%">
      <strong>Package Enabled (Scaling On)</strong><br/>
      <img src="screenshots/package_enable_true.png" alt="Package Enabled" style="height:420px; width:100%; object-fit:cover; display:block;"/>
    </td>
    <td align="center" width="50%">
      <strong>Package Disabled (Raw Flutter)</strong><br/>
      <img src="screenshots/package_enable_false.png" alt="Package Disabled" style="height:420px; width:100%; object-fit:cover; display:block;"/>
    </td>
  </tr>
  <tr>
    <td colspan="2" align="center" style="color:#666; font-size: 12px;">
      Use the settings (tune icon) in the example app to toggle autoscale and package enable/disable, then Save.
    </td>
  </tr>
  
</table>

## Features

- 🎯 **Easy Scaling**: Simple API similar to `flutter_screenutil` (`.w`, `.sw`, `.sh`, `.r`, `.sp`, `.h`)
- 📱 **Responsive Design**: Automatic scaling based on screen dimensions and aspect ratios
- ⚡ **High Performance**: Intelligent caching system prevents recalculation on every rebuild
- 🔧 **Const Widgets**: Generate const-compatible widgets for better performance
- 🚀 **Extension Methods**: Use context extensions for cleaner code
- 📐 **Size System**: Predefined size enums (xs, sm, md, lg, xl, xxl) for consistent design
- 🎨 **Theme Support**: Centralized theme configuration with `SKitTheme`
- 📱 **Device Detection**: Built-in tablet, mobile, and desktop detection
- 🔄 **Smart Caching**: Flyweight pattern with automatic cache invalidation on size/orientation change
- 🎨 **ThemeData Integration**: Use responsive scaling in Flutter's theme system
- 🔤 **Font Configuration**: Automatic font selection per language with Google Fonts support
- 🧭 **Orientation Autoscale**: Enable different autoscale behavior for landscape vs portrait
- 🔁 **Runtime Toggle**: Enable/disable scaling globally to compare with raw Flutter sizes

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  flutter_scale_kit: ^1.0.7
```

Then run:

```bash
flutter pub get
```

## Quick Start

### 1. Configure Size Values (Optional but Recommended)

Set up your size configurations at app startup. This is where you define what values `SKSize.md`, `SKSize.lg`, etc. represent for padding, margin, radius, and spacing:

```dart
void main() {
  // Configure size values before runApp
  setPaddingSizes(SizeValues.custom(xs: 4, sm: 8, md: 16, lg: 24, xl: 32, xxl: 48));
  setMarginSizes(SizeValues.custom(xs: 2, sm: 4, md: 8, lg: 12, xl: 16, xxl: 24));
  setRadiusSizes(SizeValues.custom(xs: 2, sm: 4, md: 8, lg: 12, xl: 16, xxl: 24));
  setSpacingSizes(SizeValues.custom(xs: 4, sm: 8, md: 12, lg: 16, xl: 20, xxl: 24));

  // Set default values for methods without parameters
  setDefaultPadding(16);
  setDefaultMargin(8);
  setDefaultRadius(12);
  setDefaultSpacing(8);

  runApp(const MyApp());
}
```

**Note:** If you don't configure sizes, default values will be used (xs=2, sm=4, md=8, lg=12, xl=16, xxl=24).

### 2. Wrap Your App

Wrap your `MaterialApp` with `ScaleKitBuilder` at the top level:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_scale_kit/flutter_scale_kit.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaleKitBuilder(
      designWidth: 375,
      designHeight: 812,
      designType: DeviceType.mobile,
      child: MaterialApp(
        title: 'My App',
        home: HomePage(),
      ),
    );
  }
}
```

### 3. Use Extension Methods

Use extension methods for quick scaling:

```dart
Container(
  width: 200.w,      // Scaled width
  height: 100.h,     // Scaled height
  padding: EdgeInsets.all(16.w),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(12.r),
  ),
  child: Text(
    'Hello World',
    style: TextStyle(fontSize: 16.sp),
  ),
)
```

### 4. Use SKit Helper Methods

Use `SKit` helper methods for convenient widget creation:

```dart
SKit.padding(
  all: 16,
  child: SKit.roundedContainer(
    all: 12,
    color: Colors.blue.shade50,
    borderColor: Colors.blue,
    borderWidth: 2,
    child: Text('Hello'),
  ),
)
```

**Note:** Most containers need both `borderRadius` and `border`. Use `borderColor` and `borderWidth` parameters to add borders to your rounded containers. You can also specify borders on individual sides (top, bottom, left, right) with different colors and widths. All border widths are automatically scaled based on screen size.

## Usage

### Extension Methods

All extension methods work similar to `flutter_screenutil`:

```dart
// Width scaling
200.w           // Scaled width

// Height scaling
100.h           // Scaled height

// Font size scaling
16.sp           // Scaled font size

// Border radius scaling
12.r            // Scaled radius

// Screen percentage
0.5.sw          // 50% of screen width
0.25.sh         // 25% of screen height

// Font size with system factor
16.spf          // Scaled font size with system text scale factor
```

### SKit Helper Class

The `SKit` class provides convenient methods for creating widgets:

```dart
// Padding
SKit.padding(all: 16, child: widget)
SKit.paddingSize(all: SKSize.md, child: widget)

// Margin
SKit.margin(12, child: widget)
SKit.marginSize(all: SKSize.md, child: widget)

// Rounded container with border on all sides
SKit.roundedContainer(
  all: 12,
  color: Colors.blue.shade50,
  borderColor: Colors.blue,
  borderWidth: 2,
)

// Rounded container with border on specific sides
SKit.roundedContainer(
  all: 12,
  color: Colors.green.shade50,
  borderTop: true,
  borderBottom: true,
  borderColor: Colors.green,
  borderWidth: 2,
)

// Rounded container with different colors per side
SKit.roundedContainer(
  all: 12,
  color: Colors.pink.shade50,
  borderTop: true,
  borderTopColor: Colors.red,
  borderTopWidth: 3,
  borderBottom: true,
  borderBottomColor: Colors.blue,
  borderBottomWidth: 2,
)

SKit.roundedContainerSize(
  all: SKSize.md,
  color: Colors.blue.shade50,
  borderColor: Colors.blue,
  borderWidth: 2,
)

// Spacing
SKit.hSpace(8)           // Horizontal spacing
SKit.vSpace(8)           // Vertical spacing
SKit.sSpace(8)           // Square spacing

// Text
SKit.text('Hello', textSize: SKTextSize.s16)
SKit.text('Hello', fontSize: 16)
```

### Size System Configuration

**Important:** Configure your size values at the start of your app (typically in `main()` or app initialization) before using size enums. This ensures consistent sizing throughout your application.

#### Where to Configure

Set up your size configurations in your app's initialization:

```dart
void main() {
  // Configure sizes at app startup (before runApp)
  setPaddingSizes(SizeValues.custom(xs: 4, sm: 8, md: 16, lg: 24, xl: 32, xxl: 48));
  setMarginSizes(SizeValues.custom(xs: 2, sm: 4, md: 8, lg: 12, xl: 16, xxl: 24));
  setRadiusSizes(SizeValues.custom(xs: 2, sm: 4, md: 8, lg: 12, xl: 16, xxl: 24));
  setSpacingSizes(SizeValues.custom(xs: 4, sm: 8, md: 12, lg: 16, xl: 20, xxl: 24));
  setTextSizes(TextSizeValues.custom(s14: 15, s16: 17, s18: 20, s24: 26));

  // Set default values for methods without parameters
  setDefaultPadding(16);
  setDefaultMargin(8);
  setDefaultRadius(12);
  setDefaultSpacing(8);
  setDefaultTextSize(14);

  runApp(const MyApp());
}
```

#### Using Size Enums

After configuration, use size enums throughout your app:

```dart
// Padding with size enum
SKit.paddingSize(all: SKSize.md, child: widget)
SKit.paddingSize(horizontal: SKSize.lg, vertical: SKSize.sm, child: widget)

// Margin with size enum
SKit.marginSize(all: SKSize.md, child: widget)

// Radius with size enum
SKit.roundedContainerSize(all: SKSize.lg, color: Colors.blue)

// Spacing with size enum
SKit.hSpaceSize(SKSize.md)  // Horizontal spacing
SKit.vSpaceSize(SKSize.sm)  // Vertical spacing
```

#### Using Default Values

When you've set default values, you can use methods without parameters:

```dart
SKit.pad()              // Uses default padding (16)
SKit.margin()           // Uses default margin (8)
SKit.rounded()         // Uses default radius (12)
SKit.h()                // Uses default spacing (8)
SKit.v()                // Uses default spacing (8)
```

#### Rounded Container with Border

Most containers need both border radius and border. Use `borderColor` and `borderWidth` parameters:

```dart
// Container with radius and border on all sides
SKit.roundedContainer(
  all: 12,
  color: Colors.blue.shade50,
  borderColor: Colors.blue,
  borderWidth: 2,  // Border thickness (automatically scaled)
  child: Text('Content'),
)

// Border on specific sides only
SKit.roundedContainer(
  all: 12,
  color: Colors.green.shade50,
  borderTop: true,      // Border on top
  borderBottom: true,    // Border on bottom
  borderColor: Colors.green,
  borderWidth: 2,
  child: Text('Content'),
)

// Different colors and widths for different sides
SKit.roundedContainer(
  all: 12,
  color: Colors.pink.shade50,
  borderTop: true,
  borderTopColor: Colors.red,
  borderTopWidth: 3,
  borderBottom: true,
  borderBottomColor: Colors.blue,
  borderBottomWidth: 2,
  borderLeft: true,
  borderLeftColor: Colors.green,
  borderLeftWidth: 1,
  child: Text('Content'),
)

// Using size enum
SKit.roundedContainerSize(
  all: SKSize.md,
  color: Colors.blue.shade50,
  borderColor: Colors.blue,
  borderWidth: 2,
  child: Text('Content'),
)

// Using default radius with border
SKit.rounded(
  null,
  const Text('Content'),
  Colors.blue.shade50,
  Colors.blue,  // borderColor
  2,            // borderWidth
)
```

**Border Parameters:**

- `borderColor` - Border color for all sides (if individual sides not specified)
- `borderWidth` - Border width for all sides (automatically scaled)
- `borderTop`, `borderBottom`, `borderLeft`, `borderRight` - Show border on specific sides (boolean)
- `borderTopColor`, `borderBottomColor`, `borderLeftColor`, `borderRightColor` - Individual side colors
- `borderTopWidth`, `borderBottomWidth`, `borderLeftWidth`, `borderRightWidth` - Individual side widths (automatically scaled)

### SKitTheme - Centralized Design System

Define all your design tokens in one place:

```dart
// Define theme
const theme = SKitTheme(
  textXs: 10,
  textSm: 12,
  textMd: 14,
  textLg: 16,
  textXl: 18,
  textXxl: 24,
  paddingXs: 4,
  paddingSm: 8,
  paddingMd: 16,
  paddingLg: 24,
  paddingXl: 32,
  radiusSm: 4,
  radiusMd: 8,
  radiusLg: 12,
  spacingXs: 4,
  spacingSm: 8,
  spacingMd: 16,
  spacingLg: 24,
);

// Compute once
final values = theme.compute();

// Use everywhere with const widgets
SKPadding(
  padding: values.paddingMd!,
  child: SKContainer(
    decoration: BoxDecoration(
      borderRadius: values.borderRadiusMd,
    ),
    child: Text('Hello', style: values.textMd),
  ),
)
```

### Compute once, use everywhere (performance best practice)

The compute pattern lets you pre-scale all your design tokens once per build and reuse them across your widget tree. This minimizes repeated calculations, enables more const-friendly widgets, and improves frame-time stability.

When to use compute:

- Use `SKitTheme.compute()` in a widget's build method (or builder) when you need many scaled values together (text styles, paddings, margins, radii, spacing, sizes).
- Prefer it for list/grid items and complex screens to avoid recalculating the same values per child.

Benefits:

- All values are scaled together with one factory access.
- Fewer object allocations and repeated calculations.
- Cleaner code: one place defines your tokens, one object provides them.

Example: precompute many values and build with them

```dart
// Define your design tokens once (can be const)
const theme = SKitTheme(
  textSm: 12,
  textMd: 14,
  textLg: 16,
  paddingSm: 8,
  paddingMd: 16,
  paddingLg: 24,
  spacingSm: 8,
  spacingMd: 16,
  spacingLg: 24,
  radiusSm: 6,
  radiusMd: 12,
);

@override
Widget build(BuildContext context) {
  // Compute once per build
  final values = theme.compute();

  return ListView.separated(
    padding: values.paddingHorizontal,
    itemCount: 20,
    separatorBuilder: (_, __) => SizedBox(height: values.spacingMd!),
    itemBuilder: (context, index) {
      return SKContainer(
        margin: values.marginHorizontal,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: values.borderRadiusMd,
        ),
        padding: values.paddingMd,
        child: Row(
          children: [
            Container(
              width: values.widthSm ?? 40,
              height: values.heightSm ?? 40,
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: values.borderRadiusSm,
              ),
            ),
            SizedBox(width: values.spacingMd!),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Title', style: values.textLg?.copyWith(fontWeight: FontWeight.bold)),
                  SizedBox(height: values.spacingSm!),
                  Text('Subtitle text', style: values.textSm),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}
```

Legacy compute helper (simple one-off values)

If you only need a few values in places where defining a full theme is overkill, you can use the legacy `SKitValues.compute` factory. This is maintained for convenience but `SKitTheme.compute()` is recommended for larger UIs.

```dart
final v = SKitValues.compute(
  padding: 16,
  margin: 8,
  borderRadius: 12,
  width: 120,
  height: 48,
  fontSize: 16,
);

return SKPadding(
  padding: v.padding,
  child: SKContainer(
    margin: v.margin,
    decoration: BoxDecoration(borderRadius: v.borderRadius),
    width: v.width,
    height: v.height,
    child: Text('Button', style: TextStyle(fontSize: v.fontSize)),
  ),
);
```

Tips:

- Compute close to where values are used to respect current device metrics and orientation.
- Recompute automatically when `MediaQuery` or locale changes (ScaleKitBuilder handles this); do not store across frames.
- Pair with `FontConfig`: precomputed `TextStyle`s automatically apply the selected font per language.

### Context Extensions

Use context extensions for responsive scaling:

```dart
Container(
  padding: context.scalePadding(horizontal: 20, vertical: 16),
  margin: context.scaleMargin(all: 8),
  decoration: BoxDecoration(
    borderRadius: context.scaleBorderRadius(all: 12),
  ),
  child: const Text('Content'),
)

// Device detection
if (context.isMobile) {
  // Mobile layout
} else if (context.isTablet) {
  // Tablet layout
}
```

### ScaleManager Direct API

### Responsive Builder & Columns

Build different widgets per device/orientation with sensible fallbacks, and resolve responsive integers (e.g., Grid columns) quickly.

#### SKResponsive Widget

Use when you have separate builders for each device/orientation:

```dart
// Widget builder with separate builders
SKResponsive(
  mobile: (_) => Text('Mobile portrait'),
  mobileLandscape: (_) => Text('Mobile landscape'), // Falls back to mobile if null
  tablet: (_) => Text('Tablet portrait'),
  tabletLandscape: (_) => Text('Tablet landscape'), // Falls back to tablet -> mobileLandscape -> mobile
  desktop: (_) => Text('Desktop'),
)
```

Fallback rules:
- `mobileLandscape` → falls back to `mobile` if null
- `tabletLandscape` → falls back to `tablet` → `mobileLandscape` → `mobile` if null
- Device: desktop → tablet → mobile; tablet → mobile

#### SKResponsiveBuilder Widget

Use when you need access to device and orientation in your builder function:

```dart
// Builder pattern with device and orientation info
SKResponsiveBuilder(
  builder: (context, device, orientation) {
    if (device == DeviceType.mobile && orientation == Orientation.landscape) {
      return Text('Mobile Landscape');
    }
    if (device == DeviceType.tablet) {
      return Text('Tablet');
    }
    return Text('Desktop or other');
  },
  desktopAs: DesktopAs.tablet, // Optional: make desktop behave like tablet
)

// Responsive integer with fallback rules (alias for columns)
final cols = SKit.responsiveInt(
  mobile: 2,            // required base
  tablet: 4,            // optional (falls back to mobile if null)
  desktop: 8,           // optional (falls back to tablet->mobile if null)
  mobileLandscape: 4,   // optional override for mobile landscape
  // tabletLandscape falls back to mobileLandscape, then tablet, then mobile
);
GridView.count(crossAxisCount: cols)
```

Both widgets support the same fallback rules:

- Device: desktop → tablet → mobile; tablet → mobile
- Orientation: landscape → device portrait; for tablet.landscape → mobile.landscape → mobile.portrait

Desktop behavior (CSS-like):

- On Android/iOS, devices are classified only as mobile or tablet by width; desktop logic doesn’t apply.
- On desktop (width ≥ 1200), desktop values are used by default. You can opt to reuse tablet/mobile values to mimic CSS breakpoints.
- This lets you build grids like in CSS (e.g., 2/4/8 columns) while forcing desktop to act like tablet/mobile if that’s desired.

Examples:

```dart
// Make desktop behave like tablet for layout decisions
SKResponsive(
  mobile: (_) => MobileView(),
  tablet: (_) => TabletView(),
  desktop: (_) => DesktopView(),
  desktopAs: DesktopAs.tablet, // 👈 map desktop to tablet behavior
)

// Resolve an integer (e.g., Grid crossAxisCount) with desktop mapped to tablet
final cols = SKit.responsiveInt(
  mobile: 2,
  tablet: 4,
  desktop: 8,
  desktopAs: DesktopAs.tablet, // 👈 desktop will use tablet values unless explicitly provided
);
GridView.count(crossAxisCount: cols)
```

Access scale values directly:

```dart
final scale = ScaleManager.instance;

Container(
  width: scale.getWidth(200),
  height: scale.getHeight(100),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(scale.getRadius(12)),
  ),
  child: Text(
    'Hello',
    style: TextStyle(fontSize: scale.getFontSize(16)),
  ),
)
```

### Helper Properties

Access device properties similar to `flutter_screenutil`:

```dart
final scaleKit = ScaleManager.instance;

// Device properties
double screenWidth = scaleKit.screenWidth;
double screenHeight = scaleKit.screenHeight;
double pixelRatio = scaleKit.pixelRatio;
double statusBarHeight = scaleKit.statusBarHeight;
double bottomBarHeight = scaleKit.bottomBarHeight;
double textScaleFactor = scaleKit.textScaleFactor;
double scaleWidth = scaleKit.scaleWidth;
double scaleHeight = scaleKit.scaleHeight;
Orientation orientation = scaleKit.orientation;
```

### ThemeData Integration

Use responsive scaling in your theme:

```dart
ScaleKitBuilder(
  designWidth: 375,
  designHeight: 812,
  designType: DeviceType.mobile,
  child: MaterialApp(
    theme: ResponsiveThemeData.create(
      context: context,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
    ),
    home: HomePage(),
  ),
)
```

### Orientation Autoscale (Landscape vs Portrait)

Scale Kit lets you control autoscale behavior per orientation. Defaults are tuned for comfort: landscape boosts are enabled, portrait boosts are disabled.

```dart
ScaleKitBuilder(
  designWidth: 375,
  designHeight: 812,
  // Orientation-specific flags
  autoScaleLandscape: true,  // default
  autoScalePortrait: false,  // default
  // Optional landscape boosts
  mobileLandscapeFontBoost: 1.2,
  mobileLandscapeSizeBoost: 1.2,
)
```

Notes:

- Landscape: readability boosts (e.g., +20% fonts on mobile) can apply.
- Portrait: stable sizes by default; set `autoScalePortrait: true` if you want portrait boosts.
- Size boosts only apply in landscape by default; portrait preserves your design intent.

#### Comparison with flutter_screenutil

### Enable/Disable Scaling (Runtime Toggle)

You can turn scaling off entirely to compare against raw Flutter sizes.

```dart
final enabled = ValueNotifier<bool>(true);

ScaleKitBuilder(
  designWidth: 375,
  designHeight: 812,
  enabledListenable: enabled, // runtime toggle
  enabled: enabled.value,      // initial
  child: MaterialApp(...),
);

// Toggle anywhere
enabled.value = false; // disables scaling (values returned unmodified)
```

Notes:

- When disabled, `.w/.h/.sp` and ScaleManager methods return the input value (no scaling).
- Re-enable to restore responsive scaling.

Tip: Use the example app’s settings (tune icon) to live-test autoscale flags and boosts, then Save to apply. You can Reset to defaults from the sheet.

When resizing windows (desktop/web) or changing device sizes, `flutter_screenutil` often scales cards and paddings more aggressively, which can make components look oversized. Scale Kit clamps scale factors and applies orientation-aware boosts, keeping practical sizes and better visual balance during resizes and rotations.

### Font Configuration (Automatic Font Selection)

Configure fonts for different languages. All TextStyles automatically use the configured font for the current language:

```dart
import 'package:google_fonts/google_fonts.dart';

void main() {
  // Configure font for specific language (optional)
  // If not configured, Flutter's default font will be used
  FontConfig.instance.setLanguageFont(
    LanguageFontConfig(
      languageCode: 'ar',
      googleFont: GoogleFonts.almarai,  // Pass GoogleFonts function
    ),
  );

  FontConfig.instance.setLanguageFont(
    LanguageFontConfig(
      languageCode: 'en',
      googleFont: GoogleFonts.inter,
    ),
  );

  // Configure font for language group
  FontConfig.instance.setLanguageGroupFont(
    LanguageGroupFontConfig(
      languageCodes: ['ar', 'fa', 'ur'],
      googleFont: GoogleFonts.almarai,
    ),
  );

  // Set default font (used when no specific language config exists)
  FontConfig.instance.setDefaultFont(
    googleFont: GoogleFonts.inter,
  );

  runApp(const MyApp());
}
```

**Usage:**

Once configured, all TextStyles automatically use the configured font:

```dart
// Automatic font application - no manual configuration needed
Text('Hello', style: TextStyle(fontSize: 16.sp))  // ✅ Uses FontConfig automatically

// Or via theme - all theme text styles get the font automatically
ResponsiveThemeData.create(
  context: context,
  textTheme: ThemeData.light().textTheme,  // ✅ All styles get font automatically
)
```

**Custom Font Family:**

You can also use custom font families (fonts loaded in `pubspec.yaml`):

```dart
FontConfig.instance.setLanguageFont(
  LanguageFontConfig(
    languageCode: 'ar',
    customFontFamily: 'CustomArabicFont',  // From pubspec.yaml
  ),
);
```

**Note:** If no font is configured, Flutter's default font (Roboto on Android, San Francisco on iOS) will be used. The font configuration is completely optional.

## Package Size

**Important:** When you add this package as a dependency using `flutter pub get`, you will **NOT** download the `example` folder. Pub.dev automatically excludes the example folder from the package distribution. The example folder is only available on the pub.dev website for documentation purposes.

The package size is optimized and only includes the necessary library code (`lib/` folder).

## API Reference

### Extension Methods (on num)

- `.w` - Scaled width (e.g., `200.w`)
- `.sw` - Screen width percentage (e.g., `0.5.sw` = 50% width)
- `.sh` - Screen height percentage (e.g., `0.25.sh` = 25% height)
- `.r` - Scaled radius/border radius (e.g., `12.r`)
- `.sp` - Scaled font size (e.g., `16.sp`)
- `.h` - Scaled height (e.g., `100.h`)
- `.spf` - Font size with system text scale factor (e.g., `16.spf`)

### Context Extensions

- `context.scaleWidth(double width)` - Get scaled width
- `context.scaleHeight(double height)` - Get scaled height
- `context.scaleFontSize(double fontSize)` - Get scaled font size
- `context.scaleSize(double size)` - Get scaled size
- `context.scalePadding(...)` - Get responsive padding
- `context.scaleMargin(...)` - Get responsive margin
- `context.scaleBorderRadius(...)` - Get responsive border radius
- `context.isMobile` - Check if device is mobile
- `context.isTablet` - Check if device is tablet
- `context.isDesktop` - Check if device is desktop

### ScaleManager Properties

- `pixelRatio` - Device pixel density
- `screenWidth` - Device width in logical pixels
- `screenHeight` - Device height in logical pixels
- `bottomBarHeight` - Bottom safe zone distance
- `statusBarHeight` - Status bar height (includes notch)
- `textScaleFactor` - System font scaling factor
- `scaleWidth` - Ratio of actual width to UI design width
- `scaleHeight` - Ratio of actual height to UI design height
- `orientation` - Screen orientation (portrait/landscape)
- `devicePixelRatio` - Physical pixels per logical pixel
- `topSafeHeight` - Top safe area height
- `bottomSafeHeight` - Bottom safe area height
- `safeAreaHeight` - Total safe area height
- `safeAreaWidth` - Safe area width

### ScaleManager Methods

- `getWidth(double width)` - Get scaled width
- `getHeight(double height)` - Get scaled height
- `getFontSize(double fontSize)` - Get scaled font size
- `getFontSizeWithFactor(double fontSize)` - Get scaled font size with system factor
- `getRadius(double radius)` - Get scaled radius
- `getScreenWidth(double percentage)` - Get screen width percentage
- `getScreenHeight(double percentage)` - Get screen height percentage

### FontConfig API

- `FontConfig.instance` - Singleton instance for font configuration
- `setLanguageFont(LanguageFontConfig)` - Configure font for specific language
- `setLanguageGroupFont(LanguageGroupFontConfig)` - Configure font for language group
- `setDefaultFont({googleFont?, customFontFamily?})` - Set default font
- `setLanguagesFonts(List<LanguageFontConfig>)` - Configure multiple languages at once
- `setLanguageGroupsFonts(List<LanguageGroupFontConfig>)` - Configure multiple language groups
- `getTextStyle({languageCode?, baseTextStyle})` - Get TextStyle with configured font
- `currentLanguageCode` - Get current language code
- `clear()` - Clear all font configurations

## Performance

Flutter Scale Kit uses intelligent caching to minimize recalculations:

- **Flyweight Pattern**: Reuses cached calculated values
- **Cache Invalidation**: Automatically clears cache on size/orientation change
- **Const Widgets**: Pre-calculated values for const-compatible widgets
- **Singleton Pattern**: Single instance manages all scaling operations
- **Threshold-Based Updates**: Only recalculates on significant size changes (>5%)

## Architecture

The package uses design patterns for optimal performance:

- **Singleton**: `ScaleManager` - Global scale configuration
- **Factory**: `ScaleValueFactory` - Creates cached scaled values
- **Flyweight**: `ScaleValueCache` - Reuses cached values

## Device-Specific Scaling

The package automatically adapts scaling strategies based on:

- **Device Type**: Mobile, Tablet, Desktop, Web
- **Aspect Ratio**: Narrow, Wide, Standard
- **Orientation**: Portrait, Landscape
- **Foldable Devices**: Detects fold/unfold transitions

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

If you find this package useful, please consider giving it a star ⭐ on GitHub!

## Acknowledgements

Huge thanks to the authors and contributors of `flutter_screenutil` and similar responsive design packages. We used them extensively, learned from their great ideas, and built Flutter Scale Kit as an alternative optimized for our apps' performance and developer experience. `flutter_screenutil` is a solid package; this project simply explores a different set of trade‑offs (compute-once patterns, caching, language-aware fonts, and orientation-aware scaling) that matched our needs.

## FAQ

Q: Why choose Flutter Scale Kit over `flutter_screenutil`?

A: If you want compute-once patterns, automatic font selection by language, orientation-aware scaling controls, and an optional runtime toggle to compare raw Flutter vs scaled values, Scale Kit might fit better. If you’re happy with your current setup, `flutter_screenutil` remains an excellent choice.

Q: How do I disable scaling to compare with raw Flutter sizes?

A: Use `ScaleKitBuilder(enabled: false)` or provide `enabledListenable` for a runtime switch. In the example, tap the tune icon to toggle and Save.

Q: Can I control autoscale separately for portrait and landscape?

A: Yes. `autoScaleLandscape` (default true) and `autoScalePortrait` (default false) let you enable/disable boosts per orientation. You can also set device-specific font/size boosts.

Q: Do all TextStyles get my configured font automatically?

A: Yes. Fonts apply automatically via `FontConfig` integration in theme creation and text style scaling. If no configuration is provided, Flutter’s default font is used.

Q: Why is borderRadius removed when using different border colors per side?

A: It’s a Flutter limitation. When individual sides have different colors, `BoxDecoration` can’t combine non-uniform borders with `borderRadius`. We avoid the rendering error by omitting `borderRadius` in those cases.

Q: Will this increase my package size?

A: The package only ships the `lib/` code. The example and screenshots are not included in the pub.dev download. Use Google Fonts conditionally as needed.
