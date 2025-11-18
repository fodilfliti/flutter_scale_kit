import 'package:flutter/material.dart';
import '../core/scale_value_factory.dart';

/// Scaled Margin widget - extends Flutter's Container
/// Automatically applies scaling to EdgeInsets values
/// Uses cached values for optimal performance
class SKMargin extends Container {
  static final _factory = ScaleValueFactory.instance;

  SKMargin({super.key, required EdgeInsetsGeometry margin, super.child})
    : super(margin: _factory.resolveEdgeInsets(margin));
}
