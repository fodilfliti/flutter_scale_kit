import 'package:flutter/material.dart';
import 'scale_config.dart';

/// Extension methods for easy access to ScaleConfig from BuildContext
extension ScaleExtension on BuildContext {
  /// Get ScaleConfig from the current context
  ScaleConfig get scale {
    return ScaleConfig(context: this);
  }

  /// Get scaled width
  double scaleWidth(double width) {
    return scale.getWidth(width);
  }

  /// Get scaled height
  double scaleHeight(double height) {
    return scale.getHeight(height);
  }

  /// Get scaled font size
  double scaleFontSize(double fontSize) {
    return scale.getFontSize(fontSize);
  }

  /// Get scaled size
  double scaleSize(double size) {
    return scale.getSize(size);
  }

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
    return scale.getPadding(
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
    return scale.getMargin(
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
    return scale.getBorderRadius(
      all: all,
      topLeft: topLeft,
      topRight: topRight,
      bottomLeft: bottomLeft,
      bottomRight: bottomRight,
    );
  }

  /// Check if device is tablet
  bool get isTablet => scale.isTablet;

  /// Check if device is mobile
  bool get isMobile => scale.isMobile;

  /// Check if device is desktop
  bool get isDesktop => scale.isDesktop;
}

