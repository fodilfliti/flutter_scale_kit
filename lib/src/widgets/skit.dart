import 'package:flutter/material.dart';
import '../core/scale_value_factory.dart';
import '../core/size_enums.dart';
import '../core/size_values.dart';
import '../core/size_system.dart'
    show
        paddingSizes,
        marginSizes,
        radiusSizes,
        spacingSizes,
        textSizes,
        defaultPaddingValue,
        defaultMarginValue,
        defaultRadiusValue,
        defaultSpacingValue,
        defaultTextSizeValue;
import 'scaled_padding.dart';
import 'scaled_margin.dart';
import 'scaled_container.dart';
import 'spacing_widgets.dart';

/// ScaleKit helper class providing convenient methods for creating
/// responsive widgets and scaled values.
///
/// This class provides a simple, easy-to-use API for creating scaled
/// padding, margins, containers, spacing, and text widgets. All methods
/// automatically scale values based on the current device's screen size
/// and orientation.
///
/// Example usage:
/// ```dart
/// SKit.padding(all: 16, child: Text('Hello'))
/// SKit.margin(SKSize.md, child: Container(...))
/// SKit.roundedContainer(all: 12, color: Colors.blue)
/// SKit.hSpace(8)
/// SKit.text('Hello', textSize: SKTextSize.s16)
/// ```
class SKit {
  SKit._();

  static ScaleValueFactory get _f => ScaleValueFactory.instance;

  /// Creates a scaled padding widget using a size enum, numeric value, or default.
  ///
  /// If [size] is provided and is not a [Widget], it will be used to determine
  /// the padding value. If [size] is a [Widget], it will be used as the child
  /// and the default padding value will be used.
  ///
  /// Parameters:
  /// - [size] - Optional size value (SKSize enum, double, or Widget)
  /// - [child] - Optional child widget
  ///
  /// Returns a [SKPadding] widget with scaled padding.
  static SKPadding pad([dynamic size, Widget? child]) {
    if (size != null && size is! Widget) {
      final value = _getSizeValue(size, paddingSizes);
      return padding(all: value, child: child);
    } else if (size is Widget) {
      return padding(all: defaultPaddingValue, child: size);
    } else {
      return padding(all: defaultPaddingValue, child: child);
    }
  }

  /// Creates a scaled padding widget using size enum or numeric values.
  ///
  /// All parameters can accept either [SKSize] enum values or numeric values.
  /// The values will be automatically scaled based on the device's screen size.
  ///
  /// Parameters:
  /// - [all] - Padding applied to all sides
  /// - [horizontal] - Horizontal padding (left and right)
  /// - [vertical] - Vertical padding (top and bottom)
  /// - [top], [bottom], [left], [right] - Individual side padding
  /// - [child] - Optional child widget
  ///
  /// Returns a [SKPadding] widget with scaled padding.
  static SKPadding paddingSize({
    dynamic all,
    dynamic horizontal,
    dynamic vertical,
    dynamic top,
    dynamic bottom,
    dynamic left,
    dynamic right,
    Widget? child,
  }) {
    final values = paddingSizes;
    return padding(
      all: all != null ? _getSizeValue(all, values) : null,
      horizontal: horizontal != null ? _getSizeValue(horizontal, values) : null,
      vertical: vertical != null ? _getSizeValue(vertical, values) : null,
      top: top != null ? _getSizeValue(top, values) : null,
      bottom: bottom != null ? _getSizeValue(bottom, values) : null,
      left: left != null ? _getSizeValue(left, values) : null,
      right: right != null ? _getSizeValue(right, values) : null,
      child: child,
    );
  }

  static double _getSizeValue(dynamic size, SizeValues values) {
    if (size is SKSize) {
      return values.get(size);
    } else if (size is num) {
      return _f.createWidth(size.toDouble());
    }
    throw ArgumentError('Size must be SKSize enum or numeric value');
  }

  /// Creates a scaled margin widget using a size enum, numeric value, or default.
  ///
  /// If [size] is provided and is not a [Widget], it will be used to determine
  /// the margin value. If [size] is a [Widget], it will be used as the child
  /// and the default margin value will be used.
  ///
  /// Parameters:
  /// - [size] - Optional size value (SKSize enum, double, or Widget)
  /// - [child] - Optional child widget
  ///
  /// Returns a [SKMargin] widget with scaled margin.
  static SKMargin margin([dynamic size, Widget? child]) {
    if (size != null && size is! Widget) {
      final value = _getSizeValue(size, marginSizes);
      return _margin(all: value, child: child);
    } else if (size is Widget) {
      return _margin(all: defaultMarginValue, child: size);
    } else {
      return _margin(all: defaultMarginValue, child: child);
    }
  }

  static SKMargin _margin({
    double? all,
    double? horizontal,
    double? vertical,
    double? top,
    double? bottom,
    double? left,
    double? right,
    Widget? child,
  }) {
    final margin = _f.createMargin(
      all: all,
      horizontal: horizontal,
      vertical: vertical,
      top: top,
      bottom: bottom,
      left: left,
      right: right,
    );
    return SKMargin(margin: margin, child: child);
  }

  /// Creates a scaled margin widget using size enum or numeric values.
  ///
  /// All parameters can accept either [SKSize] enum values or numeric values.
  ///
  /// Parameters:
  /// - [all] - Margin applied to all sides
  /// - [horizontal] - Horizontal margin (left and right)
  /// - [vertical] - Vertical margin (top and bottom)
  /// - [top], [bottom], [left], [right] - Individual side margin
  /// - [child] - Optional child widget
  ///
  /// Returns a [SKMargin] widget with scaled margin.
  static SKMargin marginSize({
    dynamic all,
    dynamic horizontal,
    dynamic vertical,
    dynamic top,
    dynamic bottom,
    dynamic left,
    dynamic right,
    Widget? child,
  }) {
    final values = marginSizes;
    return _margin(
      all: all != null ? _getSizeValue(all, values) : null,
      horizontal: horizontal != null ? _getSizeValue(horizontal, values) : null,
      vertical: vertical != null ? _getSizeValue(vertical, values) : null,
      top: top != null ? _getSizeValue(top, values) : null,
      bottom: bottom != null ? _getSizeValue(bottom, values) : null,
      left: left != null ? _getSizeValue(left, values) : null,
      right: right != null ? _getSizeValue(right, values) : null,
      child: child,
    );
  }

  /// Creates a scaled container with border radius using a size enum, numeric value, or default.
  ///
  /// Parameters:
  /// - [size] - Optional size value (SKSize enum, double, Widget, or Color)
  /// - [child] - Optional child widget
  /// - [color] - Optional background color
  /// - [borderColor] - Optional border color
  /// - [borderWidth] - Optional border width (thickness)
  ///
  /// Returns a [SKContainer] widget with scaled border radius and optional border.
  static SKContainer rounded([
    dynamic size,
    Widget? child,
    Color? color,
    Color? borderColor,
    double? borderWidth,
  ]) {
    double allValue;
    if (size != null && size is! Widget && size is! Color) {
      allValue = _getSizeValue(size, radiusSizes);
    } else if (size is Widget) {
      allValue = defaultRadiusValue;
      child = size;
    } else {
      allValue = defaultRadiusValue;
    }
    return roundedContainerSize(
      all: allValue,
      color: color,
      borderColor: borderColor,
      borderWidth: borderWidth,
      child: child,
    );
  }

  /// Creates a scaled container with border radius using size enum or numeric values.
  ///
  /// All radius parameters can accept either [SKSize] enum values or numeric values.
  ///
  /// Parameters:
  /// - [all] - Border radius applied to all corners
  /// - [topLeft], [topRight], [bottomLeft], [bottomRight] - Individual corner radius
  /// - [color] - Optional background color
  /// - [borderColor] - Optional border color (applied to all sides if individual sides not specified)
  /// - [borderWidth] - Optional border width (thickness)
  /// - [borderTop], [borderBottom], [borderLeft], [borderRight] - Optional border on specific sides
  /// - [borderTopColor], [borderBottomColor], [borderLeftColor], [borderRightColor] - Optional border colors for specific sides
  /// - [borderTopWidth], [borderBottomWidth], [borderLeftWidth], [borderRightWidth] - Optional border widths for specific sides
  /// - [child] - Optional child widget
  /// - [padding] - Optional padding
  /// - [margin] - Optional margin
  ///
  /// Returns a [SKContainer] widget with scaled border radius and optional border.
  static SKContainer roundedContainerSize({
    dynamic all,
    dynamic topLeft,
    dynamic topRight,
    dynamic bottomLeft,
    dynamic bottomRight,
    Color? color,
    Color? borderColor,
    double? borderWidth,
    bool? borderTop,
    bool? borderBottom,
    bool? borderLeft,
    bool? borderRight,
    Color? borderTopColor,
    Color? borderBottomColor,
    Color? borderLeftColor,
    Color? borderRightColor,
    double? borderTopWidth,
    double? borderBottomWidth,
    double? borderLeftWidth,
    double? borderRightWidth,
    Widget? child,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
  }) {
    final values = radiusSizes;
    return roundedContainer(
      all: all != null ? _getSizeValue(all, values) : null,
      topLeft: topLeft != null ? _getSizeValue(topLeft, values) : null,
      topRight: topRight != null ? _getSizeValue(topRight, values) : null,
      bottomLeft: bottomLeft != null ? _getSizeValue(bottomLeft, values) : null,
      bottomRight:
          bottomRight != null ? _getSizeValue(bottomRight, values) : null,
      color: color,
      borderColor: borderColor,
      borderWidth: borderWidth,
      borderTop: borderTop,
      borderBottom: borderBottom,
      borderLeft: borderLeft,
      borderRight: borderRight,
      borderTopColor: borderTopColor,
      borderBottomColor: borderBottomColor,
      borderLeftColor: borderLeftColor,
      borderRightColor: borderRightColor,
      borderTopWidth: borderTopWidth,
      borderBottomWidth: borderBottomWidth,
      borderLeftWidth: borderLeftWidth,
      borderRightWidth: borderRightWidth,
      child: child,
      padding: padding,
      margin: margin,
    );
  }

  /// Gets a scaled radius value using a size enum, numeric value, or default.
  ///
  /// Parameters:
  /// - [size] - Optional size value (SKSize enum or double)
  ///
  /// Returns a scaled radius value.
  static double radius([dynamic size]) {
    final value =
        size != null ? _getSizeValue(size, radiusSizes) : defaultRadiusValue;
    return _radius(value);
  }

  static double _radius(double radius) => _f.createRadius(radius);

  /// Creates a [BorderRadius] using size enum or numeric values.
  ///
  /// All parameters can accept either [SKSize] enum values or numeric values.
  ///
  /// Parameters:
  /// - [all] - Border radius applied to all corners
  /// - [topLeft], [topRight], [bottomLeft], [bottomRight] - Individual corner radius
  ///
  /// Returns a [BorderRadius] with scaled values.
  static BorderRadius borderRadiusSize({
    dynamic all,
    dynamic topLeft,
    dynamic topRight,
    dynamic bottomLeft,
    dynamic bottomRight,
  }) {
    final values = radiusSizes;
    return borderRadius(
      all: all != null ? _getSizeValue(all, values) : null,
      topLeft: topLeft != null ? _getSizeValue(topLeft, values) : null,
      topRight: topRight != null ? _getSizeValue(topRight, values) : null,
      bottomLeft: bottomLeft != null ? _getSizeValue(bottomLeft, values) : null,
      bottomRight:
          bottomRight != null ? _getSizeValue(bottomRight, values) : null,
    );
  }

  /// Creates horizontal spacing using a size enum, numeric value, or default.
  ///
  /// Parameters:
  /// - [size] - Optional size value (SKSize enum or double)
  ///
  /// Returns a [SKSizedBox] widget with scaled horizontal spacing.
  static SKSizedBox h([dynamic size]) {
    final value =
        size != null ? _getSizeValue(size, spacingSizes) : defaultSpacingValue;
    return hSpace(value);
  }

  /// Creates vertical spacing using a size enum, numeric value, or default.
  ///
  /// Parameters:
  /// - [size] - Optional size value (SKSize enum or double)
  ///
  /// Returns a [SKSizedBox] widget with scaled vertical spacing.
  static SKSizedBox v([dynamic size]) {
    final value =
        size != null ? _getSizeValue(size, spacingSizes) : defaultSpacingValue;
    return vSpace(value);
  }

  /// Creates horizontal spacing using a size enum or numeric value.
  ///
  /// Parameters:
  /// - [size] - Size value (SKSize enum or double)
  ///
  /// Returns a [SKSizedBox] widget with scaled horizontal spacing.
  static SKSizedBox hSpaceSize(dynamic size) {
    final value = _getSizeValue(size, spacingSizes);
    return hSpace(value);
  }

  /// Creates vertical spacing using a size enum or numeric value.
  ///
  /// Parameters:
  /// - [size] - Size value (SKSize enum or double)
  ///
  /// Returns a [SKSizedBox] widget with scaled vertical spacing.
  static SKSizedBox vSpaceSize(dynamic size) {
    final value = _getSizeValue(size, spacingSizes);
    return vSpace(value);
  }

  /// Creates square spacing using a size enum or numeric value.
  ///
  /// Parameters:
  /// - [size] - Size value (SKSize enum or double)
  ///
  /// Returns a [SKSizedBox] widget with equal width and height.
  static SKSizedBox sSpaceSize(dynamic size) {
    final value = _getSizeValue(size, spacingSizes);
    return sSpace(value);
  }

  /// Creates [EdgeInsets] padding using size enum or numeric values.
  ///
  /// All parameters can accept either [SKSize] enum values or numeric values.
  ///
  /// Parameters:
  /// - [all] - Padding applied to all sides
  /// - [horizontal] - Horizontal padding
  /// - [vertical] - Vertical padding
  /// - [top], [bottom], [left], [right] - Individual side padding
  ///
  /// Returns scaled [EdgeInsets] padding.
  static EdgeInsets paddingEdgeInsetsSize({
    dynamic all,
    dynamic horizontal,
    dynamic vertical,
    dynamic top,
    dynamic bottom,
    dynamic left,
    dynamic right,
  }) {
    final values = paddingSizes;
    return paddingEdgeInsets(
      all: all != null ? _getSizeValue(all, values) : null,
      horizontal: horizontal != null ? _getSizeValue(horizontal, values) : null,
      vertical: vertical != null ? _getSizeValue(vertical, values) : null,
      top: top != null ? _getSizeValue(top, values) : null,
      bottom: bottom != null ? _getSizeValue(bottom, values) : null,
      left: left != null ? _getSizeValue(left, values) : null,
      right: right != null ? _getSizeValue(right, values) : null,
    );
  }

  /// Creates [EdgeInsets] margin using size enum or numeric values.
  ///
  /// All parameters can accept either [SKSize] enum values or numeric values.
  ///
  /// Parameters:
  /// - [all] - Margin applied to all sides
  /// - [horizontal] - Horizontal margin
  /// - [vertical] - Vertical margin
  /// - [top], [bottom], [left], [right] - Individual side margin
  ///
  /// Returns scaled [EdgeInsets] margin.
  static EdgeInsets marginEdgeInsetsSize({
    dynamic all,
    dynamic horizontal,
    dynamic vertical,
    dynamic top,
    dynamic bottom,
    dynamic left,
    dynamic right,
  }) {
    final values = marginSizes;
    return marginEdgeInsets(
      all: all != null ? _getSizeValue(all, values) : null,
      horizontal: horizontal != null ? _getSizeValue(horizontal, values) : null,
      vertical: vertical != null ? _getSizeValue(vertical, values) : null,
      top: top != null ? _getSizeValue(top, values) : null,
      bottom: bottom != null ? _getSizeValue(bottom, values) : null,
      left: left != null ? _getSizeValue(left, values) : null,
      right: right != null ? _getSizeValue(right, values) : null,
    );
  }

  /// Creates a scaled padding widget with numeric values.
  ///
  /// Parameters:
  /// - [all] - Padding applied to all sides
  /// - [horizontal] - Horizontal padding (left and right)
  /// - [vertical] - Vertical padding (top and bottom)
  /// - [top], [bottom], [left], [right] - Individual side padding
  /// - [child] - Optional child widget
  ///
  /// Returns a [SKPadding] widget with scaled padding.
  static SKPadding padding({
    double? all,
    double? horizontal,
    double? vertical,
    double? top,
    double? bottom,
    double? left,
    double? right,
    Widget? child,
  }) {
    final padding = _f.createPadding(
      all: all,
      horizontal: horizontal,
      vertical: vertical,
      top: top,
      bottom: bottom,
      left: left,
      right: right,
    );

    return SKPadding(padding: padding, child: child);
  }

  /// Creates a scaled margin widget with numeric values.
  ///
  /// For size enum usage, use [margin] or [marginSize] instead.
  ///
  /// Parameters:
  /// - [all] - Margin applied to all sides
  /// - [horizontal] - Horizontal margin
  /// - [vertical] - Vertical margin
  /// - [top], [bottom], [left], [right] - Individual side margin
  /// - [child] - Optional child widget
  ///
  /// Returns a [SKMargin] widget with scaled margin.
  static SKMargin marginValue({
    double? all,
    double? horizontal,
    double? vertical,
    double? top,
    double? bottom,
    double? left,
    double? right,
    Widget? child,
  }) {
    return _margin(
      all: all,
      horizontal: horizontal,
      vertical: vertical,
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: child,
    );
  }

  /// Creates a scaled container with border radius and optional border using numeric values.
  ///
  /// Parameters:
  /// - [all] - Border radius applied to all corners
  /// - [topLeft], [topRight], [bottomLeft], [bottomRight] - Individual corner radius
  /// - [color] - Optional background color
  /// - [borderColor] - Optional border color (applied to all sides if individual sides not specified)
  /// - [borderWidth] - Optional border width (thickness), will be scaled automatically
  /// - [borderTop], [borderBottom], [borderLeft], [borderRight] - Optional border on specific sides
  /// - [borderTopColor], [borderBottomColor], [borderLeftColor], [borderRightColor] - Optional border colors for specific sides
  /// - [borderTopWidth], [borderBottomWidth], [borderLeftWidth], [borderRightWidth] - Optional border widths for specific sides
  /// - [child] - Optional child widget
  /// - [padding] - Optional padding
  /// - [margin] - Optional margin
  ///
  /// Returns a [SKContainer] widget with scaled border radius and optional border.
  static SKContainer roundedContainer({
    double? all,
    double? topLeft,
    double? topRight,
    double? bottomLeft,
    double? bottomRight,
    Color? color,
    Color? borderColor,
    double? borderWidth,
    bool? borderTop,
    bool? borderBottom,
    bool? borderLeft,
    bool? borderRight,
    Color? borderTopColor,
    Color? borderBottomColor,
    Color? borderLeftColor,
    Color? borderRightColor,
    double? borderTopWidth,
    double? borderBottomWidth,
    double? borderLeftWidth,
    double? borderRightWidth,
    Widget? child,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
  }) {
    final borderRadius = _f.createBorderRadius(
      all: all,
      topLeft: topLeft,
      topRight: topRight,
      bottomLeft: bottomLeft,
      bottomRight: bottomRight,
    );

    final scaledBorderWidth =
        borderWidth != null ? _f.createWidth(borderWidth) : null;

    // Check if individual border sides are specified
    final hasIndividualBorders = borderTop != null ||
        borderBottom != null ||
        borderLeft != null ||
        borderRight != null ||
        borderTopColor != null ||
        borderBottomColor != null ||
        borderLeftColor != null ||
        borderRightColor != null ||
        borderTopWidth != null ||
        borderBottomWidth != null ||
        borderLeftWidth != null ||
        borderRightWidth != null;

    Border? border;
    if (hasIndividualBorders) {
      // Use Border.only() for individual sides
      final topWidth = borderTopWidth != null
          ? _f.createWidth(borderTopWidth)
          : (borderTop == true ? (scaledBorderWidth ?? 1.0) : 0.0);
      final bottomWidth = borderBottomWidth != null
          ? _f.createWidth(borderBottomWidth)
          : (borderBottom == true ? (scaledBorderWidth ?? 1.0) : 0.0);
      final leftWidth = borderLeftWidth != null
          ? _f.createWidth(borderLeftWidth)
          : (borderLeft == true ? (scaledBorderWidth ?? 1.0) : 0.0);
      final rightWidth = borderRightWidth != null
          ? _f.createWidth(borderRightWidth)
          : (borderRight == true ? (scaledBorderWidth ?? 1.0) : 0.0);

      final topColor = borderTopColor ?? borderColor ?? Colors.transparent;
      final bottomColor = borderBottomColor ?? borderColor ?? Colors.transparent;
      final leftColor = borderLeftColor ?? borderColor ?? Colors.transparent;
      final rightColor = borderRightColor ?? borderColor ?? Colors.transparent;

      border = Border(
        top: (borderTop == true || borderTopWidth != null || borderTopColor != null) && topWidth > 0
            ? BorderSide(color: topColor, width: topWidth)
            : BorderSide.none,
        bottom: (borderBottom == true || borderBottomWidth != null || borderBottomColor != null) && bottomWidth > 0
            ? BorderSide(color: bottomColor, width: bottomWidth)
            : BorderSide.none,
        left: (borderLeft == true || borderLeftWidth != null || borderLeftColor != null) && leftWidth > 0
            ? BorderSide(color: leftColor, width: leftWidth)
            : BorderSide.none,
        right: (borderRight == true || borderRightWidth != null || borderRightColor != null) && rightWidth > 0
            ? BorderSide(color: rightColor, width: rightWidth)
            : BorderSide.none,
      );
    } else if (borderColor != null || scaledBorderWidth != null) {
      // Use Border.all() for all sides
      border = Border.all(
        color: borderColor ?? Colors.transparent,
        width: scaledBorderWidth ?? 1.0,
      );
    }

    return SKContainer(
      decoration: BoxDecoration(
        color: color,
        borderRadius: borderRadius,
        border: border,
      ),
      padding: padding,
      margin: margin,
      child: child,
    );
  }

  /// Creates a scaled container widget.
  ///
  /// Parameters:
  /// - [color] - Optional background color
  /// - [child] - Optional child widget
  /// - [padding] - Optional padding
  /// - [margin] - Optional margin
  /// - [width] - Optional width
  /// - [height] - Optional height
  /// - [alignment] - Optional alignment
  /// - [decoration] - Optional box decoration
  ///
  /// Returns a [SKContainer] widget.
  static SKContainer container({
    Color? color,
    Widget? child,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    double? width,
    double? height,
    AlignmentGeometry? alignment,
    BoxDecoration? decoration,
  }) {
    return SKContainer(
      decoration:
          decoration ?? (color != null ? BoxDecoration(color: color) : null),
      padding: padding,
      margin: margin,
      width: width,
      height: height,
      alignment: alignment,
      child: child,
    );
  }

  /// Creates a scaled [TextStyle] using a text size enum or numeric value.
  ///
  /// Parameters:
  /// - [textSize] - Optional [SKTextSize] enum value
  /// - [fontSize] - Optional numeric font size
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
  static TextStyle textStyle({
    SKTextSize? textSize,
    double? fontSize,
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
    double finalFontSize;
    if (textSize != null) {
      finalFontSize = textSizes.get(textSize);
    } else if (fontSize != null) {
      finalFontSize = fontSize;
    } else {
      finalFontSize = defaultTextSizeValue;
    }

    return _f.createTextStyle(
      fontSize: finalFontSize,
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
  }

  /// Creates a [Text] widget with scaled [TextStyle] using a text size enum or numeric value.
  ///
  /// Parameters:
  /// - [data] - The text to display
  /// - [textSize] - Optional [SKTextSize] enum value
  /// - [fontSize] - Optional numeric font size
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
  /// - [textAlign] - Optional text alignment
  /// - [maxLines] - Optional maximum lines
  /// - [overflow] - Optional text overflow
  ///
  /// Returns a [Text] widget with scaled font size.
  static Text text(
    String data, {
    SKTextSize? textSize,
    double? fontSize,
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
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
  }) {
    final style = textStyle(
      textSize: textSize,
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

    return Text(
      data,
      style: style,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }

  /// Creates a scaled horizontal spacing widget.
  ///
  /// Parameters:
  /// - [width] - The width value to scale
  ///
  /// Returns a [SKSizedBox] widget with scaled horizontal spacing.
  static SKSizedBox hSpace(double width) {
    return SKSizedBox(width: _f.createWidth(width));
  }

  /// Creates a scaled vertical spacing widget.
  ///
  /// Parameters:
  /// - [height] - The height value to scale
  ///
  /// Returns a [SKSizedBox] widget with scaled vertical spacing.
  static SKSizedBox vSpace(double height) {
    return SKSizedBox(height: _f.createHeight(height));
  }

  /// Creates a scaled square spacing widget.
  ///
  /// Parameters:
  /// - [size] - The size value to scale (applied to both width and height)
  ///
  /// Returns a [SKSizedBox] widget with equal width and height.
  static SKSizedBox sSpace(double size) {
    final scaledSize = _f.createWidth(size);
    return SKSizedBox(width: scaledSize, height: scaledSize);
  }

  /// Creates a scaled horizontal [SizedBox].
  ///
  /// Parameters:
  /// - [width] - The width value to scale
  ///
  /// Returns a [SKSizedBox] widget with scaled horizontal spacing.
  static SKSizedBox horizontalSizeBox(double width) {
    return SKSizedBox(width: _f.createWidth(width));
  }

  /// Creates a scaled vertical [SizedBox].
  ///
  /// Parameters:
  /// - [height] - The height value to scale
  ///
  /// Returns a [SKSizedBox] widget with scaled vertical spacing.
  static SKSizedBox verticalSizeBox(double height) {
    return SKSizedBox(height: _f.createHeight(height));
  }

  /// Creates a scaled [SizedBox] widget.
  ///
  /// Parameters:
  /// - [width] - Optional width value to scale
  /// - [height] - Optional height value to scale
  /// - [child] - Optional child widget
  ///
  /// Returns a [SKSizedBox] widget.
  static SKSizedBox sizedBox({double? width, double? height, Widget? child}) {
    final scaledWidth = width != null ? _f.createWidth(width) : null;
    final scaledHeight = height != null ? _f.createHeight(height) : null;
    return SKSizedBox(width: scaledWidth, height: scaledHeight, child: child);
  }

  /// Creates a scaled width value.
  ///
  /// Parameters:
  /// - [width] - The width value to scale
  ///
  /// Returns the scaled width.
  static double width(double width) => _f.createWidth(width);

  /// Creates a scaled height value.
  ///
  /// Parameters:
  /// - [height] - The height value to scale
  ///
  /// Returns the scaled height.
  static double height(double height) => _f.createHeight(height);

  /// Creates a scaled font size value.
  ///
  /// Parameters:
  /// - [fontSize] - The font size value to scale
  ///
  /// Returns the scaled font size.
  static double fontSize(double fontSize) => _f.createFontSize(fontSize);

  /// Creates a scaled radius value.
  ///
  /// For size enum usage, use [radius] instead.
  ///
  /// Parameters:
  /// - [radius] - The radius value to scale
  ///
  /// Returns the scaled radius.
  static double radiusValue(double radius) => _radius(radius);

  /// Creates a screen width percentage value.
  ///
  /// Parameters:
  /// - [percentage] - The percentage of screen width (0.0 to 1.0)
  ///
  /// Returns the calculated screen width percentage.
  static double screenWidth(double percentage) =>
      _f.createScreenWidth(percentage);

  /// Creates a screen height percentage value.
  ///
  /// Parameters:
  /// - [percentage] - The percentage of screen height (0.0 to 1.0)
  ///
  /// Returns the calculated screen height percentage.
  static double screenHeight(double percentage) =>
      _f.createScreenHeight(percentage);

  /// Creates [EdgeInsets] padding with scaled numeric values.
  ///
  /// These are runtime values, so use `final` not `const` when assigning.
  ///
  /// Parameters:
  /// - [all] - Padding applied to all sides
  /// - [horizontal] - Horizontal padding
  /// - [vertical] - Vertical padding
  /// - [top], [bottom], [left], [right] - Individual side padding
  ///
  /// Returns scaled [EdgeInsets] padding.
  static EdgeInsets paddingEdgeInsets({
    double? all,
    double? horizontal,
    double? vertical,
    double? top,
    double? bottom,
    double? left,
    double? right,
  }) => _f.createPadding(
    all: all,
    horizontal: horizontal,
    vertical: vertical,
    top: top,
    bottom: bottom,
    left: left,
    right: right,
  );

  /// Creates [EdgeInsets] margin with scaled numeric values.
  ///
  /// These are runtime values, so use `final` not `const` when assigning.
  ///
  /// Parameters:
  /// - [all] - Margin applied to all sides
  /// - [horizontal] - Horizontal margin
  /// - [vertical] - Vertical margin
  /// - [top], [bottom], [left], [right] - Individual side margin
  ///
  /// Returns scaled [EdgeInsets] margin.
  static EdgeInsets marginEdgeInsets({
    double? all,
    double? horizontal,
    double? vertical,
    double? top,
    double? bottom,
    double? left,
    double? right,
  }) => _f.createMargin(
    all: all,
    horizontal: horizontal,
    vertical: vertical,
    top: top,
    bottom: bottom,
    left: left,
    right: right,
  );

  /// Creates a [BorderRadius] with scaled numeric values.
  ///
  /// These are runtime values, so use `final` not `const` when assigning.
  ///
  /// Parameters:
  /// - [all] - Border radius applied to all corners
  /// - [topLeft], [topRight], [bottomLeft], [bottomRight] - Individual corner radius
  ///
  /// Returns a [BorderRadius] with scaled values.
  static BorderRadius borderRadius({
    double? all,
    double? topLeft,
    double? topRight,
    double? bottomLeft,
    double? bottomRight,
  }) => _f.createBorderRadius(
    all: all,
    topLeft: topLeft,
    topRight: topRight,
    bottomLeft: bottomLeft,
    bottomRight: bottomRight,
  );
}
