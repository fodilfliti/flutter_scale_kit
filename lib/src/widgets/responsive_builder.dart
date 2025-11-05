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

  const SKResponsive({
    super.key,
    this.mobile,
    this.tablet,
    this.desktop,
    this.mobileLandscape,
    this.tabletLandscape,
    this.desktopLandscape,
    this.desktopAs = DesktopAs.desktop,
  });

  @override
  Widget build(BuildContext context) {
    final scale = ScaleManager.instance;
    final device = _deviceByWidth();
    final isLandscape = scale.orientation == Orientation.landscape;

    ResponsiveWidgetBuilder? pick() {
      if (device == DeviceType.desktop) {
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
            return desktop; // unreachable due to early return, keeps analyzer happy
          case DeviceType.web:
            return desktop ?? tablet ?? mobile;
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

  DeviceType _deviceByWidth() {
    final w = ScaleManager.instance.screenWidth;
    if (w < 600) return DeviceType.mobile;
    if (w < 1200) return DeviceType.tablet;
    return DeviceType.desktop;
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

  const SKResponsiveValue({
    this.mobile,
    this.tablet,
    this.desktop,
    this.mobileLandscape,
    this.tabletLandscape,
    this.desktopLandscape,
  });

  T? resolve() {
    final scale = ScaleManager.instance;
    final isLandscape = scale.orientation == Orientation.landscape;
    final device = scale.deviceType;

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
  }) : assert(
         builder != null ||
             mobile != null ||
             tablet != null ||
             desktop != null ||
             mobileLandscape != null ||
             tabletLandscape != null ||
             desktopLandscape != null,
         'At least one builder must be provided',
       );

  @override
  Widget build(BuildContext context) {
    final scale = ScaleManager.instance;
    final device = _deviceByWidth();
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

  DeviceType _deviceByWidth() {
    final w = ScaleManager.instance.screenWidth;
    if (w < 600) return DeviceType.mobile;
    if (w < 1200) return DeviceType.tablet;
    return DeviceType.desktop;
  }
}
