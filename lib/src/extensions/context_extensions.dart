import 'package:flutter/material.dart';
import '../core/scale_manager.dart';
import '../core/scale_value_factory.dart';
import '../core/device_detector.dart';

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
      DeviceDetector.detectFromContext(this) == DeviceType.mobile;

  /// Check if device is tablet
  bool get isTablet =>
      DeviceDetector.detectFromContext(this) == DeviceType.tablet;

  /// Check if device is desktop
  bool get isDesktop =>
      DeviceDetector.detectFromContext(this) == DeviceType.desktop;
}
