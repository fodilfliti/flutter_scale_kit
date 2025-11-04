import 'package:flutter/material.dart';
import 'scale_manager.dart';
import 'device_detector.dart';

/// Scaling strategy calculator
/// Determines appropriate scaling strategy based on device characteristics
class ScalingStrategy {
  /// Select scaling strategy based on device characteristics
  static ScalingStrategyType selectStrategy({
    required double screenWidth,
    required double screenHeight,
    required DeviceType deviceType,
    required Orientation orientation,
  }) {
    final aspectCategory = DeviceDetector.getAspectRatioCategory(
      screenWidth,
      screenHeight,
    );

    switch (aspectCategory) {
      case AspectRatioCategory.narrow:
        return ScalingStrategyType.narrow;
      case AspectRatioCategory.wide:
        return ScalingStrategyType.wide;
      case AspectRatioCategory.standard:
        return ScalingStrategyType.standard;
    }
  }

  /// Calculate scale factor based on strategy
  static double calculateScaleFactor({
    required double screenWidth,
    required double screenHeight,
    required double designWidth,
    required double designHeight,
    required ScalingStrategyType strategy,
    required DeviceType deviceType,
  }) {
    final scaleWidth = screenWidth / designWidth;
    final scaleHeight = screenHeight / designHeight;

    switch (strategy) {
      case ScalingStrategyType.narrow:
        // Narrow/tall devices: width-based with compensation
        return scaleWidth * 0.95;

      case ScalingStrategyType.wide:
        // Wide/short devices: height-based with compensation
        return scaleHeight * 0.98;

      case ScalingStrategyType.standard:
        // Standard devices: balanced scaling
        switch (deviceType) {
          case DeviceType.mobile:
            // Mobile: prefer width-based
            return scaleWidth;
          case DeviceType.tablet:
            // Tablet: balanced
            final aspectRatio = screenWidth / screenHeight;
            if (aspectRatio >= 1.3 && aspectRatio <= 1.5) {
              // iPad-like (4:3)
              return (scaleWidth * 0.7 + scaleHeight * 0.3);
            } else if (aspectRatio >= 1.5 && aspectRatio <= 1.8) {
              // Android tablet-like (16:10)
              return (scaleWidth * 0.6 + scaleHeight * 0.4);
            } else {
              // Square or other
              return (scaleWidth + scaleHeight) / 2;
            }
          case DeviceType.desktop:
          case DeviceType.web:
            // Desktop: constrained scaling
            if (screenWidth >= 1920) {
              return (1920 / designWidth).clamp(0.5, 2.0);
            } else {
              return scaleWidth.clamp(0.5, 1.8);
            }
        }
    }
  }

  /// Calculate font scale factor
  static double calculateFontScaleFactor({
    required double scaleFactor,
    required ScalingStrategyType strategy,
    required DeviceType deviceType,
  }) {
    switch (deviceType) {
      case DeviceType.tablet:
        return scaleFactor * 1.05; // 5% larger for readability
      case DeviceType.mobile:
        switch (strategy) {
          case ScalingStrategyType.narrow:
            return scaleFactor * 1.02; // Slightly larger for tall screens
          case ScalingStrategyType.wide:
            return scaleFactor * 0.98; // Slightly smaller for wide screens
          case ScalingStrategyType.standard:
            return scaleFactor;
        }
      case DeviceType.desktop:
      case DeviceType.web:
        return scaleFactor;
    }
  }
}

/// Scaling strategy type enum
enum ScalingStrategyType {
  narrow, // Too tall devices
  wide, // Too wide devices
  standard, // Normal devices
}

