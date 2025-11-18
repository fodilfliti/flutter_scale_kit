import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import '../core/device_detector.dart';
import '../core/scale_manager.dart' show DeviceType;

/// A mixin that provides device metrics and platform convenience getters.
///
/// This mixin listens to binding events and keeps track of the current logical
/// screen size along with derived helpers such as [isMobile], [isTablet],
/// [isDesktop], [isMobilePlatform], [isDesktopPlatform], [isWeb], [isAndroidPlatform],
/// and [isIOSPlatform]. It can be applied to any [State] subclass to expose these
/// helpers without relying on a `BuildContext`.
mixin DeviceMetricsMixin<T extends StatefulWidget> on State<T> {
  Size _logicalScreenSize = Size.zero;
  double _devicePixelRatio = 1.0;
  DeviceType _deviceType = DeviceType.mobile;
  late final _DeviceMetricsBindingObserver _deviceMetricsObserver;

  /// Current logical screen size derived from the first platform view.
  ///
  /// Falls back to [Size.zero] when no view is available.
  Size get logicalScreenSize => _logicalScreenSize;

  /// Current device pixel ratio derived from the first platform view.
  double get devicePixelRatio => _devicePixelRatio;

  /// Shortest logical side of the screen.
  double get logicalShortestSide => _logicalScreenSize.shortestSide;

  /// Indicates if the current device is categorized as mobile according
  /// to the configured ScaleKit breakpoints.
  bool get isMobile => _deviceType == DeviceType.mobile;

  /// Indicates if the current device is categorized as tablet according
  /// to the configured ScaleKit breakpoints.
  bool get isTablet => _deviceType == DeviceType.tablet;

  /// Indicates if the current device is categorized as desktop according
  /// to the configured ScaleKit breakpoints.
  bool get isDesktop => _deviceType == DeviceType.desktop;

  /// Indicates if the current target platform is considered a mobile platform.
  bool get isMobilePlatform {
    if (kIsWeb) return false;
    return defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS;
  }

  /// Indicates if the current target platform is considered a desktop platform.
  bool get isDesktopPlatform {
    if (kIsWeb) return true; // Web is considered a desktop platform
    return defaultTargetPlatform == TargetPlatform.macOS ||
        defaultTargetPlatform == TargetPlatform.linux ||
        defaultTargetPlatform == TargetPlatform.windows ||
        defaultTargetPlatform == TargetPlatform.fuchsia;
  }

  /// Indicates if the app is running on the web.
  bool get isWeb => kIsWeb;

  /// Indicates if the app is running on Android platform.
  bool get isAndroidPlatform {
    if (kIsWeb) return false;
    return defaultTargetPlatform == TargetPlatform.android;
  }

  /// Indicates if the app is running on iOS platform.
  bool get isIOSPlatform {
    if (kIsWeb) return false;
    return defaultTargetPlatform == TargetPlatform.iOS;
  }

  @override
  @mustCallSuper
  void initState() {
    super.initState();
    _deviceMetricsObserver = _DeviceMetricsBindingObserver(
      onMetricsChanged: _handleBindingMetricsChanged,
    );
    WidgetsBinding.instance.addObserver(_deviceMetricsObserver);
    _refreshMetrics();
  }

  @override
  @mustCallSuper
  void dispose() {
    WidgetsBinding.instance.removeObserver(_deviceMetricsObserver);
    super.dispose();
  }

  void _handleBindingMetricsChanged() {
    final previousSize = _logicalScreenSize;
    _refreshMetrics();

    if (mounted && previousSize != _logicalScreenSize) {
      // Trigger rebuild so dependent getters update.
      setState(() {});
      onDeviceMetricsChanged(previousSize, _logicalScreenSize);
    }
  }

  /// Override to react to device metric updates without manually subscribing
  /// to [WidgetsBindingObserver] callbacks.
  @protected
  void onDeviceMetricsChanged(Size previous, Size current) {}

  void _refreshMetrics() {
    final binding = WidgetsBinding.instance.platformDispatcher;
    if (binding.views.isEmpty) {
      _logicalScreenSize = Size.zero;
      _devicePixelRatio = 1.0;
      _deviceType = DeviceType.mobile;
      return;
    }

    final view = binding.views.first;
    _devicePixelRatio = view.devicePixelRatio;
    final physicalSize = view.physicalSize;
    if (_devicePixelRatio == 0) {
      _logicalScreenSize = Size.zero;
    } else {
      _logicalScreenSize = Size(
        physicalSize.width / _devicePixelRatio,
        physicalSize.height / _devicePixelRatio,
      );
    }

    _deviceType = DeviceDetector.detectDeviceType(_logicalScreenSize.width);
  }
}

class _DeviceMetricsBindingObserver extends WidgetsBindingObserver {
  _DeviceMetricsBindingObserver({required this.onMetricsChanged});

  final VoidCallback onMetricsChanged;

  @override
  void didChangeMetrics() => onMetricsChanged();
}
