import 'package:flutter/material.dart';
import '../core/scale_value_factory.dart';

/// Scaled ElevatedButton widget - extends Flutter's ElevatedButton
/// Automatically applies scaling to padding, minimumSize, fixedSize, borderRadius, and elevation
/// Uses cached values for optimal performance
class SKElevatedButton extends ElevatedButton {
  static final _factory = ScaleValueFactory.instance;

  SKElevatedButton({
    super.key,
    required super.onPressed,
    super.onLongPress,
    super.onHover,
    super.onFocusChange,
    ButtonStyle? style,
    super.focusNode,
    super.autofocus,
    super.clipBehavior = Clip.none,
    super.statesController,
    super.child,
    EdgeInsetsGeometry? padding,
    Size? minimumSize,
    Size? fixedSize,
    double? elevation,
    BorderRadius? borderRadius,
  }) : super(
         style:
             style != null
                 ? _scaleButtonStyle(
                   style,
                   padding: padding,
                   minimumSize: minimumSize,
                   fixedSize: fixedSize,
                   elevation: elevation,
                   borderRadius: borderRadius,
                 )
                 : _createButtonStyle(
                   padding: padding,
                   minimumSize: minimumSize,
                   fixedSize: fixedSize,
                   elevation: elevation,
                   borderRadius: borderRadius,
                 ),
       );

  static ButtonStyle _scaleButtonStyle(
    ButtonStyle baseStyle, {
    EdgeInsetsGeometry? padding,
    Size? minimumSize,
    Size? fixedSize,
    double? elevation,
    BorderRadius? borderRadius,
  }) {
    return baseStyle.copyWith(
      padding:
          padding != null
              ? WidgetStateProperty.all(_scaleEdgeInsets(padding))
              : null,
      minimumSize:
          minimumSize != null
              ? WidgetStateProperty.all(
                Size(
                  _factory.createWidth(minimumSize.width),
                  _factory.createHeight(minimumSize.height),
                ),
              )
              : null,
      fixedSize:
          fixedSize != null
              ? WidgetStateProperty.all(
                Size(
                  _factory.createWidth(fixedSize.width),
                  _factory.createHeight(fixedSize.height),
                ),
              )
              : null,
      elevation:
          elevation != null
              ? WidgetStateProperty.all(_factory.createWidth(elevation))
              : null,
      shape:
          borderRadius != null
              ? WidgetStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: _factory.createBorderRadiusSafe(
                    topLeft: _extractRadiusValue(borderRadius.topLeft),
                    topRight: _extractRadiusValue(borderRadius.topRight),
                    bottomLeft: _extractRadiusValue(borderRadius.bottomLeft),
                    bottomRight: _extractRadiusValue(borderRadius.bottomRight),
                  ),
                ),
              )
              : null,
    );
  }

  static ButtonStyle _createButtonStyle({
    EdgeInsetsGeometry? padding,
    Size? minimumSize,
    Size? fixedSize,
    double? elevation,
    BorderRadius? borderRadius,
  }) {
    return ElevatedButton.styleFrom(
      padding: padding != null ? _scaleEdgeInsets(padding) : null,
      minimumSize:
          minimumSize != null
              ? Size(
                _factory.createWidth(minimumSize.width),
                _factory.createHeight(minimumSize.height),
              )
              : null,
      fixedSize:
          fixedSize != null
              ? Size(
                _factory.createWidth(fixedSize.width),
                _factory.createHeight(fixedSize.height),
              )
              : null,
      elevation: elevation != null ? _factory.createWidth(elevation) : null,
      shape:
          borderRadius != null
              ? RoundedRectangleBorder(
                borderRadius: _factory.createBorderRadiusSafe(
                  topLeft: _extractRadiusValue(borderRadius.topLeft),
                  topRight: _extractRadiusValue(borderRadius.topRight),
                  bottomLeft: _extractRadiusValue(borderRadius.bottomLeft),
                  bottomRight: _extractRadiusValue(borderRadius.bottomRight),
                ),
              )
              : null,
    );
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

/// Scaled TextButton widget - extends Flutter's TextButton
/// Automatically applies scaling to padding, minimumSize, fixedSize, and borderRadius
/// Uses cached values for optimal performance
class SKTextButton extends TextButton {
  static final _factory = ScaleValueFactory.instance;

  SKTextButton({
    super.key,
    required super.onPressed,
    super.onLongPress,
    super.onHover,
    super.onFocusChange,
    ButtonStyle? style,
    super.focusNode,
    super.autofocus,
    super.clipBehavior = Clip.none,
    super.statesController,
    Widget? child,
    EdgeInsetsGeometry? padding,
    Size? minimumSize,
    Size? fixedSize,
    BorderRadius? borderRadius,
  }) : super(
         child: child ?? const SizedBox.shrink(),
         style:
             style != null
                 ? _scaleButtonStyle(
                   style,
                   padding: padding,
                   minimumSize: minimumSize,
                   fixedSize: fixedSize,
                   borderRadius: borderRadius,
                 )
                 : _createButtonStyle(
                   padding: padding,
                   minimumSize: minimumSize,
                   fixedSize: fixedSize,
                   borderRadius: borderRadius,
                 ),
       );

  static ButtonStyle _scaleButtonStyle(
    ButtonStyle baseStyle, {
    EdgeInsetsGeometry? padding,
    Size? minimumSize,
    Size? fixedSize,
    BorderRadius? borderRadius,
  }) {
    return baseStyle.copyWith(
      padding:
          padding != null
              ? WidgetStateProperty.all(_scaleEdgeInsets(padding))
              : null,
      minimumSize:
          minimumSize != null
              ? WidgetStateProperty.all(
                Size(
                  _factory.createWidth(minimumSize.width),
                  _factory.createHeight(minimumSize.height),
                ),
              )
              : null,
      fixedSize:
          fixedSize != null
              ? WidgetStateProperty.all(
                Size(
                  _factory.createWidth(fixedSize.width),
                  _factory.createHeight(fixedSize.height),
                ),
              )
              : null,
      shape:
          borderRadius != null
              ? WidgetStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: _factory.createBorderRadiusSafe(
                    topLeft: _extractRadiusValue(borderRadius.topLeft),
                    topRight: _extractRadiusValue(borderRadius.topRight),
                    bottomLeft: _extractRadiusValue(borderRadius.bottomLeft),
                    bottomRight: _extractRadiusValue(borderRadius.bottomRight),
                  ),
                ),
              )
              : null,
    );
  }

  static ButtonStyle _createButtonStyle({
    EdgeInsetsGeometry? padding,
    Size? minimumSize,
    Size? fixedSize,
    BorderRadius? borderRadius,
  }) {
    return TextButton.styleFrom(
      padding: padding != null ? _scaleEdgeInsets(padding) : null,
      minimumSize:
          minimumSize != null
              ? Size(
                _factory.createWidth(minimumSize.width),
                _factory.createHeight(minimumSize.height),
              )
              : null,
      fixedSize:
          fixedSize != null
              ? Size(
                _factory.createWidth(fixedSize.width),
                _factory.createHeight(fixedSize.height),
              )
              : null,
      shape:
          borderRadius != null
              ? RoundedRectangleBorder(
                borderRadius: _factory.createBorderRadiusSafe(
                  topLeft: _extractRadiusValue(borderRadius.topLeft),
                  topRight: _extractRadiusValue(borderRadius.topRight),
                  bottomLeft: _extractRadiusValue(borderRadius.bottomLeft),
                  bottomRight: _extractRadiusValue(borderRadius.bottomRight),
                ),
              )
              : null,
    );
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

/// Scaled OutlinedButton widget - extends Flutter's OutlinedButton
/// Automatically applies scaling to padding, minimumSize, fixedSize, and borderRadius
/// Uses cached values for optimal performance
class SKOutlinedButton extends OutlinedButton {
  static final _factory = ScaleValueFactory.instance;

  SKOutlinedButton({
    super.key,
    required super.onPressed,
    super.onLongPress,
    super.onHover,
    super.onFocusChange,
    ButtonStyle? style,
    super.focusNode,
    super.autofocus,
    super.clipBehavior = Clip.none,
    super.statesController,
    super.child,
    EdgeInsetsGeometry? padding,
    Size? minimumSize,
    Size? fixedSize,
    BorderRadius? borderRadius,
  }) : super(
         style:
             style != null
                 ? _scaleButtonStyle(
                   style,
                   padding: padding,
                   minimumSize: minimumSize,
                   fixedSize: fixedSize,
                   borderRadius: borderRadius,
                 )
                 : _createButtonStyle(
                   padding: padding,
                   minimumSize: minimumSize,
                   fixedSize: fixedSize,
                   borderRadius: borderRadius,
                 ),
       );

  static ButtonStyle _scaleButtonStyle(
    ButtonStyle baseStyle, {
    EdgeInsetsGeometry? padding,
    Size? minimumSize,
    Size? fixedSize,
    BorderRadius? borderRadius,
  }) {
    return baseStyle.copyWith(
      padding:
          padding != null
              ? WidgetStateProperty.all(_scaleEdgeInsets(padding))
              : null,
      minimumSize:
          minimumSize != null
              ? WidgetStateProperty.all(
                Size(
                  _factory.createWidth(minimumSize.width),
                  _factory.createHeight(minimumSize.height),
                ),
              )
              : null,
      fixedSize:
          fixedSize != null
              ? WidgetStateProperty.all(
                Size(
                  _factory.createWidth(fixedSize.width),
                  _factory.createHeight(fixedSize.height),
                ),
              )
              : null,
      shape:
          borderRadius != null
              ? WidgetStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: _factory.createBorderRadiusSafe(
                    topLeft: _extractRadiusValue(borderRadius.topLeft),
                    topRight: _extractRadiusValue(borderRadius.topRight),
                    bottomLeft: _extractRadiusValue(borderRadius.bottomLeft),
                    bottomRight: _extractRadiusValue(borderRadius.bottomRight),
                  ),
                ),
              )
              : null,
    );
  }

  static ButtonStyle _createButtonStyle({
    EdgeInsetsGeometry? padding,
    Size? minimumSize,
    Size? fixedSize,
    BorderRadius? borderRadius,
  }) {
    return OutlinedButton.styleFrom(
      padding: padding != null ? _scaleEdgeInsets(padding) : null,
      minimumSize:
          minimumSize != null
              ? Size(
                _factory.createWidth(minimumSize.width),
                _factory.createHeight(minimumSize.height),
              )
              : null,
      fixedSize:
          fixedSize != null
              ? Size(
                _factory.createWidth(fixedSize.width),
                _factory.createHeight(fixedSize.height),
              )
              : null,
      shape:
          borderRadius != null
              ? RoundedRectangleBorder(
                borderRadius: _factory.createBorderRadiusSafe(
                  topLeft: _extractRadiusValue(borderRadius.topLeft),
                  topRight: _extractRadiusValue(borderRadius.topRight),
                  bottomLeft: _extractRadiusValue(borderRadius.bottomLeft),
                  bottomRight: _extractRadiusValue(borderRadius.bottomRight),
                ),
              )
              : null,
    );
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

/// Scaled IconButton widget - extends Flutter's IconButton
/// Automatically applies scaling to iconSize, padding, and constraints
/// Uses cached values for optimal performance
class SKIconButton extends IconButton {
  static final _factory = ScaleValueFactory.instance;

  SKIconButton({
    super.key,
    required super.icon,
    super.selectedIcon,
    double? iconSize,
    EdgeInsetsGeometry? padding,
    BoxConstraints? constraints,
    required super.onPressed,
    super.onLongPress,
    super.tooltip,
    super.focusNode,
    super.autofocus,
    super.style,
    super.isSelected,
    super.mouseCursor,
    super.highlightColor,
    super.splashColor,
    super.splashRadius,
    super.hoverColor,
    super.focusColor,
    super.disabledColor,
    super.visualDensity,
  }) : super(
         iconSize: iconSize != null ? _factory.createFontSize(iconSize) : null,
         padding: padding != null ? _scaleEdgeInsets(padding) : null,
         constraints:
             constraints != null ? _scaleConstraints(constraints) : null,
       );

  static BoxConstraints _scaleConstraints(BoxConstraints constraints) {
    return BoxConstraints(
      minWidth: _factory.createWidth(constraints.minWidth),
      maxWidth:
          constraints.maxWidth != double.infinity
              ? _factory.createWidth(constraints.maxWidth)
              : double.infinity,
      minHeight: _factory.createHeight(constraints.minHeight),
      maxHeight:
          constraints.maxHeight != double.infinity
              ? _factory.createHeight(constraints.maxHeight)
              : double.infinity,
    );
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
}
