import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'
    show kIsWeb, defaultTargetPlatform, TargetPlatform;
import 'package:flutter_scale_kit/flutter_scale_kit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'
    as su
    show ScreenUtil, ScreenUtilInit;
import 'package:syntax_highlight/syntax_highlight.dart';
import 'package:device_preview/device_preview.dart' hide DeviceType;
import 'widgets/section_card.dart';
import 'widgets/comparison_card.dart';
import 'widgets/live_scaling_debug.dart';
import 'widgets/settings_sheet.dart';
import 'widgets/navigation_buttons.dart';
import 'widgets/section_title.dart';
import 'widgets/tip_card.dart';
import 'widgets/extension_row.dart';
import 'widgets/size_box.dart';
import 'widgets/info_row.dart';
import 'data/code_snippets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize syntax highlighter with Dart language support
  await Highlighter.initialize(['dart']);
  // Configure FontConfig for different languages (optional)
  // If not configured, Flutter's default font will be used
  FontConfig.instance.setLanguageFont(
    LanguageFontConfig(languageCode: 'ar', googleFont: GoogleFonts.almarai),
  );

  FontConfig.instance.setLanguageFont(
    LanguageFontConfig(languageCode: 'en', googleFont: GoogleFonts.inter),
  );

  // Configure font for language group
  FontConfig.instance.setLanguageGroupFont(
    LanguageGroupFontConfig(
      languageCodes: ['ar', 'fa', 'ur'],
      googleFont: GoogleFonts.almarai,
    ),
  );

  // Set default font (used when no specific language config exists)
  FontConfig.instance.setDefaultFont(googleFont: GoogleFonts.inter);

  runApp(const MyApp());
}

/// Main app widget - ScaleKitBuilder wraps MaterialApp at the top level
/// This allows ScaleKit to be available throughout the entire app
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ValueNotifier<bool> _enabled = ValueNotifier<bool>(true);
  bool _autoScale = true;
  bool _autoScaleLandscape = true;
  bool _autoScalePortrait = false;
  int _builderVersion = 0;

  // Device Preview (testing only, debug mode only, default disabled)
  bool _devicePreviewEnabled = false;

  double _mobileLandscapeFontBoost = 1.2;
  double _mobileLandscapeSizeBoost = 1.2;
  double _tabletLandscapeFontBoost = 1.2;
  double _tabletLandscapeSizeBoost = 1.2;
  double _desktopLandscapeFontBoost = 1.0;
  double _desktopLandscapeSizeBoost = 1.0;

  double _mobilePortraitFontBoost = 1.0;
  double _mobilePortraitSizeBoost = 1.0;
  double _tabletPortraitFontBoost = 1.0;
  double _tabletPortraitSizeBoost = 1.0;
  double _desktopPortraitFontBoost = 1.0;
  double _desktopPortraitSizeBoost = 1.0;

  // Scale limits: null = auto-detect (intelligent defaults)
  // Users can enable manual control from settings
  double? _minScale;
  double? _maxScale;

  @override
  void initState() {
    super.initState();
    // Set up device_preview callback for ScaleManager (testing only)
    // Note: device_preview platform detection may not work correctly
    // This is for visual testing only
    // Works in both debug and release builds (for web deployment)
    ScaleManager.setDevicePreviewPlatformGetter((context) {
      if (!_devicePreviewEnabled || context == null) return null;
      // Note: device_preview doesn't provide a reliable way to get the simulated platform
      // This is a limitation - device detection may not work correctly with device_preview
      // This feature is for visual testing only
      return null; // Return null to use default platform detection
    });
  }

  void _toggleDevicePreview() {
    setState(() {
      _devicePreviewEnabled = !_devicePreviewEnabled;
      // Force rebuild when toggling device preview
      _builderVersion++;
    });
  }

  // Direct activation without dialog (for banner button)
  void _activateDevicePreviewDirectly() {
    if (_devicePreviewEnabled) {
      // Already enabled, do nothing
      return;
    }
    // Directly activate without any dialog
    setState(() {
      _devicePreviewEnabled = true;
      // Force rebuild when activating device preview
      _builderVersion++;
    });
  }

  void _onDevicePreviewChanged() {
    // Force rebuild when device changes in device_preview
    setState(() {
      _builderVersion++;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget app = ScaleKitBuilder(
      key: ValueKey(_builderVersion),
      designWidth: 375,
      designHeight: 812,
      designType: DeviceType.mobile,

      // 🧠 INTELLIGENT AUTO-CONFIGURATION:
      // minScale & maxScale are null by default, enabling smart auto-detection!
      // The package automatically determines optimal scale limits based on:
      // - Device type (mobile: 0.85-1.15x, tablet: 0.8-1.3x, desktop: 0.6-2.0x)
      // - Orientation (landscape gets wider range than portrait)
      // - Screen size and aspect ratio (handles foldables, ultra-wide, etc.)
      //
      // 95% of apps work perfectly without manual configuration!
      // Toggle "Manual Scale Control" in settings to override if needed.
      minScale: _minScale, // null = auto (recommended)
      maxScale: _maxScale, // null = auto (recommended)
      // Autoscale options
      autoScale: _autoScale,
      autoScaleLandscape: _autoScaleLandscape,
      autoScalePortrait: _autoScalePortrait,
      enabledListenable: _enabled,
      enabled: _enabled.value,

      // 🔄 ORIENTATION BOOSTS (Applied AFTER scale clamping):
      // These multiply the final scaled values to optimize readability/usability
      // when devices rotate. Smart defaults: mobile/tablet landscape = 1.2x boost.
      //
      // Math example (iPhone landscape):
      //   1. Raw scale: 852/375 = 2.27x width
      //   2. Clamped: 1.25x (mobile landscape limit)
      //   3. Boost applied: 1.25 × 1.2 = 1.5x final
      //   Result: 16.sp = 16 × 1.5 = 24px (more readable in landscape!)
      //
      // Customize these only for specialized UIs:
      //   - Dense dashboards: set to 1.0 (no boost)
      //   - Reading apps: increase font boost (e.g., 1.4) while keeping size lower (1.1)
      //   - Kiosks: boost portrait mode for vertical tablets
      //
      // Separate font & size boosts let text scale differently from UI elements!
      mobileLandscapeFontBoost: _mobileLandscapeFontBoost, // Default: 1.2
      mobileLandscapeSizeBoost: _mobileLandscapeSizeBoost, // Default: 1.2
      tabletLandscapeFontBoost: _tabletLandscapeFontBoost, // Default: 1.2
      tabletLandscapeSizeBoost: _tabletLandscapeSizeBoost, // Default: 1.2
      desktopLandscapeFontBoost: _desktopLandscapeFontBoost, // Default: 1.0
      desktopLandscapeSizeBoost: _desktopLandscapeSizeBoost, // Default: 1.0
      mobilePortraitFontBoost: _mobilePortraitFontBoost, // Default: 1.0
      mobilePortraitSizeBoost: _mobilePortraitSizeBoost, // Default: 1.0
      tabletPortraitFontBoost: _tabletPortraitFontBoost, // Default: 1.0
      tabletPortraitSizeBoost: _tabletPortraitSizeBoost, // Default: 1.0
      desktopPortraitFontBoost: _desktopPortraitFontBoost, // Default: 1.0
      desktopPortraitSizeBoost: _desktopPortraitSizeBoost, // Default: 1.0
      child: MaterialApp(
        title: 'Flutter Scale Kit - Complete Examples',
        debugShowCheckedModeBanner: false,
        theme: ResponsiveThemeData.create(
          context: context,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF6750A4), // Material 3 purple
            brightness: Brightness.light,
          ),
          useMaterial3: true,
        ).copyWith(
          scaffoldBackgroundColor: const Color(0xFFF5F5F5),
          cardTheme: CardTheme(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: Colors.grey.shade200, width: 1),
            ),
            color: Colors.white,
          ),
        ),
        home: HomePage(
          enabled: _enabled,
          openSettings: _openSettings,
          devicePreviewEnabled: _devicePreviewEnabled,
          onDevicePreviewToggle: _toggleDevicePreview,
          onDevicePreviewActivateDirectly: _activateDevicePreviewDirectly,
          onDevicePreviewChanged: _onDevicePreviewChanged,
        ),
      ),
    );

    // Wrap with DevicePreview if enabled (works in both debug and release builds)
    if (_devicePreviewEnabled) {
      return DevicePreview(enabled: true, builder: (context) => app);
    }

    return app;
  }

  void _openSettings(BuildContext hostContext) {
    SettingsSheet.show(
      hostContext,
      enabled: _enabled,
      autoScale: _autoScale,
      autoScaleLandscape: _autoScaleLandscape,
      autoScalePortrait: _autoScalePortrait,
      minScale: _minScale,
      maxScale: _maxScale,
      mobileLandscapeFontBoost: _mobileLandscapeFontBoost,
      mobileLandscapeSizeBoost: _mobileLandscapeSizeBoost,
      tabletLandscapeFontBoost: _tabletLandscapeFontBoost,
      tabletLandscapeSizeBoost: _tabletLandscapeSizeBoost,
      desktopLandscapeFontBoost: _desktopLandscapeFontBoost,
      desktopLandscapeSizeBoost: _desktopLandscapeSizeBoost,
      mobilePortraitFontBoost: _mobilePortraitFontBoost,
      mobilePortraitSizeBoost: _mobilePortraitSizeBoost,
      tabletPortraitFontBoost: _tabletPortraitFontBoost,
      tabletPortraitSizeBoost: _tabletPortraitSizeBoost,
      desktopPortraitFontBoost: _desktopPortraitFontBoost,
      desktopPortraitSizeBoost: _desktopPortraitSizeBoost,
      onSave: (
        enabled,
        autoScale,
        autoScaleLandscape,
        autoScalePortrait,
        minScale,
        maxScale,
        mobileLandscapeFontBoost,
        mobileLandscapeSizeBoost,
        tabletLandscapeFontBoost,
        tabletLandscapeSizeBoost,
        desktopLandscapeFontBoost,
        desktopLandscapeSizeBoost,
        mobilePortraitFontBoost,
        mobilePortraitSizeBoost,
        tabletPortraitFontBoost,
        tabletPortraitSizeBoost,
        desktopPortraitFontBoost,
        desktopPortraitSizeBoost,
      ) async {
        setState(() {
          _autoScale = autoScale;
          _autoScaleLandscape = autoScaleLandscape;
          _autoScalePortrait = autoScalePortrait;
          _minScale = minScale;
          _maxScale = maxScale;
          _mobileLandscapeFontBoost = mobileLandscapeFontBoost;
          _mobileLandscapeSizeBoost = mobileLandscapeSizeBoost;
          _tabletLandscapeFontBoost = tabletLandscapeFontBoost;
          _tabletLandscapeSizeBoost = tabletLandscapeSizeBoost;
          _desktopLandscapeFontBoost = desktopLandscapeFontBoost;
          _desktopLandscapeSizeBoost = desktopLandscapeSizeBoost;
          _mobilePortraitFontBoost = mobilePortraitFontBoost;
          _mobilePortraitSizeBoost = mobilePortraitSizeBoost;
          _tabletPortraitFontBoost = tabletPortraitFontBoost;
          _tabletPortraitSizeBoost = tabletPortraitSizeBoost;
          _desktopPortraitFontBoost = desktopPortraitFontBoost;
          _desktopPortraitSizeBoost = desktopPortraitSizeBoost;
        });
        // Force-apply: toggle disable -> wait -> restore target enabled
        final bool targetEnabled = enabled;
        _enabled.value = false;
        await Future.delayed(const Duration(milliseconds: 30));
        _enabled.value = targetEnabled;
        // Nudge a full rebuild of the ScaleKitBuilder subtree
        setState(() {
          _builderVersion++;
        });
      },
    );
  }
}

/// Main example page with comprehensive demonstrations
class HomePage extends StatelessWidget {
  final ValueNotifier<bool> enabled;
  final void Function(BuildContext) openSettings;
  final bool devicePreviewEnabled;
  final VoidCallback onDevicePreviewToggle;
  final VoidCallback onDevicePreviewActivateDirectly;
  final VoidCallback onDevicePreviewChanged;

  const HomePage({
    super.key,
    required this.enabled,
    required this.openSettings,
    required this.devicePreviewEnabled,
    required this.onDevicePreviewToggle,
    required this.onDevicePreviewActivateDirectly,
    required this.onDevicePreviewChanged,
  });

  // Helper to check if running on desktop (Windows, macOS, Linux) or web
  bool _isDesktop() {
    if (kIsWeb) return true;
    return defaultTargetPlatform == TargetPlatform.windows ||
        defaultTargetPlatform == TargetPlatform.macOS ||
        defaultTargetPlatform == TargetPlatform.linux;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Scale Kit'),
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        foregroundColor: Colors.grey.shade900,
        actions: [
          Row(
            children: [
              const Text('Enabled'),
              ValueListenableBuilder<bool>(
                valueListenable: enabled,
                builder:
                    (_, value, __) => Switch(
                      value: value,
                      onChanged: (v) => enabled.value = v,
                    ),
              ),
              SizedBox(width: 8.w),
              ValueListenableBuilder<bool>(
                valueListenable: enabled,
                builder: (context, isEnabled, _) {
                  if (!isEnabled) return const SizedBox.shrink();
                  return IconButton(
                    tooltip: 'Configure Scale Kit',
                    icon: const Icon(Icons.tune),
                    onPressed: () => openSettings(context),
                  );
                },
              ),
              // Device Preview Toggle (web/desktop only, testing only)
              // Works in both debug and release builds
              if (_isDesktop()) ...[
                SizedBox(width: 8.w),
                Tooltip(
                  message:
                      'Device Preview (Testing Only)\n'
                      '⚠️ WARNING: This is for testing only!\n'
                      'Device detection may not work correctly.\n'
                      'Reload after changing devices.',
                  child: IconButton(
                    icon: Icon(
                      devicePreviewEnabled
                          ? Icons.phone_android
                          : Icons.phone_android_outlined,
                      color: devicePreviewEnabled ? Colors.orange : Colors.grey,
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder:
                            (context) => AlertDialog(
                              title: const Text('Device Preview'),
                              content: const Text(
                                '⚠️ WARNING: This is for testing only!\n\n'
                                'Device Preview allows you to test your app on different device sizes and platforms.\n\n'
                                'IMPORTANT:\n'
                                '• Device detection may not work correctly\n'
                                '• Mobile/tablet detection may be inaccurate\n'
                                '• You must reload the app after changing devices\n'
                                '• This should only be used for visual testing\n'
                                '• Do not rely on this for production behavior\n\n'
                                'This feature is available on web/desktop.',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    onDevicePreviewToggle();
                                  },
                                  child: Text(
                                    devicePreviewEnabled ? 'Disable' : 'Enable',
                                  ),
                                ),
                              ],
                            ),
                      );
                    },
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Device Preview Banner (desktop/web only, when not active)
            // Works in both debug and release builds
            if (_isDesktop() && !devicePreviewEnabled)
              _buildDevicePreviewBanner(),
            if (_isDesktop() && !devicePreviewEnabled) SizedBox(height: 24.h),
            // Quick Start Section
            const SectionTitle(
              title: '🚀 Quick Start',
              subtitle: 'Extension methods (.w, .h, .sp)',
            ),
            SizedBox(height: 12.h),
            _buildQuickStartExample(),
            SizedBox(height: 24.h),

            // Autoscale Orientation Info
            const SectionTitle(
              title: '🧭 Autoscale Orientation',
              subtitle: 'Landscape on by default, Portrait off',
            ),
            SizedBox(height: 12.h),
            _buildAutoscaleOrientationInfo(),
            SizedBox(height: 24.h),
            _buildEnableToggleInfo(),
            SizedBox(height: 24.h),

            // Extension Methods
            const SectionTitle(
              title: '📐 Extension Methods',
              subtitle: 'All available extensions',
            ),
            SizedBox(height: 12.h),
            _buildExtensionMethodsExample(),
            SizedBox(height: 24.h),

            // Responsive Builder & Columns
            const SectionTitle(
              title: '🧩 Responsive Builder & Columns',
              subtitle: 'Build per device/orientation and resolve grid counts',
            ),
            SizedBox(height: 12.h),
            _buildResponsiveExamples(),
            SizedBox(height: 24.h),

            // SKit Helper Class
            const SectionTitle(
              title: '🛠️ SKit Helper Class',
              subtitle: 'Short and easy to use',
            ),
            SizedBox(height: 12.h),
            _buildSKitHelperExample(),
            SizedBox(height: 24.h),

            // Size System
            const SectionTitle(
              title: '📏 Size System',
              subtitle: 'xs, sm, md, lg, xl, xxl',
            ),
            SizedBox(height: 12.h),
            _buildSizeSystemExample(),
            SizedBox(height: 24.h),

            // Text Size System
            const SectionTitle(
              title: '🔤 Text Size System',
              subtitle: 'SKTextSize (s6 to s52)',
            ),
            SizedBox(height: 12.h),
            _buildTextSizeSystemExample(),
            SizedBox(height: 24.h),

            // ScaleKitDesignValues - Centralized Design
            const SectionTitle(
              title: '🎨 ScaleKitDesignValues',
              subtitle: 'Define all values in one place',
            ),
            SizedBox(height: 12.h),
            _buildDesignValuesExample(),
            SizedBox(height: 24.h),

            // Font Configuration
            const SectionTitle(
              title: '🔤 Font Configuration',
              subtitle: 'Automatic font selection per language',
            ),
            SizedBox(height: 12.h),
            _buildFontConfigExample(),
            SizedBox(height: 24.h),

            // Optimized Widgets
            const SectionTitle(
              title: '⚡ Optimized Widgets',
              subtitle: 'SKPadding, SKContainer, HSpace, VSpace',
            ),
            SizedBox(height: 12.h),
            _buildOptimizedWidgetsExample(),
            SizedBox(height: 24.h),

            // Context Extensions
            const SectionTitle(
              title: '🔗 Context Extensions',
              subtitle: 'context.scalePadding(), context.isMobile',
            ),
            SizedBox(height: 12.h),
            _buildContextExtensionsExample(context),
            SizedBox(height: 24.h),

            // ScaleManager Direct Usage
            const SectionTitle(
              title: '⚙️ ScaleManager',
              subtitle: 'Direct API access',
            ),
            SizedBox(height: 12.h),
            _buildScaleManagerExample(),
            SizedBox(height: 24.h),

            // Device Information
            const SectionTitle(
              title: '📱 Device Information',
              subtitle: 'All available properties',
            ),
            SizedBox(height: 12.h),
            _buildDeviceInfoExample(context),
            SizedBox(height: 24.h),

            // Live Scaling Debug
            const SectionTitle(
              title: '🔍 Live Scaling Debug',
              subtitle: 'Watch values change on resize/orientation',
            ),
            SizedBox(height: 12.h),
            const LiveScalingDebug(),
            SizedBox(height: 24.h),

            // Performance Tips
            const SectionTitle(
              title: '💡 Performance Tips',
              subtitle: 'Best practices',
            ),
            SizedBox(height: 12.h),
            _buildPerformanceTipsExample(),
            SizedBox(height: 24.h),

            // Heavy Pages (Stress Test)
            const NavigationButtons(),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }

  // ============================================================================
  // AUTOSCALE ORIENTATION INFO
  // ============================================================================
  Widget _buildAutoscaleOrientationInfo() {
    return SectionCard(
      title: 'Orientation-Specific Autoscale',
      subtitle: 'Landscape on by default, Portrait off',
      description:
          'By default: autoScaleLandscape=true, autoScalePortrait=false. This keeps portrait UI stable while allowing readability boosts in landscape. You can configure device-specific font and size boosts per orientation.',
      code: CodeSnippets.scaleKitBuilder,
      codeLanguage: 'dart',
      interactive: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '💡 Tip: Use the settings (tune icon) in the AppBar to live-test autoscale flags and boosts, then Save to apply.',
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.blue.shade700,
              fontStyle: FontStyle.italic,
            ),
          ),
          SizedBox(height: 8.h),
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              borderRadius: BorderRadius.circular(8.rSafe),
              border: Border.all(color: Colors.orange.shade200, width: 1),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  size: 18.sp,
                  color: Colors.orange.shade700,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    'Compared to flutter_screenutil: when resizing desktop windows, its cards often scale disproportionately. Scale Kit keeps practical sizes due to clamped scales and orientation-aware boosts.',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.orange.shade900,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================================
  // ENABLE TOGGLE INFO
  // ============================================================================
  Widget _buildEnableToggleInfo() {
    return SectionCard(
      title: 'Enable/Disable Scaling (Runtime Toggle)',
      description:
          'You can turn scaling off entirely to compare against raw Flutter sizes. This is useful for debugging and understanding the impact of scaling.',
      code: CodeSnippets.enableToggle,
      codeLanguage: 'dart',
      interactive: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(8.rSafe),
              border: Border.all(color: Colors.green.shade200, width: 1),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.toggle_on,
                  size: 18.sp,
                  color: Colors.green.shade700,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    'Use the switch in the AppBar to toggle Scale Kit on/off and visually compare against Flutter\'s raw sizes.',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.green.shade900,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'When disabled, .w/.h/.sp and ScaleManager methods return the input value (no scaling). Re-enable to restore responsive scaling.',
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey.shade600,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================================
  // DEVICE PREVIEW BANNER
  // ============================================================================
  Widget _buildDevicePreviewBanner() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.orange.shade50, Colors.amber.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.rSafe),
        border: Border.all(color: Colors.orange.shade300, width: 2.w),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.shade200.withOpacity(0.3),
            blurRadius: 8.rSafe,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 600;

          if (isWide) {
            // Wide layout: Row
            return Row(
              children: [
                // Icon
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade100,
                    borderRadius: BorderRadius.circular(12.rSafe),
                  ),
                  child: Icon(
                    Icons.phone_android,
                    size: 32.sp,
                    color: Colors.orange.shade700,
                  ),
                ),
                SizedBox(width: 16.w),
                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '📱 Test on Different Devices',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange.shade900,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Activate Device Preview to test your app on different device sizes and platforms. Perfect for visual testing and responsive design validation.',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.orange.shade800,
                          height: 1.4,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            size: 16.sp,
                            color: Colors.orange.shade700,
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            'Click the phone icon in the AppBar to activate',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.orange.shade700,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16.w),
                // Action Button - Direct activation without dialog
                ElevatedButton.icon(
                  onPressed:
                      devicePreviewEnabled
                          ? null // Disable if already enabled
                          : () {
                            // Direct activation without dialog
                            onDevicePreviewActivateDirectly();
                          },
                  icon: Icon(Icons.phone_android, size: 20.sp),
                  label: Text(
                    devicePreviewEnabled ? 'Activated' : 'Activate',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        devicePreviewEnabled
                            ? Colors.green.shade600
                            : Colors.orange.shade600,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: Colors.green.shade400,
                    disabledForegroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.w,
                      vertical: 12.h,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.rSafe),
                    ),
                    elevation: 2,
                  ),
                ),
              ],
            );
          } else {
            // Narrow layout: Column
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // Icon
                    Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: Colors.orange.shade100,
                        borderRadius: BorderRadius.circular(12.rSafe),
                      ),
                      child: Icon(
                        Icons.phone_android,
                        size: 32.sp,
                        color: Colors.orange.shade700,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        '📱 Test on Different Devices',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange.shade900,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                Text(
                  'Activate Device Preview to test your app on different device sizes and platforms. Perfect for visual testing and responsive design validation.',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.orange.shade800,
                    height: 1.4,
                  ),
                ),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      size: 16.sp,
                      color: Colors.orange.shade700,
                    ),
                    SizedBox(width: 6.w),
                    Expanded(
                      child: Text(
                        'Click the phone icon in the AppBar to activate',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.orange.shade700,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                // Action Button (full width on narrow screens) - Direct activation without dialog
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed:
                        devicePreviewEnabled
                            ? null // Disable if already enabled
                            : () {
                              // Direct activation without dialog
                              onDevicePreviewActivateDirectly();
                            },
                    icon: Icon(Icons.phone_android, size: 20.sp),
                    label: Text(
                      devicePreviewEnabled
                          ? 'Device Preview Activated'
                          : 'Activate Device Preview',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          devicePreviewEnabled
                              ? Colors.green.shade600
                              : Colors.orange.shade600,
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: Colors.green.shade400,
                      disabledForegroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w,
                        vertical: 12.h,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.rSafe),
                      ),
                      elevation: 2,
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  // ============================================================================
  // QUICK START EXAMPLE
  // ============================================================================
  Widget _buildQuickStartExample() {
    return SectionCard(
      title: 'Basic Usage (Like flutter_screenutil)',
      description:
          'Use extension methods (.w, .h, .sp, .rSafe, .r, .rFixed) to scale or lock your UI elements. The syntax is similar to flutter_screenutil, making migration easy.',
      code: CodeSnippets.quickStart,
      codeLanguage: 'dart',
      result: Container(
        width: 200.w,
        height: 100.h,
        decoration: BoxDecoration(
          color: Colors.blue.shade100,
          borderRadius: BorderRadius.circular(12.rSafe),
        ),
        padding: EdgeInsets.all(16.w),
        child: Center(
          child: Text(
            '200.w × 100.h',
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  // ============================================================================
  // EXTENSION METHODS EXAMPLE
  // ============================================================================
  Widget _buildExtensionMethodsExample() {
    return Column(
      children: [
        SectionCard(
          title: 'All Extension Methods',
          description:
              'All extension methods work similar to flutter_screenutil. Use them to scale widths, heights, fonts, radii—with .rSafe for stable corners, .r for fully responsive, and .rFixed for hard constants.',
          code: CodeSnippets.extensionMethods,
          codeLanguage: 'dart',
          result: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ExtensionRow(
                label: '.w - Width scaling',
                code: '200.w',
                value: 200.w,
              ),
              ExtensionRow(
                label: '.h - Height scaling',
                code: '100.h',
                value: 100.h,
              ),
              ExtensionRow(
                label: '.sp - Font size',
                code: '16.sp',
                value: 16.sp,
              ),
              ExtensionRow(
                label: '.rSafe - Stable radius',
                code: '12.rSafe',
                value: 12.rSafe,
              ),
              ExtensionRow(
                label: '.r - Full responsive radius',
                code: '12.r',
                value: 12.r,
              ),
              ExtensionRow(
                label: '.rFixed - Constant radius',
                code: '12.rFixed',
                value: 12.rFixed,
              ),
              ExtensionRow(
                label: '.sw - Screen width %',
                code: '0.5.sw',
                value: 0.5.sw,
              ),
              ExtensionRow(
                label: '.sh - Screen height %',
                code: '0.3.sh',
                value: 0.3.sh,
              ),
              ExtensionRow(
                label: '.spf - Font with factor',
                code: '14.spf',
                value: 14.spf,
              ),
              SizedBox(height: 12.h),
              Container(
                width: 0.5.sw,
                height: 80.h,
                decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  borderRadius: BorderRadius.circular(12.rSafe),
                ),
                child: Center(
                  child: Text(
                    '50% Screen Width (.rSafe corners)',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        ComparisonCard(
          title: 'Scale Kit vs flutter_screenutil vs Raw Flutter',
          description:
              'Compare how the same code behaves with different scaling approaches. Resize the window to see the difference!',
          items: [
            ComparisonItem(
              label: 'Flutter Scale Kit',
              color: Colors.purple,
              code: CodeSnippets.comparisonScaleKit,
              result: Container(
                width: 200.w,
                height: 100.h,
                decoration: BoxDecoration(
                  color: Colors.purple.shade100,
                  borderRadius: BorderRadius.circular(8.rSafe),
                ),
                child: Center(
                  child: Text(
                    '200.w × 100.h',
                    style: TextStyle(fontSize: 16.sp),
                  ),
                ),
              ),
            ),
            ComparisonItem(
              label: 'flutter_screenutil',
              color: Colors.blue,
              code: CodeSnippets.comparisonScreenUtil,
              result: su.ScreenUtilInit(
                designSize: const Size(375, 812),
                builder:
                    (context, child) => Container(
                      width: 200 * su.ScreenUtil().scaleWidth,
                      height: 100 * su.ScreenUtil().scaleHeight,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          '200.w × 100.h',
                          style: TextStyle(
                            fontSize: 16 * su.ScreenUtil().scaleText,
                          ),
                        ),
                      ),
                    ),
              ),
              note: 'Same syntax, but different scaling algorithm',
            ),
            ComparisonItem(
              label: 'Raw Flutter (No Scaling)',
              color: Colors.grey,
              code: CodeSnippets.comparisonRawFlutter,
              result: Container(
                width: 200,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text('200 × 100', style: TextStyle(fontSize: 16)),
                ),
              ),
              note: 'Fixed sizes - not responsive',
            ),
          ],
        ),
      ],
    );
  }

  // ============================================================================
  // RESPONSIVE BUILDER & COLUMNS EXAMPLES
  // ============================================================================
  Widget _buildResponsiveExamples() {
    return Column(
      children: [
        SectionCard(
          title: 'SKResponsive Widget',
          subtitle: 'Widget builder with fallbacks',
          description:
              'Build different widgets per device/orientation with sensible fallbacks. Falls back to mobile → tablet → desktop.',
          code: CodeSnippets.skResponsive,
          codeLanguage: 'dart',
          result: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8.rSafe),
            ),
            padding: EdgeInsets.all(12.w),
            child: SKResponsive(
              mobile:
                  (_) => Text(
                    'Mobile portrait',
                    style: TextStyle(fontSize: 12.sp),
                  ),
              mobileLandscape:
                  (_) => Text(
                    'Mobile landscape',
                    style: TextStyle(fontSize: 12.sp),
                  ),
              tablet:
                  (_) => Text(
                    'Tablet portrait',
                    style: TextStyle(fontSize: 12.sp),
                  ),
              tabletLandscape:
                  (_) => Text(
                    'Tablet landscape',
                    style: TextStyle(fontSize: 12.sp),
                  ),
              desktop:
                  (_) => Text('Desktop', style: TextStyle(fontSize: 12.sp)),
            ),
          ),
        ),
        SizedBox(height: 16.h),
        SectionCard(
          title: 'SKResponsiveBuilder',
          subtitle: 'Builder pattern with device/orientation info',
          description:
              'Supports two usage patterns: main builder with device/orientation context, or device-specific builders. Device-specific builders take priority.',
          code: CodeSnippets.skResponsiveBuilder,
          codeLanguage: 'dart',
          result: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(8.rSafe),
                ),
                padding: EdgeInsets.all(12.w),
                child: SKResponsiveBuilder(
                  builder: (context, device, orientation) {
                    String deviceText;
                    String orientationText =
                        orientation == Orientation.landscape
                            ? 'Landscape'
                            : 'Portrait';

                    switch (device) {
                      case DeviceType.mobile:
                        deviceText = 'Mobile';
                        break;
                      case DeviceType.tablet:
                        deviceText = 'Tablet';
                        break;
                      case DeviceType.desktop:
                      case DeviceType.web:
                        deviceText = 'Desktop';
                        break;
                    }

                    return Text(
                      '$deviceText $orientationText',
                      style: TextStyle(fontSize: 12.sp),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        SectionCard(
          title: 'SKit.responsiveInt / responsiveDouble',
          subtitle: 'Resolve responsive integers (e.g., Grid columns)',
          description:
              'Quickly resolve integer/double values based on device type and orientation with fallback logic. Perfect for GridView crossAxisCount.',
          code: CodeSnippets.skitHelper,
          codeLanguage: 'dart',
          result: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Builder(
                builder: (context) {
                  final cols = SKit.responsiveInt(
                    mobile: 2,
                    tablet: 4,
                    desktop: 8,
                  );
                  return Text(
                    'Resolved columns: $cols',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  );
                },
              ),
              SizedBox(height: 8.h),
              Container(
                height: 120.h,
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8.rSafe),
                ),
                child: GridView.count(
                  crossAxisCount: SKit.responsiveInt(
                    mobile: 2,
                    tablet: 4,
                    desktop: 8,
                  ),
                  crossAxisSpacing: 8.w,
                  mainAxisSpacing: 8.h,
                  children: List.generate(
                    8,
                    (i) => Container(color: Colors.blue[(i % 9 + 1) * 100]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ============================================================================
  // SKIT HELPER CLASS EXAMPLE
  // ============================================================================
  Widget _buildSKitHelperExample() {
    return Column(
      children: [
        SectionCard(
          title: 'SKit Helper Methods',
          subtitle: 'Short and easy to use',
          description:
              'The SKit class provides convenient methods for creating widgets with padding, margin, rounded containers, spacing, and text.',
          code: CodeSnippets.skitMethods,
          codeLanguage: 'dart',
          result: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Padding:',
                style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4.h),
              SKit.padding(
                all: 16,
                child: Container(
                  color: Colors.blue.shade100,
                  padding: EdgeInsets.all(8.w),
                  child: Text(
                    'SKit.padding(all: 16)',
                    style: TextStyle(fontSize: 14.sp),
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                'Margin:',
                style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4.h),
              SKit.margin(
                12,
                Container(
                  color: Colors.green.shade100,
                  padding: EdgeInsets.all(8.w),
                  child: Text(
                    'SKit.margin(12)',
                    style: TextStyle(fontSize: 14.sp),
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                'Rounded Container:',
                style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4.h),
              SKit.roundedContainer(
                all: 16,
                color: Colors.purple.shade100,
                child: Padding(
                  padding: EdgeInsets.all(12.w),
                  child: Text(
                    'SKit.roundedContainer(all: 16)',
                    style: TextStyle(fontSize: 14.sp),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        SectionCard(
          title: 'Rounded Container with Borders',
          subtitle: 'Flexible border options',
          description:
              'Most containers need both border radius and border. Use borderColor and borderWidth parameters. You can specify borders on individual sides with different colors and widths.',
          code: CodeSnippets.roundedContainerBorders,
          codeLanguage: 'dart',
          result: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SKit.roundedContainer(
                all: 12,
                color: Colors.blue.shade50,
                borderColor: Colors.blue,
                borderWidth: 2,
                child: Padding(
                  padding: EdgeInsets.all(12.w),
                  child: Text(
                    'Border on all sides',
                    style: TextStyle(fontSize: 14.sp),
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              SKit.roundedContainer(
                all: 12,
                color: Colors.green.shade50,
                borderTop: true,
                borderBottom: true,
                borderColor: Colors.green,
                borderWidth: 2,
                child: Padding(
                  padding: EdgeInsets.all(12.w),
                  child: Text(
                    'Border on top & bottom only',
                    style: TextStyle(fontSize: 14.sp),
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              SKit.roundedContainer(
                all: 12,
                color: Colors.orange.shade50,
                borderLeft: true,
                borderRight: true,
                borderColor: Colors.orange,
                borderWidth: 2,
                child: Padding(
                  padding: EdgeInsets.all(12.w),
                  child: Text(
                    'Border on left & right only',
                    style: TextStyle(fontSize: 14.sp),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        SectionCard(
          title: 'Rounded Container Decorations',
          subtitle: 'Gradients, shadows & images',
          description:
              'Combine gradient, elevation, shadow color, and backgroundImage to build rich surfaces.',
          code: CodeSnippets.roundedContainerDecorations,
          codeLanguage: 'dart',
          result: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SKit.roundedContainer(
                all: 16,
                gradient: const LinearGradient(
                  colors: [Color(0xFF7F7FD5), Color(0xFF86A8E7)],
                ),
                elevation: 8,
                shadowColor: Colors.black45,
                padding: EdgeInsets.all(16.w),
                child: Text(
                  'Gradient with elevation helper',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              SKit.roundedContainer(
                all: 20,
                backgroundImage: const DecorationImage(
                  image: AssetImage('assets/images/rounded_bg.png'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black38,
                    BlendMode.darken,
                  ),
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 24,
                    offset: Offset(0, 14),
                  ),
                ],
                padding: EdgeInsets.all(20.w),
                child: Text(
                  'Background image + box shadow',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ============================================================================
  // SIZE SYSTEM EXAMPLE
  // ============================================================================
  Widget _buildSizeSystemExample() {
    return Column(
      children: [
        SectionCard(
          title: 'Size System (SKSize)',
          subtitle: 'xs, sm, md, lg, xl, xxl',
          description:
              'Predefined size enums for consistent design. Configure your size values at app startup (in main()) before using size enums. Default values: xs=2, sm=4, md=8, lg=12, xl=16, xxl=24.',
          code: CodeSnippets.sizeSystem,
          codeLanguage: 'dart',
          result: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Size Values:',
                style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.h),
              Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: [
                  SizeBox(
                    label: 'xs',
                    size: SKSize.xs,
                    color: Colors.red.shade100,
                  ),
                  SizeBox(
                    label: 'sm',
                    size: SKSize.sm,
                    color: Colors.orange.shade100,
                  ),
                  SizeBox(
                    label: 'md',
                    size: SKSize.md,
                    color: Colors.yellow.shade100,
                  ),
                  SizeBox(
                    label: 'lg',
                    size: SKSize.lg,
                    color: Colors.green.shade100,
                  ),
                  SizeBox(
                    label: 'xl',
                    size: SKSize.xl,
                    color: Colors.blue.shade100,
                  ),
                  SizeBox(
                    label: 'xxl',
                    size: SKSize.xxl,
                    color: Colors.purple.shade100,
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Text(
                'Using Size Enums:',
                style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.h),
              SKit.paddingSize(
                all: SKSize.md,
                child: SKit.roundedContainerSize(
                  all: SKSize.md,
                  color: Colors.purple.shade100,
                  child: Padding(
                    padding: SKit.paddingEdgeInsetsSize(all: SKSize.sm),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'SKit.paddingSize(all: SKSize.md)',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'SKit.roundedContainerSize(all: SKSize.md)',
                          style: TextStyle(fontSize: 12.sp),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        SectionCard(
          title: 'Custom Size Values',
          subtitle: 'Configure your own size values',
          description:
              'You can customize size values to match your design system. Set them once at app startup, then use size enums throughout your app.',
          code: CodeSnippets.customSizeValues,
          codeLanguage: 'dart',
          result: Builder(
            builder: (context) {
              setPaddingSizes(
                SizeValues.custom(
                  xs: 4,
                  sm: 8,
                  md: 16,
                  lg: 24,
                  xl: 32,
                  xxl: 48,
                ),
              );
              setRadiusSizes(
                SizeValues.custom(xs: 2, sm: 4, md: 8, lg: 12, xl: 16, xxl: 24),
              );
              return SKit.paddingSize(
                all: SKSize.md,
                child: SKit.roundedContainerSize(
                  all: SKSize.md,
                  color: Colors.green.shade100,
                  child: Padding(
                    padding: SKit.paddingEdgeInsetsSize(all: SKSize.sm),
                    child: Text(
                      'Custom sizes: md padding=16, md radius=8',
                      style: TextStyle(fontSize: 12.sp),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 16.h),
        SectionCard(
          title: 'Default Values',
          subtitle: 'Use methods without parameters',
          description:
              'Set default values once, then use methods without parameters for cleaner code.',
          code: CodeSnippets.defaultValues,
          codeLanguage: 'dart',
          result: Builder(
            builder: (context) {
              setDefaultPadding(20);
              setDefaultMargin(10);
              setDefaultRadius(15);
              setDefaultSpacing(12);
              return SKit.pad(
                SKit.margin(
                  SKit.rounded(
                    null,
                    Padding(
                      padding: EdgeInsets.all(12.w),
                      child: Column(
                        children: [
                          Text(
                            'SKit.pad() - uses default (20)',
                            style: TextStyle(fontSize: 12.sp),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'SKit.margin() - uses default (10)',
                            style: TextStyle(fontSize: 12.sp),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'SKit.rounded() - uses default safe radius (15)',
                            style: TextStyle(fontSize: 12.sp),
                          ),
                        ],
                      ),
                    ),
                    Colors.orange.shade100,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // ============================================================================
  // TEXT SIZE SYSTEM EXAMPLE
  // ============================================================================
  Widget _buildTextSizeSystemExample() {
    return SectionCard(
      title: 'Text Size System (SKTextSize)',
      subtitle: 's6 to s52',
      description:
          'Predefined text size enums for consistent typography. Available sizes: s6, s8, s10, s11, s12, s13, s14, s15, s16, s17, s18, s20, s22, s24, s26, s28, s30, s32, s34, s36, s40, s48, s52.',
      code: CodeSnippets.textSizeSystem,
      codeLanguage: 'dart',
      result: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Small Sizes:',
            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4.h),
          SKit.text('s10 - Small labels', textSize: SKTextSize.s10),
          SKit.text('s12 - Body small', textSize: SKTextSize.s12),
          SKit.text('s14 - Body medium (default)', textSize: SKTextSize.s14),
          SizedBox(height: 12.h),
          Text(
            'Medium Sizes:',
            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4.h),
          SKit.text('s16 - Body large', textSize: SKTextSize.s16),
          SKit.text('s18 - Subheadline', textSize: SKTextSize.s18),
          SizedBox(height: 12.h),
          Text(
            'Large Sizes:',
            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4.h),
          SKit.text(
            's20 - Headline small',
            textSize: SKTextSize.s20,
            fontWeight: FontWeight.bold,
          ),
          SKit.text(
            's24 - Headline large',
            textSize: SKTextSize.s24,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(height: 12.h),
          Text(
            'Very Large Sizes:',
            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4.h),
          SKit.text(
            's32 - Display',
            textSize: SKTextSize.s32,
            fontWeight: FontWeight.bold,
          ),
          SKit.text(
            's48 - Hero text',
            textSize: SKTextSize.s48,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(height: 12.h),
          Text(
            'Using textStyle():',
            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4.h),
          Text(
            'Custom text with SKit.textStyle(textSize: SKTextSize.s18)',
            style: SKit.textStyle(
              textSize: SKTextSize.s18,
              color: Colors.deepPurple,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            'Custom Text Sizes:',
            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4.h),
          Builder(
            builder: (context) {
              setTextSizes(
                TextSizeValues.custom(s14: 15, s16: 17, s18: 20, s24: 26),
              );
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Custom s14=15, s16=17, s18=20, s24=26',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  SKit.text('s14 (now 15)', textSize: SKTextSize.s14),
                  SKit.text('s16 (now 17)', textSize: SKTextSize.s16),
                  SKit.text('s18 (now 20)', textSize: SKTextSize.s18),
                  SKit.text('s24 (now 26)', textSize: SKTextSize.s24),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  // ============================================================================
  // SKITTHEME EXAMPLE
  // ============================================================================
  Widget _buildDesignValuesExample() {
    return SectionCard(
      title: 'ScaleKitDesignValues - Centralized Design System',
      subtitle: 'Define all values in one place',
      description:
          'Define all your design tokens in one place, compute once per build, use everywhere with const widgets. This minimizes repeated calculations and improves performance.',
      code: CodeSnippets.designValues,
      codeLanguage: 'dart',
      result: Builder(
        builder: (context) {
          // Define all design tokens in one place
          const design = ScaleKitDesignValues(
            // Text sizes
            textXs: 10,
            textSm: 12,
            textMd: 14,
            textLg: 16,
            textXl: 18,
            textXxl: 24,
            // Padding values
            paddingXs: 4,
            paddingSm: 8,
            paddingMd: 16,
            paddingLg: 24,
            paddingXl: 32,
            // Margin values
            marginXs: 4,
            marginSm: 8,
            marginMd: 16,
            marginLg: 24,
            // Radius values
            radiusXs: 2,
            radiusSm: 4,
            radiusMd: 8,
            radiusLg: 12,
            radiusXl: 16,
            // Spacing values
            spacingXs: 4,
            spacingSm: 8,
            spacingMd: 16,
            spacingLg: 24,
            spacingXl: 32,
          );

          // Compute once - all values are now scaled
          final values = design.compute();

          // Use const widgets everywhere with pre-computed values
          return Column(
            children: [
              SKPadding(
                padding: values.paddingMd!,
                child: SKContainer(
                  decoration: BoxDecoration(
                    color: Colors.purple.shade100,
                    borderRadius: values.borderRadiusMd,
                  ),
                  padding: values.paddingSm!,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Using ScaleKitDesignValues.compute()',
                        style: values.textLg?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      if (values.spacingSm != null)
                        SizedBox(height: values.spacingSm!),
                      Text(
                        'Text: textMd (14)',
                        style: values.textMd?.copyWith(color: Colors.black87),
                      ),
                      if (values.spacingXs != null)
                        SizedBox(height: values.spacingXs!),
                      Text(
                        'Text: textSm (12)',
                        style: values.textSm?.copyWith(color: Colors.black87),
                      ),
                      if (values.spacingXs != null)
                        SizedBox(height: values.spacingXs!),
                      Text(
                        'Padding: paddingMd (16)',
                        style: values.textSm?.copyWith(color: Colors.black87),
                      ),
                      Text(
                        'Radius: radiusMd (8)',
                        style: values.textSm?.copyWith(color: Colors.black87),
                      ),
                    ],
                  ),
                ),
              ),
              if (values.spacingMd != null) SizedBox(height: values.spacingMd!),
              Text(
                'All values defined once, computed once, used everywhere!',
                style: values.textSm?.copyWith(
                  color: Colors.grey.shade600,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          );
        },
      ),
      interactive: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(8.rSafe),
          border: Border.all(color: Colors.blue.shade200, width: 1),
        ),
        child: Row(
          children: [
            Icon(
              Icons.lightbulb_outline,
              size: 18.sp,
              color: Colors.blue.shade700,
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                '💡 Tip: Compute close to where values are used to respect current device metrics and orientation. Recompute automatically when MediaQuery or locale changes.',
                style: TextStyle(fontSize: 12.sp, color: Colors.blue.shade900),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================================
  // FONT CONFIGURATION EXAMPLE
  // ============================================================================
  Widget _buildFontConfigExample() {
    return SectionCard(
      title: 'Font Configuration',
      subtitle: 'Automatic font selection per language',
      description:
          'Configure fonts for different languages. All TextStyles automatically use the configured font for the current language. If no font is configured, Flutter\'s default font is used.',
      code: CodeSnippets.fontConfig,
      codeLanguage: 'dart',
      result: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(8.rSafe),
          border: Border.all(color: Colors.blue.shade200, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Current Language: ${FontConfig.instance.currentLanguageCode}',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade900,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'All TextStyles automatically use the configured font for this language.',
              style: TextStyle(fontSize: 12.sp, color: Colors.blue.shade800),
            ),
            SizedBox(height: 12.h),
            Text(
              'Example text with automatic font:',
              style: TextStyle(fontSize: 16.sp),
            ),
            SizedBox(height: 8.h),
            Text('مرحبا (Arabic)', style: TextStyle(fontSize: 16.sp)),
            Text('Hello (English)', style: TextStyle(fontSize: 16.sp)),
          ],
        ),
      ),
    );
  }

  // ============================================================================
  // OPTIMIZED WIDGETS EXAMPLE
  // ============================================================================
  Widget _buildOptimizedWidgetsExample() {
    return SectionCard(
      title: 'Optimized Widgets',
      subtitle: 'SKPadding, SKContainer, HSpace, VSpace',
      description:
          'Optimized widgets for better performance. These widgets are designed to work efficiently with the scaling system.',
      code: CodeSnippets.optimizedWidgets,
      codeLanguage: 'dart',
      result: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'SKPadding + SKContainer:',
            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.h),
          SKPadding(
            padding: SKit.paddingEdgeInsets(all: 16),
            child: SKContainer(
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: SKit.borderRadius(all: 12),
              ),
              padding: SKit.paddingEdgeInsets(all: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SKPadding + SKContainer',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Using optimized widgets for better performance',
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'Spacing Widgets:',
            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Container(width: 30.w, height: 30.w, color: Colors.red.shade200),
              SKit.hSpace(12),
              Container(
                width: 30.w,
                height: 30.w,
                color: Colors.green.shade200,
              ),
              SKit.hSpace(16),
              Container(width: 30.w, height: 30.w, color: Colors.blue.shade200),
            ],
          ),
          SizedBox(height: 12.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 100.w,
                height: 30.w,
                color: Colors.orange.shade200,
              ),
              SKit.vSpace(12),
              Container(
                width: 100.w,
                height: 30.w,
                color: Colors.pink.shade200,
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Text(
            'SKMargin:',
            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.h),
          SKMargin(
            margin: SKit.marginEdgeInsets(all: 12),
            child: Container(
              padding: EdgeInsets.all(12.w),
              color: Colors.green.shade100,
              child: Text(
                'SKMargin - Container with margin',
                style: TextStyle(fontSize: 14.sp),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================================
  // CONTEXT EXTENSIONS EXAMPLE
  // ============================================================================
  Widget _buildContextExtensionsExample(BuildContext context) {
    return SectionCard(
      title: 'Context Extensions',
      subtitle: 'context.scalePadding(), context.isMobile',
      description:
          'Use context extensions for responsive scaling and device detection. Clean and convenient API for accessing scaling methods directly from BuildContext.',
      code: CodeSnippets.contextExtensions,
      codeLanguage: 'dart',
      result: Container(
        padding: context.scalePadding(horizontal: 20, vertical: 16),
        margin: context.scaleMargin(all: 8),
        decoration: BoxDecoration(
          color: Colors.amber.shade100,
          borderRadius: context.scaleBorderRadius(all: 10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'context.scalePadding(horizontal: 20, vertical: 16)',
              style: TextStyle(fontSize: 12.sp),
            ),
            SizedBox(height: 8.h),
            Text(
              'context.scaleMargin(all: 8)',
              style: TextStyle(fontSize: 12.sp),
            ),
            SizedBox(height: 8.h),
            Text(
              'context.scaleBorderRadius(all: 10)',
              style: TextStyle(fontSize: 12.sp),
            ),
            SizedBox(height: 12.h),
            Divider(),
            SizedBox(height: 8.h),
            Text(
              'Device Detection:',
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.h),
            Text(
              'Is Mobile: ${context.isMobile}',
              style: TextStyle(fontSize: 12.sp),
            ),
            Text(
              'Is Tablet: ${context.isTablet}',
              style: TextStyle(fontSize: 12.sp),
            ),
            Text(
              'Is Desktop: ${context.isDesktop}',
              style: TextStyle(fontSize: 12.sp),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================================
  // SCALEMANAGER EXAMPLE
  // ============================================================================
  Widget _buildScaleManagerExample() {
    return SectionCard(
      title: 'ScaleManager Direct API',
      subtitle: 'Access scale values directly',
      description:
          'Access scale values directly from ScaleManager.instance. Useful when you need more control or want to use the API programmatically.',
      code: CodeSnippets.scaleManagerDirect,
      codeLanguage: 'dart',
      result: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Builder(
            builder: (context) {
              final scale = ScaleManager.instance;
              return Container(
                width: scale.getWidth(200),
                height: scale.getHeight(125),
                decoration: BoxDecoration(
                  color: Colors.purple.shade200,
                  borderRadius: BorderRadius.circular(scale.getRadius(12)),
                ),
                padding: EdgeInsets.all(16.w),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'ScaleManager.instance',
                        style: TextStyle(
                          fontSize: scale.getFontSize(14),
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                        softWrap: true,
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'getWidth(200) × getHeight(125)',
                        style: TextStyle(
                          fontSize: scale.getFontSize(12),
                          color: Colors.white70,
                        ),
                        textAlign: TextAlign.center,
                        softWrap: true,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 16.h),
          Text(
            'Screen Percentage:',
            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.h),
          Builder(
            builder: (context) {
              final scale = ScaleManager.instance;
              return Container(
                width: scale.getScreenWidth(0.75),
                height: 60.h,
                decoration: BoxDecoration(
                  color: Colors.blue.shade200,
                  borderRadius: BorderRadius.circular(8.rSafe),
                ),
                child: Center(
                  child: Text(
                    '75% Screen Width',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // ============================================================================
  // DEVICE INFORMATION EXAMPLE
  // ============================================================================
  Widget _buildDeviceInfoExample(BuildContext context) {
    final scaleKit = ScaleManager.instance;
    return SectionCard(
      title: 'Device Information',
      subtitle: 'All available properties',
      description:
          'Access all device properties and scale information from ScaleManager.instance. Similar to flutter_screenutil properties.',
      code: CodeSnippets.deviceInformation,
      codeLanguage: 'dart',
      result: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InfoRow(
            label: 'Device Type',
            value: DeviceDetector.detectFromContext(context).name,
          ),
          InfoRow(
            label: 'Screen Width',
            value: '${scaleKit.screenWidth.toStringAsFixed(1)}px',
          ),
          InfoRow(
            label: 'Screen Height',
            value: '${scaleKit.screenHeight.toStringAsFixed(1)}px',
          ),
          InfoRow(
            label: 'Pixel Ratio',
            value: scaleKit.pixelRatio.toStringAsFixed(2),
          ),
          InfoRow(label: 'Orientation', value: scaleKit.orientation.name),
          InfoRow(
            label: 'Status Bar Height',
            value: '${scaleKit.statusBarHeight.toStringAsFixed(1)}px',
          ),
          InfoRow(
            label: 'Bottom Bar Height',
            value: '${scaleKit.bottomBarHeight.toStringAsFixed(1)}px',
          ),
          InfoRow(
            label: 'Top Safe Height',
            value: '${scaleKit.topSafeHeight.toStringAsFixed(1)}px',
          ),
          InfoRow(
            label: 'Bottom Safe Height',
            value: '${scaleKit.bottomSafeHeight.toStringAsFixed(1)}px',
          ),
          InfoRow(
            label: 'Safe Area Height',
            value: '${scaleKit.safeAreaHeight.toStringAsFixed(1)}px',
          ),
          InfoRow(
            label: 'Safe Area Width',
            value: '${scaleKit.safeAreaWidth.toStringAsFixed(1)}px',
          ),
          InfoRow(
            label: 'Text Scale Factor',
            value: scaleKit.textScaleFactor.toStringAsFixed(2),
          ),
          InfoRow(
            label: 'Scale Width',
            value: scaleKit.scaleWidth.toStringAsFixed(3),
          ),
          InfoRow(
            label: 'Scale Height',
            value: scaleKit.scaleHeight.toStringAsFixed(3),
          ),
          InfoRow(label: 'Is Mobile', value: context.isMobile.toString()),
          InfoRow(label: 'Is Tablet', value: context.isTablet.toString()),
          InfoRow(label: 'Is Desktop', value: context.isDesktop.toString()),
        ],
      ),
    );
  }

  // ============================================================================
  // PERFORMANCE TIPS EXAMPLE
  // ============================================================================
  Widget _buildPerformanceTipsExample() {
    return SectionCard(
      title: 'Performance Tips',
      subtitle: 'Best practices',
      description:
          'Follow these best practices to get optimal performance from Flutter Scale Kit. These tips help minimize recalculations and improve frame-time stability.',
      code: CodeSnippets.performanceTips,
      codeLanguage: 'dart',
      result: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TipCard(
            title: '1. Use ScaleKitDesignValues for const widgets',
            description:
                'Define all design values once, compute once, use everywhere with const widgets for optimal performance.',
          ),
          SizedBox(height: 12.h),
          const TipCard(
            title: '2. Use size enums for consistency',
            description:
                'Use SKSize (xs, sm, md, lg, xl, xxl) and SKTextSize (s6 to s52) for consistent sizing across your app.',
          ),
          SizedBox(height: 12.h),
          const TipCard(
            title: '3. Set default values',
            description:
                'Use setDefaultPadding(), setDefaultMargin(), etc. to use methods without parameters (e.g., SKit.pad()).',
          ),
          SizedBox(height: 12.h),
          const TipCard(
            title: '4. Use optimized widgets',
            description:
                'SKPadding, SKContainer, HSpace, VSpace are optimized for performance and can be used with const.',
          ),
          SizedBox(height: 12.h),
          const TipCard(
            title: '5. Cache is automatic',
            description:
                'ScaleKitBuilder automatically clears cache only on size/orientation changes - no manual cache management needed.',
          ),
          SizedBox(height: 12.h),
          const TipCard(
            title: '6. Extension methods are convenient',
            description:
                'Use .w, .h, .sp, .rSafe, .r, .rFixed, .sw, .sh for quick scaling or fixed radii - they\'re cached and optimized.',
          ),
        ],
      ),
    );
  }
}
