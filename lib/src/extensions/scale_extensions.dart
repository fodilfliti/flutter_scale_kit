import '../core/scale_value_factory.dart';

/// Extension methods for easy scaling operations
/// Similar to flutter_screenutil API
extension ScaleExtension on num {
  // Short alias for faster access - using getter to cache reference
  static final ScaleValueFactory _f = ScaleValueFactory.instance;

  /// Scaled width
  double get w => _f.createWidth(toDouble());

  /// Screen width percentage (e.g., 1.sw = full screen width)
  double get sw => _f.createScreenWidth(toDouble());

  /// Screen height percentage (e.g., 1.sh = full screen height)
  double get sh => _f.createScreenHeight(toDouble());

  /// Fully responsive radius/border radius (best for pills, avatars, circles).
  double get r => _f.createRadius(toDouble());

  /// Scaled radius with gentle clamping to avoid overly round corners (recommended default).
  double get rSafe => _f.createRadiusSafe(toDouble());

  /// Fixed radius (no scaling, still cached)
  double get rFixed => _f.createFixedRadius(toDouble());

  /// Scaled font size
  double get sp => _f.createFontSize(toDouble());

  /// Scaled height
  double get h => _f.createHeight(toDouble());

  /// Font size with system text scale factor applied
  double get spf => _f.createFontSizeWithFactor(toDouble());
}
