import 'package:flutter/material.dart';
import '../core/scale_value_factory.dart';

/// Scaled Padding widget - extends Flutter's Padding
/// Automatically applies scaling to EdgeInsets values
/// Uses cached values for optimal performance
class SKPadding extends Padding {
  static final _factory = ScaleValueFactory.instance;

  SKPadding({super.key, required EdgeInsetsGeometry padding, super.child})
    : super(padding: _factory.resolveEdgeInsets(padding));
}
