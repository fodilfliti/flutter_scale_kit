import 'package:flutter/material.dart';
import '../core/scale_value_factory.dart';

/// Scaled AppBar widget - extends Flutter's AppBar
/// Automatically applies scaling to toolbarHeight, elevation, titleSpacing, and leadingWidth
/// Uses cached values for optimal performance
class SKAppBar extends AppBar {
  static final _factory = ScaleValueFactory.instance;

  SKAppBar({
    super.key,
    super.leading,
    super.automaticallyImplyLeading = true,
    super.title,
    super.actions,
    super.flexibleSpace,
    super.bottom,
    double? elevation,
    double? scrolledUnderElevation,
    double? toolbarHeight,
    double? leadingWidth,
    super.titleTextStyle,
    super.toolbarTextStyle,
    super.systemOverlayStyle,
    super.backgroundColor,
    super.foregroundColor,
    super.shadowColor,
    super.surfaceTintColor,
    super.primary = true,
    super.centerTitle,
    super.excludeHeaderSemantics = false,
    double? titleSpacing,
    super.toolbarOpacity = 1.0,
    super.bottomOpacity = 1.0,
    super.iconTheme,
    super.actionsIconTheme,
    super.shape,
    super.forceMaterialTransparency = false,
    super.clipBehavior,
  }) : super(
         elevation: elevation != null ? _factory.createWidth(elevation) : null,
         scrolledUnderElevation:
             scrolledUnderElevation != null
                 ? _factory.createWidth(scrolledUnderElevation)
                 : null,
         toolbarHeight:
             toolbarHeight != null
                 ? _factory.createHeight(toolbarHeight)
                 : null,
         leadingWidth:
             leadingWidth != null ? _factory.createWidth(leadingWidth) : null,
         titleSpacing:
             titleSpacing != null ? _factory.createWidth(titleSpacing) : null,
       );
}
