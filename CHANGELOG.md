# Changelog

All notable changes to this project will be documented in this file.

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
