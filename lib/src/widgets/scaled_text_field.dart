import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import '../core/scale_value_factory.dart';
import '../core/font_config.dart';

/// Scaled TextField widget - extends Flutter's TextField
/// Automatically applies scaling to fontSize, padding (via InputDecoration), and borderRadius
/// Uses cached values for optimal performance
/// Applies FontConfig automatically if configured
class SKTextField extends TextField {
  static final _factory = ScaleValueFactory.instance;

  SKTextField({
    super.key,
    super.controller,
    super.focusNode,
    InputDecoration? decoration,
    super.keyboardType,
    super.textInputAction,
    super.textCapitalization = TextCapitalization.none,
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
    super.onEditingComplete,
    super.onSubmitted,
    super.onAppPrivateCommand,
    super.inputFormatters,
    super.enabled,
    double cursorWidth = 2.0,
    double? cursorHeight,
    super.cursorRadius,
    super.cursorColor,
    super.selectionHeightStyle,
    super.selectionWidthStyle,
    super.keyboardAppearance,
    EdgeInsets scrollPadding = const EdgeInsets.all(20.0),
    DragStartBehavior? dragStartBehavior,
    super.enableInteractiveSelection = true,
    super.selectionControls,
    super.onTap,
    super.mouseCursor,
    super.buildCounter,
    super.scrollController,
    super.scrollPhysics,
    super.autofillHints,
    super.clipBehavior = Clip.hardEdge,
    super.restorationId,
    super.stylusHandwritingEnabled,
    super.enableIMEPersonalizedLearning = true,
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
         dragStartBehavior: dragStartBehavior ?? DragStartBehavior.start,
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
    } catch (e) {
      // If copyWith fails, return original border
    }
    return border;
  }

  /// Scales EdgeInsetsGeometry values
  static EdgeInsetsGeometry _scaleEdgeInsets(EdgeInsetsGeometry insets) {
    return _factory.resolveEdgeInsets(insets);
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
