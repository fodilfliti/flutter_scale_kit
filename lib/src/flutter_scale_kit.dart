import 'package:flutter/material.dart';
import 'scale_config.dart';

/// Main class for Flutter Scale Kit
/// Provides responsive design utilities
class FlutterScaleKit {
  /// Initialize ScaleConfig with custom design dimensions
  static ScaleConfig init({
    required BuildContext context,
    double? designWidth,
    double? designHeight,
    double? minScale,
    double? maxScale,
  }) {
    return ScaleConfig(
      context: context,
      designWidth: designWidth,
      designHeight: designHeight,
      minScale: minScale ?? 0.5,
      maxScale: maxScale ?? 2.0,
    );
  }

  /// Get default ScaleConfig
  static ScaleConfig of(BuildContext context) {
    return ScaleConfig(context: context);
  }
}

