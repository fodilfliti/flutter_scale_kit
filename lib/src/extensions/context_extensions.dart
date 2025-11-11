import 'package:flutter/material.dart';
import '../core/scale_manager.dart';
import '../core/scale_value_factory.dart';

/// BuildContext extensions for easy access to scaling utilities
extension ScaleContextExtension on BuildContext {
  /// Get ScaleManager instance
  ScaleManager get scaleManager => ScaleManager.instance;

  /// Get scaled width
  double scaleWidth(double width) =>
      ScaleValueFactory.instance.createWidth(width);

  /// Get scaled height
  double scaleHeight(double height) =>
      ScaleValueFactory.instance.createHeight(height);

  /// Get scaled font size
  double scaleFontSize(double fontSize) =>
      ScaleValueFactory.instance.createFontSize(fontSize);

  /// Get scaled size
  double scaleSize(double size) => ScaleValueFactory.instance.createWidth(size);

  /// Get responsive padding
  EdgeInsets scalePadding({
    double? all,
    double? horizontal,
    double? vertical,
    double? top,
    double? bottom,
    double? left,
    double? right,
  }) {
    return ScaleValueFactory.instance.createPadding(
      all: all,
      horizontal: horizontal,
      vertical: vertical,
      top: top,
      bottom: bottom,
      left: left,
      right: right,
    );
  }

  /// Get responsive margin
  EdgeInsets scaleMargin({
    double? all,
    double? horizontal,
    double? vertical,
    double? top,
    double? bottom,
    double? left,
    double? right,
  }) {
    return ScaleValueFactory.instance.createMargin(
      all: all,
      horizontal: horizontal,
      vertical: vertical,
      top: top,
      bottom: bottom,
      left: left,
      right: right,
    );
  }

  /// Get responsive border radius
  BorderRadius scaleBorderRadius({
    double? all,
    double? topLeft,
    double? topRight,
    double? bottomLeft,
    double? bottomRight,
  }) {
    return ScaleValueFactory.instance.createBorderRadius(
      all: all,
      topLeft: topLeft,
      topRight: topRight,
      bottomLeft: bottomLeft,
      bottomRight: bottomRight,
    );
  }

  /// Check if device is mobile
  bool get isMobile =>
      scaleManager.deviceTypeFor(DeviceClassificationSource.size) ==
      DeviceType.mobile;

  /// Check if device is tablet
  bool get isTablet =>
      scaleManager.deviceTypeFor(DeviceClassificationSource.size) ==
      DeviceType.tablet;

  /// Check if device is desktop
  bool get isDesktop =>
      scaleManager.deviceTypeFor(DeviceClassificationSource.size) ==
      DeviceType.desktop;

  /// Check if the responsive classification resolves to mobile/tablet/desktop.
  ///
  /// Use [source] to control which classification is consulted (responsive/platform/size).
  bool isTypeOfMobile({
    DeviceClassificationSource source = DeviceClassificationSource.responsive,
  }) => scaleManager.deviceTypeFor(source) == DeviceType.mobile;

  /// Check if the responsive classification resolves to tablet for the chosen [source].
  bool isTypeOfTablet({
    DeviceClassificationSource source = DeviceClassificationSource.responsive,
  }) => scaleManager.deviceTypeFor(source) == DeviceType.tablet;

  /// Check if the responsive classification resolves to desktop (optionally treating web as desktop).
  bool isTypeOfDesktop({
    DeviceClassificationSource source = DeviceClassificationSource.responsive,
    bool includeWeb = true,
  }) {
    final type = scaleManager.deviceTypeFor(source);
    if (type == DeviceType.desktop) return true;
    if (!includeWeb) return false;
    return type == DeviceType.web;
  }

  /// True when the current platform is a desktop OS (Windows/macOS/Linux/Web).
  bool get isDesktopPlatform {
    switch (scaleManager.platformCategory) {
      case PlatformCategory.windows:
      case PlatformCategory.macos:
      case PlatformCategory.linux:
      case PlatformCategory.web:
        return true;
      case PlatformCategory.android:
      case PlatformCategory.ios:
      case PlatformCategory.fuchsia:
        return false;
    }
  }

  /// True when running on the web platform.
  bool get isWebPlatform =>
      scaleManager.platformCategory == PlatformCategory.web;

  /// Screen size class based on the configured breakpoints.
  DeviceSizeClass get screenSizeClass => scaleManager.screenSizeClass;

  /// Convenience checker for screen size classes.
  bool isScreenSize(DeviceSizeClass sizeClass) => screenSizeClass == sizeClass;

  bool get isSmallMobileSize => screenSizeClass == DeviceSizeClass.smallMobile;
  bool get isMobileSize => screenSizeClass == DeviceSizeClass.mobile;
  bool get isLargeMobileSize => screenSizeClass == DeviceSizeClass.largeMobile;
  bool get isTabletSize => screenSizeClass == DeviceSizeClass.tablet;
  bool get isLargeTabletSize => screenSizeClass == DeviceSizeClass.largeTablet;
  bool get isDesktopSize => screenSizeClass == DeviceSizeClass.desktop;
  bool get isLargeDesktopSize =>
      screenSizeClass == DeviceSizeClass.largeDesktop;
  bool get isExtraLargeDesktopSize =>
      screenSizeClass == DeviceSizeClass.extraLargeDesktop;

  /// Access the configured breakpoints for advanced use-cases.
  ScaleBreakpoints get scaleBreakpoints => scaleManager.breakpoints;
}
