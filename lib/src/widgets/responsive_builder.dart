import 'package:flutter/widgets.dart';
import '../core/scale_manager.dart';
import '../core/responsive_enums.dart';

typedef ResponsiveWidgetBuilder = Widget Function(BuildContext context);

/// A simple device/orientation-aware builder with sensible fallbacks.
///
/// Fallback rules:
/// - Device: desktop -> tablet -> mobile; tablet -> mobile
/// - Orientation: landscape -> corresponding portrait; tablet.landscape -> mobile.landscape -> mobile.portrait
class SKResponsive extends StatelessWidget {
  final ResponsiveWidgetBuilder? mobile;
  final ResponsiveWidgetBuilder? tablet;
  final ResponsiveWidgetBuilder? desktop;

  final ResponsiveWidgetBuilder? mobileLandscape;
  final ResponsiveWidgetBuilder? tabletLandscape;
  final ResponsiveWidgetBuilder? desktopLandscape;
  final DesktopAs desktopAs;

  /// Forces the responsive logic to treat the current device as the provided type.
  final DeviceType? deviceTypeOverride;

  /// Overrides the desktop lock fallback (when active) for this widget.
  final bool lockDesktopAsTablet;
  final bool lockDesktopAsMobile;

  const SKResponsive({
    super.key,
    this.mobile,
    this.tablet,
    this.desktop,
    this.mobileLandscape,
    this.tabletLandscape,
    this.desktopLandscape,
    this.desktopAs = DesktopAs.desktop,
    this.deviceTypeOverride,
    this.lockDesktopAsTablet = false,
    this.lockDesktopAsMobile = false,
  }) : assert(
         !(lockDesktopAsTablet && lockDesktopAsMobile),
         'lockDesktopAsTablet and lockDesktopAsMobile cannot both be true.',
       );

  @override
  Widget build(BuildContext context) {
    final scale = ScaleManager.instance;
    final overrideFallback =
        lockDesktopAsTablet
            ? DesktopLockFallback.tablet
            : lockDesktopAsMobile
            ? DesktopLockFallback.mobile
            : null;
    final device =
        deviceTypeOverride ??
        scale.responsiveDeviceType(override: overrideFallback);
    final isLandscape = scale.orientation == Orientation.landscape;

    ResponsiveWidgetBuilder? pick() {
      if (device == DeviceType.desktop || device == DeviceType.web) {
        // Desktop handling can mimic tablet/mobile if desired
        switch (desktopAs) {
          case DesktopAs.desktop:
            return desktop ?? tablet ?? mobile;
          case DesktopAs.tablet:
            if (isLandscape) {
              return tabletLandscape ?? mobileLandscape ?? tablet ?? mobile;
            }
            return tablet ?? mobile;
          case DesktopAs.mobile:
            if (isLandscape) {
              return mobileLandscape ?? mobile ?? tablet ?? desktop;
            }
            return mobile ?? tablet ?? desktop;
        }
      }
      if (isLandscape) {
        switch (device) {
          case DeviceType.tablet:
            // If tabletLandscape is null, fall back to tablet, then mobileLandscape, then mobile
            return tabletLandscape ?? tablet ?? mobileLandscape ?? mobile;
          case DeviceType.mobile:
            // If mobileLandscape is null, fall back to mobile
            return mobileLandscape ?? mobile;
          case DeviceType.desktop:
            return desktopLandscape ?? desktop ?? tablet ?? mobile;
          case DeviceType.web:
            return desktopLandscape ?? desktop ?? tablet ?? mobile;
        }
      } else {
        switch (device) {
          case DeviceType.desktop:
            return desktop ?? tablet ?? mobile;
          case DeviceType.web:
            return desktop ?? tablet ?? mobile;
          case DeviceType.tablet:
            return tablet ?? mobile;
          case DeviceType.mobile:
            return mobile;
        }
      }
    }

    final builder = pick();
    if (builder != null) return builder(context);
    return const SizedBox.shrink();
  }
}

/// Generic responsive value resolver following the same fallback rules.
class SKResponsiveValue<T> {
  final T? mobile;
  final T? tablet;
  final T? desktop;
  final T? mobileLandscape;
  final T? tabletLandscape;
  final T? desktopLandscape;

  /// Forces this value set to resolve as the provided [DeviceType] when non-null.
  final DeviceType? deviceTypeOverride;

  /// Overrides the desktop lock fallback (when active) for this value.
  final bool lockDesktopAsTablet;
  final bool lockDesktopAsMobile;

  const SKResponsiveValue({
    this.mobile,
    this.tablet,
    this.desktop,
    this.mobileLandscape,
    this.tabletLandscape,
    this.desktopLandscape,
    this.deviceTypeOverride,
    this.lockDesktopAsTablet = false,
    this.lockDesktopAsMobile = false,
  }) : assert(
         !(lockDesktopAsTablet && lockDesktopAsMobile),
         'lockDesktopAsTablet and lockDesktopAsMobile cannot both be true.',
       );

  /// Resolves the value for the current context.
  ///
  /// Provide [overrideDeviceType] to force resolution regardless of the detected device.
  T? resolve({DeviceType? overrideDeviceType}) {
    final scale = ScaleManager.instance;
    final isLandscape = scale.orientation == Orientation.landscape;
    final overrideFallback =
        lockDesktopAsTablet
            ? DesktopLockFallback.tablet
            : lockDesktopAsMobile
            ? DesktopLockFallback.mobile
            : null;
    final device =
        overrideDeviceType ??
        deviceTypeOverride ??
        scale.responsiveDeviceType(override: overrideFallback);

    if (device == DeviceType.desktop || device == DeviceType.web) {
      return desktop ?? tablet ?? mobile;
    }
    if (isLandscape) {
      switch (device) {
        case DeviceType.tablet:
          return tabletLandscape ?? mobileLandscape ?? tablet ?? mobile;
        case DeviceType.mobile:
          return mobileLandscape ?? mobile;
        case DeviceType.desktop:
        case DeviceType.web:
          return desktop; // unreachable due to early return
      }
    } else {
      switch (device) {
        case DeviceType.desktop:
        case DeviceType.web:
          return desktop ?? tablet ?? mobile;
        case DeviceType.tablet:
          return tablet ?? mobile;
        case DeviceType.mobile:
          return mobile;
      }
    }
  }

  // device() not needed; using ScaleManager.deviceType
}

/// Builder function type for SKResponsiveBuilder
/// Receives context, device type, and orientation
typedef ResponsiveBuilder =
    Widget Function(
      BuildContext context,
      DeviceType device,
      Orientation orientation,
    );

/// A responsive builder widget that provides device and orientation information
/// to the builder function.
///
/// This widget supports two usage patterns:
///
/// 1. **Builder pattern**: Use the main `builder` that receives (context, device, orientation)
/// ```dart
/// SKResponsiveBuilder(
///   builder: (context, device, orientation) {
///     if (device == DeviceType.mobile && orientation == Orientation.landscape) {
///       return Text('Mobile Landscape');
///     }
///     return Text('Other');
///   },
/// )
/// ```
///
/// 2. **Separate builders**: Use device-specific builders (similar to SKResponsive)
/// ```dart
/// SKResponsiveBuilder(
///   mobile: (_) => Text('Mobile'),
///   tablet: (_) => Text('Tablet'),
///   desktop: (_) => Text('Desktop'),
///   mobileLandscape: (_) => Text('Mobile Landscape'),
/// )
/// ```
///
/// If both are provided, device-specific builders take priority over the main builder.
/// Fallback rules are the same as SKResponsive:
/// - `mobileLandscape` → falls back to `mobile` if null
/// - `tabletLandscape` → falls back to `tablet` → `mobileLandscape` → `mobile` if null
class SKResponsiveBuilder extends StatelessWidget {
  /// Main builder that receives (context, device, orientation)
  /// Used as fallback if device-specific builders are not provided
  final ResponsiveBuilder? builder;

  /// Device-specific builders (similar to SKResponsive)
  final ResponsiveWidgetBuilder? mobile;
  final ResponsiveWidgetBuilder? tablet;
  final ResponsiveWidgetBuilder? desktop;
  final ResponsiveWidgetBuilder? mobileLandscape;
  final ResponsiveWidgetBuilder? tabletLandscape;
  final ResponsiveWidgetBuilder? desktopLandscape;

  final DesktopAs desktopAs;

  /// Forces the builder to resolve as a specific [DeviceType]. When null, the global detection is used.
  final DeviceType? deviceTypeOverride;

  /// Overrides the desktop lock fallback (when active) for this builder.
  final bool lockDesktopAsTablet;
  final bool lockDesktopAsMobile;

  const SKResponsiveBuilder({
    super.key,
    this.builder,
    this.mobile,
    this.tablet,
    this.desktop,
    this.mobileLandscape,
    this.tabletLandscape,
    this.desktopLandscape,
    this.desktopAs = DesktopAs.desktop,
    this.deviceTypeOverride,
    this.lockDesktopAsTablet = false,
    this.lockDesktopAsMobile = false,
  }) : assert(
         builder != null ||
             mobile != null ||
             tablet != null ||
             desktop != null ||
             mobileLandscape != null ||
             tabletLandscape != null ||
             desktopLandscape != null,
         'At least one builder must be provided',
       ),
       assert(
         !(lockDesktopAsTablet && lockDesktopAsMobile),
         'lockDesktopAsTablet and lockDesktopAsMobile cannot both be true.',
       );

  @override
  Widget build(BuildContext context) {
    final scale = ScaleManager.instance;
    final overrideFallback =
        lockDesktopAsTablet
            ? DesktopLockFallback.tablet
            : lockDesktopAsMobile
            ? DesktopLockFallback.mobile
            : null;
    final device =
        deviceTypeOverride ??
        scale.responsiveDeviceType(override: overrideFallback);
    final orientation = scale.orientation;

    // Try device-specific builders first (similar to SKResponsive)
    ResponsiveWidgetBuilder? widgetBuilder = _pickDeviceSpecificBuilder(
      device,
      orientation,
    );

    // If device-specific builder found, use it
    if (widgetBuilder != null) {
      return widgetBuilder(context);
    }

    // Otherwise, use the main builder if provided
    if (builder != null) {
      // Handle desktop resolution based on desktopAs
      DeviceType resolvedDevice = device;
      if (device == DeviceType.desktop || device == DeviceType.web) {
        switch (desktopAs) {
          case DesktopAs.desktop:
            resolvedDevice = device;
            break;
          case DesktopAs.tablet:
            resolvedDevice = DeviceType.tablet;
            break;
          case DesktopAs.mobile:
            resolvedDevice = DeviceType.mobile;
            break;
        }
      }

      return builder!(context, resolvedDevice, orientation);
    }

    // Fallback to empty widget
    return const SizedBox.shrink();
  }

  ResponsiveWidgetBuilder? _pickDeviceSpecificBuilder(
    DeviceType device,
    Orientation orientation,
  ) {
    if (device == DeviceType.desktop || device == DeviceType.web) {
      // Desktop handling can mimic tablet/mobile if desired
      switch (desktopAs) {
        case DesktopAs.desktop:
          return desktop ?? tablet ?? mobile;
        case DesktopAs.tablet:
          if (orientation == Orientation.landscape) {
            return tabletLandscape ?? tablet ?? mobileLandscape ?? mobile;
          }
          return tablet ?? mobile;
        case DesktopAs.mobile:
          if (orientation == Orientation.landscape) {
            return mobileLandscape ?? mobile ?? tablet ?? desktop;
          }
          return mobile ?? tablet ?? desktop;
      }
    }

    if (orientation == Orientation.landscape) {
      switch (device) {
        case DeviceType.tablet:
          // If tabletLandscape is null, fall back to tablet, then mobileLandscape, then mobile
          return tabletLandscape ?? tablet ?? mobileLandscape ?? mobile;
        case DeviceType.mobile:
          // If mobileLandscape is null, fall back to mobile
          return mobileLandscape ?? mobile;
        case DeviceType.desktop:
        case DeviceType.web:
          return desktopLandscape ?? desktop ?? tablet ?? mobile;
      }
    } else {
      // Portrait
      switch (device) {
        case DeviceType.desktop:
        case DeviceType.web:
          return desktop ?? tablet ?? mobile;
        case DeviceType.tablet:
          return tablet ?? mobile;
        case DeviceType.mobile:
          return mobile;
      }
    }
  }
}
