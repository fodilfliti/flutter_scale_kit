import 'package:flutter/material.dart';
import '../core/scale_value_factory.dart';

/// Scaled Icon widget - extends Flutter's Icon
/// Automatically applies scaling to icon size
/// Uses cached values for optimal performance
class SKIcon extends Icon {
  static final _factory = ScaleValueFactory.instance;

  SKIcon(
    super.icon, {
    super.key,
    double? size,
    super.color,
    super.shadows,
    super.semanticLabel,
    super.textDirection,
  }) : super(
          size: size != null ? _factory.createFontSize(size) : null,
        );
}

