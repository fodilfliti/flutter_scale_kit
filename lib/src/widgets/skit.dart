import 'dart:ui' as ui;
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
import '../core/scale_manager.dart';
import '../core/responsive_enums.dart';

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
  /// For advanced decoration options (gradient, shadows, background images), use
  /// [roundedContainer] or [roundedContainerSize].
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
  /// - [gradient] - Optional background gradient (ignored if [shape] is [BoxShape.circle] with custom borders)
  /// - [backgroundImage] - Optional background image
  /// - [backgroundBlendMode] - Optional blend mode applied to [backgroundImage] and [color]/[gradient]
  /// - [boxShadow] - Optional list of shadows applied to the container
  /// - [elevation] - Optional elevation helper that generates Material-like shadows when [boxShadow] is not provided
  /// - [shadowColor] - Optional color applied to generated elevation shadows or to override [boxShadow] colors
  /// - [shape] - Optional box shape (defaults to [BoxShape.rectangle])
  /// - [child] - Optional child widget
  /// - [padding] - Optional padding
  /// - [margin] - Optional margin
  ///
  /// Returns a [SKContainer] widget with scaled border radius, border, and advanced decoration options.
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
    Gradient? gradient,
    DecorationImage? backgroundImage,
    BlendMode? backgroundBlendMode,
    List<BoxShadow>? boxShadow,
    double? elevation,
    Color? shadowColor,
    BoxShape? shape,
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
      gradient: gradient,
      backgroundImage: backgroundImage,
      backgroundBlendMode: backgroundBlendMode,
      boxShadow: boxShadow,
      elevation: elevation,
      shadowColor: shadowColor,
      shape: shape,
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
  /// - [gradient] - Optional background gradient (ignored if [shape] is [BoxShape.circle] with custom borders)
  /// - [backgroundImage] - Optional background image
  /// - [backgroundBlendMode] - Optional blend mode applied to [backgroundImage] and [color]/[gradient]
  /// - [boxShadow] - Optional list of shadows to apply to the container
  /// - [elevation] - Optional elevation helper that generates Material-like shadows when [boxShadow] is not provided
  /// - [shadowColor] - Optional color applied to generated elevation shadows or to override [boxShadow] colors
  /// - [shape] - Optional box shape (defaults to [BoxShape.rectangle])
  /// - [child] - Optional child widget
  /// - [padding] - Optional padding
  /// - [margin] - Optional margin
  ///
  /// Returns a [SKContainer] widget with scaled border radius, border, and advanced decoration options.
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
    Gradient? gradient,
    DecorationImage? backgroundImage,
    BlendMode? backgroundBlendMode,
    List<BoxShadow>? boxShadow,
    double? elevation,
    Color? shadowColor,
    BoxShape? shape,
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
    final hasIndividualBorders =
        borderTop == true ||
        borderBottom == true ||
        borderLeft == true ||
        borderRight == true ||
        borderTopColor != null ||
        borderBottomColor != null ||
        borderLeftColor != null ||
        borderRightColor != null ||
        borderTopWidth != null ||
        borderBottomWidth != null ||
        borderLeftWidth != null ||
        borderRightWidth != null;

    Border? border;
    BorderRadius? effectiveBorderRadius = borderRadius;
    final resolvedShape = shape ?? BoxShape.rectangle;

    if (hasIndividualBorders) {
      // Use Border() constructor for individual sides
      final defaultWidth = scaledBorderWidth ?? 1.0;
      final defaultColor = borderColor ?? Colors.black;

      final topWidth =
          borderTopWidth != null
              ? _f.createWidth(borderTopWidth)
              : (borderTop == true ? defaultWidth : 0.0);
      final bottomWidth =
          borderBottomWidth != null
              ? _f.createWidth(borderBottomWidth)
              : (borderBottom == true ? defaultWidth : 0.0);
      final leftWidth =
          borderLeftWidth != null
              ? _f.createWidth(borderLeftWidth)
              : (borderLeft == true ? defaultWidth : 0.0);
      final rightWidth =
          borderRightWidth != null
              ? _f.createWidth(borderRightWidth)
              : (borderRight == true ? defaultWidth : 0.0);

      final topColor =
          borderTopColor ??
          (borderTop == true ? defaultColor : Colors.transparent);
      final bottomColor =
          borderBottomColor ??
          (borderBottom == true ? defaultColor : Colors.transparent);
      final leftColor =
          borderLeftColor ??
          (borderLeft == true ? defaultColor : Colors.transparent);
      final rightColor =
          borderRightColor ??
          (borderRight == true ? defaultColor : Colors.transparent);

      // Check if all border colors are the same
      final allColorsSame =
          topColor == bottomColor &&
          bottomColor == leftColor &&
          leftColor == rightColor;

      // Flutter doesn't allow borderRadius with non-uniform border colors
      // If borders have different colors, remove borderRadius
      if (!allColorsSame) {
        effectiveBorderRadius = null;
      }

      border = Border(
        top:
            topWidth > 0
                ? BorderSide(color: topColor, width: topWidth)
                : BorderSide.none,
        bottom:
            bottomWidth > 0
                ? BorderSide(color: bottomColor, width: bottomWidth)
                : BorderSide.none,
        left:
            leftWidth > 0
                ? BorderSide(color: leftColor, width: leftWidth)
                : BorderSide.none,
        right:
            rightWidth > 0
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

    if (resolvedShape != BoxShape.rectangle) {
      effectiveBorderRadius = null;
    }

    final resolvedShadows = _resolveBoxShadows(
      boxShadow: boxShadow,
      elevation: elevation,
      shadowColor: shadowColor,
    );

    return SKContainer(
      decoration: BoxDecoration(
        color: color,
        borderRadius: effectiveBorderRadius,
        border: border,
        gradient: gradient,
        image: backgroundImage,
        backgroundBlendMode: backgroundBlendMode,
        boxShadow: resolvedShadows,
        shape: resolvedShape,
      ),
      padding: padding,
      margin: margin,
      child: child,
    );
  }

  static List<BoxShadow>? _resolveBoxShadows({
    List<BoxShadow>? boxShadow,
    double? elevation,
    Color? shadowColor,
  }) {
    if (boxShadow != null) {
      if (shadowColor != null) {
        return boxShadow
            .map(
              (shadow) => shadow.copyWith(
                color: shadowColor.withValues(alpha: shadow.color.a),
              ),
            )
            .toList(growable: false);
      }
      return boxShadow;
    }

    if (elevation != null && elevation > 0) {
      final clampedElevation = elevation.clamp(0.0, 24.0);
      final baseShadows = kElevationToShadow[clampedElevation.round()];

      if (baseShadows != null && baseShadows.isNotEmpty) {
        if (shadowColor != null) {
          return baseShadows
              .map(
                (shadow) => shadow.copyWith(
                  color: shadowColor.withValues(alpha: shadow.color.a),
                ),
              )
              .toList(growable: false);
        }
        return baseShadows;
      }

      final defaultColor = (shadowColor ?? Colors.black).withValues(
        alpha: 0.24,
      );
      final blurRadius = _f.createWidth(clampedElevation * 1.5);
      final spreadRadius = _f.createWidth(clampedElevation * 0.1);
      final dy = _f.createWidth(clampedElevation / 2);

      return [
        BoxShadow(
          color: defaultColor,
          blurRadius: blurRadius,
          spreadRadius: spreadRadius,
          offset: Offset(0, dy),
        ),
      ];
    }

    return null;
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

  /// Creates a fully-featured [Text] widget with ALL commonly-used attributes pre-configured.
  ///
  /// This comprehensive version includes all Text widget properties for maximum flexibility.
  /// Use this when you need full control over text rendering without manually specifying
  /// every parameter.
  ///
  /// Parameters:
  /// - [data] - The text to display (required)
  /// - Style parameters: [textSize], [fontSize], [fontWeight], [fontStyle], [color], etc.
  /// - Text layout: [textAlign], [textDirection], [softWrap], [overflow], [maxLines], [minFontSize]
  /// - Accessibility: [semanticsLabel], [textScaleFactor], [textWidthBasis]
  /// - Localization: [locale]
  /// - Selection: [selectionColor]
  ///
  /// Returns a [Text] widget with scaled font size and all specified attributes.
  static Text textFull(
    String data, {
    // Text style parameters
    SKTextSize? textSize,
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
    // Text widget parameters
    TextAlign? textAlign,
    TextDirection? textDirection,
    Locale? locale,
    bool? softWrap,
    TextOverflow? overflow,
    double? textScaleFactor,
    int? maxLines,
    String? semanticsLabel,
    TextWidthBasis? textWidthBasis,
    TextHeightBehavior? textHeightBehavior,
    Color? selectionColor,
  }) {
    // Calculate scaled font size
    double finalFontSize;
    if (textSize != null) {
      finalFontSize = textSizes.get(textSize);
    } else if (fontSize != null) {
      finalFontSize = fontSize;
    } else {
      finalFontSize = defaultTextSizeValue;
    }

    // Create comprehensive text style
    final style = _f.createTextStyle(
      fontSize: finalFontSize,
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
    );

    return Text(
      data,
      style: style,
      textAlign: textAlign,
      textDirection: textDirection,
      locale: locale,
      softWrap: softWrap,
      overflow: overflow,
      textScaleFactor: textScaleFactor,
      maxLines: maxLines,
      semanticsLabel: semanticsLabel,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
      selectionColor: selectionColor,
    );
  }

  /// Creates a comprehensive [TextStyle] with ALL commonly-used attributes.
  ///
  /// This is the complete TextStyle factory with every Flutter TextStyle property.
  /// Use this when you need full styling control without creating TextStyle manually.
  ///
  /// All size-related properties ([fontSize], [letterSpacing], [wordSpacing], [height])
  /// are automatically scaled based on screen size.
  ///
  /// Parameters include: fontSize, fontWeight, fontStyle, color, backgroundColor,
  /// shadows, decoration, letterSpacing, wordSpacing, height, and more.
  ///
  /// Returns a fully-configured [TextStyle] with scaled font size.
  static TextStyle textStyleFull({
    SKTextSize? textSize,
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
    List<ui.FontFeature>? fontFeatures,
    List<ui.FontVariation>? fontVariations,
    String? debugLabel,
    TextOverflow? overflow,
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
      fontFeatures: fontFeatures,
      fontVariations: fontVariations,
      debugLabel: debugLabel,
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

  /// Resolves a responsive integer (e.g., grid columns) based on device and orientation.
  ///
  /// Fallbacks:
  /// - Device: desktop -> tablet -> mobile; tablet -> mobile
  /// - Orientation: landscape -> device portrait; tablet.landscape -> mobile.landscape -> mobile.portrait
  ///
  /// Examples:
  /// - columns(mobile: 2) => tablet=2, desktop=2
  /// - columns(mobile: 2, desktop: 8) => tablet=2, desktop=8
  /// - columns(mobile: 2, mobileLandscape: 4) => tabletLandscape=4 (if not provided)
  static int columns({
    int? mobile,
    int? tablet,
    int? desktop,
    int? mobileLandscape,
    int? tabletLandscape,
    int? desktopLandscape,
  }) {
    return responsiveInt(
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
      mobileLandscape: mobileLandscape,
      tabletLandscape: tabletLandscape,
      desktopLandscape: desktopLandscape,
    );
  }

  /// Resolves a responsive integer with the same rules as [columns],
  /// but with a generic name suitable for any integer-based config
  /// (e.g., grid columns, padding steps, itemCount, etc.).
  static int responsiveInt({
    int? mobile,
    int? tablet,
    int? desktop,
    int? mobileLandscape,
    int? tabletLandscape,
    int? desktopLandscape,
    DesktopAs desktopAs = DesktopAs.desktop,
  }) {
    final scale = ScaleManager.instance;
    final isLandscape = scale.orientation == Orientation.landscape;
    final device = _device();

    int? pickLandscape() {
      switch (device) {
        case DeviceType.desktop:
        case DeviceType.web:
          return desktopLandscape ??
              tabletLandscape ??
              mobileLandscape ??
              desktop ??
              tablet ??
              mobile;
        case DeviceType.tablet:
          return tabletLandscape ?? mobileLandscape ?? tablet ?? mobile;
        case DeviceType.mobile:
          return mobileLandscape ?? mobile;
      }
    }

    int? pickPortrait() {
      switch (device) {
        case DeviceType.desktop:
        case DeviceType.web:
          return desktop ?? tablet ?? mobile;
        case DeviceType.tablet:
          return tablet ?? mobile;
        case DeviceType.mobile:
          return mobile;
      }
    }

    if (device == DeviceType.desktop || device == DeviceType.web) {
      switch (desktopAs) {
        case DesktopAs.desktop:
          return (desktop ?? tablet ?? mobile) ?? (mobile ?? 0);
        case DesktopAs.tablet:
          if (isLandscape) {
            return (tabletLandscape ?? mobileLandscape ?? tablet ?? mobile) ??
                (mobile ?? 0);
          }
          return (tablet ?? mobile) ?? (mobile ?? 0);
        case DesktopAs.mobile:
          if (isLandscape) {
            return (mobileLandscape ?? mobile) ?? 0;
          }
          return (mobile ?? 0);
      }
    }
    final value = isLandscape ? pickLandscape() : pickPortrait();
    return value ?? (mobile ?? 0);
  }

  static DeviceType _device() {
    final w = ScaleManager.instance.screenWidth;
    if (w < 600) return DeviceType.mobile;
    if (w < 1200) return DeviceType.tablet;
    return DeviceType.desktop;
  }

  /// Resolves a responsive double value using the same fallback rules as [responsiveInt].
  static double responsiveDouble({
    double? mobile,
    double? tablet,
    double? desktop,
    double? mobileLandscape,
    double? tabletLandscape,
    double? desktopLandscape,
    DesktopAs desktopAs = DesktopAs.desktop,
  }) {
    final scale = ScaleManager.instance;
    final isLandscape = scale.orientation == Orientation.landscape;
    final device = _device();

    double? pickLandscape() {
      switch (device) {
        case DeviceType.desktop:
        case DeviceType.web:
          return desktopLandscape ??
              tabletLandscape ??
              mobileLandscape ??
              desktop ??
              tablet ??
              mobile;
        case DeviceType.tablet:
          return tabletLandscape ?? mobileLandscape ?? tablet ?? mobile;
        case DeviceType.mobile:
          return mobileLandscape ?? mobile;
      }
    }

    double? pickPortrait() {
      switch (device) {
        case DeviceType.desktop:
        case DeviceType.web:
          return desktop ?? tablet ?? mobile;
        case DeviceType.tablet:
          return tablet ?? mobile;
        case DeviceType.mobile:
          return mobile;
      }
    }

    if (device == DeviceType.desktop || device == DeviceType.web) {
      switch (desktopAs) {
        case DesktopAs.desktop:
          return (desktop ?? tablet ?? mobile) ?? (mobile ?? 0.0);
        case DesktopAs.tablet:
          if (isLandscape) {
            return (tabletLandscape ?? mobileLandscape ?? tablet ?? mobile) ??
                (mobile ?? 0.0);
          }
          return (tablet ?? mobile) ?? (mobile ?? 0.0);
        case DesktopAs.mobile:
          if (isLandscape) {
            return (mobileLandscape ?? mobile) ?? 0.0;
          }
          return (mobile ?? 0.0);
      }
    }
    final value = isLandscape ? pickLandscape() : pickPortrait();
    return value ?? (mobile ?? 0.0);
  }
}
