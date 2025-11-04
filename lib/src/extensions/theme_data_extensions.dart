import 'package:flutter/material.dart';
import '../core/scale_manager.dart';

/// ThemeData extensions for responsive theme configuration
extension ScaleThemeDataExtension on ThemeData {
  /// Create responsive text theme
  TextTheme createResponsiveTextTheme(TextTheme baseTheme) {
    final scaleKit = ScaleManager.instance;

    return TextTheme(
      displayLarge: baseTheme.displayLarge?.copyWith(
        fontSize:
            baseTheme.displayLarge!.fontSize != null
                ? scaleKit.getFontSize(baseTheme.displayLarge!.fontSize!)
                : null,
      ),
      displayMedium: baseTheme.displayMedium?.copyWith(
        fontSize:
            baseTheme.displayMedium!.fontSize != null
                ? scaleKit.getFontSize(baseTheme.displayMedium!.fontSize!)
                : null,
      ),
      displaySmall: baseTheme.displaySmall?.copyWith(
        fontSize:
            baseTheme.displaySmall!.fontSize != null
                ? scaleKit.getFontSize(baseTheme.displaySmall!.fontSize!)
                : null,
      ),
      headlineLarge: baseTheme.headlineLarge?.copyWith(
        fontSize:
            baseTheme.headlineLarge!.fontSize != null
                ? scaleKit.getFontSize(baseTheme.headlineLarge!.fontSize!)
                : null,
      ),
      headlineMedium: baseTheme.headlineMedium?.copyWith(
        fontSize:
            baseTheme.headlineMedium!.fontSize != null
                ? scaleKit.getFontSize(baseTheme.headlineMedium!.fontSize!)
                : null,
      ),
      headlineSmall: baseTheme.headlineSmall?.copyWith(
        fontSize:
            baseTheme.headlineSmall!.fontSize != null
                ? scaleKit.getFontSize(baseTheme.headlineSmall!.fontSize!)
                : null,
      ),
      titleLarge: baseTheme.titleLarge?.copyWith(
        fontSize:
            baseTheme.titleLarge!.fontSize != null
                ? scaleKit.getFontSize(baseTheme.titleLarge!.fontSize!)
                : null,
      ),
      titleMedium: baseTheme.titleMedium?.copyWith(
        fontSize:
            baseTheme.titleMedium!.fontSize != null
                ? scaleKit.getFontSize(baseTheme.titleMedium!.fontSize!)
                : null,
      ),
      titleSmall: baseTheme.titleSmall?.copyWith(
        fontSize:
            baseTheme.titleSmall!.fontSize != null
                ? scaleKit.getFontSize(baseTheme.titleSmall!.fontSize!)
                : null,
      ),
      bodyLarge: baseTheme.bodyLarge?.copyWith(
        fontSize:
            baseTheme.bodyLarge!.fontSize != null
                ? scaleKit.getFontSize(baseTheme.bodyLarge!.fontSize!)
                : null,
      ),
      bodyMedium: baseTheme.bodyMedium?.copyWith(
        fontSize:
            baseTheme.bodyMedium!.fontSize != null
                ? scaleKit.getFontSize(baseTheme.bodyMedium!.fontSize!)
                : null,
      ),
      bodySmall: baseTheme.bodySmall?.copyWith(
        fontSize:
            baseTheme.bodySmall!.fontSize != null
                ? scaleKit.getFontSize(baseTheme.bodySmall!.fontSize!)
                : null,
      ),
      labelLarge: baseTheme.labelLarge?.copyWith(
        fontSize:
            baseTheme.labelLarge!.fontSize != null
                ? scaleKit.getFontSize(baseTheme.labelLarge!.fontSize!)
                : null,
      ),
      labelMedium: baseTheme.labelMedium?.copyWith(
        fontSize:
            baseTheme.labelMedium!.fontSize != null
                ? scaleKit.getFontSize(baseTheme.labelMedium!.fontSize!)
                : null,
      ),
      labelSmall: baseTheme.labelSmall?.copyWith(
        fontSize:
            baseTheme.labelSmall!.fontSize != null
                ? scaleKit.getFontSize(baseTheme.labelSmall!.fontSize!)
                : null,
      ),
    );
  }
}

/// Helper class for creating responsive ThemeData
class ResponsiveThemeData {
  /// Create ThemeData with responsive text styles
  static ThemeData create({
    required BuildContext context,
    ColorScheme? colorScheme,
    TextTheme? textTheme,
    bool useMaterial3 = true,
    double? fontSizeFactor,
    Map<String, Object>? other,
  }) {
    final baseTheme = ThemeData(
      colorScheme:
          colorScheme ?? ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: useMaterial3,
      textTheme: textTheme,
    );

    // Scale text theme if provided
    if (textTheme != null) {
      final scaledTextTheme = baseTheme.createResponsiveTextTheme(textTheme);
      return baseTheme.copyWith(textTheme: scaledTextTheme);
    }

    return baseTheme;
  }
}
