import 'package:flutter/material.dart';
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

  /// Minimum scale factor (optional).
  final double? minScale;

  /// Maximum scale factor (optional).
  final double? maxScale;

  /// Creates a [ScaleKitBuilder] widget.
  ///
  /// Parameters:
  /// - [child] - The child widget (typically MaterialApp)
  /// - [designWidth] - Design width in logical pixels
  /// - [designHeight] - Design height in logical pixels
  /// - [designType] - Design device type (default: mobile)
  /// - [minScale] - Optional minimum scale factor
  /// - [maxScale] - Optional maximum scale factor
  const ScaleKitBuilder({
    super.key,
    required this.child,
    required this.designWidth,
    required this.designHeight,
    this.designType = DeviceType.mobile,
    this.minScale,
    this.maxScale,
  });

  @override
  State<ScaleKitBuilder> createState() => _ScaleKitBuilderState();
}

class _ScaleKitBuilderState extends State<ScaleKitBuilder> {
  Size? _previousSize;
  Orientation? _previousOrientation;
  Locale? _previousLocale;
  bool _isInitialized = false;

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

  void _initializeScaleManager() {
    if (!_isInitialized) {
      ScaleManager.instance.init(
        context: context,
        designWidth: widget.designWidth,
        designHeight: widget.designHeight,
        designType: widget.designType,
      );
      _isInitialized = true;

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
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
