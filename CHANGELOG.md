# Changelog

All notable changes to this project will be documented in this file.

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
- Extension methods for easy scaling (`.w`, `.h`, `.sp`, `.r`, `.sw`, `.sh`, `.spf`)
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
