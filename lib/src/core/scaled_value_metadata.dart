import 'cache_key.dart';

/// Metadata describing how a numeric value was scaled.
class SKScaledValueMetadata {
  final ScaleType scaleType;

  const SKScaledValueMetadata(this.scaleType);

  bool matchesDomain(SKValueDomain domain) {
    switch (domain) {
      case SKValueDomain.width:
        return switch (scaleType) {
          ScaleType.width ||
          ScaleType.widthMax ||
          ScaleType.widthMin ||
          ScaleType.widthClamp ||
          ScaleType.screenWidth ||
          ScaleType.screenWidthMax ||
          ScaleType.screenWidthMin ||
          ScaleType.screenWidthClamp => true,
          _ => false,
        };
      case SKValueDomain.height:
        return switch (scaleType) {
          ScaleType.height ||
          ScaleType.heightMax ||
          ScaleType.heightMin ||
          ScaleType.heightClamp ||
          ScaleType.screenHeight ||
          ScaleType.screenHeightMax ||
          ScaleType.screenHeightMin ||
          ScaleType.screenHeightClamp => true,
          _ => false,
        };
      case SKValueDomain.radius:
        return switch (scaleType) {
          ScaleType.radius ||
          ScaleType.radiusSafe ||
          ScaleType.radiusFixed ||
          ScaleType.radiusMax ||
          ScaleType.radiusMin ||
          ScaleType.radiusClamp => true,
          _ => false,
        };
      case SKValueDomain.fontSize:
        return switch (scaleType) {
          ScaleType.fontSize ||
          ScaleType.fontSizeWithFactor ||
          ScaleType.fontSizeMax ||
          ScaleType.fontSizeMin ||
          ScaleType.fontSizeClamp => true,
          _ => false,
        };
    }
  }
}

/// Domain of a scaled numeric value (width, height, radius, or font size).
enum SKValueDomain { width, height, radius, fontSize }

/// Tracks metadata for scaled numeric values using [Expando].
class SKScaledValueTracker {
  static final Expando<SKScaledValueMetadata>? _metadata =
      _supportsExpando
          ? Expando<SKScaledValueMetadata>('sk_scaled_value_metadata')
          : null;

  /// Associates [value] with a [ScaleType] so widgets can detect pre-scaled numbers.
  static double mark(double value, ScaleType scaleType) {
    final metadata = _metadata;
    if (metadata != null) {
      metadata[value] = SKScaledValueMetadata(scaleType);
    }
    return value;
  }

  static SKScaledValueMetadata? metadata(Object? value) {
    final metadata = _metadata;
    if (metadata == null || value == null) return null;
    return metadata[value];
  }

  static bool matches(Object? value, SKValueDomain domain) {
    final meta = metadata(value);
    if (meta == null) return false;
    return meta.matchesDomain(domain);
  }

  static bool get _supportsExpando => !_isWebLike;

  static bool get _isWebLike => identical(0, 0.0);
}
