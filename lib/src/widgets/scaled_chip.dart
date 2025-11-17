import 'package:flutter/material.dart';
import '../core/scale_value_factory.dart';

/// Scaled ActionChip widget - extends Flutter's ActionChip
/// Automatically applies scaling to padding, labelPadding, borderRadius, and elevation
/// Uses cached values for optimal performance
class SKActionChip extends ActionChip {
  static final _factory = ScaleValueFactory.instance;

  SKActionChip({
    super.key,
    required super.label,
    super.avatar,
    super.onPressed,
    GestureLongPressCallback? onLongPress,
    super.tooltip,
    super.clipBehavior = Clip.none,
    super.focusNode,
    super.autofocus,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? labelPadding,
    BorderRadius? borderRadius,
    double? elevation,
    ShapeBorder? shape,
  }) : super(
          padding: padding != null ? _scaleEdgeInsets(padding) : null,
          labelPadding:
              labelPadding != null ? _scaleEdgeInsets(labelPadding) : null,
          shape: _createShape(borderRadius, shape),
          elevation: elevation != null ? _factory.createWidth(elevation) : null,
        );

  static OutlinedBorder? _createShape(BorderRadius? borderRadius, ShapeBorder? shape) {
    if (borderRadius != null) {
      return RoundedRectangleBorder(
        borderRadius: _factory.createBorderRadiusSafe(
          topLeft: _extractRadiusValue(borderRadius.topLeft),
          topRight: _extractRadiusValue(borderRadius.topRight),
          bottomLeft: _extractRadiusValue(borderRadius.bottomLeft),
          bottomRight: _extractRadiusValue(borderRadius.bottomRight),
        ),
      );
    }
    return shape as OutlinedBorder?;
  }

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
    final resolved = insets.resolve(TextDirection.ltr);
    return _factory.createPadding(
      top: resolved.top,
      bottom: resolved.bottom,
      left: resolved.left,
      right: resolved.right,
    );
  }

  static double _extractRadiusValue(Radius radius) {
    if (radius.x == radius.y) {
      return radius.x;
    }
    return radius.x;
  }
}

/// Scaled FilterChip widget - extends Flutter's FilterChip
/// Automatically applies scaling to padding, labelPadding, borderRadius, and elevation
/// Uses cached values for optimal performance
class SKFilterChip extends FilterChip {
  static final _factory = ScaleValueFactory.instance;

  SKFilterChip({
    super.key,
    required super.label,
    super.avatar,
    required super.selected,
    super.onSelected,
    GestureLongPressCallback? onLongPress,
    super.tooltip,
    super.clipBehavior = Clip.none,
    super.focusNode,
    super.autofocus,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? labelPadding,
    BorderRadius? borderRadius,
    double? elevation,
    ShapeBorder? shape,
  }) : super(
          padding: padding != null ? _scaleEdgeInsets(padding) : null,
          labelPadding:
              labelPadding != null ? _scaleEdgeInsets(labelPadding) : null,
          shape: _createShape(borderRadius, shape),
          elevation: elevation != null ? _factory.createWidth(elevation) : null,
        );

  static OutlinedBorder? _createShape(BorderRadius? borderRadius, ShapeBorder? shape) {
    if (borderRadius != null) {
      return RoundedRectangleBorder(
        borderRadius: _factory.createBorderRadiusSafe(
          topLeft: _extractRadiusValue(borderRadius.topLeft),
          topRight: _extractRadiusValue(borderRadius.topRight),
          bottomLeft: _extractRadiusValue(borderRadius.bottomLeft),
          bottomRight: _extractRadiusValue(borderRadius.bottomRight),
        ),
      );
    }
    return shape as OutlinedBorder?;
  }

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
    final resolved = insets.resolve(TextDirection.ltr);
    return _factory.createPadding(
      top: resolved.top,
      bottom: resolved.bottom,
      left: resolved.left,
      right: resolved.right,
    );
  }

  static double _extractRadiusValue(Radius radius) {
    if (radius.x == radius.y) {
      return radius.x;
    }
    return radius.x;
  }
}

/// Scaled ChoiceChip widget - extends Flutter's ChoiceChip
/// Automatically applies scaling to padding, labelPadding, borderRadius, and elevation
/// Uses cached values for optimal performance
class SKChoiceChip extends ChoiceChip {
  static final _factory = ScaleValueFactory.instance;

  SKChoiceChip({
    super.key,
    required super.label,
    super.avatar,
    required super.selected,
    super.onSelected,
    GestureLongPressCallback? onLongPress,
    super.tooltip,
    super.clipBehavior = Clip.none,
    super.focusNode,
    super.autofocus,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? labelPadding,
    BorderRadius? borderRadius,
    double? elevation,
    ShapeBorder? shape,
  }) : super(
          padding: padding != null ? _scaleEdgeInsets(padding) : null,
          labelPadding:
              labelPadding != null ? _scaleEdgeInsets(labelPadding) : null,
          shape: _createShape(borderRadius, shape),
          elevation: elevation != null ? _factory.createWidth(elevation) : null,
        );

  static OutlinedBorder? _createShape(BorderRadius? borderRadius, ShapeBorder? shape) {
    if (borderRadius != null) {
      return RoundedRectangleBorder(
        borderRadius: _factory.createBorderRadiusSafe(
          topLeft: _extractRadiusValue(borderRadius.topLeft),
          topRight: _extractRadiusValue(borderRadius.topRight),
          bottomLeft: _extractRadiusValue(borderRadius.bottomLeft),
          bottomRight: _extractRadiusValue(borderRadius.bottomRight),
        ),
      );
    }
    return shape as OutlinedBorder?;
  }

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
    final resolved = insets.resolve(TextDirection.ltr);
    return _factory.createPadding(
      top: resolved.top,
      bottom: resolved.bottom,
      left: resolved.left,
      right: resolved.right,
    );
  }

  static double _extractRadiusValue(Radius radius) {
    if (radius.x == radius.y) {
      return radius.x;
    }
    return radius.x;
  }
}

/// Scaled InputChip widget - extends Flutter's InputChip
/// Automatically applies scaling to padding, labelPadding, borderRadius, and elevation
/// Uses cached values for optimal performance
class SKInputChip extends InputChip {
  static final _factory = ScaleValueFactory.instance;

  SKInputChip({
    super.key,
    required super.label,
    super.avatar,
    super.onPressed,
    GestureLongPressCallback? onLongPress,
    super.onDeleted,
    super.deleteIcon,
    super.tooltip,
    super.clipBehavior = Clip.none,
    super.focusNode,
    super.autofocus,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? labelPadding,
    BorderRadius? borderRadius,
    double? elevation,
    ShapeBorder? shape,
    super.selected,
  }) : super(
          padding: padding != null ? _scaleEdgeInsets(padding) : null,
          labelPadding:
              labelPadding != null ? _scaleEdgeInsets(labelPadding) : null,
          shape: _createShape(borderRadius, shape),
          elevation: elevation != null ? _factory.createWidth(elevation) : null,
        );

  static OutlinedBorder? _createShape(BorderRadius? borderRadius, ShapeBorder? shape) {
    if (borderRadius != null) {
      return RoundedRectangleBorder(
        borderRadius: _factory.createBorderRadiusSafe(
          topLeft: _extractRadiusValue(borderRadius.topLeft),
          topRight: _extractRadiusValue(borderRadius.topRight),
          bottomLeft: _extractRadiusValue(borderRadius.bottomLeft),
          bottomRight: _extractRadiusValue(borderRadius.bottomRight),
        ),
      );
    }
    return shape as OutlinedBorder?;
  }

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
    final resolved = insets.resolve(TextDirection.ltr);
    return _factory.createPadding(
      top: resolved.top,
      bottom: resolved.bottom,
      left: resolved.left,
      right: resolved.right,
    );
  }

  static double _extractRadiusValue(Radius radius) {
    if (radius.x == radius.y) {
      return radius.x;
    }
    return radius.x;
  }
}
