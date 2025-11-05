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
            return tabletLandscape ?? mobileLandscape ?? tablet ?? mobile;
          case DeviceType.mobile:
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
