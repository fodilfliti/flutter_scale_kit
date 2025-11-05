import 'package:flutter/material.dart';

/// Function type for Google Fonts (e.g., GoogleFonts.inter, GoogleFonts.almarai)
/// This matches the signature of Google Fonts functions which take a TextStyle
/// and return a TextStyle with the font applied
typedef GoogleFontFunction = TextStyle Function({TextStyle? textStyle});

/// Font configuration for a specific language
class LanguageFontConfig {
  /// Language code (e.g., 'ar', 'en', 'fr', 'bn')
  final String languageCode;

  /// Google Font function (e.g., GoogleFonts.inter, GoogleFonts.almarai)
  /// or null to use custom font family
  final GoogleFontFunction? googleFont;

  /// Custom font family name (used when googleFont is null)
  final String? customFontFamily;

  const LanguageFontConfig({
    required this.languageCode,
    this.googleFont,
    this.customFontFamily,
  }) : assert(
         googleFont != null || customFontFamily != null,
         'Either googleFont or customFontFamily must be provided',
       );
}

/// Font configuration for a language group (multiple languages sharing the same font)
class LanguageGroupFontConfig {
  /// List of language codes in this group (e.g., ['ar', 'fa', 'ur'])
  final List<String> languageCodes;

  /// Google Font function (e.g., GoogleFonts.inter, GoogleFonts.almarai)
  /// or null to use custom font family
  final GoogleFontFunction? googleFont;

  /// Custom font family name (used when googleFont is null)
  final String? customFontFamily;

  const LanguageGroupFontConfig({
    required this.languageCodes,
    this.googleFont,
    this.customFontFamily,
  }) : assert(
         googleFont != null || customFontFamily != null,
         'Either googleFont or customFontFamily must be provided',
       );
}

/// Global font configuration manager
///
/// This class manages font families for different languages and language groups.
/// It automatically applies the correct font when language changes.
///
/// Example usage:
/// ```dart
/// // Configure font for specific language
/// FontConfig.instance.setLanguageFont(
///   LanguageFontConfig(
///     languageCode: 'ar',
///     googleFont: GoogleFonts.almarai,
///   ),
/// );
///
/// // Configure font for language group
/// FontConfig.instance.setLanguageGroupFont(
///   LanguageGroupFontConfig(
///     languageCodes: ['ar', 'fa', 'ur'],
///     googleFont: GoogleFonts.almarai,
///   ),
/// );
///
/// // Set default font
/// FontConfig.instance.setDefaultFont(
///   googleFont: GoogleFonts.inter,
/// );
/// ```
class FontConfig {
  static FontConfig? _instance;
  static FontConfig get instance => _instance ??= FontConfig._internal();

  FontConfig._internal();

  /// Map of individual language font configurations
  /// Key: language code, Value: font configuration
  final Map<String, LanguageFontConfig> _languageFonts = {};

  /// List of language group font configurations
  final List<LanguageGroupFontConfig> _languageGroupFonts = [];

  /// Default Google Font function
  GoogleFontFunction? _defaultGoogleFont;

  /// Default custom font family
  String? _defaultCustomFontFamily;

  /// Current language code (updated when language changes)
  String _currentLanguageCode = 'en';

  /// Callback to notify listeners when font configuration changes
  VoidCallback? onLanguageChanged;

  /// Set current language code
  void setLanguage(String languageCode) {
    if (_currentLanguageCode != languageCode) {
      _currentLanguageCode = languageCode;
      onLanguageChanged?.call();
    }
  }

  /// Get current language code
  String get currentLanguageCode => _currentLanguageCode;

  /// Get font configuration for a specific language code
  /// Returns the font configuration if found, or null to use default
  LanguageFontConfig? _getLanguageFontConfig(String languageCode) {
    // First, check individual language configuration
    if (_languageFonts.containsKey(languageCode)) {
      return _languageFonts[languageCode];
    }

    // Then, check language groups
    for (final group in _languageGroupFonts) {
      if (group.languageCodes.contains(languageCode)) {
        return LanguageFontConfig(
          languageCode: languageCode,
          googleFont: group.googleFont,
          customFontFamily: group.customFontFamily,
        );
      }
    }

    // Return null if no configuration found (will use default)
    return null;
  }

  /// Get Google Font function for a specific language code
  /// Returns the Google Font function configured for this language, or default
  GoogleFontFunction? getGoogleFont(String? languageCode) {
    final lang = languageCode ?? _currentLanguageCode;
    final config = _getLanguageFontConfig(lang);
    return config?.googleFont ?? _defaultGoogleFont;
  }

  /// Get custom font family for a specific language code
  /// Returns the custom font family configured for this language, or default
  String? getCustomFontFamily(String? languageCode) {
    final lang = languageCode ?? _currentLanguageCode;
    final config = _getLanguageFontConfig(lang);
    return config?.customFontFamily ?? _defaultCustomFontFamily;
  }

  /// Check if a language uses Google Fonts
  bool usesGoogleFont(String? languageCode) {
    final lang = languageCode ?? _currentLanguageCode;
    final config = _getLanguageFontConfig(lang);
    if (config != null) {
      return config.googleFont != null;
    }
    return _defaultGoogleFont != null;
  }

  /// Get TextStyle with the appropriate font for a language code
  TextStyle getTextStyle({
    String? languageCode,
    required TextStyle baseTextStyle,
  }) {
    final lang = languageCode ?? _currentLanguageCode;
    final googleFont = getGoogleFont(lang);
    final customFontFamily = getCustomFontFamily(lang);

    if (googleFont != null) {
      // Apply Google Font (pass textStyle parameter)
      return googleFont(textStyle: baseTextStyle);
    } else if (customFontFamily != null) {
      // Apply custom font family
      return baseTextStyle.copyWith(fontFamily: customFontFamily);
    } else {
      // No font configuration, return base style as-is (uses Flutter default font)
      // This ensures the app works even if user doesn't configure any fonts
      return baseTextStyle;
    }
  }

  /// Configure font for a specific language
  void setLanguageFont(LanguageFontConfig config) {
    _languageFonts[config.languageCode] = config;
  }

  /// Configure font for a language group
  void setLanguageGroupFont(LanguageGroupFontConfig config) {
    _languageGroupFonts.add(config);
  }

  /// Set default font using Google Font
  void setDefaultFont({
    GoogleFontFunction? googleFont,
    String? customFontFamily,
  }) {
    assert(
      googleFont != null || customFontFamily != null,
      'Either googleFont or customFontFamily must be provided',
    );
    _defaultGoogleFont = googleFont;
    _defaultCustomFontFamily = customFontFamily;
  }

  /// Configure multiple languages at once
  void setLanguagesFonts(List<LanguageFontConfig> configs) {
    for (final config in configs) {
      _languageFonts[config.languageCode] = config;
    }
  }

  /// Configure multiple language groups at once
  void setLanguageGroupsFonts(List<LanguageGroupFontConfig> configs) {
    _languageGroupFonts.clear();
    _languageGroupFonts.addAll(configs);
  }

  /// Clear all configurations
  void clear() {
    _languageFonts.clear();
    _languageGroupFonts.clear();
    _defaultGoogleFont = null;
    _defaultCustomFontFamily = null;
    _currentLanguageCode = 'en';
  }

  /// Clear only language-specific configurations (keep default)
  void clearLanguageConfigs() {
    _languageFonts.clear();
    _languageGroupFonts.clear();
  }
}
