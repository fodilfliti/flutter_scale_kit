import 'package:flutter/material.dart';
import 'scale_manager.dart';
import 'cache_key.dart';
import 'device_detector.dart';
import 'font_config.dart';

/// Flyweight pattern cache for storing scaled values
/// Reuses cached calculated values to minimize memory usage
class ScaleValueCache {
  static ScaleValueCache? _instance;
  static ScaleValueCache get instance => _instance ??= ScaleValueCache._();

  ScaleValueCache._();

  // Cache maps for different value types
  final Map<CacheKey, double> _widthCache = {};
  final Map<CacheKey, double> _heightCache = {};
  final Map<CacheKey, double> _fontSizeCache = {};
  final Map<CacheKey, double> _fontSizeWithFactorCache = {};
  final Map<CacheKey, double> _radiusCache = {};
  final Map<CacheKey, double> _safeRadiusCache = {};
  final Map<CacheKey, double> _fixedRadiusCache = {};
  final Map<CacheKey, double> _screenWidthCache = {};
  final Map<CacheKey, double> _screenHeightCache = {};
  final Map<CacheKey, EdgeInsets> _paddingCache = {};
  final Map<CacheKey, EdgeInsets> _marginCache = {};
  final Map<CacheKey, BorderRadius> _borderRadiusCache = {};
  final Map<CacheKey, BorderRadius> _borderRadiusSafeCache = {};
  final Map<CacheKey, BorderRadius> _borderRadiusFixedCache = {};
  final Map<CacheKey, TextStyle> _textStyleCache = {};

  /// Get device ID string for cache key
  String _getDeviceId() {
    final manager = ScaleManager.instance;
    final deviceType = DeviceDetector.detectDeviceType(manager.screenWidth);
    final aspectCategory = DeviceDetector.getAspectRatioCategory(
      manager.screenWidth,
      manager.screenHeight,
    );

    return '${deviceType.name}_${manager.orientation.name}_${aspectCategory.name}';
  }

  /// Get cached width or calculate and cache
  double getWidth(double value) {
    final key = CacheKey(
      value: value,
      scaleType: ScaleType.width,
      deviceId: _getDeviceId(),
    );

    return _widthCache.putIfAbsent(
      key,
      () => ScaleManager.instance.getWidth(value),
    );
  }

  /// Get cached height or calculate and cache
  double getHeight(double value) {
    final key = CacheKey(
      value: value,
      scaleType: ScaleType.height,
      deviceId: _getDeviceId(),
    );

    return _heightCache.putIfAbsent(
      key,
      () => ScaleManager.instance.getHeight(value),
    );
  }

  /// Get cached font size or calculate and cache
  double getFontSize(double value) {
    final key = CacheKey(
      value: value,
      scaleType: ScaleType.fontSize,
      deviceId: _getDeviceId(),
    );

    return _fontSizeCache.putIfAbsent(
      key,
      () => ScaleManager.instance.getFontSize(value),
    );
  }

  /// Get cached font size with factor or calculate and cache
  double getFontSizeWithFactor(double value) {
    final key = CacheKey(
      value: value,
      scaleType: ScaleType.fontSizeWithFactor,
      deviceId: _getDeviceId(),
    );

    return _fontSizeWithFactorCache.putIfAbsent(
      key,
      () => ScaleManager.instance.getFontSizeWithFactor(value),
    );
  }

  /// Get cached radius or calculate and cache
  double getRadius(double value) {
    final key = CacheKey(
      value: value,
      scaleType: ScaleType.radius,
      deviceId: _getDeviceId(),
    );

    return _radiusCache.putIfAbsent(
      key,
      () => ScaleManager.instance.getRadius(value),
    );
  }

  /// Get cached safe radius (scaled with gentle clamps) or calculate and cache
  double getRadiusSafe(double value) {
    final key = CacheKey(
      value: value,
      scaleType: ScaleType.radiusSafe,
      deviceId: _getDeviceId(),
    );

    return _safeRadiusCache.putIfAbsent(
      key,
      () => ScaleManager.instance.getRadiusSafe(value),
    );
  }

  /// Get cached fixed radius (no scaling) or cache the raw value.
  double getFixedRadius(double value) {
    final key = CacheKey(
      value: value,
      scaleType: ScaleType.radiusFixed,
      deviceId: _getDeviceId(),
    );

    return _fixedRadiusCache.putIfAbsent(
      key,
      () => ScaleManager.instance.getFixedRadius(value),
    );
  }

  /// Get cached screen width percentage or calculate and cache
  double getScreenWidth(double value) {
    final key = CacheKey(
      value: value,
      scaleType: ScaleType.screenWidth,
      deviceId: _getDeviceId(),
    );

    return _screenWidthCache.putIfAbsent(
      key,
      () => ScaleManager.instance.getScreenWidth(value),
    );
  }

  /// Get cached screen height percentage or calculate and cache
  double getScreenHeight(double value) {
    final key = CacheKey(
      value: value,
      scaleType: ScaleType.screenHeight,
      deviceId: _getDeviceId(),
    );

    return _screenHeightCache.putIfAbsent(
      key,
      () => ScaleManager.instance.getScreenHeight(value),
    );
  }

  /// Get cached padding or calculate and cache
  EdgeInsets getPadding({
    double? all,
    double? horizontal,
    double? vertical,
    double? top,
    double? bottom,
    double? left,
    double? right,
  }) {
    // Create a unique key based on padding parameters
    final value =
        (all ?? 0) +
        (horizontal ?? 0) * 10 +
        (vertical ?? 0) * 100 +
        (top ?? 0) * 1000 +
        (bottom ?? 0) * 10000 +
        (left ?? 0) * 100000 +
        (right ?? 0) * 1000000;

    final manager = ScaleManager.instance;
    final key = CacheKey(
      value: value,
      scaleType: ScaleType.padding,
      deviceId: _getDeviceId(),
    );

    return _paddingCache.putIfAbsent(key, () {
      if (!manager.isEnabled) {
        return EdgeInsets.only(
          top: top ?? vertical ?? all ?? 0,
          bottom: bottom ?? vertical ?? all ?? 0,
          left: left ?? horizontal ?? all ?? 0,
          right: right ?? horizontal ?? all ?? 0,
        );
      }

      return EdgeInsets.only(
        top: (top ?? vertical ?? all ?? 0) * manager.scaleHeight,
        bottom: (bottom ?? vertical ?? all ?? 0) * manager.scaleHeight,
        left: (left ?? horizontal ?? all ?? 0) * manager.scaleWidth,
        right: (right ?? horizontal ?? all ?? 0) * manager.scaleWidth,
      );
    });
  }

  /// Get cached margin or calculate and cache
  EdgeInsets getMargin({
    double? all,
    double? horizontal,
    double? vertical,
    double? top,
    double? bottom,
    double? left,
    double? right,
  }) {
    // Reuse padding calculation logic
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

  /// Get cached border radius or calculate and cache
  BorderRadius getBorderRadius({
    double? all,
    double? topLeft,
    double? topRight,
    double? bottomLeft,
    double? bottomRight,
  }) {
    final value =
        (all ?? 0) +
        (topLeft ?? 0) * 10 +
        (topRight ?? 0) * 100 +
        (bottomLeft ?? 0) * 1000 +
        (bottomRight ?? 0) * 10000;

    final manager = ScaleManager.instance;
    final key = CacheKey(
      value: value,
      scaleType: ScaleType.borderRadius,
      deviceId: _getDeviceId(),
    );

    return _borderRadiusCache.putIfAbsent(key, () {
      if (!manager.isEnabled) {
        return BorderRadius.only(
          topLeft: Radius.circular(topLeft ?? all ?? 0),
          topRight: Radius.circular(topRight ?? all ?? 0),
          bottomLeft: Radius.circular(bottomLeft ?? all ?? 0),
          bottomRight: Radius.circular(bottomRight ?? all ?? 0),
        );
      }

      final radius = manager.scaleWidth;
      return BorderRadius.only(
        topLeft: Radius.circular((topLeft ?? all ?? 0) * radius),
        topRight: Radius.circular((topRight ?? all ?? 0) * radius),
        bottomLeft: Radius.circular((bottomLeft ?? all ?? 0) * radius),
        bottomRight: Radius.circular((bottomRight ?? all ?? 0) * radius),
      );
    });
  }

  /// Get cached border radius using safe radius scaling.
  BorderRadius getBorderRadiusSafe({
    double? all,
    double? topLeft,
    double? topRight,
    double? bottomLeft,
    double? bottomRight,
  }) {
    final value =
        (all ?? 0) +
        (topLeft ?? 0) * 10 +
        (topRight ?? 0) * 100 +
        (bottomLeft ?? 0) * 1000 +
        (bottomRight ?? 0) * 10000;

    final manager = ScaleManager.instance;
    final key = CacheKey(
      value: value,
      scaleType: ScaleType.borderRadiusSafe,
      deviceId: _getDeviceId(),
    );

    return _borderRadiusSafeCache.putIfAbsent(key, () {
      if (!manager.isEnabled) {
        return BorderRadius.only(
          topLeft: Radius.circular(topLeft ?? all ?? 0),
          topRight: Radius.circular(topRight ?? all ?? 0),
          bottomLeft: Radius.circular(bottomLeft ?? all ?? 0),
          bottomRight: Radius.circular(bottomRight ?? all ?? 0),
        );
      }

      return BorderRadius.only(
        topLeft: Radius.circular(manager.getRadiusSafe(topLeft ?? all ?? 0)),
        topRight: Radius.circular(manager.getRadiusSafe(topRight ?? all ?? 0)),
        bottomLeft: Radius.circular(
          manager.getRadiusSafe(bottomLeft ?? all ?? 0),
        ),
        bottomRight: Radius.circular(
          manager.getRadiusSafe(bottomRight ?? all ?? 0),
        ),
      );
    });
  }

  /// Get cached border radius without scaling.
  BorderRadius getBorderRadiusFixed({
    double? all,
    double? topLeft,
    double? topRight,
    double? bottomLeft,
    double? bottomRight,
  }) {
    final value =
        (all ?? 0) +
        (topLeft ?? 0) * 10 +
        (topRight ?? 0) * 100 +
        (bottomLeft ?? 0) * 1000 +
        (bottomRight ?? 0) * 10000;

    final key = CacheKey(
      value: value,
      scaleType: ScaleType.borderRadiusFixed,
      deviceId: _getDeviceId(),
    );

    return _borderRadiusFixedCache.putIfAbsent(key, () {
      return BorderRadius.only(
        topLeft: Radius.circular(topLeft ?? all ?? 0),
        topRight: Radius.circular(topRight ?? all ?? 0),
        bottomLeft: Radius.circular(bottomLeft ?? all ?? 0),
        bottomRight: Radius.circular(bottomRight ?? all ?? 0),
      );
    });
  }

  /// Get cached TextStyle or calculate and cache
  TextStyle getTextStyle({
    required double fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    Color? color,
    String? fontFamily,
    double? letterSpacing,
    double? height,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
  }) {
    // Get current language code for cache key (to invalidate cache on language change)
    final languageCode = FontConfig.instance.currentLanguageCode;

    // Create a unique key based on TextStyle parameters including language
    final value =
        fontSize +
        (fontWeight?.index ?? 0) * 1000 +
        (fontStyle?.index ?? 0) * 100 +
        (color != null ? color.toARGB32().toDouble() : 0) * 0.001 +
        (fontFamily?.hashCode ?? 0) * 0.000001 +
        (letterSpacing ?? 0) * 100 +
        (height ?? 0) * 10 +
        (decoration.toString().hashCode) * 0.0000001 +
        (decorationColor?.toARGB32().toDouble() ?? 0) * 0.000000001 +
        (decorationStyle?.index ?? 0) * 0.0000000001 +
        (decorationThickness ?? 0) * 1000 +
        languageCode.hashCode * 0.00000000001;

    final key = CacheKey(
      value: value,
      scaleType: ScaleType.fontSize,
      deviceId: _getDeviceId(),
    );

    return _textStyleCache.putIfAbsent(key, () {
      final manager = ScaleManager.instance;
      final scaledFontSize = manager.getFontSize(fontSize);

      // Create base TextStyle
      final baseTextStyle = TextStyle(
        fontSize: scaledFontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        color: color,
        fontFamily: fontFamily,
        letterSpacing: letterSpacing,
        height: height,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        decorationThickness: decorationThickness,
      );

      // Apply FontConfig automatically if fontFamily is not explicitly provided
      // This ensures all TextStyles use the configured font for current language
      if (fontFamily == null) {
        return FontConfig.instance.getTextStyle(baseTextStyle: baseTextStyle);
      }

      return baseTextStyle;
    });
  }

  /// Clear all caches (called on size/orientation change)
  void clearCache() {
    _widthCache.clear();
    _heightCache.clear();
    _fontSizeCache.clear();
    _fontSizeWithFactorCache.clear();
    _radiusCache.clear();
    _safeRadiusCache.clear();
    _fixedRadiusCache.clear();
    _screenWidthCache.clear();
    _screenHeightCache.clear();
    _paddingCache.clear();
    _marginCache.clear();
    _borderRadiusCache.clear();
    _borderRadiusSafeCache.clear();
    _borderRadiusFixedCache.clear();
    _textStyleCache.clear();
  }
}
