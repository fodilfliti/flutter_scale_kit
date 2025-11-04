import 'package:flutter/material.dart';
import 'scale_value_cache.dart';

/// Factory pattern for creating cached scaled values
/// Provides a clean API for creating scaled dimensions
class ScaleValueFactory {
  static ScaleValueFactory? _instance;
  static ScaleValueFactory get instance => _instance ??= ScaleValueFactory._();
  
  ScaleValueFactory._();

  final _cache = ScaleValueCache.instance;

  /// Create scaled width
  double createWidth(double width) {
    return _cache.getWidth(width);
  }

  /// Create scaled height
  double createHeight(double height) {
    return _cache.getHeight(height);
  }

  /// Create scaled font size
  double createFontSize(double fontSize) {
    return _cache.getFontSize(fontSize);
  }

  /// Create scaled font size with system text scale factor
  double createFontSizeWithFactor(double fontSize) {
    return _cache.getFontSizeWithFactor(fontSize);
  }

  /// Create scaled radius
  double createRadius(double radius) {
    return _cache.getRadius(radius);
  }

  /// Create screen width percentage
  double createScreenWidth(double percentage) {
    return _cache.getScreenWidth(percentage);
  }

  /// Create screen height percentage
  double createScreenHeight(double percentage) {
    return _cache.getScreenHeight(percentage);
  }

  /// Create responsive padding
  EdgeInsets createPadding({
    double? all,
    double? horizontal,
    double? vertical,
    double? top,
    double? bottom,
    double? left,
    double? right,
  }) {
    return _cache.getPadding(
      all: all,
      horizontal: horizontal,
      vertical: vertical,
      top: top,
      bottom: bottom,
      left: left,
      right: right,
    );
  }

  /// Create responsive margin
  EdgeInsets createMargin({
    double? all,
    double? horizontal,
    double? vertical,
    double? top,
    double? bottom,
    double? left,
    double? right,
  }) {
    return _cache.getMargin(
      all: all,
      horizontal: horizontal,
      vertical: vertical,
      top: top,
      bottom: bottom,
      left: left,
      right: right,
    );
  }

  /// Create responsive border radius
  BorderRadius createBorderRadius({
    double? all,
    double? topLeft,
    double? topRight,
    double? bottomLeft,
    double? bottomRight,
  }) {
    return _cache.getBorderRadius(
      all: all,
      topLeft: topLeft,
      topRight: topRight,
      bottomLeft: bottomLeft,
      bottomRight: bottomRight,
    );
  }
}

