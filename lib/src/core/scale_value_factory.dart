import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'scale_value_cache.dart';

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
    return _cache.getWidth(width);
  }

  /// Creates a scaled height value.
  ///
  /// Parameters:
  /// - [height] - The height value to scale
  ///
  /// Returns the scaled height based on the current device's screen size.
  double createHeight(double height) {
    return _cache.getHeight(height);
  }

  /// Creates a scaled font size value.
  ///
  /// Parameters:
  /// - [fontSize] - The font size value to scale
  ///
  /// Returns the scaled font size based on device type and orientation.
  double createFontSize(double fontSize) {
    return _cache.getFontSize(fontSize);
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
    return _cache.getFontSizeWithFactor(fontSize);
  }

  /// Creates a scaled radius value.
  ///
  /// Parameters:
  /// - [radius] - The radius value to scale
  ///
  /// Returns the scaled radius based on the current device's screen size.
  double createRadius(double radius) {
    return _cache.getRadius(radius);
  }

  /// Creates a gently clamped radius value (cached).
  ///
  /// This keeps rounded corners from becoming too circular on large screens
  /// while still adapting slightly to scale changes.
  double createRadiusSafe(double radius) {
    return _cache.getRadiusSafe(radius);
  }

  /// Creates an unscaled radius value (cached).
  ///
  /// Parameters:
  /// - [radius] - Raw radius value that should remain consistent
  ///
  /// Returns the original radius while leveraging cache for reuse.
  double createFixedRadius(double radius) {
    return _cache.getFixedRadius(radius);
  }

  /// Creates a screen width percentage value.
  ///
  /// Parameters:
  /// - [percentage] - The percentage of screen width (0.0 to 1.0)
  ///
  /// Returns the calculated screen width percentage.
  double createScreenWidth(double percentage) {
    return _cache.getScreenWidth(percentage);
  }

  /// Creates a screen height percentage value.
  ///
  /// Parameters:
  /// - [percentage] - The percentage of screen height (0.0 to 1.0)
  ///
  /// Returns the calculated screen height percentage.
  double createScreenHeight(double percentage) {
    return _cache.getScreenHeight(percentage);
  }

  /// Creates a scaled width value with maximum constraint (cached).
  ///
  /// Parameters:
  /// - [width] - The width value to scale
  /// - [max] - Maximum allowed value
  ///
  /// Returns the scaled width clamped to the maximum value.
  double createWidthMax(double width, double max) {
    return _cache.getWidthMax(width, max);
  }

  /// Creates a scaled width value with minimum constraint (cached).
  ///
  /// Parameters:
  /// - [width] - The width value to scale
  /// - [min] - Minimum allowed value
  ///
  /// Returns the scaled width clamped to the minimum value.
  double createWidthMin(double width, double min) {
    return _cache.getWidthMin(width, min);
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
    return _cache.getWidthClamp(width, min, max);
  }

  /// Creates a scaled height value with maximum constraint (cached).
  ///
  /// Parameters:
  /// - [height] - The height value to scale
  /// - [max] - Maximum allowed value
  ///
  /// Returns the scaled height clamped to the maximum value.
  double createHeightMax(double height, double max) {
    return _cache.getHeightMax(height, max);
  }

  /// Creates a scaled height value with minimum constraint (cached).
  ///
  /// Parameters:
  /// - [height] - The height value to scale
  /// - [min] - Minimum allowed value
  ///
  /// Returns the scaled height clamped to the minimum value.
  double createHeightMin(double height, double min) {
    return _cache.getHeightMin(height, min);
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
    return _cache.getHeightClamp(height, min, max);
  }

  /// Creates a screen width percentage value with maximum constraint (cached).
  ///
  /// Parameters:
  /// - [percentage] - The percentage of screen width (0.0 to 1.0)
  /// - [max] - Maximum allowed value
  ///
  /// Returns the calculated screen width percentage clamped to the maximum value.
  double createScreenWidthMax(double percentage, double max) {
    return _cache.getScreenWidthMax(percentage, max);
  }

  /// Creates a screen width percentage value with minimum constraint (cached).
  ///
  /// Parameters:
  /// - [percentage] - The percentage of screen width (0.0 to 1.0)
  /// - [min] - Minimum allowed value
  ///
  /// Returns the calculated screen width percentage clamped to the minimum value.
  double createScreenWidthMin(double percentage, double min) {
    return _cache.getScreenWidthMin(percentage, min);
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
    return _cache.getScreenWidthClamp(percentage, min, max);
  }

  /// Creates a screen height percentage value with maximum constraint (cached).
  ///
  /// Parameters:
  /// - [percentage] - The percentage of screen height (0.0 to 1.0)
  /// - [max] - Maximum allowed value
  ///
  /// Returns the calculated screen height percentage clamped to the maximum value.
  double createScreenHeightMax(double percentage, double max) {
    return _cache.getScreenHeightMax(percentage, max);
  }

  /// Creates a screen height percentage value with minimum constraint (cached).
  ///
  /// Parameters:
  /// - [percentage] - The percentage of screen height (0.0 to 1.0)
  /// - [min] - Minimum allowed value
  ///
  /// Returns the calculated screen height percentage clamped to the minimum value.
  double createScreenHeightMin(double percentage, double min) {
    return _cache.getScreenHeightMin(percentage, min);
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
    return _cache.getScreenHeightClamp(percentage, min, max);
  }

  /// Creates a scaled radius value with maximum constraint (cached).
  ///
  /// Parameters:
  /// - [radius] - The radius value to scale
  /// - [max] - Maximum allowed value
  ///
  /// Returns the scaled radius clamped to the maximum value.
  double createRadiusMax(double radius, double max) {
    return _cache.getRadiusMax(radius, max);
  }

  /// Creates a scaled radius value with minimum constraint (cached).
  ///
  /// Parameters:
  /// - [radius] - The radius value to scale
  /// - [min] - Minimum allowed value
  ///
  /// Returns the scaled radius clamped to the minimum value.
  double createRadiusMin(double radius, double min) {
    return _cache.getRadiusMin(radius, min);
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
    return _cache.getRadiusClamp(radius, min, max);
  }

  /// Creates a scaled font size value with maximum constraint (cached).
  ///
  /// Parameters:
  /// - [fontSize] - The font size value to scale
  /// - [max] - Maximum allowed value
  ///
  /// Returns the scaled font size clamped to the maximum value.
  double createFontSizeMax(double fontSize, double max) {
    return _cache.getFontSizeMax(fontSize, max);
  }

  /// Creates a scaled font size value with minimum constraint (cached).
  ///
  /// Parameters:
  /// - [fontSize] - The font size value to scale
  /// - [min] - Minimum allowed value
  ///
  /// Returns the scaled font size clamped to the minimum value.
  double createFontSizeMin(double fontSize, double min) {
    return _cache.getFontSizeMin(fontSize, min);
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
    return _cache.getFontSizeClamp(fontSize, min, max);
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
