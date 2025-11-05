import 'package:flutter/material.dart';
import '../core/font_config.dart';

/// Extension on TextStyle to apply font configuration based on current language
extension TextStyleFontConfigExtension on TextStyle {
  /// Apply font configuration for a specific language code
  ///
  /// If languageCode is null, uses the current language from FontConfig
  ///
  /// Example:
  /// ```dart
  /// TextStyle(
  ///   fontSize: 16,
  ///   fontWeight: FontWeight.w500,
  /// ).withFontConfig(languageCode: 'ar')
  /// ```
  TextStyle withFontConfig({String? languageCode}) {
    return FontConfig.instance.getTextStyle(
      languageCode: languageCode,
      baseTextStyle: this,
    );
  }
}

/// Extension on BuildContext to easily access font configuration
extension FontConfigContextExtension on BuildContext {
  /// Get FontConfig instance
  FontConfig get fontConfig => FontConfig.instance;

  /// Get current language code (safely, with fallback)
  String get languageCode {
    try {
      return Localizations.localeOf(this).languageCode;
    } catch (e) {
      // Localizations not available, return default
      return 'en';
    }
  }

  /// Apply font configuration to a TextStyle based on current language
  TextStyle applyFontConfig(TextStyle textStyle) {
    return FontConfig.instance.getTextStyle(
      languageCode: languageCode,
      baseTextStyle: textStyle,
    );
  }
}
