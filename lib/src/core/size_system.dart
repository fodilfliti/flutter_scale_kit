// Size system - global configuration and functions
// Enums and value classes are in separate files
import 'size_values.dart';

// Global size values for each category (can be null for defaults)
SizeValues? _globalPaddingValues;
SizeValues? _globalMarginValues;
SizeValues? _globalRadiusValues;
SizeValues? _globalSpacingValues;

// Default single values for each category (can be null)
double? _defaultPaddingValue;
double? _defaultMarginValue;
double? _defaultRadiusValue;
double? _defaultSpacingValue;

// Default values fallback
const SizeValues _defaultSizeValues = SizeValues();

/// Get padding size values (returns default if not set)
SizeValues get paddingSizes => _globalPaddingValues ?? _defaultSizeValues;

/// Get margin size values (returns default if not set)
SizeValues get marginSizes => _globalMarginValues ?? _defaultSizeValues;

/// Get radius size values (returns default if not set)
SizeValues get radiusSizes => _globalRadiusValues ?? _defaultSizeValues;

/// Get spacing size values (returns default if not set)
SizeValues get spacingSizes => _globalSpacingValues ?? _defaultSizeValues;

/// Get current size values (for backward compatibility - uses padding)
SizeValues get sizeValues => paddingSizes;

/// Get default padding value (returns default if not set)
double get defaultPaddingValue => _defaultPaddingValue ?? 16.0;

/// Get default margin value (returns default if not set)
double get defaultMarginValue => _defaultMarginValue ?? 8.0;

/// Get default radius value (returns default if not set)
double get defaultRadiusValue => _defaultRadiusValue ?? 12.0;

/// Get default spacing value (returns default if not set)
double get defaultSpacingValue => _defaultSpacingValue ?? 8.0;

/// Set custom size values for padding (null to reset to default)
void setPaddingSizes(SizeValues? values) {
  _globalPaddingValues = values;
}

/// Set default padding value (used when SKit.pad() is called without parameters)
void setDefaultPadding(double? value) {
  _defaultPaddingValue = value;
}

/// Set custom size values for margin (null to reset to default)
void setMarginSizes(SizeValues? values) {
  _globalMarginValues = values;
}

/// Set default margin value (used when SKit.margin() is called without parameters)
void setDefaultMargin(double? value) {
  _defaultMarginValue = value;
}

/// Set custom size values for radius (null to reset to default)
void setRadiusSizes(SizeValues? values) {
  _globalRadiusValues = values;
}

/// Set default radius value (used when SKit.rounded() is called without parameters)
void setDefaultRadius(double? value) {
  _defaultRadiusValue = value;
}

/// Set custom size values for spacing (null to reset to default)
void setSpacingSizes(SizeValues? values) {
  _globalSpacingValues = values;
}

/// Set default spacing value (used when SKit.h() or SKit.v() is called without parameters)
void setDefaultSpacing(double? value) {
  _defaultSpacingValue = value;
}

/// Set all size values at once (null values are ignored)
void setSizeConfig(SizeConfig config) {
  if (config.padding != null) _globalPaddingValues = config.padding;
  if (config.margin != null) _globalMarginValues = config.margin;
  if (config.radius != null) _globalRadiusValues = config.radius;
  if (config.spacing != null) _globalSpacingValues = config.spacing;
}

/// Set custom size values globally (for backward compatibility)
/// Sets all categories to the same values
void setSizeValues(SizeValues values) {
  _globalPaddingValues = values;
  _globalMarginValues = values;
  _globalRadiusValues = values;
  _globalSpacingValues = values;
}

// Global text size values (can be null for defaults)
TextSizeValues? _globalTextSizeValues;

// Default single value for text size
double? _defaultTextSizeValue;

// Default text size values fallback
const TextSizeValues _defaultTextSizeValues = TextSizeValues();

/// Get text size values (returns default if not set)
TextSizeValues get textSizes => _globalTextSizeValues ?? _defaultTextSizeValues;

/// Get default text size value (returns default if not set)
double get defaultTextSizeValue => _defaultTextSizeValue ?? 14.0;

/// Set custom text size values (null to reset to default)
void setTextSizes(TextSizeValues? values) {
  _globalTextSizeValues = values;
}

/// Set default text size value (used when SKit.textSize() is called without parameters)
void setDefaultTextSize(double? value) {
  _defaultTextSizeValue = value;
}

/// Reset all size values to defaults (null)
void resetSizeValues() {
  _globalPaddingValues = null;
  _globalMarginValues = null;
  _globalRadiusValues = null;
  _globalSpacingValues = null;
  _globalTextSizeValues = null;
  _defaultPaddingValue = null;
  _defaultMarginValue = null;
  _defaultRadiusValue = null;
  _defaultSpacingValue = null;
  _defaultTextSizeValue = null;
}
