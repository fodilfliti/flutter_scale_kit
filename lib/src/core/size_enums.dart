/// Size enum for predefined sizes used throughout the app.
///
/// This enum provides a consistent way to define sizes for padding,
/// margin, radius, and spacing. The actual values can be customized
/// using [SizeValues] configuration.
///
/// Example usage:
/// ```dart
/// SKit.paddingSize(all: SKSize.md)
/// SKit.roundedContainerSize(all: SKSize.lg)
/// ```
enum SKSize {
  /// Extra small size.
  xs,

  /// Small size.
  sm,

  /// Medium size.
  md,

  /// Large size.
  lg,

  /// Extra large size.
  xl,

  /// Extra extra large size.
  xxl,
}

/// Text size enum with comprehensive font sizes.
///
/// This enum provides predefined text sizes from 6 to 52 pixels,
/// covering common text sizes used in Flutter apps. The values are
/// based on Material Design typography scale and common patterns.
///
/// Example usage:
/// ```dart
/// SKit.text('Hello', textSize: SKTextSize.s16)
/// SKit.textStyle(textSize: SKTextSize.s24)
/// ```
enum SKTextSize {
  /// 6px - Very tiny labels.
  s6,

  /// 8px - Tiny labels.
  s8,

  /// 10px - Small labels.
  s10,

  /// 11px - Small labels.
  s11,

  /// 12px - Body small, captions.
  s12,

  /// 13px - Body small.
  s13,

  /// 14px - Body medium (default).
  s14,

  /// 15px - Body medium.
  s15,

  /// 16px - Body large.
  s16,

  /// 17px - Body large.
  s17,

  /// 18px - Subheadline.
  s18,

  /// 20px - Headline small.
  s20,

  /// 22px - Headline medium.
  s22,

  /// 24px - Headline large.
  s24,

  /// 26px - Display small.
  s26,

  /// 28px - Display medium.
  s28,

  /// 30px - Display large.
  s30,

  /// 32px - Display extra large.
  s32,

  /// 34px - Hero text.
  s34,

  /// 36px - Hero text.
  s36,

  /// 40px - Hero text.
  s40,

  /// 48px - Hero text.
  s48,

  /// 52px - Hero text.
  s52,
}
