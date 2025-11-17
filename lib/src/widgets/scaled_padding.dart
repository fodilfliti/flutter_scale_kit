import 'package:flutter/material.dart';
import '../core/scale_value_factory.dart';

/// Scaled Padding widget - extends Flutter's Padding
/// Automatically applies scaling to EdgeInsets values
/// Uses cached values for optimal performance
class SKPadding extends Padding {
  static final _factory = ScaleValueFactory.instance;

  SKPadding({super.key, required EdgeInsetsGeometry padding, super.child})
    : super(padding: _scalePadding(padding));

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
}
