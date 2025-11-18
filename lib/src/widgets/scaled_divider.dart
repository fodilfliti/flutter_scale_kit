import 'package:flutter/material.dart';
import '../core/scale_value_factory.dart';

/// Scaled Divider widget - extends Flutter's Divider
/// Automatically applies scaling to thickness, indent, endIndent, and height
/// Uses cached values for optimal performance
class SKDivider extends Divider {
  static final _factory = ScaleValueFactory.instance;

  SKDivider({
    super.key,
    double? height,
    double? thickness,
    double? indent,
    double? endIndent,
    super.color,
  }) : super(
         height: height != null ? _factory.resolveHeight(height) : null,
         thickness: thickness != null ? _factory.resolveWidth(thickness) : null,
         indent: indent != null ? _factory.resolveWidth(indent) : null,
         endIndent: endIndent != null ? _factory.resolveWidth(endIndent) : null,
       );
}
