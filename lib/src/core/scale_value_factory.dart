import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'cache_key.dart';
import 'scale_value_cache.dart';
import 'scaled_value_metadata.dart';

/// Factory pattern for creating cached scaled values.
///
/// This class provides a clean API for creating scaled dimensions, padding,
/// margins, border radius, and text styles. All values are automatically
/// cached using the [ScaleValueCache] to improve performance.
///
/// Usage:
/// ```dart
/// final factory = ScaleValueFactory.instance;
/// final scaledWidth = factory.createWidth(200);
/// final scaledPadding = factory.createPadding(all: 16);
/// ```
class ScaleValueFactory {
  static ScaleValueFactory? _instance;
  static ScaleValueFactory get instance => _instance ??= ScaleValueFactory._();

  ScaleValueFactory._();

  final _cache = ScaleValueCache.instance;

  /// Creates a scaled width value.
  ///
  /// Parameters:
  /// - [width] - The width value to scale
  ///
  /// Returns the scaled width based on the current device's screen size.
  double createWidth(double width) {
    return SKScaledValueTracker.mark(_cache.getWidth(width), ScaleType.width);
  }

  /// Creates a scaled height value.
  ///
  /// Parameters:
  /// - [height] - The height value to scale
  ///
  /// Returns the scaled height based on the current device's screen size.
  double createHeight(double height) {
    return SKScaledValueTracker.mark(
      _cache.getHeight(height),
      ScaleType.height,
    );
  }

  /// Creates a scaled font size value.
  ///
  /// Parameters:
  /// - [fontSize] - The font size value to scale
  ///
  /// Returns the scaled font size based on device type and orientation.
  double createFontSize(double fontSize) {
    return SKScaledValueTracker.mark(
      _cache.getFontSize(fontSize),
      ScaleType.fontSize,
    );
  }

  /// Creates a scaled font size value with system text scale factor applied.
  ///
  /// This method includes the system's text scale factor (from accessibility
  /// settings) in addition to the responsive scaling.
  ///
  /// Parameters:
  /// - [fontSize] - The font size value to scale
  ///
  /// Returns the scaled font size with system factor applied.
  double createFontSizeWithFactor(double fontSize) {
    return SKScaledValueTracker.mark(
      _cache.getFontSizeWithFactor(fontSize),
      ScaleType.fontSizeWithFactor,
    );
  }

  /// Creates a scaled radius value.
  ///
  /// Parameters:
  /// - [radius] - The radius value to scale
  ///
  /// Returns the scaled radius based on the current device's screen size.
  double createRadius(double radius) {
    return SKScaledValueTracker.mark(
      _cache.getRadius(radius),
      ScaleType.radius,
    );
  }

  /// Creates a gently clamped radius value (cached).
  ///
  /// This keeps rounded corners from becoming too circular on large screens
  /// while still adapting slightly to scale changes.
  double createRadiusSafe(double radius) {
    return SKScaledValueTracker.mark(
      _cache.getRadiusSafe(radius),
      ScaleType.radiusSafe,
    );
  }

  /// Creates an unscaled radius value (cached).
  ///
  /// Parameters:
  /// - [radius] - Raw radius value that should remain consistent
  ///
  /// Returns the original radius while leveraging cache for reuse.
  double createFixedRadius(double radius) {
    return SKScaledValueTracker.mark(
      _cache.getFixedRadius(radius),
      ScaleType.radiusFixed,
    );
  }

  /// Creates a screen width percentage value.
  ///
  /// Parameters:
  /// - [percentage] - The percentage of screen width (0.0 to 1.0)
  ///
  /// Returns the calculated screen width percentage.
  double createScreenWidth(double percentage) {
    return SKScaledValueTracker.mark(
      _cache.getScreenWidth(percentage),
      ScaleType.screenWidth,
    );
  }

  /// Creates a screen height percentage value.
  ///
  /// Parameters:
  /// - [percentage] - The percentage of screen height (0.0 to 1.0)
  ///
  /// Returns the calculated screen height percentage.
  double createScreenHeight(double percentage) {
    return SKScaledValueTracker.mark(
      _cache.getScreenHeight(percentage),
      ScaleType.screenHeight,
    );
  }

  /// Creates a scaled width value with maximum constraint (cached).
  ///
  /// Parameters:
  /// - [width] - The width value to scale
  /// - [max] - Maximum allowed value
  ///
  /// Returns the scaled width clamped to the maximum value.
  double createWidthMax(double width, double max) {
    return SKScaledValueTracker.mark(
      _cache.getWidthMax(width, max),
      ScaleType.widthMax,
    );
  }

  /// Creates a scaled width value with minimum constraint (cached).
  ///
  /// Parameters:
  /// - [width] - The width value to scale
  /// - [min] - Minimum allowed value
  ///
  /// Returns the scaled width clamped to the minimum value.
  double createWidthMin(double width, double min) {
    return SKScaledValueTracker.mark(
      _cache.getWidthMin(width, min),
      ScaleType.widthMin,
    );
  }

  /// Creates a scaled width value with clamp constraint (cached).
  ///
  /// Parameters:
  /// - [width] - The width value to scale
  /// - [min] - Minimum allowed value
  /// - [max] - Maximum allowed value
  ///
  /// Returns the scaled width clamped between min and max.
  double createWidthClamp(double width, double min, double max) {
    return SKScaledValueTracker.mark(
      _cache.getWidthClamp(width, min, max),
      ScaleType.widthClamp,
    );
  }

  /// Creates a scaled height value with maximum constraint (cached).
  ///
  /// Parameters:
  /// - [height] - The height value to scale
  /// - [max] - Maximum allowed value
  ///
  /// Returns the scaled height clamped to the maximum value.
  double createHeightMax(double height, double max) {
    return SKScaledValueTracker.mark(
      _cache.getHeightMax(height, max),
      ScaleType.heightMax,
    );
  }

  /// Creates a scaled height value with minimum constraint (cached).
  ///
  /// Parameters:
  /// - [height] - The height value to scale
  /// - [min] - Minimum allowed value
  ///
  /// Returns the scaled height clamped to the minimum value.
  double createHeightMin(double height, double min) {
    return SKScaledValueTracker.mark(
      _cache.getHeightMin(height, min),
      ScaleType.heightMin,
    );
  }

  /// Creates a scaled height value with clamp constraint (cached).
  ///
  /// Parameters:
  /// - [height] - The height value to scale
  /// - [min] - Minimum allowed value
  /// - [max] - Maximum allowed value
  ///
  /// Returns the scaled height clamped between min and max.
  double createHeightClamp(double height, double min, double max) {
    return SKScaledValueTracker.mark(
      _cache.getHeightClamp(height, min, max),
      ScaleType.heightClamp,
    );
  }

  /// Creates a screen width percentage value with maximum constraint (cached).
  ///
  /// Parameters:
  /// - [percentage] - The percentage of screen width (0.0 to 1.0)
  /// - [max] - Maximum allowed value
  ///
  /// Returns the calculated screen width percentage clamped to the maximum value.
  double createScreenWidthMax(double percentage, double max) {
    return SKScaledValueTracker.mark(
      _cache.getScreenWidthMax(percentage, max),
      ScaleType.screenWidthMax,
    );
  }

  /// Creates a screen width percentage value with minimum constraint (cached).
  ///
  /// Parameters:
  /// - [percentage] - The percentage of screen width (0.0 to 1.0)
  /// - [min] - Minimum allowed value
  ///
  /// Returns the calculated screen width percentage clamped to the minimum value.
  double createScreenWidthMin(double percentage, double min) {
    return SKScaledValueTracker.mark(
      _cache.getScreenWidthMin(percentage, min),
      ScaleType.screenWidthMin,
    );
  }

  /// Creates a screen width percentage value with clamp constraint (cached).
  ///
  /// Parameters:
  /// - [percentage] - The percentage of screen width (0.0 to 1.0)
  /// - [min] - Minimum allowed value
  /// - [max] - Maximum allowed value
  ///
  /// Returns the calculated screen width percentage clamped between min and max.
  double createScreenWidthClamp(double percentage, double min, double max) {
    return SKScaledValueTracker.mark(
      _cache.getScreenWidthClamp(percentage, min, max),
      ScaleType.screenWidthClamp,
    );
  }

  /// Creates a screen height percentage value with maximum constraint (cached).
  ///
  /// Parameters:
  /// - [percentage] - The percentage of screen height (0.0 to 1.0)
  /// - [max] - Maximum allowed value
  ///
  /// Returns the calculated screen height percentage clamped to the maximum value.
  double createScreenHeightMax(double percentage, double max) {
    return SKScaledValueTracker.mark(
      _cache.getScreenHeightMax(percentage, max),
      ScaleType.screenHeightMax,
    );
  }

  /// Creates a screen height percentage value with minimum constraint (cached).
  ///
  /// Parameters:
  /// - [percentage] - The percentage of screen height (0.0 to 1.0)
  /// - [min] - Minimum allowed value
  ///
  /// Returns the calculated screen height percentage clamped to the minimum value.
  double createScreenHeightMin(double percentage, double min) {
    return SKScaledValueTracker.mark(
      _cache.getScreenHeightMin(percentage, min),
      ScaleType.screenHeightMin,
    );
  }

  /// Creates a screen height percentage value with clamp constraint (cached).
  ///
  /// Parameters:
  /// - [percentage] - The percentage of screen height (0.0 to 1.0)
  /// - [min] - Minimum allowed value
  /// - [max] - Maximum allowed value
  ///
  /// Returns the calculated screen height percentage clamped between min and max.
  double createScreenHeightClamp(double percentage, double min, double max) {
    return SKScaledValueTracker.mark(
      _cache.getScreenHeightClamp(percentage, min, max),
      ScaleType.screenHeightClamp,
    );
  }

  /// Creates a scaled radius value with maximum constraint (cached).
  ///
  /// Parameters:
  /// - [radius] - The radius value to scale
  /// - [max] - Maximum allowed value
  ///
  /// Returns the scaled radius clamped to the maximum value.
  double createRadiusMax(double radius, double max) {
    return SKScaledValueTracker.mark(
      _cache.getRadiusMax(radius, max),
      ScaleType.radiusMax,
    );
  }

  /// Creates a scaled radius value with minimum constraint (cached).
  ///
  /// Parameters:
  /// - [radius] - The radius value to scale
  /// - [min] - Minimum allowed value
  ///
  /// Returns the scaled radius clamped to the minimum value.
  double createRadiusMin(double radius, double min) {
    return SKScaledValueTracker.mark(
      _cache.getRadiusMin(radius, min),
      ScaleType.radiusMin,
    );
  }

  /// Creates a scaled radius value with clamp constraint (cached).
  ///
  /// Parameters:
  /// - [radius] - The radius value to scale
  /// - [min] - Minimum allowed value
  /// - [max] - Maximum allowed value
  ///
  /// Returns the scaled radius clamped between min and max.
  double createRadiusClamp(double radius, double min, double max) {
    return SKScaledValueTracker.mark(
      _cache.getRadiusClamp(radius, min, max),
      ScaleType.radiusClamp,
    );
  }

  /// Creates a scaled font size value with maximum constraint (cached).
  ///
  /// Parameters:
  /// - [fontSize] - The font size value to scale
  /// - [max] - Maximum allowed value
  ///
  /// Returns the scaled font size clamped to the maximum value.
  double createFontSizeMax(double fontSize, double max) {
    return SKScaledValueTracker.mark(
      _cache.getFontSizeMax(fontSize, max),
      ScaleType.fontSizeMax,
    );
  }

  /// Creates a scaled font size value with minimum constraint (cached).
  ///
  /// Parameters:
  /// - [fontSize] - The font size value to scale
  /// - [min] - Minimum allowed value
  ///
  /// Returns the scaled font size clamped to the minimum value.
  double createFontSizeMin(double fontSize, double min) {
    return SKScaledValueTracker.mark(
      _cache.getFontSizeMin(fontSize, min),
      ScaleType.fontSizeMin,
    );
  }

  /// Creates a scaled font size value with clamp constraint (cached).
  ///
  /// Parameters:
  /// - [fontSize] - The font size value to scale
  /// - [min] - Minimum allowed value
  /// - [max] - Maximum allowed value
  ///
  /// Returns the scaled font size clamped between min and max.
  double createFontSizeClamp(double fontSize, double min, double max) {
    return SKScaledValueTracker.mark(
      _cache.getFontSizeClamp(fontSize, min, max),
      ScaleType.fontSizeClamp,
    );
  }

  /// Creates responsive [EdgeInsets] padding.
  ///
  /// All values are automatically scaled based on the device's screen size.
  ///
  /// Parameters:
  /// - [all] - Padding applied to all sides
  /// - [horizontal] - Horizontal padding (left/right or start/end)
  /// - [vertical] - Vertical padding (top and bottom)
  /// - [top], [bottom], [left], [right] - Individual side padding
  /// - [start], [end] - Direction-aware padding resolved by [Directionality]
  ///
  /// Returns scaled [EdgeInsetsGeometry] padding.
  EdgeInsetsGeometry createPadding({
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
    return _cache.getPadding(
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

  /// Creates responsive [EdgeInsets] margin.
  ///
  /// All values are automatically scaled based on the device's screen size.
  ///
  /// Parameters:
  /// - [all] - Margin applied to all sides
  /// - [horizontal] - Horizontal margin (left/right or start/end)
  /// - [vertical] - Vertical margin (top and bottom)
  /// - [top], [bottom], [left], [right] - Individual side margin
  /// - [start], [end] - Direction-aware margin resolved by [Directionality]
  ///
  /// Returns scaled [EdgeInsetsGeometry] margin.
  EdgeInsetsGeometry createMargin({
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
    return _cache.getMargin(
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

  /// Resolves a numeric width value, returning it unchanged if it was already scaled.
  double resolveWidth(num width) {
    final originalValue = width;
    final doubleValue = width.toDouble();
    if (SKScaledValueTracker.matches(originalValue, SKValueDomain.width)) {
      return doubleValue;
    }
    return createWidth(doubleValue);
  }

  /// Resolves a numeric height value, returning it unchanged if it was already scaled.
  double resolveHeight(num height) {
    final originalValue = height;
    final doubleValue = height.toDouble();
    if (SKScaledValueTracker.matches(originalValue, SKValueDomain.height)) {
      return doubleValue;
    }
    return createHeight(doubleValue);
  }

  /// Resolves a numeric radius value using [createRadiusSafe] by default.
  double resolveRadiusSafe(num radius) {
    final originalValue = radius;
    final doubleValue = radius.toDouble();
    if (SKScaledValueTracker.matches(originalValue, SKValueDomain.radius)) {
      return doubleValue;
    }
    return createRadiusSafe(doubleValue);
  }

  /// Resolves a numeric radius value using [createRadius].
  double resolveRadius(num radius) {
    final originalValue = radius;
    final doubleValue = radius.toDouble();
    if (SKScaledValueTracker.matches(originalValue, SKValueDomain.radius)) {
      return doubleValue;
    }
    return createRadius(doubleValue);
  }

  /// Resolves a numeric radius value using [createFixedRadius].
  double resolveRadiusFixed(num radius) {
    final originalValue = radius;
    final doubleValue = radius.toDouble();
    if (SKScaledValueTracker.matches(originalValue, SKValueDomain.radius)) {
      return doubleValue;
    }
    return createFixedRadius(doubleValue);
  }

  /// Resolves a numeric font size value, returning it unchanged if already scaled.
  double resolveFontSize(num fontSize) {
    final originalValue = fontSize;
    final doubleValue = fontSize.toDouble();
    if (SKScaledValueTracker.matches(originalValue, SKValueDomain.fontSize)) {
      return doubleValue;
    }
    return createFontSize(doubleValue);
  }

  /// Resolves a numeric font size value that should include the system factor.
  double resolveFontSizeWithFactor(num fontSize) {
    final originalValue = fontSize;
    final doubleValue = fontSize.toDouble();
    if (SKScaledValueTracker.matches(originalValue, SKValueDomain.fontSize)) {
      return doubleValue;
    }
    return createFontSizeWithFactor(doubleValue);
  }

  /// Resolves an [EdgeInsetsGeometry], scaling each side only when needed.
  EdgeInsetsGeometry resolveEdgeInsets(EdgeInsetsGeometry insets) {
    if (insets is EdgeInsets) {
      return EdgeInsets.only(
        left: resolveWidth(insets.left),
        right: resolveWidth(insets.right),
        top: resolveHeight(insets.top),
        bottom: resolveHeight(insets.bottom),
      );
    } else if (insets is EdgeInsetsDirectional) {
      return EdgeInsetsDirectional.only(
        start: resolveWidth(insets.start),
        end: resolveWidth(insets.end),
        top: resolveHeight(insets.top),
        bottom: resolveHeight(insets.bottom),
      );
    }
    final resolved = insets.resolve(TextDirection.ltr);
    return EdgeInsets.only(
      left: resolveWidth(resolved.left),
      right: resolveWidth(resolved.right),
      top: resolveHeight(resolved.top),
      bottom: resolveHeight(resolved.bottom),
    );
  }

  /// Resolves [BoxConstraints], scaling finite dimensions only when needed.
  BoxConstraints resolveBoxConstraints(BoxConstraints constraints) {
    double resolveWidthIfFinite(double value) {
      if (value == double.infinity || value == double.negativeInfinity) {
        return value;
      }
      return resolveWidth(value);
    }

    double resolveHeightIfFinite(double value) {
      if (value == double.infinity || value == double.negativeInfinity) {
        return value;
      }
      return resolveHeight(value);
    }

    return BoxConstraints(
      minWidth: resolveWidthIfFinite(constraints.minWidth),
      maxWidth: resolveWidthIfFinite(constraints.maxWidth),
      minHeight: resolveHeightIfFinite(constraints.minHeight),
      maxHeight: resolveHeightIfFinite(constraints.maxHeight),
    );
  }

  /// Creates responsive [BorderRadius].
  ///
  /// All values are automatically scaled based on the device's screen size.
  ///
  /// Parameters:
  /// - [all] - Border radius applied to all corners
  /// - [topLeft], [topRight], [bottomLeft], [bottomRight] - Individual corner radius
  ///
  /// Returns scaled [BorderRadius].
  BorderRadius createBorderRadius({
    double? all,
    double? topLeft,
    double? topRight,
    double? bottomLeft,
    double? bottomRight,
  }) {
    return _cache.getBorderRadius(
      all: all,
      topLeft: topLeft,
      topRight: topRight,
      bottomLeft: bottomLeft,
      bottomRight: bottomRight,
    );
  }

  /// Creates a [BorderRadius] using the gently clamped radius scaling.
  BorderRadius createBorderRadiusSafe({
    double? all,
    double? topLeft,
    double? topRight,
    double? bottomLeft,
    double? bottomRight,
  }) {
    return _cache.getBorderRadiusSafe(
      all: all,
      topLeft: topLeft,
      topRight: topRight,
      bottomLeft: bottomLeft,
      bottomRight: bottomRight,
    );
  }

  /// Creates a [BorderRadius] without scaling any values.
  ///
  /// Useful when you want consistent curvature regardless of device scale.
  BorderRadius createBorderRadiusFixed({
    double? all,
    double? topLeft,
    double? topRight,
    double? bottomLeft,
    double? bottomRight,
  }) {
    return _cache.getBorderRadiusFixed(
      all: all,
      topLeft: topLeft,
      topRight: topRight,
      bottomLeft: bottomLeft,
      bottomRight: bottomRight,
    );
  }

  /// Creates responsive [TextStyle].
  ///
  /// The font size is automatically scaled based on device type and orientation.
  ///
  /// Parameters:
  /// - [fontSize] - The font size value to scale (required)
  /// - [fontWeight] - Optional font weight
  /// - [fontStyle] - Optional font style
  /// - [color] - Optional text color
  /// - [fontFamily] - Optional font family
  /// - [letterSpacing] - Optional letter spacing
  /// - [height] - Optional line height
  /// - [decoration] - Optional text decoration
  /// - [decorationColor] - Optional decoration color
  /// - [decorationStyle] - Optional decoration style
  /// - [decorationThickness] - Optional decoration thickness
  ///
  /// Returns a [TextStyle] with scaled font size.
  TextStyle createTextStyle({
    required double fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    Color? color,
    Color? backgroundColor,
    String? fontFamily,
    List<String>? fontFamilyFallback,
    double? letterSpacing,
    double? wordSpacing,
    double? height,
    TextBaseline? textBaseline,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    List<Shadow>? shadows,
    Paint? foreground,
    Paint? background,
    TextLeadingDistribution? leadingDistribution,
    Locale? locale,
    List<ui.FontFeature>? fontFeatures,
    List<ui.FontVariation>? fontVariations,
    String? debugLabel,
    TextOverflow? overflow,
  }) {
    // Get base cached style with core parameters
    final baseStyle = _cache.getTextStyle(
      fontSize: fontSize,
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

    // Apply additional parameters via copyWith (these don't need caching)
    if (backgroundColor != null ||
        fontFamilyFallback != null ||
        wordSpacing != null ||
        textBaseline != null ||
        shadows != null ||
        foreground != null ||
        background != null ||
        leadingDistribution != null ||
        locale != null ||
        fontFeatures != null ||
        fontVariations != null ||
        debugLabel != null ||
        overflow != null) {
      return baseStyle.copyWith(
        backgroundColor: backgroundColor,
        fontFamilyFallback: fontFamilyFallback,
        wordSpacing: wordSpacing,
        textBaseline: textBaseline,
        shadows: shadows,
        foreground: foreground,
        background: background,
        leadingDistribution: leadingDistribution,
        locale: locale,
        fontFeatures: fontFeatures,
        fontVariations: fontVariations,
        debugLabel: debugLabel,
        overflow: overflow,
      );
    }

    return baseStyle;
  }
}

/// Top-level getter for easier access to [ScaleValueFactory].
///
/// This provides a shorthand for accessing the factory instance.
/// Usage: `skFactory.createWidth(100)` instead of `ScaleValueFactory.instance.createWidth(100)`
// ignore: non_constant_identifier_names
ScaleValueFactory get skFactory => ScaleValueFactory.instance;
