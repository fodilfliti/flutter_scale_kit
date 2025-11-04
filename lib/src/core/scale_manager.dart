import 'package:flutter/material.dart';
import 'aspect_ratio_adapter.dart';
import 'device_detector.dart';

/// Singleton manager for scale configuration
/// Manages design dimensions, device type, and scale factors
class ScaleManager {
  static ScaleManager? _instance;
  static ScaleManager get instance => _instance ??= ScaleManager._();

  ScaleManager._();

  // Design dimensions
  double _designWidth = 375.0;
  double _designHeight = 812.0;

  // Current device properties
  double _screenWidth = 0;
  double _screenHeight = 0;
  double _devicePixelRatio = 1.0;
  double _textScaleFactor = 1.0;
  Orientation _orientation = Orientation.portrait;

  // Scale factors
  double _scaleWidth = 1.0;
  double _scaleHeight = 1.0;

  // Safe area properties
  double _topSafeHeight = 0;
  double _bottomSafeHeight = 0;
  double _statusBarHeight = 0;

  // Getters for device properties
  double get pixelRatio => _devicePixelRatio;
  double get devicePixelRatio => _devicePixelRatio;
  double get screenWidth => _screenWidth;
  double get screenHeight => _screenHeight;
  double get bottomBarHeight => _bottomSafeHeight;
  double get statusBarHeight => _statusBarHeight;
  double get textScaleFactor => _textScaleFactor;
  double get scaleWidth => _scaleWidth;
  double get scaleHeight => _scaleHeight;
  Orientation get orientation => _orientation;
  double get topSafeHeight => _topSafeHeight;
  double get bottomSafeHeight => _bottomSafeHeight;
  double get safeAreaHeight => _topSafeHeight + _bottomSafeHeight;
  double get safeAreaWidth => _screenWidth;

  /// Initialize ScaleManager with design dimensions
  void init({
    required BuildContext context,
    required double designWidth,
    required double designHeight,
    DeviceType designType = DeviceType.mobile,
  }) {
    _designWidth = designWidth;
    _designHeight = designHeight;

    _updateFromContext(context);
  }

  /// Update scale factors from MediaQuery context
  void _updateFromContext(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;
    final padding = mediaQuery.padding;
    final viewPadding = mediaQuery.viewPadding;

    _screenWidth = size.width;
    _screenHeight = size.height;
    _devicePixelRatio = mediaQuery.devicePixelRatio;
    _textScaleFactor = mediaQuery.textScaler.scale(1.0);
    _orientation =
        size.width > size.height ? Orientation.landscape : Orientation.portrait;

    // Safe area calculations
    _topSafeHeight = padding.top;
    _bottomSafeHeight = padding.bottom;
    _statusBarHeight = viewPadding.top;

    // Calculate scale factors
    _calculateScaleFactors();
  }

  /// Calculate scale factors based on design dimensions and device type
  void _calculateScaleFactors() {
    _scaleWidth = _screenWidth / _designWidth;
    _scaleHeight = _screenHeight / _designHeight;

    // Apply min/max constraints based on device type
    final (minScale, maxScale) = _getScaleLimits();
    _scaleWidth = _scaleWidth.clamp(minScale, maxScale);
    _scaleHeight = _scaleHeight.clamp(minScale, maxScale);
  }

  /// Get scale limits based on device type
  (double minScale, double maxScale) _getScaleLimits() {
    final deviceType = _detectDeviceType();

    switch (deviceType) {
      case DeviceType.mobile:
        return (0.8, 1.2);
      case DeviceType.tablet:
        return (0.7, 1.5);
      case DeviceType.desktop:
      case DeviceType.web:
        return (0.5, 2.0);
    }
  }

  /// Detect current device type based on screen width
  DeviceType _detectDeviceType() {
    if (_screenWidth < 600) {
      return DeviceType.mobile;
    } else if (_screenWidth < 1200) {
      return DeviceType.tablet;
    } else {
      return DeviceType.desktop;
    }
  }

  /// Update from context (called on size/orientation change)
  void updateFromContext(BuildContext context) {
    _updateFromContext(context);
  }

  /// Get scaled width
  double getWidth(double width) {
    return width * _scaleWidth;
  }

  /// Get scaled height
  double getHeight(double height) {
    return height * _scaleHeight;
  }

  /// Get scaled font size
  double getFontSize(double fontSize) {
    final fontScale = _getFontScaleFactor();
    return fontSize * fontScale;
  }

  /// Get font size with system text scale factor
  double getFontSizeWithFactor(double fontSize) {
    final fontScale = _getFontScaleFactor();
    return fontSize * fontScale * _textScaleFactor;
  }

  /// Get font scale factor based on aspect ratio
  double _getFontScaleFactor() {
    final deviceType = _detectDeviceType();
    final aspectCategory = DeviceDetector.getAspectRatioCategory(
      _screenWidth,
      _screenHeight,
    );

    final scaleFactor = _scaleWidth < _scaleHeight ? _scaleWidth : _scaleHeight;

    return AspectRatioAdapter.getFontScaleFactor(
      scaleFactor: scaleFactor,
      aspectCategory: aspectCategory,
      deviceType: deviceType,
    );
  }

  /// Get scaled radius
  double getRadius(double radius) {
    return radius * _scaleWidth;
  }

  /// Get screen width percentage
  double getScreenWidth(double percentage) {
    return _screenWidth * percentage;
  }

  /// Get screen height percentage
  double getScreenHeight(double percentage) {
    return _screenHeight * percentage;
  }

  /// Clear cache (called when size/orientation changes)
  void clearCache() {
    // Cache clearing will be handled by ScaleValueCache
  }
}

/// Device type enum
enum DeviceType { mobile, tablet, desktop, web }
