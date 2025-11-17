import 'package:flutter/widgets.dart';

import '../core/scale_value_factory.dart';
import '../widgets/spacing_widgets.dart';

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

  /// Horizontal space widget using scaled width.
  ///
  /// Mirrors `horizontalSpace` from flutter_screenutil.
  Widget get horizontalSpace => HSpace(w);

  /// Vertical space widget using scaled height.
  ///
  /// Mirrors `verticalSpace` from flutter_screenutil.
  Widget get verticalSpace => VSpace(h);

  /// Scaled width with maximum constraint (cached).
  ///
  /// Example: `200.wMax(300)` returns scaled width clamped to max 300.
  double wMax(double max) => _f.createWidthMax(toDouble(), max);

  /// Scaled width with minimum constraint (cached).
  ///
  /// Example: `200.wMin(100)` returns scaled width clamped to min 100.
  double wMin(double min) => _f.createWidthMin(toDouble(), min);

  /// Scaled width with clamp constraint (cached).
  ///
  /// Example: `200.wClamp(100, 300)` returns scaled width clamped between 100 and 300.
  double wClamp(double min, double max) =>
      _f.createWidthClamp(toDouble(), min, max);

  /// Scaled height with maximum constraint (cached).
  ///
  /// Example: `100.hMax(150)` returns scaled height clamped to max 150.
  double hMax(double max) => _f.createHeightMax(toDouble(), max);

  /// Scaled height with minimum constraint (cached).
  ///
  /// Example: `100.hMin(50)` returns scaled height clamped to min 50.
  double hMin(double min) => _f.createHeightMin(toDouble(), min);

  /// Scaled height with clamp constraint (cached).
  ///
  /// Example: `100.hClamp(50, 150)` returns scaled height clamped between 50 and 150.
  double hClamp(double min, double max) =>
      _f.createHeightClamp(toDouble(), min, max);

  /// Screen width percentage with maximum constraint (cached).
  ///
  /// Example: `0.5.swMax(200)` returns 50% screen width clamped to max 200.
  double swMax(double max) => _f.createScreenWidthMax(toDouble(), max);

  /// Screen width percentage with minimum constraint (cached).
  ///
  /// Example: `0.5.swMin(100)` returns 50% screen width clamped to min 100.
  double swMin(double min) => _f.createScreenWidthMin(toDouble(), min);

  /// Screen width percentage with clamp constraint (cached).
  ///
  /// Example: `0.5.swClamp(100, 200)` returns 50% screen width clamped between 100 and 200.
  double swClamp(double min, double max) =>
      _f.createScreenWidthClamp(toDouble(), min, max);

  /// Screen height percentage with maximum constraint (cached).
  ///
  /// Example: `0.3.shMax(150)` returns 30% screen height clamped to max 150.
  double shMax(double max) => _f.createScreenHeightMax(toDouble(), max);

  /// Screen height percentage with minimum constraint (cached).
  ///
  /// Example: `0.3.shMin(80)` returns 30% screen height clamped to min 80.
  double shMin(double min) => _f.createScreenHeightMin(toDouble(), min);

  /// Screen height percentage with clamp constraint (cached).
  ///
  /// Example: `0.3.shClamp(80, 150)` returns 30% screen height clamped between 80 and 150.
  double shClamp(double min, double max) =>
      _f.createScreenHeightClamp(toDouble(), min, max);

  /// Scaled radius with maximum constraint (cached).
  ///
  /// Example: `12.rMax(20)` returns scaled radius clamped to max 20.
  double rMax(double max) => _f.createRadiusMax(toDouble(), max);

  /// Scaled radius with minimum constraint (cached).
  ///
  /// Example: `12.rMin(8)` returns scaled radius clamped to min 8.
  double rMin(double min) => _f.createRadiusMin(toDouble(), min);

  /// Scaled radius with clamp constraint (cached).
  ///
  /// Example: `12.rClamp(8, 20)` returns scaled radius clamped between 8 and 20.
  double rClamp(double min, double max) =>
      _f.createRadiusClamp(toDouble(), min, max);

  /// Scaled font size with maximum constraint (cached).
  ///
  /// Example: `16.spMax(24)` returns scaled font size clamped to max 24.
  double spMax(double max) => _f.createFontSizeMax(toDouble(), max);

  /// Scaled font size with minimum constraint (cached).
  ///
  /// Example: `16.spMin(12)` returns scaled font size clamped to min 12.
  double spMin(double min) => _f.createFontSizeMin(toDouble(), min);

  /// Scaled font size with clamp constraint (cached).
  ///
  /// Example: `16.spClamp(12, 24)` returns scaled font size clamped between 12 and 24.
  double spClamp(double min, double max) =>
      _f.createFontSizeClamp(toDouble(), min, max);
}

extension EdgeInsetsScaleExtensions on EdgeInsets {
  EdgeInsets _scale(double Function(double) scaler) {
    return EdgeInsets.only(
      left: scaler(left),
      right: scaler(right),
      top: scaler(top),
      bottom: scaler(bottom),
    );
  }

  EdgeInsets get w => _scale(ScaleValueFactory.instance.createWidth);

  EdgeInsets get h => _scale(ScaleValueFactory.instance.createHeight);

  EdgeInsets get r => _scale(ScaleValueFactory.instance.createRadius);
}

extension EdgeInsetsDirectionalScaleExtensions on EdgeInsetsDirectional {
  EdgeInsetsDirectional _scale(double Function(double) scaler) {
    return EdgeInsetsDirectional.only(
      start: scaler(start),
      end: scaler(end),
      top: scaler(top),
      bottom: scaler(bottom),
    );
  }

  EdgeInsetsDirectional get w => _scale(ScaleValueFactory.instance.createWidth);

  EdgeInsetsDirectional get h =>
      _scale(ScaleValueFactory.instance.createHeight);

  EdgeInsetsDirectional get r =>
      _scale(ScaleValueFactory.instance.createRadius);
}

extension BoxConstraintsScaleExtensions on BoxConstraints {
  static double _scaleDimension(double value, double Function(double) scaler) {
    if (value == double.infinity || value == double.negativeInfinity) {
      return value;
    }
    return scaler(value);
  }

  BoxConstraints get w {
    final scaler = ScaleValueFactory.instance.createWidth;
    return copyWith(
      minWidth: _scaleDimension(minWidth, scaler),
      maxWidth: _scaleDimension(maxWidth, scaler),
      minHeight: _scaleDimension(minHeight, scaler),
      maxHeight: _scaleDimension(maxHeight, scaler),
    );
  }

  BoxConstraints get h {
    final scaler = ScaleValueFactory.instance.createHeight;
    return copyWith(
      minWidth: _scaleDimension(minWidth, scaler),
      maxWidth: _scaleDimension(maxWidth, scaler),
      minHeight: _scaleDimension(minHeight, scaler),
      maxHeight: _scaleDimension(maxHeight, scaler),
    );
  }

  BoxConstraints get r {
    final scaler = ScaleValueFactory.instance.createRadius;
    return copyWith(
      minWidth: _scaleDimension(minWidth, scaler),
      maxWidth: _scaleDimension(maxWidth, scaler),
      minHeight: _scaleDimension(minHeight, scaler),
      maxHeight: _scaleDimension(maxHeight, scaler),
    );
  }
}

extension RadiusScaleExtensions on Radius {
  Radius _scale({
    required double Function(double) scaleX,
    required double Function(double) scaleY,
  }) {
    return Radius.elliptical(scaleX(x), scaleY(y));
  }

  Radius get w => _scale(
    scaleX: ScaleValueFactory.instance.createWidth,
    scaleY: ScaleValueFactory.instance.createWidth,
  );

  Radius get h => _scale(
    scaleX: ScaleValueFactory.instance.createHeight,
    scaleY: ScaleValueFactory.instance.createHeight,
  );

  Radius get r => _scale(
    scaleX: ScaleValueFactory.instance.createRadius,
    scaleY: ScaleValueFactory.instance.createRadius,
  );
}

extension BorderRadiusScaleExtensions on BorderRadius {
  BorderRadius _scale(Radius Function(Radius) scaler) {
    return BorderRadius.only(
      topLeft: scaler(topLeft),
      topRight: scaler(topRight),
      bottomLeft: scaler(bottomLeft),
      bottomRight: scaler(bottomRight),
    );
  }

  BorderRadius get w => _scale((radius) => radius.w);

  BorderRadius get h => _scale((radius) => radius.h);

  BorderRadius get r => _scale((radius) => radius.r);
}
