import 'package:flutter/material.dart';
import '../core/scale_manager.dart';
import '../core/font_config.dart';
import '../widgets/scale_kit_builder.dart';

/// ThemeData extensions for responsive theme configuration
extension ScaleThemeDataExtension on ThemeData {
  /// Create responsive text theme with automatic font configuration
  ///
  /// This method:
  /// 1. Scales font sizes based on device dimensions
  /// 2. Automatically applies FontConfig based on current language
  ///
  /// All TextStyles in the theme will automatically use the configured font
  /// for the current language, without needing to call `.withFontConfig()` manually.
  TextTheme createResponsiveTextTheme(
    TextTheme baseTheme, {
    String? languageCode,
  }) {
    final scaleKit = ScaleManager.instance;
    final fontConfig = FontConfig.instance;
    final lang = languageCode ?? fontConfig.currentLanguageCode;

    // Helper to apply both scaling and font config
    TextStyle? applyResponsiveStyle(TextStyle? style) {
      if (style == null) return null;

      // Scale font size
      final scaledSize =
          style.fontSize != null ? scaleKit.getFontSize(style.fontSize!) : null;

      final scaledStyle = style.copyWith(fontSize: scaledSize);

      // Apply font config (Google Fonts or custom font family)
      return fontConfig.getTextStyle(
        languageCode: lang,
        baseTextStyle: scaledStyle,
      );
    }

    return TextTheme(
      displayLarge: applyResponsiveStyle(baseTheme.displayLarge),
      displayMedium: applyResponsiveStyle(baseTheme.displayMedium),
      displaySmall: applyResponsiveStyle(baseTheme.displaySmall),
      headlineLarge: applyResponsiveStyle(baseTheme.headlineLarge),
      headlineMedium: applyResponsiveStyle(baseTheme.headlineMedium),
      headlineSmall: applyResponsiveStyle(baseTheme.headlineSmall),
      titleLarge: applyResponsiveStyle(baseTheme.titleLarge),
      titleMedium: applyResponsiveStyle(baseTheme.titleMedium),
      titleSmall: applyResponsiveStyle(baseTheme.titleSmall),
      bodyLarge: applyResponsiveStyle(baseTheme.bodyLarge),
      bodyMedium: applyResponsiveStyle(baseTheme.bodyMedium),
      bodySmall: applyResponsiveStyle(baseTheme.bodySmall),
      labelLarge: applyResponsiveStyle(baseTheme.labelLarge),
      labelMedium: applyResponsiveStyle(baseTheme.labelMedium),
      labelSmall: applyResponsiveStyle(baseTheme.labelSmall),
    );
  }

  /// Apply font configuration to existing text theme
  ///
  /// Useful when you want to update the theme after language change
  TextTheme applyFontConfig(TextTheme textTheme, {String? languageCode}) {
    final fontConfig = FontConfig.instance;
    final lang = languageCode ?? fontConfig.currentLanguageCode;

    TextStyle? applyFont(TextStyle? style) {
      if (style == null) return null;
      return fontConfig.getTextStyle(languageCode: lang, baseTextStyle: style);
    }

    return TextTheme(
      displayLarge: applyFont(textTheme.displayLarge),
      displayMedium: applyFont(textTheme.displayMedium),
      displaySmall: applyFont(textTheme.displaySmall),
      headlineLarge: applyFont(textTheme.headlineLarge),
      headlineMedium: applyFont(textTheme.headlineMedium),
      headlineSmall: applyFont(textTheme.headlineSmall),
      titleLarge: applyFont(textTheme.titleLarge),
      titleMedium: applyFont(textTheme.titleMedium),
      titleSmall: applyFont(textTheme.titleSmall),
      bodyLarge: applyFont(textTheme.bodyLarge),
      bodyMedium: applyFont(textTheme.bodyMedium),
      bodySmall: applyFont(textTheme.bodySmall),
      labelLarge: applyFont(textTheme.labelLarge),
      labelMedium: applyFont(textTheme.labelMedium),
      labelSmall: applyFont(textTheme.labelSmall),
    );
  }
}

/// Helper class for creating responsive ThemeData with automatic font configuration
///
/// This class automatically applies FontConfig to all TextStyles in the theme,
/// so all text in your app will use the correct font for the current language.
class ResponsiveThemeData {
  /// Create ThemeData with responsive text styles and automatic font configuration
  ///
  /// All TextStyles in the theme will automatically use FontConfig based on
  /// the current language. No need to call `.withFontConfig()` manually.
  ///
  /// Example:
  /// ```dart
  /// ThemeData(
  ///   textTheme: ResponsiveThemeData.createTextTheme(
  ///     context: context,
  ///     baseTextTheme: ThemeData.light().textTheme,
  ///   ),
  /// )
  /// ```
  static ThemeData create({
    required BuildContext context,
    ColorScheme? colorScheme,
    TextTheme? textTheme,
    bool useMaterial3 = true,
    double? fontSizeFactor,
    Map<String, Object>? other,
  }) {
    ScaleKitScope.watch(context);
    final baseTheme = ThemeData(
      colorScheme:
          colorScheme ?? ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: useMaterial3,
      textTheme: textTheme,
    );

    // Get current language code safely
    final languageCode = _languageCodeFromContext(context);
    FontConfig.instance.setLanguage(languageCode);

    // Apply responsive text theme with font config if provided
    if (textTheme != null) {
      final scaledTextTheme = baseTheme.createResponsiveTextTheme(
        textTheme,
        languageCode: languageCode,
      );
      return baseTheme.copyWith(textTheme: scaledTextTheme);
    }

    // If no textTheme provided, apply font config to default theme
    final defaultTextTheme = baseTheme.textTheme;
    final fontConfigTheme = baseTheme.applyFontConfig(
      defaultTextTheme,
      languageCode: languageCode,
    );

    return baseTheme.copyWith(textTheme: fontConfigTheme);
  }

  /// Create a TextTheme with automatic font configuration
  ///
  /// This is a convenience method that creates a responsive TextTheme
  /// with automatic font configuration based on current language.
  static TextTheme createTextTheme({
    required BuildContext context,
    required TextTheme baseTextTheme,
  }) {
    ScaleKitScope.watch(context);
    // Get current language code safely
    final languageCode = _languageCodeFromContext(context);
    FontConfig.instance.setLanguage(languageCode);

    final baseTheme = ThemeData(textTheme: baseTextTheme);
    return baseTheme.createResponsiveTextTheme(
      baseTextTheme,
      languageCode: languageCode,
    );
  }

  static String _languageCodeFromContext(BuildContext context) {
    final locale =
        Localizations.maybeLocaleOf(context) ??
        WidgetsBinding.instance.platformDispatcher.locale;
    return locale.languageCode;
  }
}
