import 'package:flutter/material.dart';
import '../core/scale_value_factory.dart';

/// Scaled ListTile widget - extends Flutter's ListTile
/// Automatically applies scaling to contentPadding, minLeadingWidth, and minVerticalPadding
/// Uses cached values for optimal performance
class SKListTile extends ListTile {
  static final _factory = ScaleValueFactory.instance;

  SKListTile({
    super.key,
    super.leading,
    super.title,
    super.subtitle,
    super.trailing,
    super.isThreeLine = false,
    super.dense,
    super.visualDensity,
    super.shape,
    EdgeInsetsGeometry? contentPadding,
    super.enabled = true,
    super.mouseCursor,
    super.selected = false,
    super.focusColor,
    super.hoverColor,
    super.tileColor,
    super.selectedTileColor,
    super.iconColor,
    super.textColor,
    super.selectedColor,
    double? minLeadingWidth,
    double? minVerticalPadding,
    super.enableFeedback,
    super.onTap,
    super.onLongPress,
    super.onFocusChange,
    super.autofocus = false,
    super.focusNode,
  }) : super(
          contentPadding: contentPadding != null
              ? _scaleEdgeInsets(contentPadding)
              : null,
          minLeadingWidth: minLeadingWidth != null
              ? _factory.createWidth(minLeadingWidth)
              : null,
          minVerticalPadding: minVerticalPadding != null
              ? _factory.createHeight(minVerticalPadding)
              : null,
        );

  /// Scales EdgeInsetsGeometry values
  static EdgeInsetsGeometry _scaleEdgeInsets(EdgeInsetsGeometry insets) {
    if (insets is EdgeInsets) {
      return _factory.createPadding(
        top: insets.top,
        bottom: insets.bottom,
        left: insets.left,
        right: insets.right,
      );
    } else if (insets is EdgeInsetsDirectional) {
      return _factory.createPadding(
        top: insets.top,
        bottom: insets.bottom,
        start: insets.start,
        end: insets.end,
      );
    }
    // For other EdgeInsetsGeometry types, try to extract values
    final resolved = insets.resolve(TextDirection.ltr);
    return _factory.createPadding(
      top: resolved.top,
      bottom: resolved.bottom,
      left: resolved.left,
      right: resolved.right,
    );
  }
}

