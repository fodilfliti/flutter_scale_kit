import 'package:flutter/material.dart';
import '../core/scale_value_factory.dart';

/// Comprehensive configuration for defining all responsive design values in one place.
///
/// This class allows you to define your design values (text sizes, padding,
/// margin, radius, spacing) in a single location. After computing once, you
/// can use the returned [ScaleKitDesignValuesSet] with const widgets throughout
/// your app for optimal performance.
///
/// Example usage:
/// ```dart
/// // Define all your design values
/// const design = ScaleKitDesignValues(
///   textXs: 10,
///   textSm: 12,
///   textMd: 14,
///   textLg: 16,
///   paddingXs: 4,
///   paddingSm: 8,
///   paddingMd: 16,
///   radiusSm: 4,
///   radiusMd: 8,
/// );
///
/// // Compute once in your build method
/// final values = design.compute();
///
/// // Use const widgets everywhere
/// SKPadding(
///   padding: values.paddingMd!,
///   child: SKContainer(
///     decoration: BoxDecoration(
///       borderRadius: values.borderRadiusMd,
///     ),
///     child: Text('Hello', style: values.textMd),
///   ),
/// )
/// ```
class ScaleKitDesignValues {
  /// Extra small text size.
  final double? textXs;

  /// Small text size.
  final double? textSm;

  /// Medium text size.
  final double? textMd;

  /// Large text size.
  final double? textLg;

  /// Extra large text size.
  final double? textXl;

  /// Extra extra large text size.
  final double? textXxl;

  /// Extra small padding value.
  final double? paddingXs;

  /// Small padding value.
  final double? paddingSm;

  /// Medium padding value.
  final double? paddingMd;

  /// Large padding value.
  final double? paddingLg;

  /// Extra large padding value.
  final double? paddingXl;

  /// Horizontal padding [EdgeInsets].
  final EdgeInsets? paddingHorizontal;

  /// Vertical padding [EdgeInsets].
  final EdgeInsets? paddingVertical;

  /// Extra small margin value.
  final double? marginXs;

  /// Small margin value.
  final double? marginSm;

  /// Medium margin value.
  final double? marginMd;

  /// Large margin value.
  final double? marginLg;

  /// Extra large margin value.
  final double? marginXl;

  /// Horizontal margin [EdgeInsets].
  final EdgeInsets? marginHorizontal;

  /// Vertical margin [EdgeInsets].
  final EdgeInsets? marginVertical;

  /// Extra small radius value.
  final double? radiusXs;

  /// Small radius value.
  final double? radiusSm;

  /// Medium radius value.
  final double? radiusMd;

  /// Large radius value.
  final double? radiusLg;

  /// Extra large radius value.
  final double? radiusXl;

  /// Border radius applied to all corners.
  final BorderRadius? radiusAll;

  /// Extra small spacing value.
  final double? spacingXs;

  /// Small spacing value.
  final double? spacingSm;

  /// Medium spacing value.
  final double? spacingMd;

  /// Large spacing value.
  final double? spacingLg;

  /// Extra large spacing value.
  final double? spacingXl;

  /// Small width value.
  final double? widthSm;

  /// Medium width value.
  final double? widthMd;

  /// Large width value.
  final double? widthLg;

  /// Small height value.
  final double? heightSm;

  /// Medium height value.
  final double? heightMd;

  /// Large height value.
  final double? heightLg;

  /// Creates a [ScaleKitDesignValues] with the specified design values.
  const ScaleKitDesignValues({
    this.textXs,
    this.textSm,
    this.textMd,
    this.textLg,
    this.textXl,
    this.textXxl,
    this.paddingXs,
    this.paddingSm,
    this.paddingMd,
    this.paddingLg,
    this.paddingXl,
    this.paddingHorizontal,
    this.paddingVertical,
    this.marginXs,
    this.marginSm,
    this.marginMd,
    this.marginLg,
    this.marginXl,
    this.marginHorizontal,
    this.marginVertical,
    this.radiusXs,
    this.radiusSm,
    this.radiusMd,
    this.radiusLg,
    this.radiusXl,
    this.radiusAll,
    this.spacingXs,
    this.spacingSm,
    this.spacingMd,
    this.spacingLg,
    this.spacingXl,
    this.widthSm,
    this.widthMd,
    this.widthLg,
    this.heightSm,
    this.heightMd,
    this.heightLg,
  });

  /// Computes all theme values once and returns [ScaleKitDesignValuesSet].
  ///
  /// Call this method in your build method to get all scaled values.
  /// All values are automatically scaled based on the current device's
  /// screen size and orientation.
  ///
  /// Returns a [ScaleKitDesignValuesSet] object containing all computed and scaled values.
  ScaleKitDesignValuesSet compute() {
    final f = ScaleValueFactory.instance;

    return ScaleKitDesignValuesSet(
      textXs:
          textXs != null
              ? TextStyle(fontSize: f.createFontSize(textXs!))
              : null,
      textSm:
          textSm != null
              ? TextStyle(fontSize: f.createFontSize(textSm!))
              : null,
      textMd:
          textMd != null
              ? TextStyle(fontSize: f.createFontSize(textMd!))
              : null,
      textLg:
          textLg != null
              ? TextStyle(fontSize: f.createFontSize(textLg!))
              : null,
      textXl:
          textXl != null
              ? TextStyle(fontSize: f.createFontSize(textXl!))
              : null,
      textXxl:
          textXxl != null
              ? TextStyle(fontSize: f.createFontSize(textXxl!))
              : null,
      paddingXs: paddingXs != null ? f.createPadding(all: paddingXs!) : null,
      paddingSm: paddingSm != null ? f.createPadding(all: paddingSm!) : null,
      paddingMd: paddingMd != null ? f.createPadding(all: paddingMd!) : null,
      paddingLg: paddingLg != null ? f.createPadding(all: paddingLg!) : null,
      paddingXl: paddingXl != null ? f.createPadding(all: paddingXl!) : null,
      paddingHorizontal:
          paddingHorizontal ?? f.createPadding(horizontal: paddingMd ?? 16),
      paddingVertical:
          paddingVertical ?? f.createPadding(vertical: paddingMd ?? 16),
      marginXs: marginXs != null ? f.createMargin(all: marginXs!) : null,
      marginSm: marginSm != null ? f.createMargin(all: marginSm!) : null,
      marginMd: marginMd != null ? f.createMargin(all: marginMd!) : null,
      marginLg: marginLg != null ? f.createMargin(all: marginLg!) : null,
      marginXl: marginXl != null ? f.createMargin(all: marginXl!) : null,
      marginHorizontal:
          marginHorizontal ?? f.createMargin(horizontal: marginMd ?? 16),
      marginVertical:
          marginVertical ?? f.createMargin(vertical: marginMd ?? 16),
      radiusXs: radiusXs != null ? f.createRadiusSafe(radiusXs!) : null,
      radiusSm: radiusSm != null ? f.createRadiusSafe(radiusSm!) : null,
      radiusMd: radiusMd != null ? f.createRadiusSafe(radiusMd!) : null,
      radiusLg: radiusLg != null ? f.createRadiusSafe(radiusLg!) : null,
      radiusXl: radiusXl != null ? f.createRadiusSafe(radiusXl!) : null,
      radiusAll:
          radiusAll ??
          (radiusMd != null ? f.createBorderRadiusSafe(all: radiusMd!) : null),
      borderRadiusXs:
          radiusXs != null ? f.createBorderRadiusSafe(all: radiusXs!) : null,
      borderRadiusSm:
          radiusSm != null ? f.createBorderRadiusSafe(all: radiusSm!) : null,
      borderRadiusMd:
          radiusMd != null ? f.createBorderRadiusSafe(all: radiusMd!) : null,
      borderRadiusLg:
          radiusLg != null ? f.createBorderRadiusSafe(all: radiusLg!) : null,
      borderRadiusXl:
          radiusXl != null ? f.createBorderRadiusSafe(all: radiusXl!) : null,
      spacingXs: spacingXs != null ? f.createWidth(spacingXs!) : null,
      spacingSm: spacingSm != null ? f.createWidth(spacingSm!) : null,
      spacingMd: spacingMd != null ? f.createWidth(spacingMd!) : null,
      spacingLg: spacingLg != null ? f.createWidth(spacingLg!) : null,
      spacingXl: spacingXl != null ? f.createWidth(spacingXl!) : null,
      widthSm: widthSm != null ? f.createWidth(widthSm!) : null,
      widthMd: widthMd != null ? f.createWidth(widthMd!) : null,
      widthLg: widthLg != null ? f.createWidth(widthLg!) : null,
      heightSm: heightSm != null ? f.createHeight(heightSm!) : null,
      heightMd: heightMd != null ? f.createHeight(heightMd!) : null,
      heightLg: heightLg != null ? f.createHeight(heightLg!) : null,
    );
  }
}

/// Computed design values ready for use in const widgets.
///
/// This class contains all scaled values computed from [ScaleKitDesignValues].
/// All values are already scaled and ready to use with const-compatible
/// widgets throughout your app.
class ScaleKitDesignValuesSet {
  /// Extra small text style.
  final TextStyle? textXs;

  /// Small text style.
  final TextStyle? textSm;

  /// Medium text style.
  final TextStyle? textMd;

  /// Large text style.
  final TextStyle? textLg;

  /// Extra large text style.
  final TextStyle? textXl;

  /// Extra extra large text style.
  final TextStyle? textXxl;

  /// Extra small padding.
  final EdgeInsets? paddingXs;

  /// Small padding.
  final EdgeInsets? paddingSm;

  /// Medium padding.
  final EdgeInsets? paddingMd;

  /// Large padding.
  final EdgeInsets? paddingLg;

  /// Extra large padding.
  final EdgeInsets? paddingXl;

  /// Horizontal padding.
  final EdgeInsets paddingHorizontal;

  /// Vertical padding.
  final EdgeInsets paddingVertical;

  /// Extra small margin.
  final EdgeInsets? marginXs;

  /// Small margin.
  final EdgeInsets? marginSm;

  /// Medium margin.
  final EdgeInsets? marginMd;

  /// Large margin.
  final EdgeInsets? marginLg;

  /// Extra large margin.
  final EdgeInsets? marginXl;

  /// Horizontal margin.
  final EdgeInsets marginHorizontal;

  /// Vertical margin.
  final EdgeInsets marginVertical;

  /// Extra small radius value.
  final double? radiusXs;

  /// Small radius value.
  final double? radiusSm;

  /// Medium radius value.
  final double? radiusMd;

  /// Large radius value.
  final double? radiusLg;

  /// Extra large radius value.
  final double? radiusXl;

  /// Extra small border radius.
  final BorderRadius? borderRadiusXs;

  /// Small border radius.
  final BorderRadius? borderRadiusSm;

  /// Medium border radius.
  final BorderRadius? borderRadiusMd;

  /// Large border radius.
  final BorderRadius? borderRadiusLg;

  /// Extra large border radius.
  final BorderRadius? borderRadiusXl;

  /// Border radius applied to all corners.
  final BorderRadius? radiusAll;

  /// Extra small spacing value.
  final double? spacingXs;

  /// Small spacing value.
  final double? spacingSm;

  /// Medium spacing value.
  final double? spacingMd;

  /// Large spacing value.
  final double? spacingLg;

  /// Extra large spacing value.
  final double? spacingXl;

  /// Small width value.
  final double? widthSm;

  /// Medium width value.
  final double? widthMd;

  /// Large width value.
  final double? widthLg;

  /// Small height value.
  final double? heightSm;

  /// Medium height value.
  final double? heightMd;

  /// Large height value.
  final double? heightLg;

  /// Creates a [ScaleKitDesignValuesSet] with computed and scaled values.
  const ScaleKitDesignValuesSet({
    this.textXs,
    this.textSm,
    this.textMd,
    this.textLg,
    this.textXl,
    this.textXxl,
    this.paddingXs,
    this.paddingSm,
    this.paddingMd,
    this.paddingLg,
    this.paddingXl,
    required this.paddingHorizontal,
    required this.paddingVertical,
    this.marginXs,
    this.marginSm,
    this.marginMd,
    this.marginLg,
    this.marginXl,
    required this.marginHorizontal,
    required this.marginVertical,
    this.radiusXs,
    this.radiusSm,
    this.radiusMd,
    this.radiusLg,
    this.radiusXl,
    this.borderRadiusXs,
    this.borderRadiusSm,
    this.borderRadiusMd,
    this.borderRadiusLg,
    this.borderRadiusXl,
    this.radiusAll,
    this.spacingXs,
    this.spacingSm,
    this.spacingMd,
    this.spacingLg,
    this.spacingXl,
    this.widthSm,
    this.widthMd,
    this.widthLg,
    this.heightSm,
    this.heightMd,
    this.heightLg,
  });
}

@Deprecated('Use ScaleKitDesignValues instead')
typedef SKitTheme = ScaleKitDesignValues;

@Deprecated('Use ScaleKitDesignValuesSet instead')
typedef SKitThemeValues = ScaleKitDesignValuesSet;

/// Legacy helper class for backward compatibility.
///
/// Use [ScaleKitDesignValues.compute] instead for comprehensive theme support.
/// This class is kept for backward compatibility with existing code.
class SKitValues {
  /// Padding [EdgeInsets].
  final EdgeInsets padding;

  /// Margin [EdgeInsets].
  final EdgeInsets margin;

  /// Border radius.
  final BorderRadius borderRadius;

  /// Width value.
  final double width;

  /// Height value.
  final double height;

  /// Font size value.
  final double fontSize;

  /// Radius value.
  final double radius;

  /// Text style.
  final TextStyle textStyle;

  /// Creates a [SKitValues] with the specified values.
  const SKitValues({
    required this.padding,
    required this.margin,
    required this.borderRadius,
    required this.width,
    required this.height,
    required this.fontSize,
    required this.radius,
    required this.textStyle,
  });

  /// Computes values once and returns [SKitValues].
  ///
  /// This factory method computes scaled values based on the provided
  /// parameters. Use the returned values with const-compatible widgets.
  ///
  /// Parameters:
  /// - [padding] - Optional padding value
  /// - [paddingEdgeInsets] - Optional padding [EdgeInsets]
  /// - [margin] - Optional margin value
  /// - [marginEdgeInsets] - Optional margin [EdgeInsets]
  /// - [borderRadius] - Optional border radius value
  /// - [borderRadiusValue] - Optional border radius [BorderRadius]
  /// - [width] - Optional width value
  /// - [height] - Optional height value
  /// - [fontSize] - Optional font size value
  /// - [radius] - Optional radius value
  /// - [textStyle] - Optional text style
  ///
  /// Returns a [SKitValues] object with computed and scaled values.
  factory SKitValues.compute({
    double? padding,
    EdgeInsets? paddingEdgeInsets,
    double? margin,
    EdgeInsets? marginEdgeInsets,
    double? borderRadius,
    BorderRadius? borderRadiusValue,
    double? width,
    double? height,
    double? fontSize,
    double? radius,
    TextStyle? textStyle,
  }) {
    final f = ScaleValueFactory.instance;

    return SKitValues(
      padding:
          paddingEdgeInsets ??
          (padding != null ? f.createPadding(all: padding) : EdgeInsets.zero),
      margin:
          marginEdgeInsets ??
          (margin != null ? f.createMargin(all: margin) : EdgeInsets.zero),
      borderRadius:
          borderRadiusValue ??
          (borderRadius != null
              ? f.createBorderRadius(all: borderRadius)
              : BorderRadius.zero),
      width: width != null ? f.createWidth(width) : 0,
      height: height != null ? f.createHeight(height) : 0,
      fontSize: fontSize != null ? f.createFontSize(fontSize) : 0,
      radius: radius != null ? f.createRadius(radius) : 0,
      textStyle: textStyle ?? const TextStyle(),
    );
  }
}
