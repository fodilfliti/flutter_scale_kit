import 'package:flutter/material.dart';

/// Scaled Container widget - extends Flutter's Container
/// Uses cached values for border radius and optimal performance
class SKContainer extends Container {
  SKContainer({
    super.key,
    super.alignment,
    super.padding,
    super.margin,
    super.decoration,
    super.foregroundDecoration,
    super.width,
    super.height,
    super.constraints,
    super.transform,
    super.transformAlignment,
    super.child,
    super.clipBehavior,
  });
}
