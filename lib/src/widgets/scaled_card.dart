import 'package:flutter/material.dart';
import '../core/scale_value_factory.dart';

/// Scaled Card widget - extends Flutter's Card
/// Automatically applies scaling to margin, elevation, and shape borderRadius
/// Uses cached values for optimal performance
class SKCard extends Card {
  static final _factory = ScaleValueFactory.instance;

  SKCard({
    super.key,
    super.child,
    super.color,
    super.shadowColor,
    double? elevation,
    EdgeInsetsGeometry? margin,
    ShapeBorder? shape,
    super.semanticContainer,
  }) : super(
         elevation: elevation != null ? _factory.resolveWidth(elevation) : null,
         margin: margin != null ? _factory.resolveEdgeInsets(margin) : null,
         shape: shape != null ? _scaleShape(shape) : null,
       );

  /// Scales ShapeBorder (primarily RoundedRectangleBorder)
  static ShapeBorder _scaleShape(ShapeBorder shape) {
    if (shape is RoundedRectangleBorder) {
      final borderRadius = shape.borderRadius;
      return RoundedRectangleBorder(
        borderRadius:
            borderRadius is BorderRadius
                ? BorderRadius.only(
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
                )
                : borderRadius,
        side: shape.side,
      );
    }
    // For other shape types, return as-is
    return shape;
  }

  /// Extracts the radius value from Radius
  static double _extractRadiusValue(Radius radius) {
    if (radius.x == radius.y) {
      return radius.x;
    }
    return radius.x;
  }
}
