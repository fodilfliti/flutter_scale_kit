import 'package:flutter/material.dart';
import 'aspect_ratio_adapter.dart';
import 'package:flutter/foundation.dart';
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

  // Configurable orientation boosts per device type
  double _mobileLandscapeFontBoost = 1.2;
  double _mobileLandscapeSizeBoost = 1.2;
  double _tabletLandscapeFontBoost = 1.2;
  double _tabletLandscapeSizeBoost = 1.2;
  double _desktopLandscapeFontBoost = 1.0;
  double _desktopLandscapeSizeBoost = 1.0;
  // Portrait boosts (default 1.0 - no change unless user sets)
  double _mobilePortraitFontBoost = 1.0;
  double _mobilePortraitSizeBoost = 1.0;
  double _tabletPortraitFontBoost = 1.0;
  double _tabletPortraitSizeBoost = 1.0;
  double _desktopPortraitFontBoost = 1.0;
  double _desktopPortraitSizeBoost = 1.0;

  // Controls whether auto-scale boosts are applied
  bool _autoScale = true;
  // Orientation-specific autoscale toggles
  bool _autoScaleLandscape = true;
  bool _autoScalePortrait = false;
  // Global enable/disable scaling
  bool _enabled = true;

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

  /// Configure orientation boost multipliers per device type.
  /// If not called, defaults are: mobile/tablet 1.2 (landscape), desktop 1.0.
  void setBoosts({
    double? mobileLandscapeFontBoost,
    double? mobileLandscapeSizeBoost,
    double? tabletLandscapeFontBoost,
    double? tabletLandscapeSizeBoost,
    double? desktopLandscapeFontBoost,
    double? desktopLandscapeSizeBoost,
    double? mobilePortraitFontBoost,
    double? mobilePortraitSizeBoost,
    double? tabletPortraitFontBoost,
    double? tabletPortraitSizeBoost,
    double? desktopPortraitFontBoost,
    double? desktopPortraitSizeBoost,
  }) {
    if (mobileLandscapeFontBoost != null) {
      _mobileLandscapeFontBoost = mobileLandscapeFontBoost;
    }
    if (mobileLandscapeSizeBoost != null) {
      _mobileLandscapeSizeBoost = mobileLandscapeSizeBoost;
    }
    if (tabletLandscapeFontBoost != null) {
      _tabletLandscapeFontBoost = tabletLandscapeFontBoost;
    }
    if (tabletLandscapeSizeBoost != null) {
      _tabletLandscapeSizeBoost = tabletLandscapeSizeBoost;
    }
    if (desktopLandscapeFontBoost != null) {
      _desktopLandscapeFontBoost = desktopLandscapeFontBoost;
    }
    if (desktopLandscapeSizeBoost != null) {
      _desktopLandscapeSizeBoost = desktopLandscapeSizeBoost;
    }
    if (mobilePortraitFontBoost != null) {
      _mobilePortraitFontBoost = mobilePortraitFontBoost;
    }
    if (mobilePortraitSizeBoost != null) {
      _mobilePortraitSizeBoost = mobilePortraitSizeBoost;
    }
    if (tabletPortraitFontBoost != null) {
      _tabletPortraitFontBoost = tabletPortraitFontBoost;
    }
    if (tabletPortraitSizeBoost != null) {
      _tabletPortraitSizeBoost = tabletPortraitSizeBoost;
    }
    if (desktopPortraitFontBoost != null) {
      _desktopPortraitFontBoost = desktopPortraitFontBoost;
    }
    if (desktopPortraitSizeBoost != null) {
      _desktopPortraitSizeBoost = desktopPortraitSizeBoost;
    }
  }

  /// Enable/disable autoscale boosts. When false, legacy calculations are used.
  void setAutoScale(bool enabled) {
    _autoScale = enabled;
  }

  /// Configure autoscale per orientation.
  /// Defaults: landscape=true, portrait=false
  void setAutoScaleOrientation({bool? landscape, bool? portrait}) {
    if (landscape != null) _autoScaleLandscape = landscape;
    if (portrait != null) _autoScalePortrait = portrait;
  }

  /// Enable/disable all scaling. When false, values are returned unmodified.
  void setEnabled(bool enabled) {
    _enabled = enabled;
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
    // On Android/iOS (including emulators), classify as mobile/tablet by width only
    if (!kIsWeb &&
        (defaultTargetPlatform == TargetPlatform.android ||
            defaultTargetPlatform == TargetPlatform.iOS)) {
      if (_screenWidth < 600) {
        return DeviceType.mobile;
      }
      return DeviceType.tablet; // treat large phones/tablets as tablet
    }

    // Web treated distinctly
    if (kIsWeb) {
      return DeviceType.web;
    }

    // All other platforms (Windows, macOS, Linux) -> desktop
    return DeviceType.desktop;
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
    if (!_enabled) return width;
    final sizeBoost =
        (_autoScale && _shouldApplySizeBoostForOrientation())
            ? _getSizeBoost()
            : 1.0;
    return width * _scaleWidth * sizeBoost;
  }

  /// Gets a scaled height value.
  ///
  /// Parameters:
  /// - [height] - The height value to scale
  ///
  /// Returns the scaled height based on the current scale factor.
  double getHeight(double height) {
    if (!_enabled) return height;
    final sizeBoost =
        (_autoScale && _shouldApplySizeBoostForOrientation())
            ? _getSizeBoost()
            : 1.0;
    return height * _scaleHeight * sizeBoost;
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
    if (!_enabled) return fontSize;
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
    if (!_enabled) return fontSize;
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

    if (_orientation == Orientation.landscape) {
      if (_autoScale && _autoScaleLandscape) {
        // New configurable behavior
        switch (deviceType) {
          case DeviceType.mobile:
            scaleFactor = scaleFactor * _mobileLandscapeFontBoost;
            break;
          case DeviceType.tablet:
            scaleFactor = scaleFactor * _tabletLandscapeFontBoost;
            break;
          case DeviceType.desktop:
          case DeviceType.web:
            scaleFactor = scaleFactor * _desktopLandscapeFontBoost;
            break;
        }
      } else if (!_autoScale) {
        // Legacy behavior: only mobile gets 1.2x in landscape
        if (deviceType == DeviceType.mobile) {
          scaleFactor = scaleFactor * 1.2;
        }
      }
    } else {
      // Portrait
      if (_autoScale && _autoScalePortrait) {
        switch (deviceType) {
          case DeviceType.mobile:
            scaleFactor = scaleFactor * _mobilePortraitFontBoost;
            break;
          case DeviceType.tablet:
            scaleFactor = scaleFactor * _tabletPortraitFontBoost;
            break;
          case DeviceType.desktop:
          case DeviceType.web:
            scaleFactor = scaleFactor * _desktopPortraitFontBoost;
            break;
        }
      }
    }

    return AspectRatioAdapter.getFontScaleFactor(
      scaleFactor: scaleFactor,
      aspectCategory: aspectCategory,
      deviceType: deviceType,
    );
  }

  double _getSizeBoost() {
    final deviceType = _detectDeviceType();
    if (_orientation == Orientation.landscape) {
      switch (deviceType) {
        case DeviceType.mobile:
          return _mobileLandscapeSizeBoost;
        case DeviceType.tablet:
          return _tabletLandscapeSizeBoost;
        case DeviceType.desktop:
        case DeviceType.web:
          return _desktopLandscapeSizeBoost;
      }
    } else {
      switch (deviceType) {
        case DeviceType.mobile:
          return _mobilePortraitSizeBoost;
        case DeviceType.tablet:
          return _tabletPortraitSizeBoost;
        case DeviceType.desktop:
        case DeviceType.web:
          return _desktopPortraitSizeBoost;
      }
    }
  }

  bool _shouldApplySizeBoostForOrientation() {
    if (_orientation == Orientation.landscape) return _autoScaleLandscape;
    return _autoScalePortrait;
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
