import 'package:flutter/material.dart';
import 'device_detector.dart';
import 'scale_manager.dart';

/// Aspect ratio adapter for handling different device aspect ratios
/// Provides smart scaling based on device characteristics
///
/// This class contains only static methods and has no public constructor.
class AspectRatioAdapter {
  /// Private constructor to prevent instantiation
  AspectRatioAdapter._();

  /// Get appropriate scale factor based on aspect ratio
  static double getScaleFactor({
    required double screenWidth,
    required double screenHeight,
    required double designWidth,
    required double designHeight,
    required DeviceType deviceType,
  }) {
    final aspectCategory = DeviceDetector.getAspectRatioCategory(
      screenWidth,
      screenHeight,
    );

    final scaleWidth = screenWidth / designWidth;
    final scaleHeight = screenHeight / designHeight;

    switch (aspectCategory) {
      case AspectRatioCategory.narrow:
        // Narrow/tall devices: width-based with compensation
        return scaleWidth * 0.95;

      case AspectRatioCategory.wide:
        // Wide/short devices: height-based with compensation
        return scaleHeight * 0.98;

      case AspectRatioCategory.standard:
        // Standard devices: use device-type specific logic
        return _getStandardScaleFactor(
          scaleWidth: scaleWidth,
          scaleHeight: scaleHeight,
          screenWidth: screenWidth,
          screenHeight: screenHeight,
          deviceType: deviceType,
          designWidth: designWidth,
        );
    }
  }

  /// Get scale factor for standard aspect ratio devices
  static double _getStandardScaleFactor({
    required double scaleWidth,
    required double scaleHeight,
    required double screenWidth,
    required double screenHeight,
    required DeviceType deviceType,
    required double designWidth,
  }) {
    switch (deviceType) {
      case DeviceType.mobile:
        // Mobile: prefer width-based
        return scaleWidth;

      case DeviceType.tablet:
        // Tablet: balanced scaling based on aspect ratio
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
        } else if (screenWidth >= 1440) {
          return scaleWidth.clamp(0.5, 1.8);
        } else {
          return scaleWidth.clamp(0.5, 1.5);
        }
    }
  }

  /// Get font scale factor based on aspect ratio and device type
  static double getFontScaleFactor({
    required double scaleFactor,
    required AspectRatioCategory aspectCategory,
    required DeviceType deviceType,
  }) {
    switch (deviceType) {
      case DeviceType.tablet:
        return scaleFactor * 1.05; // 5% larger for readability

      case DeviceType.mobile:
        switch (aspectCategory) {
          case AspectRatioCategory.narrow:
            return scaleFactor * 1.02; // Slightly larger for tall screens
          case AspectRatioCategory.wide:
            return scaleFactor * 0.98; // Slightly smaller for wide screens
          case AspectRatioCategory.standard:
            return scaleFactor;
        }

      case DeviceType.desktop:
      case DeviceType.web:
        return scaleFactor;
    }
  }

  /// Detect if device is in foldable state (narrow)
  static bool isFoldableClosed(double screenWidth, double aspectRatio) {
    return screenWidth < 400 && aspectRatio < 0.6;
  }

  /// Detect if device is in foldable state (unfolded)
  static bool isFoldableOpen(double screenWidth, double aspectRatio) {
    return screenWidth >= 800 || aspectRatio > 1.8;
  }

  /// Detect significant size change (for foldable transitions)
  static bool hasSignificantSizeChange(Size previousSize, Size currentSize) {
    final widthChange = (currentSize.width - previousSize.width).abs();
    final heightChange = (currentSize.height - previousSize.height).abs();

    return widthChange > previousSize.width * 0.5 ||
        heightChange > previousSize.height * 0.5;
  }
}
