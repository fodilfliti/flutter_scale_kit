import 'package:flutter/material.dart';
import 'scale_manager.dart';

/// Device detector utility
/// Detects device type based on screen dimensions
class DeviceDetector {
  /// Detect device type from screen width
  static DeviceType detectDeviceType(double screenWidth) {
    if (screenWidth < 600) {
      return DeviceType.mobile;
    } else if (screenWidth < 1200) {
      return DeviceType.tablet;
    } else {
      return DeviceType.desktop;
    }
  }

  /// Detect device type from context
  static DeviceType detectFromContext(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return detectDeviceType(size.width);
  }

  /// Check if device is mobile
  static bool isMobile(double screenWidth) {
    return screenWidth < 600;
  }

  /// Check if device is tablet
  static bool isTablet(double screenWidth) {
    return screenWidth >= 600 && screenWidth < 1200;
  }

  /// Check if device is desktop
  static bool isDesktop(double screenWidth) {
    return screenWidth >= 1200;
  }

  /// Get aspect ratio category
  static AspectRatioCategory getAspectRatioCategory(
    double screenWidth,
    double screenHeight,
  ) {
    final aspectRatio = screenWidth / screenHeight;

    if (aspectRatio < 0.5 || screenHeight > screenWidth * 2.5) {
      return AspectRatioCategory.narrow; // Too tall
    } else if (aspectRatio > 2.0 || screenWidth > screenHeight * 2.5) {
      return AspectRatioCategory.wide; // Too wide
    } else {
      return AspectRatioCategory.standard; // Normal
    }
  }
}

/// Aspect ratio category enum
enum AspectRatioCategory {
  narrow, // Too tall devices
  wide, // Too wide devices
  standard, // Normal aspect ratio devices
}

