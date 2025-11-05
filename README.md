# Flutter Scale Kit

A high-performance responsive design package for Flutter that helps you create adaptive UIs across different screen sizes with easy-to-use scaling utilities.

## Screenshots

### Mobile

![Flutter Scale Kit - Mobile](screenshots/mobile.png)

### Tablet

![Flutter Scale Kit - Tablet](screenshots/table.png)

### Desktop

![Flutter Scale Kit - Desktop](screenshots/desctop.png)

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

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  flutter_scale_kit: ^1.0.1
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
  Text('Content'),
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

### Context Extensions

Use context extensions for responsive scaling:

```dart
Container(
  padding: context.scalePadding(horizontal: 20, vertical: 16),
  margin: context.scaleMargin(all: 8),
  decoration: BoxDecoration(
    borderRadius: context.scaleBorderRadius(all: 12),
  ),
  child: Text('Content'),
)

// Device detection
if (context.isMobile) {
  // Mobile layout
} else if (context.isTablet) {
  // Tablet layout
}
```

### ScaleManager Direct API

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
