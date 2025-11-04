import 'package:flutter/material.dart';
import '../core/scale_value_factory.dart';

/// Const-compatible scaled padding widget
/// Pre-calculated values stored in const-compatible structures
class ConstScaledPadding extends Padding {
  const ConstScaledPadding({
    super.key,
    required super.padding,
    super.child,
  });
}

/// Const-compatible scaled margin widget
class ConstScaledMargin extends Container {
  ConstScaledMargin({
    super.key,
    required EdgeInsetsGeometry margin,
    super.child,
  }) : super(margin: margin);
}

/// Factory for creating const-compatible widgets
class ConstWidgetFactory {
  /// Create const padding widget
  static ConstScaledPadding createPadding({
    double? all,
    double? horizontal,
    double? vertical,
    double? top,
    double? bottom,
    double? left,
    double? right,
    Widget? child,
  }) {
    final padding = ScaleValueFactory.instance.createPadding(
      all: all,
      horizontal: horizontal,
      vertical: vertical,
      top: top,
      bottom: bottom,
      left: left,
      right: right,
    );

    return ConstScaledPadding(
      padding: padding,
      child: child,
    );
  }

  /// Create const margin widget
  static ConstScaledMargin createMargin({
    double? all,
    double? horizontal,
    double? vertical,
    double? top,
    double? bottom,
    double? left,
    double? right,
    Widget? child,
  }) {
    final margin = ScaleValueFactory.instance.createMargin(
      all: all,
      horizontal: horizontal,
      vertical: vertical,
      top: top,
      bottom: bottom,
      left: left,
      right: right,
    );

    return ConstScaledMargin(
      margin: margin,
      child: child,
    );
  }

  /// Create container with const border radius
  static Container createRoundedContainer({
    double? all,
    double? topLeft,
    double? topRight,
    double? bottomLeft,
    double? bottomRight,
    Color? color,
    Widget? child,
  }) {
    final borderRadius = ScaleValueFactory.instance.createBorderRadius(
      all: all,
      topLeft: topLeft,
      topRight: topRight,
      bottomLeft: bottomLeft,
      bottomRight: bottomRight,
    );

    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: borderRadius,
      ),
      child: child,
    );
  }
}

