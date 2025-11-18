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
    super.activeColor,
    super.activeTrackColor,
    super.inactiveThumbColor,
    super.inactiveTrackColor,
    super.activeThumbImage,
    super.inactiveThumbImage,
    super.thumbColor,
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
    super.activeColor,
    super.activeTrackColor,
    super.inactiveThumbColor,
    super.inactiveTrackColor,
    super.tileColor,
    super.selectedTileColor,
    super.thumbColor,
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
