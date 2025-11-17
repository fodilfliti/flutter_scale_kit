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
          elevation:
              elevation != null ? _factory.createWidth(elevation) : null,
          margin: margin != null ? _scaleMargin(margin) : null,
          shape: shape != null ? _scaleShape(shape) : null,
        );

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

  /// Scales ShapeBorder (primarily RoundedRectangleBorder)
  static ShapeBorder _scaleShape(ShapeBorder shape) {
    if (shape is RoundedRectangleBorder) {
      final borderRadius = shape.borderRadius;
      return RoundedRectangleBorder(
        borderRadius: borderRadius is BorderRadius
            ? _factory.createBorderRadiusSafe(
                topLeft: _extractRadiusValue(borderRadius.topLeft),
                topRight: _extractRadiusValue(borderRadius.topRight),
                bottomLeft: _extractRadiusValue(borderRadius.bottomLeft),
                bottomRight: _extractRadiusValue(borderRadius.bottomRight),
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

