/// Flutter Scale Kit - High-performance responsive design package
// Core exports
export 'src/core/scale_manager.dart';
export 'src/core/scale_value_factory.dart' show ScaleValueFactory, skFactory;
export 'src/core/scale_value_cache.dart';
export 'src/core/device_detector.dart';
export 'src/core/scaling_strategy.dart';
export 'src/core/aspect_ratio_adapter.dart';
export 'src/core/responsive_enums.dart';
// Size system exports
export 'src/core/size_enums.dart' show SKSize, SKTextSize;
export 'src/core/size_values.dart' show SizeValues, TextSizeValues, SizeConfig;
export 'src/core/size_system.dart'
    show
        paddingSizes,
        marginSizes,
        radiusSizes,
        spacingSizes,
        textSizes,
        defaultPaddingValue,
        defaultMarginValue,
        defaultRadiusValue,
        defaultSpacingValue,
        defaultTextSizeValue,
        setPaddingSizes,
        setMarginSizes,
        setRadiusSizes,
        setSpacingSizes,
        setTextSizes,
        setDefaultPadding,
        setDefaultMargin,
        setDefaultRadius,
        setDefaultSpacing,
        setDefaultTextSize,
        setSizeConfig,
        setSizeValues,
        resetSizeValues;

// Widgets
export 'src/widgets/scale_kit_builder.dart';
export 'src/widgets/const_widgets.dart';
export 'src/widgets/responsive_builder.dart';

// Font configuration
export 'src/core/font_config.dart';

// Extensions
export 'src/extensions/scale_extensions.dart';
export 'src/extensions/context_extensions.dart';
export 'src/extensions/theme_data_extensions.dart';
export 'src/extensions/text_style_extensions.dart';
