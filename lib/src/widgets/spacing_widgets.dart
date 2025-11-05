import 'package:flutter/material.dart';

/// Scaled SizedBox widget - extends Flutter's SizedBox
/// Uses cached values and can be const when size is const
class SKSizedBox extends SizedBox {
  const SKSizedBox({super.key, super.width, super.height, super.child});
}

/// Horizontal spacing widget - short name for convenience
/// Usage: HSpace(16) for horizontal spacing
class HSpace extends SizedBox {
  /// Creates a horizontal spacing widget
  ///
  /// [width] is the width of the horizontal space in logical pixels.
  const HSpace(double width, {super.key}) : super(width: width);
}

/// Vertical spacing widget - short name for convenience
/// Usage: VSpace(16) for vertical spacing
class VSpace extends SizedBox {
  const VSpace(double height, {super.key}) : super(height: height);
}

/// Square spacing widget - short name for convenience
/// Usage: SSpace(16) for both width and height
class SSpace extends SizedBox {
  const SSpace(double size, {super.key}) : super(width: size, height: size);
}
