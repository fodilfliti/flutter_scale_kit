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

  /// Creates responsive [EdgeInsets] padding.
  ///
  /// All values are automatically scaled based on the device's screen size.
  ///
  /// Parameters:
  /// - [all] - Padding applied to all sides
  /// - [horizontal] - Horizontal padding (left and right)
  /// - [vertical] - Vertical padding (top and bottom)
  /// - [top], [bottom], [left], [right] - Individual side padding
  ///
  /// Returns scaled [EdgeInsets] padding.
  EdgeInsets createPadding({
    double? all,
    double? horizontal,
    double? vertical,
    double? top,
    double? bottom,
    double? left,
    double? right,
  }) {
    return _cache.getPadding(
      all: all,
      horizontal: horizontal,
      vertical: vertical,
      top: top,
      bottom: bottom,
      left: left,
      right: right,
    );
  }

  /// Creates responsive [EdgeInsets] margin.
  ///
  /// All values are automatically scaled based on the device's screen size.
  ///
  /// Parameters:
  /// - [all] - Margin applied to all sides
  /// - [horizontal] - Horizontal margin (left and right)
  /// - [vertical] - Vertical margin (top and bottom)
  /// - [top], [bottom], [left], [right] - Individual side margin
  ///
  /// Returns scaled [EdgeInsets] margin.
  EdgeInsets createMargin({
    double? all,
    double? horizontal,
    double? vertical,
    double? top,
    double? bottom,
    double? left,
    double? right,
  }) {
    return _cache.getMargin(
      all: all,
      horizontal: horizontal,
      vertical: vertical,
      top: top,
      bottom: bottom,
      left: left,
      right: right,
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
