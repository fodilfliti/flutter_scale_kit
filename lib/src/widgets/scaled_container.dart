import 'package:flutter/material.dart';
import '../core/scale_value_factory.dart';

/// Scaled Container widget - extends Flutter's Container
/// Automatically applies scaling to border radius, padding, margin, width, height, and constraints
/// Uses cached values for border radius and optimal performance
class SKContainer extends Container {
  static final _factory = ScaleValueFactory.instance;

  SKContainer({
    super.key,
    super.alignment,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    Decoration? decoration,
    super.foregroundDecoration,
    double? width,
    double? height,
    BoxConstraints? constraints,
    super.transform,
    super.transformAlignment,
    super.child,
    super.clipBehavior,
  }) : super(
         padding: padding != null ? _scalePadding(padding) : null,
         margin: margin != null ? _scaleMargin(margin) : null,
         decoration: decoration != null ? _scaleDecoration(decoration) : null,
         width: width != null ? _factory.createWidth(width) : null,
         height: height != null ? _factory.createHeight(height) : null,
         constraints:
             constraints != null ? _scaleConstraints(constraints) : null,
       );

  /// Scales EdgeInsetsGeometry padding values
  static EdgeInsetsGeometry _scalePadding(EdgeInsetsGeometry padding) {
    if (padding is EdgeInsets) {
      return _factory.createPadding(
        top: padding.top,
        bottom: padding.bottom,
        left: padding.left,
        right: padding.right,
      );
    } else if (padding is EdgeInsetsDirectional) {
      return _factory.createPadding(
        top: padding.top,
        bottom: padding.bottom,
        start: padding.start,
        end: padding.end,
      );
    }
    // For other EdgeInsetsGeometry types, try to extract values
    final resolved = padding.resolve(TextDirection.ltr);
    return _factory.createPadding(
      top: resolved.top,
      bottom: resolved.bottom,
      left: resolved.left,
      right: resolved.right,
    );
  }

  /// Scales EdgeInsetsGeometry margin values
  static EdgeInsetsGeometry _scaleMargin(EdgeInsetsGeometry margin) {
    if (margin is EdgeInsets) {
      return _factory.createMargin(
        top: margin.top,
        bottom: margin.bottom,
        left: margin.left,
        right: margin.right,
      );
    } else if (margin is EdgeInsetsDirectional) {
      return _factory.createMargin(
        top: margin.top,
        bottom: margin.bottom,
        start: margin.start,
        end: margin.end,
      );
    }
    // For other EdgeInsetsGeometry types, try to extract values
    final resolved = margin.resolve(TextDirection.ltr);
    return _factory.createMargin(
      top: resolved.top,
      bottom: resolved.bottom,
      left: resolved.left,
      right: resolved.right,
    );
  }

  /// Scales BoxDecoration values including border radius and box shadows
  static Decoration _scaleDecoration(Decoration decoration) {
    if (decoration is! BoxDecoration) {
      return decoration;
    }

    final boxDecoration = decoration;

    // Scale border radius using rSafe
    BorderRadius? scaledBorderRadius;
    if (boxDecoration.borderRadius != null) {
      final borderRadius = boxDecoration.borderRadius!;
      // Only scale if it's a BorderRadius (not BorderRadiusDirectional)
      if (borderRadius is BorderRadius) {
        scaledBorderRadius = _factory.createBorderRadiusSafe(
          topLeft: _extractRadiusValue(borderRadius.topLeft),
          topRight: _extractRadiusValue(borderRadius.topRight),
          bottomLeft: _extractRadiusValue(borderRadius.bottomLeft),
          bottomRight: _extractRadiusValue(borderRadius.bottomRight),
        );
      }
      // For BorderRadiusDirectional, keep as is for now
      // (could be enhanced later to handle directional radius scaling)
    }

    // Scale box shadows (blur radius and spread radius)
    List<BoxShadow>? scaledBoxShadows;
    if (boxDecoration.boxShadow != null &&
        boxDecoration.boxShadow!.isNotEmpty) {
      scaledBoxShadows =
          boxDecoration.boxShadow!.map((shadow) {
            return BoxShadow(
              color: shadow.color,
              offset: Offset(
                _factory.createWidth(shadow.offset.dx),
                _factory.createHeight(shadow.offset.dy),
              ),
              blurRadius: _factory.createRadiusSafe(shadow.blurRadius),
              spreadRadius: _factory.createRadiusSafe(shadow.spreadRadius),
            );
          }).toList();
    }

    // Scale border width if border exists
    Border? scaledBorder;
    if (boxDecoration.border != null) {
      final border = boxDecoration.border!;
      if (border is Border) {
        scaledBorder = Border(
          top:
              border.top != BorderSide.none
                  ? BorderSide(
                    color: border.top.color,
                    width: _factory.createWidth(border.top.width),
                    style: border.top.style,
                  )
                  : BorderSide.none,
          bottom:
              border.bottom != BorderSide.none
                  ? BorderSide(
                    color: border.bottom.color,
                    width: _factory.createWidth(border.bottom.width),
                    style: border.bottom.style,
                  )
                  : BorderSide.none,
          left:
              border.left != BorderSide.none
                  ? BorderSide(
                    color: border.left.color,
                    width: _factory.createWidth(border.left.width),
                    style: border.left.style,
                  )
                  : BorderSide.none,
          right:
              border.right != BorderSide.none
                  ? BorderSide(
                    color: border.right.color,
                    width: _factory.createWidth(border.right.width),
                    style: border.right.style,
                  )
                  : BorderSide.none,
        );
      }
    }

    return BoxDecoration(
      color: boxDecoration.color,
      image: boxDecoration.image,
      border: scaledBorder ?? boxDecoration.border,
      borderRadius: scaledBorderRadius ?? boxDecoration.borderRadius,
      boxShadow: scaledBoxShadows ?? boxDecoration.boxShadow,
      gradient: boxDecoration.gradient,
      backgroundBlendMode: boxDecoration.backgroundBlendMode,
      shape: boxDecoration.shape,
    );
  }

  /// Extracts the radius value from Radius
  static double _extractRadiusValue(Radius radius) {
    // For uniform radius, use x value
    if (radius.x == radius.y) {
      return radius.x;
    }
    // For elliptical radius, use average (or just x for simplicity)
    return radius.x;
  }

  /// Scales BoxConstraints values
  static BoxConstraints _scaleConstraints(BoxConstraints constraints) {
    final minWidth =
        constraints.minWidth > 0
            ? _factory.createWidth(constraints.minWidth)
            : constraints.minWidth;
    final maxWidth =
        constraints.maxWidth < double.infinity
            ? _factory.createWidth(constraints.maxWidth)
            : constraints.maxWidth;
    final minHeight =
        constraints.minHeight > 0
            ? _factory.createHeight(constraints.minHeight)
            : constraints.minHeight;
    final maxHeight =
        constraints.maxHeight < double.infinity
            ? _factory.createHeight(constraints.maxHeight)
            : constraints.maxHeight;

    return BoxConstraints(
      minWidth: minWidth,
      maxWidth: maxWidth,
      minHeight: minHeight,
      maxHeight: maxHeight,
    );
  }
}
