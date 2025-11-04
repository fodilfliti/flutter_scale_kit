import 'package:flutter/material.dart';

/// Scaled Padding widget - extends Flutter's Padding
/// Uses cached values and can be const when padding is const
class SKPadding extends Padding {
  const SKPadding({
    super.key,
    required super.padding,
    super.child,
  });
}

