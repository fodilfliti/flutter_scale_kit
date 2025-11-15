import 'package:flutter/material.dart';
import '../core/scale_manager.dart';
import '../core/scale_value_factory.dart';
import '../widgets/scale_kit_builder.dart';

/// BuildContext extensions for easy access to scaling utilities
extension ScaleContextExtension on BuildContext {
  void _dependOnScaleScope() {
    ScaleKitScope.maybeOf(this);
  }

  /// Get ScaleManager instance
  ScaleManager get scaleManager {
    _dependOnScaleScope();
    return ScaleManager.instance;
  }

  /// Get scaled width
  double scaleWidth(double width) {
    _dependOnScaleScope();
    return ScaleValueFactory.instance.createWidth(width);
  }

  /// Get scaled height
  double scaleHeight(double height) {
    _dependOnScaleScope();
    return ScaleValueFactory.instance.createHeight(height);
  }

  /// Get scaled font size
  double scaleFontSize(double fontSize) {
    _dependOnScaleScope();
    return ScaleValueFactory.instance.createFontSize(fontSize);
  }

  /// Get scaled size
  double scaleSize(double size) {
    _dependOnScaleScope();
    return ScaleValueFactory.instance.createWidth(size);
  }

  /// Get responsive padding
  ///
  /// Supports absolute sides ([left]/[right]) as well as direction-aware sides
  /// ([start]/[end]) which resolve using the current [Directionality].
  EdgeInsetsGeometry scalePadding({
    double? all,
    double? horizontal,
    double? vertical,
    double? top,
    double? bottom,
    double? left,
    double? right,
    double? start,
    double? end,
  }) {
    _dependOnScaleScope();
    return ScaleValueFactory.instance.createPadding(
      all: all,
      horizontal: horizontal,
      vertical: vertical,
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      start: start,
      end: end,
    );
  }

  /// Get responsive margin
  ///
  /// Supports absolute sides ([left]/[right]) as well as direction-aware sides
  /// ([start]/[end]) which resolve using the current [Directionality].
  EdgeInsetsGeometry scaleMargin({
    double? all,
    double? horizontal,
    double? vertical,
    double? top,
    double? bottom,
    double? left,
    double? right,
    double? start,
    double? end,
  }) {
    _dependOnScaleScope();
    return ScaleValueFactory.instance.createMargin(
      all: all,
      horizontal: horizontal,
      vertical: vertical,
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      start: start,
      end: end,
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
    _dependOnScaleScope();
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

  /// True when running on desktop/web but the viewport currently resolves to a mobile size class.
  bool get isDesktopMobileSize =>
      isDesktopPlatform &&
      (isSmallMobileSize || isMobileSize || isLargeMobileSize);

  /// True when running on desktop/web and the viewport currently resolves to a tablet size class.
  bool get isDesktopTabletSize =>
      isDesktopPlatform && (isTabletSize || isLargeTabletSize);

  /// True when running on desktop/web and the viewport currently resolves to a desktop or larger size class.
  bool get isDesktopDesktopSize =>
      isDesktopPlatform &&
      (isDesktopSize || isLargeDesktopSize || isExtraLargeDesktopSize);

  /// True when running on desktop/web and the viewport resolves to a desktop or larger class.
  bool get isDesktopDesktopOrLarger => isDesktopDesktopSize;

  /// True on desktop/web when the width is at least the tablet breakpoint.
  bool get isDesktopAtLeastTablet =>
      isDesktopPlatform &&
      scaleManager.screenWidth > scaleBreakpoints.mobileMaxWidth;

  /// True on desktop/web when the width is at least the desktop breakpoint.
  bool get isDesktopAtLeastDesktop =>
      isDesktopPlatform &&
      scaleManager.screenWidth > scaleBreakpoints.tabletMaxWidth;

  /// Access the configured breakpoints for advanced use-cases.
  ScaleBreakpoints get scaleBreakpoints => scaleManager.breakpoints;
}
