import 'package:flutter/material.dart';
import '../core/scale_value_factory.dart';
import '../core/font_config.dart';

/// Scaled TextFormField widget - extends Flutter's TextFormField
/// Automatically applies scaling to fontSize, padding (via InputDecoration), and borderRadius
/// Uses cached values for optimal performance
/// Applies FontConfig automatically if configured
class SKTextFormField extends TextFormField {
  static final _factory = ScaleValueFactory.instance;
  SKTextFormField({
    super.key,
    super.controller,
    super.initialValue,
    super.focusNode,
    InputDecoration? decoration,
    super.keyboardType,
    super.textCapitalization = TextCapitalization.none,
    super.textInputAction,
    TextStyle? style,
    double? fontSize,
    super.strutStyle,
    super.textAlign = TextAlign.start,
    super.textAlignVertical,
    super.textDirection,
    super.readOnly = false,
    super.showCursor,
    super.autofocus = false,
    super.obscuringCharacter = '•',
    super.obscureText = false,
    super.autocorrect = true,
    super.smartDashesType,
    super.smartQuotesType,
    super.enableSuggestions = true,
    super.maxLines = 1,
    super.minLines,
    super.expands = false,
    super.maxLength,
    super.onChanged,
    super.onTap,
    super.onEditingComplete,
    super.onFieldSubmitted,
    super.onSaved,
    super.validator,
    super.inputFormatters,
    super.enabled,
    double cursorWidth = 2.0,
    double? cursorHeight,
    super.cursorRadius,
    super.cursorColor,
    super.keyboardAppearance,
    EdgeInsets scrollPadding = const EdgeInsets.all(20.0),
    super.enableInteractiveSelection = true,
    super.selectionControls,
    super.buildCounter,
    super.scrollPhysics,
    super.autofillHints,
    super.autovalidateMode,
    super.clipBehavior = Clip.hardEdge,
    super.restorationId,
    super.stylusHandwritingEnabled,
    super.enableIMEPersonalizedLearning = true,
    super.mouseCursor,
    super.contextMenuBuilder,
    super.canRequestFocus = true,
    super.spellCheckConfiguration,
    super.magnifierConfiguration,
    bool? applyFontConfig,
  }) : super(
         decoration:
             decoration != null ? _scaleInputDecoration(decoration) : null,
         style: _buildTextStyle(
           baseStyle: style,
           fontSize: fontSize,
           applyFontConfig: applyFontConfig ?? true,
         ),
         cursorWidth:
             cursorWidth != 2.0 ? _factory.resolveWidth(cursorWidth) : 2.0,
         cursorHeight:
             cursorHeight != null ? _factory.resolveHeight(cursorHeight) : null,
         scrollPadding: _scaleEdgeInsets(scrollPadding) as EdgeInsets,
       );

  /// Scales InputDecoration properties
  static InputDecoration _scaleInputDecoration(InputDecoration decoration) {
    return decoration.copyWith(
      contentPadding:
          decoration.contentPadding != null
              ? _scaleEdgeInsets(decoration.contentPadding!)
              : null,
      prefixIconConstraints:
          decoration.prefixIconConstraints != null
              ? _factory.resolveBoxConstraints(
                decoration.prefixIconConstraints!,
              )
              : null,
      suffixIconConstraints:
          decoration.suffixIconConstraints != null
              ? _factory.resolveBoxConstraints(
                decoration.suffixIconConstraints!,
              )
              : null,
      border:
          decoration.border != null
              ? _scaleInputBorder(decoration.border!)
              : null,
      enabledBorder:
          decoration.enabledBorder != null
              ? _scaleInputBorder(decoration.enabledBorder!)
              : null,
      focusedBorder:
          decoration.focusedBorder != null
              ? _scaleInputBorder(decoration.focusedBorder!)
              : null,
      disabledBorder:
          decoration.disabledBorder != null
              ? _scaleInputBorder(decoration.disabledBorder!)
              : null,
      errorBorder:
          decoration.errorBorder != null
              ? _scaleInputBorder(decoration.errorBorder!)
              : null,
      focusedErrorBorder:
          decoration.focusedErrorBorder != null
              ? _scaleInputBorder(decoration.focusedErrorBorder!)
              : null,
    );
  }

  /// Scales InputBorder (OutlinedInputBorder, UnderlineInputBorder)
  static InputBorder _scaleInputBorder(InputBorder border) {
    // Use copyWith which is available on all InputBorder types
    // Scale borderSide width if it's not the default
    try {
      final borderSide = (border as dynamic).borderSide;
      if (borderSide != null) {
        final side = borderSide as BorderSide;
        if (side.width != 1.0) {
          return border.copyWith(
            borderSide: side.copyWith(width: _factory.resolveWidth(side.width)),
          );
        }
      }

      // Scale borderRadius if it's a BorderRadius (for OutlinedInputBorder)
      try {
        final borderRadius = (border as dynamic).borderRadius;
        if (borderRadius is BorderRadius) {
          final scaledRadius = _scaleBorderRadius(borderRadius);
          // Only update if radius changed
          if (borderRadius != scaledRadius) {
            try {
              return (border as dynamic).copyWith(borderRadius: scaledRadius)
                  as InputBorder;
            } catch (e) {
              // If copyWith fails, return original border
            }
          }
        }
      } catch (e) {
        // If cast or copyWith fails, ignore
      }
    } catch (e) {
      // If copyWith fails, return original border
    }
    return border;
  }

  /// Extracts the radius value from Radius
  static double _extractRadiusValue(Radius radius) {
    if (radius.x == radius.y) {
      return radius.x;
    }
    return radius.x;
  }

  /// Scales EdgeInsetsGeometry values
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

  /// Builds TextStyle with automatic fontSize scaling and FontConfig
  static TextStyle _buildTextStyle({
    TextStyle? baseStyle,
    double? fontSize,
    bool applyFontConfig = true,
  }) {
    TextStyle textStyle = baseStyle ?? const TextStyle();

    if (fontSize != null) {
      textStyle = textStyle.copyWith(
        fontSize: _factory.resolveFontSize(fontSize),
      );
    } else if (textStyle.fontSize != null) {
      textStyle = textStyle.copyWith(
        fontSize: _factory.resolveFontSize(textStyle.fontSize!),
      );
    }

    if (applyFontConfig) {
      return FontConfig.instance.getTextStyle(baseTextStyle: textStyle);
    }

    return textStyle;
  }
}
