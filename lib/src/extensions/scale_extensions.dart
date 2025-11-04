import '../core/scale_value_factory.dart';

/// Extension methods for easy scaling operations
/// Similar to flutter_screenutil API
extension ScaleExtension on num {
  /// Scaled width
  double get w => ScaleValueFactory.instance.createWidth(toDouble());

  /// Screen width percentage (e.g., 1.sw = full screen width)
  double get sw => ScaleValueFactory.instance.createScreenWidth(toDouble());

  /// Screen height percentage (e.g., 1.sh = full screen height)
  double get sh => ScaleValueFactory.instance.createScreenHeight(toDouble());

  /// Scaled radius/border radius
  double get r => ScaleValueFactory.instance.createRadius(toDouble());

  /// Scaled font size
  double get sp => ScaleValueFactory.instance.createFontSize(toDouble());

  /// Scaled height
  double get h => ScaleValueFactory.instance.createHeight(toDouble());

  /// Font size with system text scale factor applied
  double get spf => ScaleValueFactory.instance.createFontSizeWithFactor(toDouble());
}

