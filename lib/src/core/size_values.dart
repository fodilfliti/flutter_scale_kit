import 'size_enums.dart';

/// Base size values configuration for consistent sizing.
///
/// This class provides default values for each size category (xs, sm, md, lg, xl, xxl).
/// Each category (padding, margin, radius, spacing) can have separate values configured
/// independently for maximum flexibility.
///
/// Example usage:
/// ```dart
/// // Use default values
/// const values = SizeValues();
///
/// // Use custom values
/// const custom = SizeValues.custom(xs: 4, sm: 8, md: 16, lg: 24, xl: 32, xxl: 48);
///
/// // Use Material 3 scale
/// const material3 = SizeValues.material3();
///
/// // Use Tailwind CSS scale
/// const tailwind = SizeValues.tailwind();
/// ```
class SizeValues {
  /// Extra small size value.
  final double xs;

  /// Small size value.
  final double sm;

  /// Medium size value.
  final double md;

  /// Large size value.
  final double lg;

  /// Extra large size value.
  final double xl;

  /// Extra extra large size value.
  final double xxl;

  /// Creates a [SizeValues] instance with default values.
  ///
  /// Default values: xs=2, sm=4, md=8, lg=12, xl=16, xxl=24
  const SizeValues({
    this.xs = 2,
    this.sm = 4,
    this.md = 8,
    this.lg = 12,
    this.xl = 16,
    this.xxl = 24,
  });

  /// Gets the value for a specific size enum.
  ///
  /// Parameters:
  /// - [size] - The [SKSize] enum value
  ///
  /// Returns the corresponding numeric value.
  double get(SKSize size) {
    switch (size) {
      case SKSize.xs:
        return xs;
      case SKSize.sm:
        return sm;
      case SKSize.md:
        return md;
      case SKSize.lg:
        return lg;
      case SKSize.xl:
        return xl;
      case SKSize.xxl:
        return xxl;
    }
  }

  /// Creates custom size values with optional parameters.
  ///
  /// Parameters not provided will use default values.
  ///
  /// Parameters:
  /// - [xs] - Extra small value (default: 2)
  /// - [sm] - Small value (default: 4)
  /// - [md] - Medium value (default: 8)
  /// - [lg] - Large value (default: 12)
  /// - [xl] - Extra large value (default: 16)
  /// - [xxl] - Extra extra large value (default: 24)
  ///
  /// Returns a [SizeValues] instance with custom values.
  factory SizeValues.custom({
    double? xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
    double? xxl,
  }) {
    return SizeValues(
      xs: xs ?? 2,
      sm: sm ?? 4,
      md: md ?? 8,
      lg: lg ?? 12,
      xl: xl ?? 16,
      xxl: xxl ?? 24,
    );
  }

  /// Creates size values based on Material Design 3 spacing scale.
  ///
  /// Returns a [SizeValues] instance with Material 3 values:
  /// xs=4, sm=8, md=12, lg=16, xl=24, xxl=32
  factory SizeValues.material3() {
    return const SizeValues(xs: 4, sm: 8, md: 12, lg: 16, xl: 24, xxl: 32);
  }

  /// Creates size values based on Tailwind CSS spacing scale.
  ///
  /// Returns a [SizeValues] instance with Tailwind values:
  /// xs=2, sm=4, md=8, lg=12, xl=16, xxl=24
  factory SizeValues.tailwind() {
    return const SizeValues(xs: 2, sm: 4, md: 8, lg: 12, xl: 16, xxl: 24);
  }
}

/// Size configuration for different categories.
///
/// This class allows users to define separate values for padding, margin,
/// radius, and spacing. Each category is optional - null means use default values.
///
/// Example usage:
/// ```dart
/// final config = SizeConfig(
///   padding: SizeValues.custom(xs: 4, sm: 8, md: 16),
///   margin: SizeValues.custom(xs: 2, sm: 4, md: 8),
///   radius: SizeValues.custom(xs: 2, sm: 4, md: 8),
/// );
/// setSizeConfig(config);
/// ```
class SizeConfig {
  /// Padding size values.
  final SizeValues? padding;

  /// Margin size values.
  final SizeValues? margin;

  /// Radius size values.
  final SizeValues? radius;

  /// Spacing size values.
  final SizeValues? spacing;

  /// Creates a [SizeConfig] with optional category values.
  ///
  /// Parameters:
  /// - [padding] - Optional padding size values
  /// - [margin] - Optional margin size values
  /// - [radius] - Optional radius size values
  /// - [spacing] - Optional spacing size values
  const SizeConfig({this.padding, this.margin, this.radius, this.spacing});

  /// Creates a custom size configuration.
  ///
  /// Parameters:
  /// - [padding] - Optional padding size values
  /// - [margin] - Optional margin size values
  /// - [radius] - Optional radius size values
  /// - [spacing] - Optional spacing size values
  ///
  /// Returns a [SizeConfig] instance.
  factory SizeConfig.custom({
    SizeValues? padding,
    SizeValues? margin,
    SizeValues? radius,
    SizeValues? spacing,
  }) {
    return SizeConfig(
      padding: padding,
      margin: margin,
      radius: radius,
      spacing: spacing,
    );
  }
}

/// Text size values configuration.
///
/// This class provides default values for common text sizes (6-52 pixels).
/// Users can customize these values globally to match their design system.
///
/// Example usage:
/// ```dart
/// // Use default values
/// const values = TextSizeValues();
///
/// // Use custom values
/// const custom = TextSizeValues.custom(s14: 15, s16: 17, s18: 20);
/// ```
class TextSizeValues {
  /// Text size value for s6 (6px).
  final double s6;

  /// Text size value for s8 (8px).
  final double s8;

  /// Text size value for s10 (10px).
  final double s10;

  /// Text size value for s11 (11px).
  final double s11;

  /// Text size value for s12 (12px).
  final double s12;

  /// Text size value for s13 (13px).
  final double s13;

  /// Text size value for s14 (14px).
  final double s14;

  /// Text size value for s15 (15px).
  final double s15;

  /// Text size value for s16 (16px).
  final double s16;

  /// Text size value for s17 (17px).
  final double s17;

  /// Text size value for s18 (18px).
  final double s18;

  /// Text size value for s20 (20px).
  final double s20;

  /// Text size value for s22 (22px).
  final double s22;

  /// Text size value for s24 (24px).
  final double s24;

  /// Text size value for s26 (26px).
  final double s26;

  /// Text size value for s28 (28px).
  final double s28;

  /// Text size value for s30 (30px).
  final double s30;

  /// Text size value for s32 (32px).
  final double s32;

  /// Text size value for s34 (34px).
  final double s34;

  /// Text size value for s36 (36px).
  final double s36;

  /// Text size value for s40 (40px).
  final double s40;

  /// Text size value for s48 (48px).
  final double s48;

  /// Text size value for s52 (52px).
  final double s52;

  /// Creates a [TextSizeValues] instance with default values.
  ///
  /// Default values match the enum names (s6=6, s8=8, etc.).
  const TextSizeValues({
    this.s6 = 6,
    this.s8 = 8,
    this.s10 = 10,
    this.s11 = 11,
    this.s12 = 12,
    this.s13 = 13,
    this.s14 = 14,
    this.s15 = 15,
    this.s16 = 16,
    this.s17 = 17,
    this.s18 = 18,
    this.s20 = 20,
    this.s22 = 22,
    this.s24 = 24,
    this.s26 = 26,
    this.s28 = 28,
    this.s30 = 30,
    this.s32 = 32,
    this.s34 = 34,
    this.s36 = 36,
    this.s40 = 40,
    this.s48 = 48,
    this.s52 = 52,
  });

  /// Gets the value for a specific text size enum.
  ///
  /// Parameters:
  /// - [size] - The [SKTextSize] enum value
  ///
  /// Returns the corresponding numeric value.
  double get(SKTextSize size) {
    switch (size) {
      case SKTextSize.s6:
        return s6;
      case SKTextSize.s8:
        return s8;
      case SKTextSize.s10:
        return s10;
      case SKTextSize.s11:
        return s11;
      case SKTextSize.s12:
        return s12;
      case SKTextSize.s13:
        return s13;
      case SKTextSize.s14:
        return s14;
      case SKTextSize.s15:
        return s15;
      case SKTextSize.s16:
        return s16;
      case SKTextSize.s17:
        return s17;
      case SKTextSize.s18:
        return s18;
      case SKTextSize.s20:
        return s20;
      case SKTextSize.s22:
        return s22;
      case SKTextSize.s24:
        return s24;
      case SKTextSize.s26:
        return s26;
      case SKTextSize.s28:
        return s28;
      case SKTextSize.s30:
        return s30;
      case SKTextSize.s32:
        return s32;
      case SKTextSize.s34:
        return s34;
      case SKTextSize.s36:
        return s36;
      case SKTextSize.s40:
        return s40;
      case SKTextSize.s48:
        return s48;
      case SKTextSize.s52:
        return s52;
    }
  }

  /// Creates custom text size values with optional parameters.
  ///
  /// Parameters not provided will use default values.
  ///
  /// Returns a [TextSizeValues] instance with custom values.
  factory TextSizeValues.custom({
    double? s6,
    double? s8,
    double? s10,
    double? s11,
    double? s12,
    double? s13,
    double? s14,
    double? s15,
    double? s16,
    double? s17,
    double? s18,
    double? s20,
    double? s22,
    double? s24,
    double? s26,
    double? s28,
    double? s30,
    double? s32,
    double? s34,
    double? s36,
    double? s40,
    double? s48,
    double? s52,
  }) {
    return TextSizeValues(
      s6: s6 ?? 6,
      s8: s8 ?? 8,
      s10: s10 ?? 10,
      s11: s11 ?? 11,
      s12: s12 ?? 12,
      s13: s13 ?? 13,
      s14: s14 ?? 14,
      s15: s15 ?? 15,
      s16: s16 ?? 16,
      s17: s17 ?? 17,
      s18: s18 ?? 18,
      s20: s20 ?? 20,
      s22: s22 ?? 22,
      s24: s24 ?? 24,
      s26: s26 ?? 26,
      s28: s28 ?? 28,
      s30: s30 ?? 30,
      s32: s32 ?? 32,
      s34: s34 ?? 34,
      s36: s36 ?? 36,
      s40: s40 ?? 40,
      s48: s48 ?? 48,
      s52: s52 ?? 52,
    );
  }

  /// Creates text size values based on Material Design 3 text scale.
  ///
  /// Returns a [TextSizeValues] instance with Material 3 values.
  factory TextSizeValues.material3() {
    return const TextSizeValues(
      s6: 6,
      s8: 8,
      s10: 10,
      s11: 11,
      s12: 12,
      s13: 13,
      s14: 14,
      s15: 15,
      s16: 16,
      s17: 17,
      s18: 18,
      s20: 20,
      s22: 22,
      s24: 24,
      s26: 26,
      s28: 28,
      s30: 30,
      s32: 32,
      s34: 34,
      s36: 36,
      s40: 40,
      s48: 48,
      s52: 52,
    );
  }
}
