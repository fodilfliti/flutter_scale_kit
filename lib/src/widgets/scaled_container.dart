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
         padding: padding != null ? _factory.resolveEdgeInsets(padding) : null,
         margin: margin != null ? _factory.resolveEdgeInsets(margin) : null,
         decoration: decoration != null ? _scaleDecoration(decoration) : null,
         width: width != null ? _factory.resolveWidth(width) : null,
         height: height != null ? _factory.resolveHeight(height) : null,
         constraints:
             constraints != null
                 ? _factory.resolveBoxConstraints(constraints)
                 : null,
       );

  /// Scales BoxDecoration values including border radius and box shadows
  static Decoration _scaleDecoration(Decoration decoration) {
    if (decoration is! BoxDecoration) {
      return decoration;
    }

    final boxDecoration = decoration;

    // Scale border radius using rSafe with metadata awareness
    BorderRadius? scaledBorderRadius;
    if (boxDecoration.borderRadius != null) {
      final borderRadius = boxDecoration.borderRadius!;
      // Only scale if it's a BorderRadius (not BorderRadiusDirectional)
      if (borderRadius is BorderRadius) {
        scaledBorderRadius = BorderRadius.only(
          topLeft: Radius.circular(
            _factory.resolveRadiusSafe(
              _extractRadiusValue(borderRadius.topLeft),
            ),
          ),
          topRight: Radius.circular(
            _factory.resolveRadiusSafe(
              _extractRadiusValue(borderRadius.topRight),
            ),
          ),
          bottomLeft: Radius.circular(
            _factory.resolveRadiusSafe(
              _extractRadiusValue(borderRadius.bottomLeft),
            ),
          ),
          bottomRight: Radius.circular(
            _factory.resolveRadiusSafe(
              _extractRadiusValue(borderRadius.bottomRight),
            ),
          ),
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
                _factory.resolveWidth(shadow.offset.dx),
                _factory.resolveHeight(shadow.offset.dy),
              ),
              blurRadius: _factory.resolveRadiusSafe(shadow.blurRadius),
              spreadRadius: _factory.resolveRadiusSafe(shadow.spreadRadius),
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
                    width: _factory.resolveWidth(border.top.width),
                    style: border.top.style,
                  )
                  : BorderSide.none,
          bottom:
              border.bottom != BorderSide.none
                  ? BorderSide(
                    color: border.bottom.color,
                    width: _factory.resolveWidth(border.bottom.width),
                    style: border.bottom.style,
                  )
                  : BorderSide.none,
          left:
              border.left != BorderSide.none
                  ? BorderSide(
                    color: border.left.color,
                    width: _factory.resolveWidth(border.left.width),
                    style: border.left.style,
                  )
                  : BorderSide.none,
          right:
              border.right != BorderSide.none
                  ? BorderSide(
                    color: border.right.color,
                    width: _factory.resolveWidth(border.right.width),
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
}
