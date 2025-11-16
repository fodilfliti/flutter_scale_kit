/// Cache key for storing scaled values
class CacheKey {
  final Object value;
  final ScaleType scaleType;
  final String deviceId; // device type + orientation + aspect ratio category

  CacheKey({
    required this.value,
    required this.scaleType,
    required this.deviceId,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CacheKey &&
        other.value == value &&
        other.scaleType == scaleType &&
        other.deviceId == deviceId;
  }

  @override
  int get hashCode => Object.hash(value, scaleType, deviceId);
}

/// Scale type enum for different scaling operations
enum ScaleType {
  width,
  height,
  fontSize,
  fontSizeWithFactor,
  radius,
  radiusSafe,
  radiusFixed,
  screenWidth,
  screenHeight,
  padding,
  margin,
  borderRadius,
  borderRadiusSafe,
  borderRadiusFixed,
  widthMax,
  widthMin,
  widthClamp,
  heightMax,
  heightMin,
  heightClamp,
  screenWidthMax,
  screenWidthMin,
  screenWidthClamp,
  screenHeightMax,
  screenHeightMin,
  screenHeightClamp,
  radiusMax,
  radiusMin,
  radiusClamp,
  fontSizeMax,
  fontSizeMin,
  fontSizeClamp,
}
