import 'package:flutter/material.dart';
import 'scale_manager.dart';
import 'cache_key.dart';

import 'font_config.dart';
import 'scaled_value_metadata.dart';

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
  final Map<CacheKey, EdgeInsetsGeometry> _paddingCache = {};
  final Map<CacheKey, EdgeInsetsGeometry> _marginCache = {};
  final Map<CacheKey, BorderRadius> _borderRadiusCache = {};
  final Map<CacheKey, BorderRadius> _borderRadiusSafeCache = {};
  final Map<CacheKey, BorderRadius> _borderRadiusFixedCache = {};
  final Map<CacheKey, TextStyle> _textStyleCache = {};
  final Map<CacheKey, double> _widthMaxCache = {};
  final Map<CacheKey, double> _widthMinCache = {};
  final Map<CacheKey, double> _widthClampCache = {};
  final Map<CacheKey, double> _heightMaxCache = {};
  final Map<CacheKey, double> _heightMinCache = {};
  final Map<CacheKey, double> _heightClampCache = {};
  final Map<CacheKey, double> _screenWidthMaxCache = {};
  final Map<CacheKey, double> _screenWidthMinCache = {};
  final Map<CacheKey, double> _screenWidthClampCache = {};
  final Map<CacheKey, double> _screenHeightMaxCache = {};
  final Map<CacheKey, double> _screenHeightMinCache = {};
  final Map<CacheKey, double> _screenHeightClampCache = {};
  final Map<CacheKey, double> _radiusMaxCache = {};
  final Map<CacheKey, double> _radiusMinCache = {};
  final Map<CacheKey, double> _radiusClampCache = {};
  final Map<CacheKey, double> _fontSizeMaxCache = {};
  final Map<CacheKey, double> _fontSizeMinCache = {};
  final Map<CacheKey, double> _fontSizeClampCache = {};

  /// Get device ID string for cache key
  int _getContextKey() {
    return ScaleManager.instance.cacheContextKey;
  }

  static const int _maxCacheSize = 2000;

  /// Puts a value into the cache with LRU eviction.
  /// If the cache exceeds [_maxCacheSize], the oldest item is removed.
  T _putWithEviction<T>(
    Map<CacheKey, T> cache,
    CacheKey key,
    T Function() ifAbsent,
  ) {
    if (cache.containsKey(key)) {
      // Move to end (mark as recently used)
      final value = cache.remove(key) as T;
      cache[key] = value;
      return value;
    }

    final value = ifAbsent();
    if (cache.length >= _maxCacheSize) {
      // Remove oldest (first key)
      cache.remove(cache.keys.first);
    }
    cache[key] = value;
    return value;
  }

  /// Get cached width or calculate and cache
  double getWidth(double value) {
    final key = CacheKey(
      value: value,
      scaleType: ScaleType.width,
      contextKey: _getContextKey(),
    );

    return _putWithEviction(
      _widthCache,
      key,
      () => SKScaledValueTracker.mark(
        ScaleManager.instance.getWidth(value),
        ScaleType.width,
      ),
    );
  }

  /// Get cached height or calculate and cache
  double getHeight(double value) {
    final key = CacheKey(
      value: value,
      scaleType: ScaleType.height,
      contextKey: _getContextKey(),
    );

    return _putWithEviction(
      _heightCache,
      key,
      () => SKScaledValueTracker.mark(
        ScaleManager.instance.getHeight(value),
        ScaleType.height,
      ),
    );
  }

  /// Get cached font size or calculate and cache
  double getFontSize(double value) {
    final key = CacheKey(
      value: value,
      scaleType: ScaleType.fontSize,
      contextKey: _getContextKey(),
    );

    return _putWithEviction(
      _fontSizeCache,
      key,
      () => SKScaledValueTracker.mark(
        ScaleManager.instance.getFontSize(value),
        ScaleType.fontSize,
      ),
    );
  }

  /// Get cached font size with factor or calculate and cache
  double getFontSizeWithFactor(double value) {
    final key = CacheKey(
      value: value,
      scaleType: ScaleType.fontSizeWithFactor,
      contextKey: _getContextKey(),
    );

    return _putWithEviction(
      _fontSizeWithFactorCache,
      key,
      () => SKScaledValueTracker.mark(
        ScaleManager.instance.getFontSizeWithFactor(value),
        ScaleType.fontSizeWithFactor,
      ),
    );
  }

  /// Get cached radius or calculate and cache
  double getRadius(double value) {
    final key = CacheKey(
      value: value,
      scaleType: ScaleType.radius,
      contextKey: _getContextKey(),
    );

    return _putWithEviction(
      _radiusCache,
      key,
      () => SKScaledValueTracker.mark(
        ScaleManager.instance.getRadius(value),
        ScaleType.radius,
      ),
    );
  }

  /// Get cached safe radius (scaled with gentle clamps) or calculate and cache
  double getRadiusSafe(double value) {
    final key = CacheKey(
      value: value,
      scaleType: ScaleType.radiusSafe,
      contextKey: _getContextKey(),
    );

    return _putWithEviction(
      _safeRadiusCache,
      key,
      () => SKScaledValueTracker.mark(
        ScaleManager.instance.getRadiusSafe(value),
        ScaleType.radiusSafe,
      ),
    );
  }

  /// Get cached fixed radius (no scaling) or cache the raw value.
  double getFixedRadius(double value) {
    final key = CacheKey(
      value: value,
      scaleType: ScaleType.radiusFixed,
      contextKey: _getContextKey(),
    );

    return _putWithEviction(
      _fixedRadiusCache,
      key,
      () => SKScaledValueTracker.mark(
        ScaleManager.instance.getFixedRadius(value),
        ScaleType.radiusFixed,
      ),
    );
  }

  /// Get cached screen width percentage or calculate and cache
  double getScreenWidth(double value) {
    final key = CacheKey(
      value: value,
      scaleType: ScaleType.screenWidth,
      contextKey: _getContextKey(),
    );

    return _putWithEviction(
      _screenWidthCache,
      key,
      () => SKScaledValueTracker.mark(
        ScaleManager.instance.getScreenWidth(value),
        ScaleType.screenWidth,
      ),
    );
  }

  /// Get cached screen height percentage or calculate and cache
  double getScreenHeight(double value) {
    final key = CacheKey(
      value: value,
      scaleType: ScaleType.screenHeight,
      contextKey: _getContextKey(),
    );

    return _putWithEviction(
      _screenHeightCache,
      key,
      () => SKScaledValueTracker.mark(
        ScaleManager.instance.getScreenHeight(value),
        ScaleType.screenHeight,
      ),
    );
  }

  EdgeInsetsGeometry _resolveInsets({
    required Map<CacheKey, EdgeInsetsGeometry> cache,
    required ScaleType scaleType,
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
    final useDirectional = start != null || end != null;
    final key = CacheKey(
      value: Object.hash(
        all,
        horizontal,
        vertical,
        top,
        bottom,
        left,
        right,
        start,
        end,
        useDirectional,
      ),
      scaleType: scaleType,
      contextKey: _getContextKey(),
    );

    return _putWithEviction(cache, key, () {
      final manager = ScaleManager.instance;
      double resolveValue(
        double? primary,
        double? secondary,
        double? fallback,
      ) {
        return primary ?? secondary ?? fallback ?? 0;
      }

      double scaleWidth(double value) =>
          manager.isEnabled ? value * manager.scaleWidth : value;
      double scaleHeight(double value) =>
          manager.isEnabled ? value * manager.scaleHeight : value;

      final double topValue = resolveValue(top, vertical, all);
      final double bottomValue = resolveValue(bottom, vertical, all);
      final double leftValue = resolveValue(left, horizontal, all);
      final double rightValue = resolveValue(right, horizontal, all);
      final double startValue = resolveValue(start, horizontal, all);
      final double endValue = resolveValue(end, horizontal, all);

      if (useDirectional) {
        return EdgeInsetsDirectional.only(
          top: scaleHeight(topValue),
          bottom: scaleHeight(bottomValue),
          start: scaleWidth(startValue),
          end: scaleWidth(endValue),
        );
      }

      return EdgeInsets.only(
        top: scaleHeight(topValue),
        bottom: scaleHeight(bottomValue),
        left: scaleWidth(leftValue),
        right: scaleWidth(rightValue),
      );
    });
  }

  /// Get cached padding or calculate and cache
  EdgeInsetsGeometry getPadding({
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
    return _resolveInsets(
      cache: _paddingCache,
      scaleType: ScaleType.padding,
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

  /// Get cached margin or calculate and cache
  EdgeInsetsGeometry getMargin({
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
    return _resolveInsets(
      cache: _marginCache,
      scaleType: ScaleType.margin,
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
      contextKey: _getContextKey(),
    );

    return _putWithEviction(_borderRadiusCache, key, () {
      if (!manager.isEnabled) {
        return BorderRadius.only(
          topLeft: Radius.circular(topLeft ?? all ?? 0),
          topRight: Radius.circular(topRight ?? all ?? 0),
          bottomLeft: Radius.circular(bottomLeft ?? all ?? 0),
          bottomRight: Radius.circular(bottomRight ?? all ?? 0),
        );
      }

      return BorderRadius.only(
        topLeft: Radius.circular(manager.getRadius(topLeft ?? all ?? 0)),
        topRight: Radius.circular(manager.getRadius(topRight ?? all ?? 0)),
        bottomLeft: Radius.circular(manager.getRadius(bottomLeft ?? all ?? 0)),
        bottomRight: Radius.circular(
          manager.getRadius(bottomRight ?? all ?? 0),
        ),
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
      contextKey: _getContextKey(),
    );

    return _putWithEviction(_borderRadiusSafeCache, key, () {
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
      contextKey: _getContextKey(),
    );

    return _putWithEviction(_borderRadiusFixedCache, key, () {
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
        (fontWeight?.value ?? 0) * 1000 +
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
      contextKey: _getContextKey(),
    );

    return _putWithEviction(_textStyleCache, key, () {
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

  /// Get cached width with max constraint or calculate and cache
  double getWidthMax(double value, double max) {
    final key = CacheKey(
      value: Object.hash(value, max),
      scaleType: ScaleType.widthMax,
      contextKey: _getContextKey(),
    );

    return _putWithEviction(
      _widthMaxCache,
      key,
      () => SKScaledValueTracker.mark(
        getWidth(value).clamp(0, max),
        ScaleType.widthMax,
      ),
    );
  }

  /// Get cached width with min constraint or calculate and cache
  double getWidthMin(double value, double min) {
    final key = CacheKey(
      value: Object.hash(value, min),
      scaleType: ScaleType.widthMin,
      contextKey: _getContextKey(),
    );

    return _putWithEviction(
      _widthMinCache,
      key,
      () => SKScaledValueTracker.mark(
        getWidth(value).clamp(min, double.infinity),
        ScaleType.widthMin,
      ),
    );
  }

  /// Get cached width with clamp constraint or calculate and cache
  double getWidthClamp(double value, double min, double max) {
    final key = CacheKey(
      value: Object.hash(value, min, max),
      scaleType: ScaleType.widthClamp,
      contextKey: _getContextKey(),
    );

    return _putWithEviction(
      _widthClampCache,
      key,
      () => SKScaledValueTracker.mark(
        getWidth(value).clamp(min, max),
        ScaleType.widthClamp,
      ),
    );
  }

  /// Get cached height with max constraint or calculate and cache
  double getHeightMax(double value, double max) {
    final key = CacheKey(
      value: Object.hash(value, max),
      scaleType: ScaleType.heightMax,
      contextKey: _getContextKey(),
    );

    return _putWithEviction(
      _heightMaxCache,
      key,
      () => SKScaledValueTracker.mark(
        getHeight(value).clamp(0, max),
        ScaleType.heightMax,
      ),
    );
  }

  /// Get cached height with min constraint or calculate and cache
  double getHeightMin(double value, double min) {
    final key = CacheKey(
      value: Object.hash(value, min),
      scaleType: ScaleType.heightMin,
      contextKey: _getContextKey(),
    );

    return _putWithEviction(
      _heightMinCache,
      key,
      () => SKScaledValueTracker.mark(
        getHeight(value).clamp(min, double.infinity),
        ScaleType.heightMin,
      ),
    );
  }

  /// Get cached height with clamp constraint or calculate and cache
  double getHeightClamp(double value, double min, double max) {
    final key = CacheKey(
      value: Object.hash(value, min, max),
      scaleType: ScaleType.heightClamp,
      contextKey: _getContextKey(),
    );

    return _putWithEviction(
      _heightClampCache,
      key,
      () => SKScaledValueTracker.mark(
        getHeight(value).clamp(min, max),
        ScaleType.heightClamp,
      ),
    );
  }

  /// Get cached screen width with max constraint or calculate and cache
  double getScreenWidthMax(double value, double max) {
    final key = CacheKey(
      value: Object.hash(value, max),
      scaleType: ScaleType.screenWidthMax,
      contextKey: _getContextKey(),
    );

    return _putWithEviction(
      _screenWidthMaxCache,
      key,
      () => SKScaledValueTracker.mark(
        getScreenWidth(value).clamp(0, max),
        ScaleType.screenWidthMax,
      ),
    );
  }

  /// Get cached screen width with min constraint or calculate and cache
  double getScreenWidthMin(double value, double min) {
    final key = CacheKey(
      value: Object.hash(value, min),
      scaleType: ScaleType.screenWidthMin,
      contextKey: _getContextKey(),
    );

    return _putWithEviction(
      _screenWidthMinCache,
      key,
      () => SKScaledValueTracker.mark(
        getScreenWidth(value).clamp(min, double.infinity),
        ScaleType.screenWidthMin,
      ),
    );
  }

  /// Get cached screen width with clamp constraint or calculate and cache
  double getScreenWidthClamp(double value, double min, double max) {
    final key = CacheKey(
      value: Object.hash(value, min, max),
      scaleType: ScaleType.screenWidthClamp,
      contextKey: _getContextKey(),
    );

    return _putWithEviction(
      _screenWidthClampCache,
      key,
      () => SKScaledValueTracker.mark(
        getScreenWidth(value).clamp(min, max),
        ScaleType.screenWidthClamp,
      ),
    );
  }

  /// Get cached screen height with max constraint or calculate and cache
  double getScreenHeightMax(double value, double max) {
    final key = CacheKey(
      value: Object.hash(value, max),
      scaleType: ScaleType.screenHeightMax,
      contextKey: _getContextKey(),
    );

    return _putWithEviction(
      _screenHeightMaxCache,
      key,
      () => SKScaledValueTracker.mark(
        getScreenHeight(value).clamp(0, max),
        ScaleType.screenHeightMax,
      ),
    );
  }

  /// Get cached screen height with min constraint or calculate and cache
  double getScreenHeightMin(double value, double min) {
    final key = CacheKey(
      value: Object.hash(value, min),
      scaleType: ScaleType.screenHeightMin,
      contextKey: _getContextKey(),
    );

    return _putWithEviction(
      _screenHeightMinCache,
      key,
      () => SKScaledValueTracker.mark(
        getScreenHeight(value).clamp(min, double.infinity),
        ScaleType.screenHeightMin,
      ),
    );
  }

  /// Get cached screen height with clamp constraint or calculate and cache
  double getScreenHeightClamp(double value, double min, double max) {
    final key = CacheKey(
      value: Object.hash(value, min, max),
      scaleType: ScaleType.screenHeightClamp,
      contextKey: _getContextKey(),
    );

    return _putWithEviction(
      _screenHeightClampCache,
      key,
      () => SKScaledValueTracker.mark(
        getScreenHeight(value).clamp(min, max),
        ScaleType.screenHeightClamp,
      ),
    );
  }

  /// Get cached radius with max constraint or calculate and cache
  double getRadiusMax(double value, double max) {
    final key = CacheKey(
      value: Object.hash(value, max),
      scaleType: ScaleType.radiusMax,
      contextKey: _getContextKey(),
    );

    return _putWithEviction(
      _radiusMaxCache,
      key,
      () => SKScaledValueTracker.mark(
        getRadius(value).clamp(0, max),
        ScaleType.radiusMax,
      ),
    );
  }

  /// Get cached radius with min constraint or calculate and cache
  double getRadiusMin(double value, double min) {
    final key = CacheKey(
      value: Object.hash(value, min),
      scaleType: ScaleType.radiusMin,
      contextKey: _getContextKey(),
    );

    return _putWithEviction(
      _radiusMinCache,
      key,
      () => SKScaledValueTracker.mark(
        getRadius(value).clamp(min, double.infinity),
        ScaleType.radiusMin,
      ),
    );
  }

  /// Get cached radius with clamp constraint or calculate and cache
  double getRadiusClamp(double value, double min, double max) {
    final key = CacheKey(
      value: Object.hash(value, min, max),
      scaleType: ScaleType.radiusClamp,
      contextKey: _getContextKey(),
    );

    return _putWithEviction(
      _radiusClampCache,
      key,
      () => SKScaledValueTracker.mark(
        getRadius(value).clamp(min, max),
        ScaleType.radiusClamp,
      ),
    );
  }

  /// Get cached font size with max constraint or calculate and cache
  double getFontSizeMax(double value, double max) {
    final key = CacheKey(
      value: Object.hash(value, max),
      scaleType: ScaleType.fontSizeMax,
      contextKey: _getContextKey(),
    );

    return _putWithEviction(
      _fontSizeMaxCache,
      key,
      () => SKScaledValueTracker.mark(
        getFontSize(value).clamp(0, max),
        ScaleType.fontSizeMax,
      ),
    );
  }

  /// Get cached font size with min constraint or calculate and cache
  double getFontSizeMin(double value, double min) {
    final key = CacheKey(
      value: Object.hash(value, min),
      scaleType: ScaleType.fontSizeMin,
      contextKey: _getContextKey(),
    );

    return _putWithEviction(
      _fontSizeMinCache,
      key,
      () => SKScaledValueTracker.mark(
        getFontSize(value).clamp(min, double.infinity),
        ScaleType.fontSizeMin,
      ),
    );
  }

  /// Get cached font size with clamp constraint or calculate and cache
  double getFontSizeClamp(double value, double min, double max) {
    final key = CacheKey(
      value: Object.hash(value, min, max),
      scaleType: ScaleType.fontSizeClamp,
      contextKey: _getContextKey(),
    );

    return _putWithEviction(
      _fontSizeClampCache,
      key,
      () => SKScaledValueTracker.mark(
        getFontSize(value).clamp(min, max),
        ScaleType.fontSizeClamp,
      ),
    );
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
    _widthMaxCache.clear();
    _widthMinCache.clear();
    _widthClampCache.clear();
    _heightMaxCache.clear();
    _heightMinCache.clear();
    _heightClampCache.clear();
    _screenWidthMaxCache.clear();
    _screenWidthMinCache.clear();
    _screenWidthClampCache.clear();
    _screenHeightMaxCache.clear();
    _screenHeightMinCache.clear();
    _screenHeightClampCache.clear();
    _radiusMaxCache.clear();
    _radiusMinCache.clear();
    _radiusClampCache.clear();
    _fontSizeMaxCache.clear();
    _fontSizeMinCache.clear();
    _fontSizeClampCache.clear();
  }
}
