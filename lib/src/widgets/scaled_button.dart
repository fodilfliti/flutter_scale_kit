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
                  _factory.resolveWidth(minimumSize.width),
                  _factory.resolveHeight(minimumSize.height),
                ),
              )
              : null,
      fixedSize:
          fixedSize != null
              ? WidgetStateProperty.all(
                Size(
                  _factory.resolveWidth(fixedSize.width),
                  _factory.resolveHeight(fixedSize.height),
                ),
              )
              : null,
      elevation:
          elevation != null
              ? WidgetStateProperty.all(_factory.resolveWidth(elevation))
              : null,
      shape:
          borderRadius != null
              ? WidgetStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: _scaleBorderRadius(borderRadius),
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
                _factory.resolveWidth(minimumSize.width),
                _factory.resolveHeight(minimumSize.height),
              )
              : null,
      fixedSize:
          fixedSize != null
              ? Size(
                _factory.resolveWidth(fixedSize.width),
                _factory.resolveHeight(fixedSize.height),
              )
              : null,
      elevation: elevation != null ? _factory.resolveWidth(elevation) : null,
      shape:
          borderRadius != null
              ? RoundedRectangleBorder(
                borderRadius: _scaleBorderRadius(borderRadius),
              )
              : null,
    );
  }

  static EdgeInsetsGeometry _scaleEdgeInsets(EdgeInsetsGeometry insets) {
    return _factory.resolveEdgeInsets(insets);
  }

  static BorderRadius _scaleBorderRadius(BorderRadius borderRadius) {
    return BorderRadius.only(
      topLeft: Radius.circular(
        _factory.resolveRadiusSafe(_extractRadiusValue(borderRadius.topLeft)),
      ),
      topRight: Radius.circular(
        _factory.resolveRadiusSafe(_extractRadiusValue(borderRadius.topRight)),
      ),
      bottomLeft: Radius.circular(
        _factory.resolveRadiusSafe(
          _extractRadiusValue(borderRadius.bottomLeft),
        ),
      ),
      bottomRight: Radius.circular(
        _factory.resolveRadiusSafe(
          _extractRadiusValue(borderRadius.bottomRight),
        ),
      ),
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
                  _factory.resolveWidth(minimumSize.width),
                  _factory.resolveHeight(minimumSize.height),
                ),
              )
              : null,
      fixedSize:
          fixedSize != null
              ? WidgetStateProperty.all(
                Size(
                  _factory.resolveWidth(fixedSize.width),
                  _factory.resolveHeight(fixedSize.height),
                ),
              )
              : null,
      shape:
          borderRadius != null
              ? WidgetStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: _scaleBorderRadius(borderRadius),
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
                _factory.resolveWidth(minimumSize.width),
                _factory.resolveHeight(minimumSize.height),
              )
              : null,
      fixedSize:
          fixedSize != null
              ? Size(
                _factory.resolveWidth(fixedSize.width),
                _factory.resolveHeight(fixedSize.height),
              )
              : null,
      shape:
          borderRadius != null
              ? RoundedRectangleBorder(
                borderRadius: _scaleBorderRadius(borderRadius),
              )
              : null,
    );
  }

  static EdgeInsetsGeometry _scaleEdgeInsets(EdgeInsetsGeometry insets) {
    return _factory.resolveEdgeInsets(insets);
  }

  static BorderRadius _scaleBorderRadius(BorderRadius borderRadius) {
    return BorderRadius.only(
      topLeft: Radius.circular(
        _factory.resolveRadiusSafe(_extractRadiusValue(borderRadius.topLeft)),
      ),
      topRight: Radius.circular(
        _factory.resolveRadiusSafe(_extractRadiusValue(borderRadius.topRight)),
      ),
      bottomLeft: Radius.circular(
        _factory.resolveRadiusSafe(
          _extractRadiusValue(borderRadius.bottomLeft),
        ),
      ),
      bottomRight: Radius.circular(
        _factory.resolveRadiusSafe(
          _extractRadiusValue(borderRadius.bottomRight),
        ),
      ),
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
                  _factory.resolveWidth(minimumSize.width),
                  _factory.resolveHeight(minimumSize.height),
                ),
              )
              : null,
      fixedSize:
          fixedSize != null
              ? WidgetStateProperty.all(
                Size(
                  _factory.resolveWidth(fixedSize.width),
                  _factory.resolveHeight(fixedSize.height),
                ),
              )
              : null,
      shape:
          borderRadius != null
              ? WidgetStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: _scaleBorderRadius(borderRadius),
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
                _factory.resolveWidth(minimumSize.width),
                _factory.resolveHeight(minimumSize.height),
              )
              : null,
      fixedSize:
          fixedSize != null
              ? Size(
                _factory.resolveWidth(fixedSize.width),
                _factory.resolveHeight(fixedSize.height),
              )
              : null,
      shape:
          borderRadius != null
              ? RoundedRectangleBorder(
                borderRadius: _scaleBorderRadius(borderRadius),
              )
              : null,
    );
  }

  static EdgeInsetsGeometry _scaleEdgeInsets(EdgeInsetsGeometry insets) {
    return _factory.resolveEdgeInsets(insets);
  }

  static BorderRadius _scaleBorderRadius(BorderRadius borderRadius) {
    return BorderRadius.only(
      topLeft: Radius.circular(
        _factory.resolveRadiusSafe(_extractRadiusValue(borderRadius.topLeft)),
      ),
      topRight: Radius.circular(
        _factory.resolveRadiusSafe(_extractRadiusValue(borderRadius.topRight)),
      ),
      bottomLeft: Radius.circular(
        _factory.resolveRadiusSafe(
          _extractRadiusValue(borderRadius.bottomLeft),
        ),
      ),
      bottomRight: Radius.circular(
        _factory.resolveRadiusSafe(
          _extractRadiusValue(borderRadius.bottomRight),
        ),
      ),
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
         iconSize: iconSize != null ? _factory.resolveFontSize(iconSize) : null,
         padding: padding != null ? _scaleEdgeInsets(padding) : null,
         constraints:
             constraints != null ? _scaleConstraints(constraints) : null,
       );

  static BoxConstraints _scaleConstraints(BoxConstraints constraints) {
    return _factory.resolveBoxConstraints(constraints);
  }

  static EdgeInsetsGeometry _scaleEdgeInsets(EdgeInsetsGeometry insets) {
    return _factory.resolveEdgeInsets(insets);
  }
}
