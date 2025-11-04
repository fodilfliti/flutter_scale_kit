import 'package:flutter/material.dart';

/// Scaled Margin widget - extends Flutter's Container
/// Uses cached values for optimal performance
class SKMargin extends Container {
  SKMargin({
    super.key,
    required EdgeInsetsGeometry margin,
    super.child,
  }) : super(margin: margin);
}

