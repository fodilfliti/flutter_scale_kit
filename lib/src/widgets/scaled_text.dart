import 'package:flutter/material.dart';
import '../core/scale_value_factory.dart';
import '../core/font_config.dart';

/// Scaled Text widget - extends Flutter's Text
/// Automatically applies scaling to fontSize and font-related properties
/// Uses cached values for optimal performance
/// Applies FontConfig automatically if configured
class SKText extends Text {
  static final _factory = ScaleValueFactory.instance;

  SKText(
    super.data, {
    super.key,
    TextStyle? style,
    double? fontSize,
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
    super.textAlign,
    super.textDirection,
    super.maxLines,
    super.overflow,
    super.textWidthBasis,
    super.textHeightBehavior,
    super.selectionColor,
    super.semanticsLabel,
    super.softWrap,
    super.strutStyle,
    super.textScaler,
    bool? applyFontConfig,
  }) : super(
         style: _buildTextStyle(
           baseStyle: style,
           fontSize: fontSize,
           fontWeight: fontWeight,
           fontStyle: fontStyle,
           color: color,
           backgroundColor: backgroundColor,
           fontFamily: fontFamily,
           fontFamilyFallback: fontFamilyFallback,
           letterSpacing: letterSpacing,
           wordSpacing: wordSpacing,
           height: height,
           textBaseline: textBaseline,
           decoration: decoration,
           decorationColor: decorationColor,
           decorationStyle: decorationStyle,
           decorationThickness: decorationThickness,
           shadows: shadows,
           foreground: foreground,
           background: background,
           leadingDistribution: leadingDistribution,
           locale: locale,
           applyFontConfig: applyFontConfig ?? true,
         ),
       );

  /// Builds TextStyle with automatic fontSize scaling and FontConfig
  static TextStyle _buildTextStyle({
    TextStyle? baseStyle,
    double? fontSize,
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
    bool applyFontConfig = true,
  }) {
    // Extract fontSize from style if provided, otherwise use direct parameter
    final effectiveFontSize = fontSize ?? baseStyle?.fontSize;

    // Scale fontSize if provided
    double? scaledFontSize;
    if (effectiveFontSize != null) {
      scaledFontSize = _factory.resolveFontSize(effectiveFontSize);
    }

    // Build base TextStyle with scaled fontSize
    final textStyle =
        baseStyle?.copyWith(
          fontSize: scaledFontSize ?? baseStyle.fontSize,
          fontWeight: fontWeight ?? baseStyle.fontWeight,
          fontStyle: fontStyle ?? baseStyle.fontStyle,
          color: color ?? baseStyle.color,
          backgroundColor: backgroundColor ?? baseStyle.backgroundColor,
          fontFamily: fontFamily ?? baseStyle.fontFamily,
          fontFamilyFallback:
              fontFamilyFallback ?? baseStyle.fontFamilyFallback,
          letterSpacing: letterSpacing ?? baseStyle.letterSpacing,
          wordSpacing: wordSpacing ?? baseStyle.wordSpacing,
          height: height ?? baseStyle.height,
          textBaseline: textBaseline ?? baseStyle.textBaseline,
          decoration: decoration ?? baseStyle.decoration,
          decorationColor: decorationColor ?? baseStyle.decorationColor,
          decorationStyle: decorationStyle ?? baseStyle.decorationStyle,
          decorationThickness:
              decorationThickness ?? baseStyle.decorationThickness,
          shadows: shadows ?? baseStyle.shadows,
          foreground: foreground ?? baseStyle.foreground,
          background: background ?? baseStyle.background,
          leadingDistribution:
              leadingDistribution ?? baseStyle.leadingDistribution,
          locale: locale ?? baseStyle.locale,
        ) ??
        TextStyle(
          fontSize: scaledFontSize,
          fontWeight: fontWeight,
          fontStyle: fontStyle,
          color: color,
          backgroundColor: backgroundColor,
          fontFamily: fontFamily,
          fontFamilyFallback: fontFamilyFallback,
          letterSpacing: letterSpacing,
          wordSpacing: wordSpacing,
          height: height,
          textBaseline: textBaseline,
          decoration: decoration,
          decorationColor: decorationColor,
          decorationStyle: decorationStyle,
          decorationThickness: decorationThickness,
          shadows: shadows,
          foreground: foreground,
          background: background,
          leadingDistribution: leadingDistribution,
          locale: locale,
        );

    // Apply FontConfig if enabled
    if (applyFontConfig) {
      return FontConfig.instance.getTextStyle(
        baseTextStyle: textStyle,
        languageCode: locale?.languageCode,
      );
    }

    return textStyle;
  }
}
