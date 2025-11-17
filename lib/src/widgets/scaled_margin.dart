import 'package:flutter/material.dart';
import '../core/scale_value_factory.dart';

/// Scaled Margin widget - extends Flutter's Container
/// Automatically applies scaling to EdgeInsets values
/// Uses cached values for optimal performance
class SKMargin extends Container {
  static final _factory = ScaleValueFactory.instance;

  SKMargin({super.key, required EdgeInsetsGeometry margin, super.child})
    : super(margin: _scaleMargin(margin));

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
}
