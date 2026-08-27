import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import '../core/scale_value_factory.dart';

/// Scaled Switch widget - extends Flutter's Switch
/// Automatically applies scaling to splashRadius
/// Uses cached values for optimal performance
class SKSwitch extends Switch {
  static final _factory = ScaleValueFactory.instance;

  SKSwitch({
    super.key,
    required super.value,
    required super.onChanged,
    Color? activeColor,
    Color? activeThumbColor,
    super.activeTrackColor,
    super.inactiveThumbColor,
    super.inactiveTrackColor,
    super.activeThumbImage,
    super.inactiveThumbImage,
    WidgetStateProperty<Color?>? thumbColor,
    super.trackColor,
    super.trackOutlineColor,
    super.overlayColor,
    double? splashRadius,
    super.focusColor,
    super.hoverColor,
    super.autofocus = false,
    super.focusNode,
    DragStartBehavior? dragStartBehavior,
  }) : super(
         thumbColor:
             thumbColor ??
             _selectedThumbColor(activeThumbColor ?? activeColor),
         splashRadius:
             splashRadius != null
                 ? _factory.resolveRadiusSafe(splashRadius)
                 : null,
         dragStartBehavior: dragStartBehavior ?? DragStartBehavior.start,
       );
}

/// Scaled SwitchListTile widget - extends Flutter's SwitchListTile
/// Automatically applies scaling to contentPadding, minLeadingWidth, minVerticalPadding, and splashRadius
/// Uses cached values for optimal performance
class SKSwitchListTile extends SwitchListTile {
  static final _factory = ScaleValueFactory.instance;

  SKSwitchListTile({
    super.key,
    required super.value,
    required super.onChanged,
    super.title,
    super.subtitle,
    super.secondary,
    super.isThreeLine,
    super.dense,
    super.shape,
    EdgeInsetsGeometry? contentPadding,
    super.selected,
    Color? activeColor,
    Color? activeThumbColor,
    super.activeTrackColor,
    super.inactiveThumbColor,
    super.inactiveTrackColor,
    super.tileColor,
    super.selectedTileColor,
    WidgetStateProperty<Color?>? thumbColor,
    super.trackColor,
    super.trackOutlineColor,
    super.activeThumbImage,
    super.inactiveThumbImage,
    super.focusNode,
    super.autofocus,
    double? splashRadius,
    DragStartBehavior? dragStartBehavior,
    super.materialTapTargetSize,
    super.visualDensity,
  }) : super(
         thumbColor:
             thumbColor ??
             _selectedThumbColor(activeThumbColor ?? activeColor),
         contentPadding:
             contentPadding != null
                 ? _factory.resolveEdgeInsets(contentPadding)
                 : null,
         splashRadius:
             splashRadius != null
                 ? _factory.resolveRadiusSafe(splashRadius)
                 : null,
         dragStartBehavior: dragStartBehavior ?? DragStartBehavior.start,
       );
}

WidgetStateProperty<Color?>? _selectedThumbColor(Color? color) {
  if (color == null) {
    return null;
  }
  return WidgetStateProperty.resolveWith((states) {
    if (states.contains(WidgetState.selected)) {
      return color;
    }
    return null;
  });
}
