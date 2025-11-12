import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../core/scale_manager.dart';
import '../core/scale_value_cache.dart';
import '../core/font_config.dart';

/// Wrapper widget that initializes ScaleKit and manages responsive updates.
///
/// This widget should wrap your [MaterialApp] at the top level of your
/// application. It listens to [MediaQuery] changes and automatically
/// updates scale factors when screen size or orientation changes.
///
/// The widget uses a threshold-based approach to prevent unnecessary
/// recalculations on minor layout adjustments while still responding
/// to significant size changes (e.g., foldable device transitions).
///
/// Example usage:
/// ```dart
/// class MyApp extends StatelessWidget {
///   @override
///   Widget build(BuildContext context) {
///     return ScaleKitBuilder(
///       designWidth: 375,
///       designHeight: 812,
///       designType: DeviceType.mobile,
///       child: MaterialApp(
///         home: HomePage(),
///       ),
///     );
///   }
/// }
/// ```
class ScaleKitBuilder extends StatefulWidget {
  /// The child widget to wrap.
  final Widget child;

  /// Design width in logical pixels.
  final double designWidth;

  /// Design height in logical pixels.
  final double designHeight;

  /// Design device type.
  final DeviceType designType;

  /// Optional override for device detection (null = auto-detect).
  final DeviceType? deviceTypeOverride;

  /// Minimum scale factor (optional).
  final double? minScale;

  /// Maximum scale factor (optional).
  final double? maxScale;

  /// Landscape font boost factors per device type (optional).
  final double? mobileLandscapeFontBoost;
  final double? tabletLandscapeFontBoost;
  final double? desktopLandscapeFontBoost;

  /// Landscape size boost factors per device type (optional).
  final double? mobileLandscapeSizeBoost;
  final double? tabletLandscapeSizeBoost;
  final double? desktopLandscapeSizeBoost;

  /// Portrait font boost factors per device type (optional).
  final double? mobilePortraitFontBoost;
  final double? tabletPortraitFontBoost;
  final double? desktopPortraitFontBoost;

  /// Portrait size boost factors per device type (optional).
  final double? mobilePortraitSizeBoost;
  final double? tabletPortraitSizeBoost;
  final double? desktopPortraitSizeBoost;

  /// Enable/disable autoscale boosts (default: true).
  final bool autoScale;

  /// Enable autoscale in landscape orientation (default: true).
  final bool autoScaleLandscape;

  /// Enable autoscale in portrait orientation (default: false).
  final bool autoScalePortrait;

  /// Globally enable/disable scaling (default: true).
  final bool enabled;

  /// When true, web and desktop platforms are locked to desktop responsive behaviour.
  /// Mobile/tablet platforms remain unaffected.
  final bool lockDesktopPlatforms;

  /// When [lockDesktopPlatforms] is true, force desktop to behave like tablet.
  final bool lockDesktopAsTablet;

  /// When [lockDesktopPlatforms] is true, force desktop to behave like mobile.
  final bool lockDesktopAsMobile;

  /// Breakpoint configuration for responsive device detection.
  final ScaleBreakpoints breakpoints;

  /// Optional listenable to toggle scaling at runtime.
  final ValueListenable<bool>? enabledListenable;

  /// Creates a [ScaleKitBuilder] widget.
  ///
  /// Parameters:
  /// - [child] - The child widget (typically MaterialApp)
  /// - [designWidth] - Design width in logical pixels
  /// - [designHeight] - Design height in logical pixels
  /// - [designType] - Design device type (default: mobile)
  /// - [deviceTypeOverride] - Optional override for runtime device detection
  /// - [lockDesktopPlatforms] - Force desktop/web platforms to behave as desktop automatically
  /// - [breakpoints] - Custom device breakpoints used for size-based detection
  /// - [minScale] - Optional minimum scale factor
  /// - [maxScale] - Optional maximum scale factor
  const ScaleKitBuilder({
    super.key,
    required this.child,
    required this.designWidth,
    required this.designHeight,
    this.designType = DeviceType.mobile,
    this.deviceTypeOverride,
    this.minScale,
    this.maxScale,
    this.mobileLandscapeFontBoost,
    this.tabletLandscapeFontBoost,
    this.desktopLandscapeFontBoost,
    this.mobileLandscapeSizeBoost,
    this.tabletLandscapeSizeBoost,
    this.desktopLandscapeSizeBoost,
    this.mobilePortraitFontBoost,
    this.tabletPortraitFontBoost,
    this.desktopPortraitFontBoost,
    this.mobilePortraitSizeBoost,
    this.tabletPortraitSizeBoost,
    this.desktopPortraitSizeBoost,
    this.autoScale = true,
    this.autoScaleLandscape = true,
    this.autoScalePortrait = false,
    this.enabled = true,
    this.lockDesktopPlatforms = false,
    this.lockDesktopAsTablet = false,
    this.lockDesktopAsMobile = false,
    this.breakpoints = const ScaleBreakpoints(),
    this.enabledListenable,
  }) : assert(
         !(lockDesktopAsTablet && lockDesktopAsMobile),
         'lockDesktopAsTablet and lockDesktopAsMobile cannot both be true.',
       );

  @override
  State<ScaleKitBuilder> createState() => _ScaleKitBuilderState();
}

class _ScaleKitBuilderState extends State<ScaleKitBuilder> {
  Size? _previousSize;
  Orientation? _previousOrientation;
  Locale? _previousLocale;
  bool _isInitialized = false;
  VoidCallback? _enabledListener;
  int _rebuildTick = 0;
  static const double _sizeChangeThreshold = 0.05;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeScaleManager();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _checkForChanges();
  }

  @override
  void didUpdateWidget(covariant ScaleKitBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!_isInitialized) return;

    bool reapply = false;

    if (oldWidget.deviceTypeOverride != widget.deviceTypeOverride) {
      ScaleManager.instance.setDeviceOverride(widget.deviceTypeOverride);
      reapply = true;
    }

    if (oldWidget.lockDesktopPlatforms != widget.lockDesktopPlatforms) {
      ScaleManager.instance.setDesktopLock(widget.lockDesktopPlatforms);
      reapply = true;
    }

    if (oldWidget.breakpoints != widget.breakpoints) {
      ScaleManager.instance.setBreakpoints(widget.breakpoints);
      reapply = true;
    }

    if (oldWidget.lockDesktopAsTablet != widget.lockDesktopAsTablet ||
        oldWidget.lockDesktopAsMobile != widget.lockDesktopAsMobile) {
      ScaleManager.instance.setDesktopLockFallback(
        widget.lockDesktopAsTablet
            ? DesktopLockFallback.tablet
            : widget.lockDesktopAsMobile
            ? DesktopLockFallback.mobile
            : DesktopLockFallback.desktop,
      );
      reapply = true;
    }

    if (oldWidget.autoScale != widget.autoScale) {
      ScaleManager.instance.setAutoScale(widget.autoScale);
      reapply = true;
    }

    if (oldWidget.minScale != widget.minScale ||
        oldWidget.maxScale != widget.maxScale) {
      ScaleManager.instance.setScaleLimits(
        minScale: widget.minScale,
        maxScale: widget.maxScale,
      );
      reapply = true;
    }

    if (oldWidget.enabled != widget.enabled) {
      ScaleManager.instance.setEnabled(widget.enabled);
      reapply = true;
    }

    if (oldWidget.autoScaleLandscape != widget.autoScaleLandscape ||
        oldWidget.autoScalePortrait != widget.autoScalePortrait) {
      ScaleManager.instance.setAutoScaleOrientation(
        landscape: widget.autoScaleLandscape,
        portrait: widget.autoScalePortrait,
      );
      reapply = true;
    }

    if (oldWidget.mobileLandscapeFontBoost != widget.mobileLandscapeFontBoost ||
        oldWidget.tabletLandscapeFontBoost != widget.tabletLandscapeFontBoost ||
        oldWidget.desktopLandscapeFontBoost !=
            widget.desktopLandscapeFontBoost ||
        oldWidget.mobileLandscapeSizeBoost != widget.mobileLandscapeSizeBoost ||
        oldWidget.tabletLandscapeSizeBoost != widget.tabletLandscapeSizeBoost ||
        oldWidget.desktopLandscapeSizeBoost !=
            widget.desktopLandscapeSizeBoost ||
        oldWidget.mobilePortraitFontBoost != widget.mobilePortraitFontBoost ||
        oldWidget.tabletPortraitFontBoost != widget.tabletPortraitFontBoost ||
        oldWidget.desktopPortraitFontBoost != widget.desktopPortraitFontBoost ||
        oldWidget.mobilePortraitSizeBoost != widget.mobilePortraitSizeBoost ||
        oldWidget.tabletPortraitSizeBoost != widget.tabletPortraitSizeBoost ||
        oldWidget.desktopPortraitSizeBoost != widget.desktopPortraitSizeBoost) {
      ScaleManager.instance.setBoosts(
        mobileLandscapeFontBoost: widget.mobileLandscapeFontBoost,
        tabletLandscapeFontBoost: widget.tabletLandscapeFontBoost,
        desktopLandscapeFontBoost: widget.desktopLandscapeFontBoost,
        mobileLandscapeSizeBoost: widget.mobileLandscapeSizeBoost,
        tabletLandscapeSizeBoost: widget.tabletLandscapeSizeBoost,
        desktopLandscapeSizeBoost: widget.desktopLandscapeSizeBoost,
        mobilePortraitFontBoost: widget.mobilePortraitFontBoost,
        tabletPortraitFontBoost: widget.tabletPortraitFontBoost,
        desktopPortraitFontBoost: widget.desktopPortraitFontBoost,
        mobilePortraitSizeBoost: widget.mobilePortraitSizeBoost,
        tabletPortraitSizeBoost: widget.tabletPortraitSizeBoost,
        desktopPortraitSizeBoost: widget.desktopPortraitSizeBoost,
      );
      reapply = true;
    }

    if (reapply) {
      // Recalculate scale and clear caches
      _onSizeOrOrientationChange();
    }

    if (oldWidget.enabledListenable != widget.enabledListenable) {
      _detachEnabledListenable();
      _attachEnabledListenable();
    }
  }

  void _initializeScaleManager() {
    if (!_isInitialized) {
      ScaleManager.instance.init(
        context: context,
        designWidth: widget.designWidth,
        designHeight: widget.designHeight,
        designType: widget.designType,
        minScale: widget.minScale,
        maxScale: widget.maxScale,
      );
      ScaleManager.instance.setDeviceOverride(widget.deviceTypeOverride);
      ScaleManager.instance.setAutoScale(widget.autoScale);
      ScaleManager.instance.setEnabled(widget.enabled);
      ScaleManager.instance.setDesktopLock(widget.lockDesktopPlatforms);
      ScaleManager.instance.setBreakpoints(widget.breakpoints);
      ScaleManager.instance.setDesktopLockFallback(
        widget.lockDesktopAsTablet
            ? DesktopLockFallback.tablet
            : widget.lockDesktopAsMobile
            ? DesktopLockFallback.mobile
            : DesktopLockFallback.desktop,
      );
      ScaleManager.instance.setAutoScaleOrientation(
        landscape: widget.autoScaleLandscape,
        portrait: widget.autoScalePortrait,
      );
      ScaleManager.instance.setBoosts(
        mobileLandscapeFontBoost: widget.mobileLandscapeFontBoost,
        tabletLandscapeFontBoost: widget.tabletLandscapeFontBoost,
        desktopLandscapeFontBoost: widget.desktopLandscapeFontBoost,
        mobileLandscapeSizeBoost: widget.mobileLandscapeSizeBoost,
        tabletLandscapeSizeBoost: widget.tabletLandscapeSizeBoost,
        desktopLandscapeSizeBoost: widget.desktopLandscapeSizeBoost,
        mobilePortraitFontBoost: widget.mobilePortraitFontBoost,
        tabletPortraitFontBoost: widget.tabletPortraitFontBoost,
        desktopPortraitFontBoost: widget.desktopPortraitFontBoost,
        mobilePortraitSizeBoost: widget.mobilePortraitSizeBoost,
        tabletPortraitSizeBoost: widget.tabletPortraitSizeBoost,
        desktopPortraitSizeBoost: widget.desktopPortraitSizeBoost,
      );
      ScaleManager.instance.setScaleLimits(
        minScale: widget.minScale,
        maxScale: widget.maxScale,
      );
      _isInitialized = true;

      _attachEnabledListenable();

      final mediaQuery = MediaQuery.of(context);
      _previousSize = mediaQuery.size;
      _previousOrientation = mediaQuery.orientation;

      // Safely get locale - may not be available during initialization
      try {
        _previousLocale = Localizations.localeOf(context);
        // Initialize font config with current language
        FontConfig.instance.setLanguage(_previousLocale!.languageCode);
      } catch (e) {
        // Localizations not available yet, use default
        _previousLocale = const Locale('en');
        FontConfig.instance.setLanguage('en');
      }
    }
  }

  void _attachEnabledListenable() {
    if (widget.enabledListenable != null) {
      _enabledListener = () {
        ScaleManager.instance.setEnabled(widget.enabledListenable!.value);
        _onSizeOrOrientationChange();
      };
      widget.enabledListenable!.addListener(_enabledListener!);
    }
  }

  void _detachEnabledListenable() {
    if (widget.enabledListenable != null && _enabledListener != null) {
      widget.enabledListenable!.removeListener(_enabledListener!);
      _enabledListener = null;
    }
  }

  @override
  void dispose() {
    ScaleManager.instance.setDesktopLock(false);
    ScaleManager.instance.setDesktopLockFallback(DesktopLockFallback.desktop);
    ScaleManager.instance.setDeviceOverride(null);
    _detachEnabledListenable();
    super.dispose();
  }

  void _checkForChanges() {
    final mediaQuery = MediaQuery.of(context);
    final currentSize = mediaQuery.size;
    final currentOrientation = mediaQuery.orientation;

    // Safely get locale
    Locale? currentLocale;
    try {
      currentLocale = Localizations.localeOf(context);
    } catch (e) {
      // Localizations not available yet
      currentLocale = _previousLocale ?? const Locale('en');
    }

    if (!_isInitialized) {
      _initializeScaleManager();
      return;
    }

    bool shouldUpdate = false;

    // Check for locale/language change
    if (_previousLocale != null && currentLocale != _previousLocale) {
      FontConfig.instance.setLanguage(currentLocale.languageCode);
      shouldUpdate = true;
    }

    if (_previousOrientation != null &&
        currentOrientation != _previousOrientation) {
      shouldUpdate = true;
    }

    if (_previousSize != null) {
      final widthChange = (currentSize.width - _previousSize!.width).abs();
      final heightChange = (currentSize.height - _previousSize!.height).abs();

      final widthChangePercent =
          _previousSize!.width > 0 ? widthChange / _previousSize!.width : 0.0;
      final heightChangePercent =
          _previousSize!.height > 0
              ? heightChange / _previousSize!.height
              : 0.0;

      final significantChange =
          widthChangePercent > _sizeChangeThreshold ||
          heightChangePercent > _sizeChangeThreshold ||
          widthChangePercent > 0.5 ||
          heightChangePercent > 0.5;

      if (significantChange) {
        shouldUpdate = true;
      }
    }

    if (shouldUpdate) {
      _previousSize = currentSize;
      _previousOrientation = currentOrientation;
      _previousLocale = currentLocale;

      _onSizeOrOrientationChange();
    }
  }

  void _onSizeOrOrientationChange() {
    ScaleManager.instance.updateFromContext(context);

    ScaleValueCache.instance.clearCache();

    // Notify FontConfig listeners if language changed
    try {
      final currentLocale = Localizations.localeOf(context);
      if (_previousLocale != null && currentLocale != _previousLocale) {
        FontConfig.instance.onLanguageChanged?.call();
      }
    } catch (e) {
      // Localizations not available
    }

    if (mounted) {
      setState(() {
        _rebuildTick++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaleKitScope(tick: _rebuildTick, child: widget.child);
  }
}

/// Internal scope used to notify descendants when ScaleKit recalculates.
class ScaleKitScope extends InheritedWidget {
  const ScaleKitScope({super.key, required this.tick, required super.child});

  final int tick;

  static ScaleKitScope? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ScaleKitScope>();
  }

  static void watch(BuildContext context) {
    maybeOf(context);
  }

  @override
  bool updateShouldNotify(covariant ScaleKitScope oldWidget) {
    return oldWidget.tick != tick;
  }
}
