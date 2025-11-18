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

/// Tracks metadata for scaled numeric values.
/// Uses Map-based tracking for all platforms to ensure FFI compatibility.
/// This avoids attaching Expando metadata to values, which FFI APIs reject.
class SKScaledValueTracker {
  // Use Map-based tracking for ALL platforms (not just web/Wasm)
  // This ensures returned values are always clean and FFI-compatible
  // We use rounded string keys to handle floating-point precision issues
  static final Map<String, Set<ScaleType>> _scaledValues = {};

  /// Creates a completely new double instance that's guaranteed to be separate.
  /// This ensures FFI compatibility (e.g., for GoogleFonts, SizedBox).
  /// The value is tracked separately using Map-based approach, not attached to the value itself.
  static double _createCleanDouble(double value) {
    // Use arithmetic operations that force creation of a new double instance.
    // Multiplying by 1.0 and adding 0.0 ensures we get a new computation result.
    final result = (value * 1.0) + 0.0;

    // Double-check: if the result is identical to the original (shouldn't happen but be safe),
    // use string parsing as a fallback to guarantee a new instance.
    if (identical(result, value)) {
      // Fallback: use high-precision string conversion to ensure new instance
      return double.parse(value.toStringAsFixed(15));
    }
    return result;
  }

  /// Associates [value] with a [ScaleType] so widgets can detect pre-scaled numbers.
  /// Returns a new double instance to ensure FFI compatibility (e.g., for GoogleFonts, SizedBox).
  ///
  /// Uses Map-based tracking (not Expando) to ensure the returned value is always clean
  /// and can be safely passed to FFI APIs without any metadata attached.
  static double mark(double value, ScaleType scaleType) {
    // Create a completely new double instance using arithmetic operations.
    // This ensures we have a truly independent instance that can be safely used with FFI
    // APIs like GoogleFonts and Flutter widgets (SizedBox, etc.)
    final cleanValue = _createCleanDouble(value);

    // Track the value using Map-based approach (not Expando) to keep it clean for FFI
    final key = _valueKey(cleanValue);
    _scaledValues.putIfAbsent(key, () => <ScaleType>{}).add(scaleType);

    return cleanValue;
  }

  static SKScaledValueMetadata? metadata(Object? value) {
    if (value == null) return null;

    // Use Map-based tracking for all platforms
    final key = _valueKey(value);
    final scaleTypes = _scaledValues[key];
    if (scaleTypes == null || scaleTypes.isEmpty) return null;
    // Return metadata with the first scale type found
    // (in practice, a value should only have one scale type, but we handle multiple)
    return SKScaledValueMetadata(scaleTypes.first);
  }

  static bool matches(Object? value, SKValueDomain domain) {
    final meta = metadata(value);
    if (meta == null) return false;
    return meta.matchesDomain(domain);
  }

  /// Extracts a clean double value for use with FFI APIs (e.g., GoogleFonts, SizedBox).
  /// This creates a new double instance that's guaranteed to be FFI-compatible.
  ///
  /// This method is primarily for explicit use when needed, as [mark] already
  /// returns clean values. Use this if you need to ensure a value is clean
  /// after it's been marked.
  static double toCleanDouble(double value) {
    // Always create a new instance to ensure FFI compatibility
    // Even if the value isn't marked, creating a new instance is safe and ensures
    // compatibility with all FFI-based APIs
    return _createCleanDouble(value);
  }

  /// Creates a string key for a value, rounding to handle floating-point precision.
  /// This ensures that values like 120.0 and 120.0000001 are treated as the same.
  static String _valueKey(Object value) {
    if (value is num) {
      // Round to 6 decimal places to handle floating-point precision issues
      return value.toDouble().toStringAsFixed(6);
    }
    return value.toString();
  }

  /// Clears the scaled values cache. Useful for testing or memory management.
  static void clearCache() {
    _scaledValues.clear();
  }
}
