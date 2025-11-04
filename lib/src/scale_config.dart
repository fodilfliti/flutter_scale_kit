import 'package:flutter/material.dart';

/// Configuration class for Flutter Scale Kit
/// Provides responsive scaling based on screen dimensions
class ScaleConfig {
  /// Default design width (in logical pixels)
  static const double defaultDesignWidth = 375.0;

  /// Default design height (in logical pixels)
  static const double defaultDesignHeight = 812.0;

  /// Design width for the current configuration
  final double designWidth;

  /// Design height for the current configuration
  final double designHeight;

  /// Current screen width
  final double screenWidth;

  /// Current screen height
  final double screenHeight;

  /// Scale factor for width
  late final double scaleWidth;

  /// Scale factor for height
  late final double scaleHeight;

  /// Text scale factor
  late final double textScale;

  /// Minimum scale factor to prevent UI from being too small
  final double minScale;

  /// Maximum scale factor to prevent UI from being too large
  final double maxScale;

  /// Creates a ScaleConfig instance
  ScaleConfig({
    required BuildContext context,
    double? designWidth,
    double? designHeight,
    this.minScale = 0.5,
    this.maxScale = 2.0,
  })  : designWidth = designWidth ?? defaultDesignWidth,
        designHeight = designHeight ?? defaultDesignHeight,
        screenWidth = MediaQuery.of(context).size.width,
        screenHeight = MediaQuery.of(context).size.height {
    _calculateScaleFactors();
  }

  void _calculateScaleFactors() {
    scaleWidth = screenWidth / designWidth;
    scaleHeight = screenHeight / designHeight;

    // Apply min/max constraints
    scaleWidth = scaleWidth.clamp(minScale, maxScale);
    scaleHeight = scaleHeight.clamp(minScale, maxScale);

    // Use the smaller scale factor to maintain aspect ratio
    textScale = scaleWidth < scaleHeight ? scaleWidth : scaleHeight;
  }

  /// Get scaled width
  double getWidth(double width) {
    return width * scaleWidth;
  }

  /// Get scaled height
  double getHeight(double height) {
    return height * scaleHeight;
  }

  /// Get scaled font size
  double getFontSize(double fontSize) {
    return fontSize * textScale;
  }

  /// Get scaled size (uses width scale for consistency)
  double getSize(double size) {
    return size * scaleWidth;
  }

  /// Get responsive padding
  EdgeInsets getPadding({
    double? all,
    double? horizontal,
    double? vertical,
    double? top,
    double? bottom,
    double? left,
    double? right,
  }) {
    return EdgeInsets.only(
      top: (top ?? vertical ?? all ?? 0) * scaleHeight,
      bottom: (bottom ?? vertical ?? all ?? 0) * scaleHeight,
      left: (left ?? horizontal ?? all ?? 0) * scaleWidth,
      right: (right ?? horizontal ?? all ?? 0) * scaleWidth,
    );
  }

  /// Get responsive margin
  EdgeInsets getMargin({
    double? all,
    double? horizontal,
    double? vertical,
    double? top,
    double? bottom,
    double? left,
    double? right,
  }) {
    return getPadding(
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
  BorderRadius getBorderRadius({
    double? all,
    double? topLeft,
    double? topRight,
    double? bottomLeft,
    double? bottomRight,
  }) {
    return BorderRadius.only(
      topLeft: Radius.circular((topLeft ?? all ?? 0) * scaleWidth),
      topRight: Radius.circular((topRight ?? all ?? 0) * scaleWidth),
      bottomLeft: Radius.circular((bottomLeft ?? all ?? 0) * scaleWidth),
      bottomRight: Radius.circular((bottomRight ?? all ?? 0) * scaleWidth),
    );
  }

  /// Check if device is tablet
  bool get isTablet => screenWidth >= 600;

  /// Check if device is mobile
  bool get isMobile => screenWidth < 600;

  /// Check if device is desktop
  bool get isDesktop => screenWidth >= 1200;
}

