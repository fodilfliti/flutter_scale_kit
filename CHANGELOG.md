# Changelog

All notable changes to this project will be documented in this file.

## [1.1.5] - 2025-11-11

### ✨ Added

- Optional `deviceTypeOverride` parameter in `ScaleKitBuilder`, `SKResponsive`, `SKResponsiveBuilder`, and `SKResponsiveValue` to force desktop/web behaviour.
- `ScaleManager.setDeviceOverride` helper to control global device detection.
- `lockDesktopPlatforms` option on `ScaleKitBuilder` to auto-lock web/desktop devices without affecting mobile/tablet.
- `ScaleManager.platformCategory` helper for safe platform inspection across mobile, desktop, and web.
- Per-widget desktop overrides (`lockDesktopAsTablet` / `lockDesktopAsMobile`) on responsive widgets and values.
- New context helpers `isTypeOfMobile()` / `isTypeOfTablet()` with `DeviceClassificationSource` support, plus `DeviceType` convenience getters.
- `ScaleManager.deviceTypeFor(...)` to fetch responsive, platform, or size classifications and `desktopLockFallback` for visibility into the current lock behaviour.
- Desktop lock fallback now respects live window breakpoints (e.g. mobile fallback applies only when the window is within the mobile size range).
- `context.isDesktopPlatform` now includes web; use `context.isWebPlatform` when you need to target web specifically.
- `ScaleKitBuilder` now accepts custom `ScaleBreakpoints`, unlocking configurable device thresholds and the new `DeviceSizeClass` helpers (available via `ScaleManager.screenSizeClass` and context extensions).
- Added size-class context helpers (`screenSizeClass`, `isSmallMobileSize`, … `isExtraLargeDesktopSize`) and exposure of the active breakpoint configuration.
- Example settings sheet and live debug panel now include breakpoint controls and live size-class/breakpoint diagnostics.

### 📚 Documentation

- Documented the new override options in the README with usage snippets.
- Expanded README coverage for breakpoint configuration, size classes, and related context helpers.

## [1.1.4] - 2025-11-10

### ✨ Added

- `horizontalSpace` and `verticalSpace` numeric extensions to mirror flutter_screenutil spacing helpers.
- Example app now showcases the new spacing extensions alongside `HSpace`/`VSpace` usage.

### 📚 Documentation

- Documented spacing widgets (`SKSizedBox`, `HSpace`, `VSpace`, `SSpace`) and numeric spacing extensions in the README.
- Added usage snippets for spacing helpers to the Extension Methods section and code snippets library.

---

## [1.1.3] - 2025-11-08

### 📚 Documentation

#### Fixed

- Fixed all navigation links and anchors to ensure proper table of contents linking
- Removed orphaned section references from table of contents
- Added missing anchors for Context Extensions, Device-Specific Scaling, and FAQ sections
- Cleaned up version references in documentation

#### Optimized

- Completely reorganized documentation structure for better user flow
- Merged redundant sections and eliminated duplication
- Improved section hierarchy with clear main sections and subsections
- Enhanced readability with better transitions between concepts

#### Added

- New hierarchical table of contents with clear section groupings
- Better separation between core concepts, APIs, configuration, and advanced features
- Improved navigation with consistent anchor naming

---

## [1.1.2] - 2025-11-08

### 📚 Documentation

#### Fixed

- Added missing navigation anchor for ScaleManager Direct API section to ensure proper table of contents linking.

---

## [1.1.1] - 2025-11-08

### 📚 Documentation

#### Optimized

- Streamlined README flow for beginners and advanced users, consolidating quick-start sections and clarifying FontConfig/ThemeData integration.
- Ensured all Table of Contents links are accurate and point to explicit anchors.
- Restored detailed content for Advanced Tuning, Reference, Optional Tools, and Community sections.
- Removed redundant Pub Popularity badge.

---

## [1.1.0] - 2025-11-08

### ✨ Renamed & Enhanced Design Values

#### Changed

- Renamed `SKitTheme` to `ScaleKitDesignValues` for clearer intent (with deprecated typedefs to keep existing code compiling).
- Renamed `SKitThemeValues` to `ScaleKitDesignValuesSet` and updated all docs/examples to use the new names.
- `ScaleKitDesignValues.compute()` now returns safe-clamped radii by default via `createRadiusSafe` / `createBorderRadiusSafe`.
- Example app and code snippets now showcase `ScaleKitDesignValues` usage, including responsive builder snippets and updated tip cards.

#### Documentation

- README “Recommended Building Blocks” now features `ScaleKitDesignValues`, runtime responsive builder snippet, and clarified `.rSafe` behavior.
- Reorganized documentation so optional tooling appears later and cross-links point from quick-start to advanced tuning.

---

## [1.0.13] - 2025-01-17

### ✨ New Radius Controls

#### Added

- **`.rSafe` extension** – gently clamped radius scaling that keeps corners natural across devices.
- **`SKRadiusMode`** – configure radius behavior (`safe`, `scaled`, `fixed`) for all `SKit.rounded*` helpers.
- **`ScaleValueFactory.createRadiusSafe()` / `createBorderRadiusSafe()`** – cached safe radius computations.
- **`ScaleManager.getRadiusSafe()`** – configurable clamp bounds with `setRadiusSafeBounds()`.

#### Changed

- `SKit.rounded`, `roundedContainer`, and `roundedContainerSize` now default to `SKRadiusMode.safe`.
- Numeric radius size helpers now avoid auto-scaling raw doubles, keeping design intent intact.
- Example app updated to demonstrate `.rSafe`, `.r`, and `.rFixed` usage, with new guidance cards.
- README extension section expanded with radius helper comparison and new code samples.
- Added `radiusMode` documentation across helper methods.

#### Fixed

- Prevented oversized corner rounding on wide desktop/tablet layouts when using design radii (e.g., 12 now clamps to 15 max).
- Ensured border-radius caching respects new safe/fixed behaviors without recomputation.

### 📚 Documentation

- Installation instructions updated to `^1.0.13`.
- New README guidance on choosing `.rSafe`, `.r`, or `.rFixed`.
- Example snippets highlight `radiusMode` usage and stable radius tips.

---

## [1.0.12] - 2025-01-16

### 🔧 Fixes & Improvements

#### Fixed

- **Android SDK Compatibility** - Updated example app to require minimum SDK 23
  - Required by `super_native_extensions` plugin dependency
  - Updated `example/android/app/build.gradle.kts` with `minSdk = 23`
  - Example app now compatible with Android 6.0 (Marshmallow) and above

#### Documentation

- **Interactive Table of Contents** - Added comprehensive TOC to README after screenshots

  - 30+ clickable navigation links organized into 5 categories
  - Quick Start, Core Concepts, Usage & Widgets, Advanced Features, Reference, Community
  - Significantly improved documentation navigation and user experience
  - Users can now jump directly to any section without scrolling

- **Deprecation Fix** - Replaced deprecated `textScaleFactor` with `textScaler`
  - Updated `SKit.textFull()` to use Flutter's latest text scaling API
  - Prepares for upcoming nonlinear text scaling support (Flutter v3.12+)
  - Updated all documentation references

#### Technical

- **Code Formatting** - Applied `dart format` to all source files
  - 8 files reformatted for consistency
  - Meets pub.dev publishing standards

### 📦 Publishing

- ✅ **0 warnings** - Package validation passed
- ✅ All Flutter analyze checks passed
- ✅ Production-ready for pub.dev

---

## [1.0.11] - 2025-01-16

### 🎨 New Features: Comprehensive Text Widgets

#### Added

- **`SKit.textFull()`** - Complete Text widget factory with ALL 30+ Flutter Text attributes
  - Style parameters: fontSize, fontWeight, fontStyle, color, backgroundColor, fontFamily, fontFamilyFallback
  - Spacing: letterSpacing, wordSpacing, height, textBaseline
  - Decoration: decoration, decorationColor, decorationStyle, decorationThickness
  - Effects: shadows, foreground, background, leadingDistribution
  - Layout: textAlign, textDirection, softWrap, overflow, maxLines
  - Accessibility: semanticsLabel, textScaleFactor, textWidthBasis, textHeightBehavior, selectionColor
  - Advanced: locale, fontFeatures, fontVariations
  - **Automatic fontSize scaling** - no need to use `.sp` manually!
- **`SKit.textStyleFull()`** - Complete TextStyle factory with ALL Flutter TextStyle attributes
  - Includes all TextStyle properties: fontSize, fontWeight, colors, spacing, decoration, shadows, etc.
  - Supports advanced features: fontFeatures, fontVariations, debugLabel, overflow
  - **Automatic fontSize scaling** built-in
  - Perfect for creating reusable comprehensive text styles

#### Enhanced

- **`ScaleValueFactory.createTextStyle()`** - Extended to support 25+ TextStyle attributes
  - Added: backgroundColor, fontFamilyFallback, wordSpacing, textBaseline
  - Added: shadows, foreground, background, leadingDistribution
  - Added: locale, fontFeatures, fontVariations, debugLabel, overflow
  - Smart caching: Core parameters cached, additional parameters applied via copyWith for optimal performance

#### Documentation

- **New "Comprehensive Text Widgets" section** in README with:
  - Before/after code examples showing the convenience
  - Complete list of all 30+ available parameters organized by category
  - Real-world usage examples with shadows, decorations, and advanced styling
  - Clear guidance on when to use `text()` vs `textFull()` vs `textStyleFull()`
  - Benefits explanation: less boilerplate, automatic scaling, type-safe, consistent styling

#### Benefits for Developers

✅ **One-stop solution** - All Text/TextStyle attributes in single method calls  
✅ **Less boilerplate** - No need to manually create TextStyle then Text  
✅ **Automatic scaling** - fontSize scaled without `.sp`  
✅ **Type-safe** - Full autocomplete support for all Flutter attributes  
✅ **Reusable styles** - Easy to create and share comprehensive text styles  
✅ **No breaking changes** - Existing `text()` and `textStyle()` methods unchanged

## [1.0.10] - 2025-01-16

### 🧠 Major Feature: Intelligent Auto-Configuration

#### Added

- **Intelligent Scale Limit Auto-Detection**: Package now automatically determines optimal `minScale` and `maxScale` based on device type, screen size, orientation, and aspect ratio
  - Mobile phones: 0.85-1.15x (portrait), 0.85-1.25x (landscape)
  - Tablets: 0.8-1.3x (portrait), 0.75-1.4x (landscape)
  - Desktop/Web: 0.6-2.0x (landscape), 0.7-1.8x (portrait)
  - Special handling for foldables, ultra-wide monitors (>2560px), small windows (<800px), and notched screens
  - Automatically adjusts limits when mobile designs run on tablets/desktop
- **Zero-Configuration Setup**: `minScale` and `maxScale` parameters are now optional (nullable) - pass `null` to enable auto-detection (recommended for 95% of use cases)
- **Manual Override Toggle**: Example app now includes "Manual Scale Control" switch in settings to toggle between auto-detection and manual configuration
- **Live Scale Preview**: Settings UI displays real-time scale calculations showing:
  - Current device type (Mobile/Tablet/Desktop) with badge
  - Orientation (Portrait/Landscape)
  - Auto-detected scale range (e.g., "Auto: 0.85-1.15x")
  - Raw scale vs clamped scale comparison with color coding
  - Active clamping warnings
  - Example calculations (e.g., "100.w = 125px")

#### Documentation

- **New "Intelligent Auto-Configuration" Section** in README (prominently placed after screenshots):
  - Two-column layout explaining what the package auto-detects and optimizes
  - Zero-configuration code example
  - Clear guidance on when manual configuration is needed (edge cases only)
- **Enhanced "Understanding Scale Limits" Section**:
  - Step-by-step math examples with real device scenarios
  - Updated use case table focusing on manual override scenarios
  - Added reminder that auto-detection handles most cases
- **New "Understanding Orientation Boosts" Section** with comprehensive documentation:
  - Complete scaling formulas for sizes and fonts
  - Default boost table for all device types and orientations
  - Real-world step-by-step math example (iPhone 14 landscape)
  - Three practical use cases with code examples (Dense dashboards, Reading apps, Kiosk tablets)
  - Complete working example with inline math breakdowns
  - Six key takeaways explaining boost behavior
- **Inline Code Documentation**:
  - Added detailed comment blocks in `main.dart` explaining intelligent auto-configuration
  - Added orientation boost explanation with math examples
  - All boost parameters now include their default values in comments
- **Key Features Section**: Added intelligent auto-configuration as a highlighted feature at the top of README

#### Changed

- `minScale` and `maxScale` parameters in `ScaleKitBuilder` are now nullable (`double?`) instead of required
- Example app defaults to `null` for both scale limits, enabling intelligent auto-detection
- Enhanced `_getScaleLimits()` algorithm in `ScaleManager` with:
  - Orientation-aware limits (landscape gets wider ranges)
  - Aspect ratio detection (narrow/standard/wide)
  - Design-to-screen ratio analysis
  - Special case handling for edge scenarios
- Settings UI now clearly indicates when auto-detection is active vs manual override:
  - Green "Auto-Intelligent" badge when using auto-detection
  - Orange "Manual Override" badge when using manual limits
  - Dynamic subtitle showing current mode

#### Fixed

- Removed unused `_useManualScaleLimits` field from example app (was causing linter warning)
- Settings sheet now properly handles null scale values throughout the UI

### Technical Improvements

- Enhanced `ScaleManager._getScaleLimits()` with 90+ lines of intelligent detection logic
- Settings preview builder now calculates and displays auto-detected values
- Scale limits are computed dynamically based on current screen state
- Manual override properly restores to null values when disabled

## [1.0.9] - 2025-01-15

### Added

- GitHub Pages deployment workflow for hosting live web demo
- Live web demo link in README for easy access to interactive example
- GitHub Actions workflow for automated web app deployment (manual trigger)

### Changed

- Updated GitHub Actions workflow to use Flutter 3.29.2
- Web demo deployment is now manual-only to prevent unnecessary builds

### Fixed

- Documentation improvements for GitHub Pages setup

## [1.0.8] - 2025-11-06

### Changed

- Example Android: set `ndkVersion` to r28 to support 16 KB memory page size requirement
- Settings UX: Save now force-applies changes (disable → short wait → enable) and rebuilds
- Settings UI: buttons use Row aligned end (Wrap fallback on compact), controls hide/show based on toggles

### Fixed

- Avoid overflow in settings action area on small screens
- Hide settings action when scaling is disabled

## [1.0.7] - 2025-11-05

### Added

- `SKResponsiveBuilder` widget with dual usage patterns:
  - Builder pattern: main `builder` that receives `(context, device, orientation)`
  - Device-specific builders: optional `mobile`, `tablet`, `desktop`, `mobileLandscape`, `tabletLandscape`, `desktopLandscape` (similar to `SKResponsive`)
- Improved fallback logic for `SKResponsive`: `mobileLandscape` now falls back to `mobile`, `tabletLandscape` falls back to `tablet` then `mobileLandscape` then `mobile`

### Changed

- `SKResponsive` fallback order: `tabletLandscape ?? tablet ?? mobileLandscape ?? mobile` (more intuitive)
- `SKResponsiveBuilder`: device-specific builders take priority over main builder when both are provided

## [1.0.6] - 2025-11-05

### Fixed

- Fixed formatting issues in `scale_value_factory.dart` to match Dart formatter

## [1.0.5] - 2025-11-05

### Fixed

- Removed dangling library doc comment (changed to regular comment)
- Fixed formatting issues in `aspect_ratio_adapter.dart` and all lib files
- Removed `.pubignore` to include example folder (pub.dev requirement)

### Added

- Complete dartdoc documentation for all public API symbols:
  - `AspectRatioAdapter` constructor documentation
  - `DeviceDetector` constructor documentation
  - `FontConfig.instance` getter documentation
  - `HSpace` constructor documentation
  - `LanguageFontConfig` constructor documentation

### Changed

- All library files formatted with `dart format` for consistency
- Example folder now included in published package (required by pub.dev)

## [1.0.4] - 2025-11-05

### Fixed

- Pub.dev compliance: shortened description (60–180 chars), removed library declaration, replaced deprecated Color.value
- Added pub badges, topics, platforms, screenshots, issue tracker and documentation links
- Exclude example from publish via `.pubignore`

### Changed

- Docs refinements and export additions (no breaking API changes)

## [1.0.3] - 2025-11-05

### Added

- `SKResponsive` widget for device/orientation-aware builders with sensible fallbacks
- `SKit.responsiveInt()` and `SKit.responsiveDouble()` for responsive integer/double resolution (e.g., Grid columns)
- `SKit.columns()` alias for `responsiveInt()` for grid layouts
- `DesktopAs` enum to control how desktop resolves (desktop/tablet/mobile) for CSS-like breakpoints
- Device detection: desktop classified strictly by width ≥ 1200 (Android/iOS remain mobile/tablet by width)
- Desktop can optionally mimic tablet/mobile values using `desktopAs` parameter
- Example app section demonstrating responsive builder and columns usage
- README updates: Responsive Builder & Columns section with DesktopAs examples and CSS-like behavior notes
- Pub badges (version, likes, points, popularity) and CTA in README
- Pub.dev metadata: topics, platforms, screenshots, issue_tracker, documentation links

### Changed

- Desktop behavior: treated as single form by default; can opt-in to tablet/mobile behavior via `desktopAs`
- Android/iOS: devices classified only as mobile/tablet by width; desktop logic doesn't apply
- README: added DesktopAs documentation and CSS-like grid examples
- Package description shortened to 169 characters (within pub.dev 60-180 range)

### Fixed

- Removed unnecessary library declaration (`library flutter_scale_kit;`)
- Replaced deprecated `Color.value` with `Color.toARGB32()` for cache key generation
- Added `.pubignore` to exclude example folder from published package

## [1.0.2] - 2025-11-05

### Added

- Orientation-specific autoscale flags: `autoScaleLandscape` (default true), `autoScalePortrait` (default false)
- Portrait font/size boosts per device type (mobile/tablet/desktop)
- Global enable/disable scaling with runtime toggle via `enabled` and `enabledListenable`
- Example app settings sheet to live-test autoscale and boosts, with Save/Cancel and Reset to defaults
- Device detection updated: Android/iOS (including emulators) are mobile/tablet by width; desktop only for desktop OS; web distinct
- README updates: Orientation Autoscale, Runtime Toggle sections; added screenshots and guidance

### Fixed

- MaterialLocalizations error when opening settings (uses proper in-app context)
- Overflow in demo card: text now wraps/scales to avoid RenderFlex overflows

### Changed

- Example made more professional and explanatory for all package parts

## [1.0.1] - 2025-01-XX

### Fixed

- Fixed `borderRadius` error when using different border colors on individual sides
- Fixed Localizations error when context doesn't include Localizations ancestor
- Made FontConfig a proper singleton with `instance` getter
- Fixed all lint warnings for local variables starting with underscore

### Added

- Font configuration system with automatic font selection per language
- Support for Google Fonts and custom font families
- Automatic font application to all TextStyles
- Language group font configuration
- Safe Localizations access with fallback to default language
- Default font fallback (uses Flutter's default font if no configuration provided)
- `FontConfig` class for managing fonts per language
- `LanguageFontConfig` and `LanguageGroupFontConfig` for font configuration
- `TextStyle` extensions for automatic font application
- Screenshots for mobile, tablet, and desktop devices

### Changed

- FontConfig now uses singleton pattern with `FontConfig.instance`
- All TextStyle creation methods automatically apply FontConfig
- ThemeData integration now includes automatic font configuration
- Improved error handling for missing Localizations context
- Updated README with side-by-side mobile and tablet screenshots

## [1.0.0] - 2024-01-XX

### Added

- Initial release of Flutter Scale Kit
- Extension methods for easy scaling (`.w`, `.sw`, `.sh`, `.r`, `.sp`, `.h`)
- `ScaleKitBuilder` widget for app-level responsive configuration
- `SKit` helper class with convenient methods for creating widgets
- Size system with predefined enums (`SKSize`, `SKTextSize`)
- Centralized theme configuration with `SKitTheme`
- Individual border side support for containers (top, bottom, left, right)
- Border color and width customization per side
- Context extensions for responsive scaling
- Device detection utilities (mobile, tablet, desktop)
- ThemeData integration for responsive themes
- Intelligent caching system for optimal performance
- Const-compatible widgets (`SKPadding`, `SKContainer`, `SKMargin`, `HSpace`, `VSpace`, `SSpace`)
- Helper properties similar to `flutter_screenutil` (pixelRatio, screenWidth, screenHeight, etc.)
- Size configuration system with default values
- Custom size values for padding, margin, radius, spacing, and text sizes

### Features

- High-performance responsive design with intelligent caching
- Flyweight pattern for value reuse
- Factory pattern for creating scaled values
- Singleton pattern for global scale management
- Automatic cache invalidation on size/orientation changes
- Device-specific scaling strategies
- Aspect ratio adaptation for various device types
- Orientation-aware font scaling (20% boost for mobile landscape)
- Threshold-based size change detection (5% threshold)

### Performance

- Caching system prevents recalculation on every rebuild
- Only recalculates on significant size or orientation changes
- Const-compatible widgets for better performance
- Optimized widget rebuilds
