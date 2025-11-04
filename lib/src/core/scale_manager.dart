import 'package:flutter/material.dart';
import 'aspect_ratio_adapter.dart';
import 'device_detector.dart';

/// Singleton manager for scale configuration and responsive design calculations.
///
/// This class manages design dimensions, device type, and scale factors
/// for responsive UI scaling. It provides helper properties similar to
/// flutter_screenutil and methods for scaling values based on screen size.
///
/// The [ScaleManager] is automatically initialized by [ScaleKitBuilder]
/// and should not be instantiated directly.
class ScaleManager {
  static ScaleManager? _instance;
  static ScaleManager get instance => _instance ??= ScaleManager._();

  ScaleManager._();

  double _designWidth = 375.0;
  double _designHeight = 812.0;

  double _screenWidth = 0;
  double _screenHeight = 0;
  double _devicePixelRatio = 1.0;
  double _textScaleFactor = 1.0;
  Orientation _orientation = Orientation.portrait;

  double _scaleWidth = 1.0;
  double _scaleHeight = 1.0;

  double _topSafeHeight = 0;
  double _bottomSafeHeight = 0;
  double _statusBarHeight = 0;

  /// Device pixel density.
  double get pixelRatio => _devicePixelRatio;

  /// Physical pixels per logical pixel.
  double get devicePixelRatio => _devicePixelRatio;

  /// Current screen width in logical pixels.
  double get screenWidth => _screenWidth;

  /// Current screen height in logical pixels.
  double get screenHeight => _screenHeight;

  /// Bottom safe zone distance, suitable for buttons with full screen.
  double get bottomBarHeight => _bottomSafeHeight;

  /// Status bar height, including notch if present.
  double get statusBarHeight => _statusBarHeight;

  /// System font scaling factor.
  double get textScaleFactor => _textScaleFactor;

  /// Ratio of actual width to UI design width.
  double get scaleWidth => _scaleWidth;

  /// Ratio of actual height to UI design height.
  double get scaleHeight => _scaleHeight;

  /// Current screen orientation.
  Orientation get orientation => _orientation;

  /// Top safe area height.
  double get topSafeHeight => _topSafeHeight;

  /// Bottom safe area height.
  double get bottomSafeHeight => _bottomSafeHeight;

  /// Total safe area height (top + bottom).
  double get safeAreaHeight => _topSafeHeight + _bottomSafeHeight;

  /// Safe area width (same as screen width).
  double get safeAreaWidth => _screenWidth;

  /// Initializes the scale manager with design dimensions.
  ///
  /// This method is called automatically by [ScaleKitBuilder] and should
  /// not be called directly.
  ///
  /// Parameters:
  /// - [context] - Build context for accessing MediaQuery
  /// - [designWidth] - Design width in logical pixels
  /// - [designHeight] - Design height in logical pixels
  /// - [designType] - Design device type (default: mobile)
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

  void _updateFromContext(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;
    final padding = mediaQuery.padding;
    final viewPadding = mediaQuery.viewPadding;

    _screenWidth = size.width;
    _screenHeight = size.height;
    _devicePixelRatio = mediaQuery.devicePixelRatio;
    _textScaleFactor = mediaQuery.textScaler.scale(1.0);

    final newOrientation =
        size.width > size.height ? Orientation.landscape : Orientation.portrait;
    _orientation = newOrientation;

    _topSafeHeight = padding.top;
    _bottomSafeHeight = padding.bottom;
    _statusBarHeight = viewPadding.top;

    _calculateScaleFactors();
  }

  void _calculateScaleFactors() {
    _scaleWidth = _screenWidth / _designWidth;
    _scaleHeight = _screenHeight / _designHeight;

    final (minScale, maxScale) = _getScaleLimits();
    _scaleWidth = _scaleWidth.clamp(minScale, maxScale);
    _scaleHeight = _scaleHeight.clamp(minScale, maxScale);
  }

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

  DeviceType _detectDeviceType() {
    if (_screenWidth < 600) {
      return DeviceType.mobile;
    } else if (_screenWidth < 1200) {
      return DeviceType.tablet;
    } else {
      return DeviceType.desktop;
    }
  }

  /// Updates scale factors from the current context.
  ///
  /// This method is called automatically by [ScaleKitBuilder] when screen
  /// size or orientation changes. It should not be called directly.
  ///
  /// Parameters:
  /// - [context] - Build context for accessing MediaQuery
  void updateFromContext(BuildContext context) {
    _updateFromContext(context);
  }

  /// Gets a scaled width value.
  ///
  /// Parameters:
  /// - [width] - The width value to scale
  ///
  /// Returns the scaled width based on the current scale factor.
  double getWidth(double width) {
    return width * _scaleWidth;
  }

  /// Gets a scaled height value.
  ///
  /// Parameters:
  /// - [height] - The height value to scale
  ///
  /// Returns the scaled height based on the current scale factor.
  double getHeight(double height) {
    return height * _scaleHeight;
  }

  /// Gets a scaled font size value.
  ///
  /// Font size scaling uses a specialized algorithm that considers device
  /// type, aspect ratio, and orientation. On mobile devices in landscape
  /// mode, font sizes are increased by 20% for better readability.
  ///
  /// Parameters:
  /// - [fontSize] - The font size value to scale
  ///
  /// Returns the scaled font size.
  double getFontSize(double fontSize) {
    final fontScale = _getFontScaleFactor();
    return fontSize * fontScale;
  }

  /// Gets a scaled font size value with system text scale factor applied.
  ///
  /// This method includes the system's text scale factor (from accessibility
  /// settings) in addition to the responsive scaling.
  ///
  /// Parameters:
  /// - [fontSize] - The font size value to scale
  ///
  /// Returns the scaled font size with system factor applied.
  double getFontSizeWithFactor(double fontSize) {
    final fontScale = _getFontScaleFactor();
    return fontSize * fontScale * _textScaleFactor;
  }

  double _getFontScaleFactor() {
    final deviceType = _detectDeviceType();
    final aspectCategory = DeviceDetector.getAspectRatioCategory(
      _screenWidth,
      _screenHeight,
    );

    double scaleFactor =
        _scaleWidth < _scaleHeight ? _scaleWidth : _scaleHeight;

    if (deviceType == DeviceType.mobile) {
      if (_orientation == Orientation.landscape) {
        scaleFactor = scaleFactor * 1.2;
      }
    }

    return AspectRatioAdapter.getFontScaleFactor(
      scaleFactor: scaleFactor,
      aspectCategory: aspectCategory,
      deviceType: deviceType,
    );
  }

  /// Gets a scaled radius value.
  ///
  /// Parameters:
  /// - [radius] - The radius value to scale
  ///
  /// Returns the scaled radius based on the current scale factor.
  double getRadius(double radius) {
    return radius * _scaleWidth;
  }

  /// Gets a screen width percentage value.
  ///
  /// Parameters:
  /// - [percentage] - The percentage of screen width (0.0 to 1.0)
  ///
  /// Returns the calculated screen width percentage.
  double getScreenWidth(double percentage) {
    return _screenWidth * percentage;
  }

  /// Gets a screen height percentage value.
  ///
  /// Parameters:
  /// - [percentage] - The percentage of screen height (0.0 to 1.0)
  ///
  /// Returns the calculated screen height percentage.
  double getScreenHeight(double percentage) {
    return _screenHeight * percentage;
  }

  /// Clears the cache (called when size/orientation changes).
  ///
  /// This method is called automatically by [ScaleKitBuilder] and should
  /// not be called directly.
  void clearCache() {
    // Cache clearing is handled by ScaleValueCache
  }
}

/// Device type enumeration for responsive design.
enum DeviceType {
  /// Mobile device (phone).
  mobile,

  /// Tablet device.
  tablet,

  /// Desktop device.
  desktop,

  /// Web platform.
  web,
}
