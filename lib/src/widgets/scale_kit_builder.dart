import 'package:flutter/material.dart';
import '../core/scale_manager.dart';
import '../core/scale_value_cache.dart';

/// Wrapper widget that listens to MediaQuery changes
/// Triggers cache clear and rebuild on size/orientation change
class ScaleKitBuilder extends StatefulWidget {
  /// Child widget
  final Widget child;

  /// Design width (in logical pixels)
  final double designWidth;

  /// Design height (in logical pixels)
  final double designHeight;

  /// Design device type
  final DeviceType designType;

  /// Minimum scale factor
  final double? minScale;

  /// Maximum scale factor
  final double? maxScale;

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
    ScaleManager.instance.init(
      context: context,
      designWidth: widget.designWidth,
      designHeight: widget.designHeight,
      designType: widget.designType,
    );
  }

  void _checkForChanges() {
    final mediaQuery = MediaQuery.of(context);
    final currentSize = mediaQuery.size;
    final currentOrientation = mediaQuery.orientation;

    // Check if size or orientation changed significantly
    bool shouldRebuild = false;

    if (_previousSize == null) {
      // First build
      _previousSize = currentSize;
      _previousOrientation = currentOrientation;
      _initializeScaleManager();
      return;
    }

    // Check for size change (>50% change indicates foldable device transition)
    if (_previousSize != null) {
      final widthChange = (currentSize.width - _previousSize!.width).abs();
      final heightChange = (currentSize.height - _previousSize!.height).abs();
      final significantChange = widthChange > _previousSize!.width * 0.5 ||
          heightChange > _previousSize!.height * 0.5;

      if (significantChange ||
          currentSize != _previousSize ||
          currentOrientation != _previousOrientation) {
        shouldRebuild = true;
      }
    }

    // Check for orientation change
    if (_previousOrientation != null &&
        currentOrientation != _previousOrientation) {
      shouldRebuild = true;
    }

    if (shouldRebuild) {
      _onSizeOrOrientationChange();
    }

    _previousSize = currentSize;
    _previousOrientation = currentOrientation;
  }

  void _onSizeOrOrientationChange() {
    // Update scale manager with new context
    ScaleManager.instance.updateFromContext(context);

    // Clear cache to force recalculation
    ScaleValueCache.instance.clearCache();

    // Trigger rebuild
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    // Update scale manager on every build to ensure it's current
    ScaleManager.instance.updateFromContext(context);

    return widget.child;
  }
}

