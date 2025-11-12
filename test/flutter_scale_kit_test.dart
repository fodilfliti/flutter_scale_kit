import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_scale_kit/flutter_scale_kit.dart';

void main() {
  testWidgets('ScaleManager calculates scale factors correctly', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ScaleKitBuilder(
          designWidth: 375,
          designHeight: 812,
          designType: DeviceType.mobile,
          child: Scaffold(
            body: Builder(
              builder: (context) {
                final scale = ScaleManager.instance;

                // Test that scale factors are calculated
                expect(scale.scaleWidth, greaterThan(0));
                expect(scale.scaleHeight, greaterThan(0));
                expect(scale.scaleWidth, lessThanOrEqualTo(3));
                expect(scale.scaleHeight, lessThanOrEqualTo(3));

                return const SizedBox();
              },
            ),
          ),
        ),
      ),
    );
  });

  testWidgets('ScaleManager getWidth scales correctly', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ScaleKitBuilder(
          designWidth: 375,
          designHeight: 812,
          designType: DeviceType.mobile,
          child: Scaffold(
            body: Builder(
              builder: (context) {
                final scale = ScaleManager.instance;
                final unitWidth = scale.getWidth(1);
                final scaledWidth = scale.getWidth(100);

                expect(unitWidth, greaterThan(0));
                expect(scaledWidth, greaterThan(0));
                expect(scaledWidth / unitWidth, closeTo(100, 1e-9));

                return const SizedBox();
              },
            ),
          ),
        ),
      ),
    );
  });

  testWidgets('ScaleManager getHeight scales correctly', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ScaleKitBuilder(
          designWidth: 375,
          designHeight: 812,
          designType: DeviceType.mobile,
          child: Scaffold(
            body: Builder(
              builder: (context) {
                final scale = ScaleManager.instance;
                final unitHeight = scale.getHeight(1);
                final scaledHeight = scale.getHeight(100);

                expect(unitHeight, greaterThan(0));
                expect(scaledHeight, greaterThan(0));
                expect(scaledHeight / unitHeight, closeTo(100, 1e-9));

                return const SizedBox();
              },
            ),
          ),
        ),
      ),
    );
  });

  testWidgets('ScaleManager getFontSize scales correctly', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ScaleKitBuilder(
          designWidth: 375,
          designHeight: 812,
          designType: DeviceType.mobile,
          child: Scaffold(
            body: Builder(
              builder: (context) {
                final scale = ScaleManager.instance;
                final scaledFontSize = scale.getFontSize(16);

                // Scaled font size should be greater than 0
                expect(scaledFontSize, greaterThan(0));

                return const SizedBox();
              },
            ),
          ),
        ),
      ),
    );
  });

  testWidgets('Device detection works', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ScaleKitBuilder(
          designWidth: 375,
          designHeight: 812,
          designType: DeviceType.mobile,
          child: Scaffold(
            body: Builder(
              builder: (context) {
                final deviceType = DeviceDetector.detectFromContext(context);

                // Device type should be detected
                expect(deviceType, isA<DeviceType>());

                return const SizedBox();
              },
            ),
          ),
        ),
      ),
    );
  });

  testWidgets('Extension methods work correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ScaleKitBuilder(
          designWidth: 375,
          designHeight: 812,
          designType: DeviceType.mobile,
          child: Scaffold(
            body: Builder(
              builder: (context) {
                // Test extension methods exist and work
                final scaledWidth = context.scaleWidth(100);
                final scaledHeight = context.scaleHeight(100);
                final scaledFontSize = context.scaleFontSize(16);

                expect(scaledWidth, greaterThan(0));
                expect(scaledHeight, greaterThan(0));
                expect(scaledFontSize, greaterThan(0));

                // Test device detection extensions
                final isMobile = context.isMobile;
                final isTablet = context.isTablet;
                final isDesktop = context.isDesktop;

                expect(isMobile || isTablet || isDesktop, isTrue);

                final manager = ScaleManager.instance;
                final responsiveType = manager.deviceTypeFor(
                  DeviceClassificationSource.responsive,
                );
                expect(context.isTypeOfMobile(), responsiveType.isTypeOfMobile);
                expect(context.isTypeOfTablet(), responsiveType.isTypeOfTablet);
                expect(
                  context.isTypeOfDesktop(),
                  responsiveType == DeviceType.desktop ||
                      responsiveType == DeviceType.web,
                );
                expect(
                  context.isTypeOfMobile(
                    source: DeviceClassificationSource.size,
                  ),
                  manager.deviceTypeFor(DeviceClassificationSource.size) ==
                      DeviceType.mobile,
                );
                expect(
                  context.isTypeOfTablet(
                    source: DeviceClassificationSource.platform,
                  ),
                  manager.deviceTypeFor(DeviceClassificationSource.platform) ==
                      DeviceType.tablet,
                );
                expect(
                  context.isTypeOfDesktop(
                    source: DeviceClassificationSource.platform,
                  ),
                  () {
                    final platformType = manager.deviceTypeFor(
                      DeviceClassificationSource.platform,
                    );
                    return platformType == DeviceType.desktop ||
                        platformType == DeviceType.web;
                  }(),
                );
                final platformCategory = manager.platformCategory;
                expect(
                  context.isDesktopPlatform,
                  platformCategory == PlatformCategory.windows ||
                      platformCategory == PlatformCategory.macos ||
                      platformCategory == PlatformCategory.linux ||
                      platformCategory == PlatformCategory.web,
                );
                expect(
                  context.isWebPlatform,
                  platformCategory == PlatformCategory.web,
                );

                return const SizedBox();
              },
            ),
          ),
        ),
      ),
    );
  });

  testWidgets('Desktop lock falls back to mobile layout when width is mobile', (
    WidgetTester tester,
  ) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.macOS;
    final originalSize = tester.view.physicalSize;
    final originalPixelRatio = tester.view.devicePixelRatio;
    tester.view.physicalSize = const Size(500, 900);
    tester.view.devicePixelRatio = 1.0;

    try {
      late int resolved;

      await tester.pumpWidget(
        MaterialApp(
          home: ScaleKitBuilder(
            designWidth: 375,
            designHeight: 812,
            lockDesktopPlatforms: true,
            lockDesktopAsMobile: true,
            child: Builder(
              builder: (context) {
                resolved = SKit.responsiveInt(
                  mobile: 2,
                  desktop: 8,
                  lockDesktopAsMobile: true,
                );
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(resolved, 2);
    } finally {
      debugDefaultTargetPlatformOverride = null;
      tester.view.physicalSize = originalSize;
      tester.view.devicePixelRatio = originalPixelRatio;
    }
  });

  testWidgets('Desktop lock keeps desktop layout when width is desktop', (
    WidgetTester tester,
  ) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.macOS;
    final originalSize = tester.view.physicalSize;
    final originalPixelRatio = tester.view.devicePixelRatio;
    tester.view.physicalSize = const Size(1400, 900);
    tester.view.devicePixelRatio = 1.0;

    try {
      late int resolved;

      await tester.pumpWidget(
        MaterialApp(
          home: ScaleKitBuilder(
            designWidth: 375,
            designHeight: 812,
            lockDesktopPlatforms: true,
            lockDesktopAsMobile: true,
            child: Builder(
              builder: (context) {
                resolved = SKit.responsiveInt(
                  mobile: 2,
                  desktop: 8,
                  lockDesktopAsMobile: true,
                );
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(resolved, 8);
    } finally {
      debugDefaultTargetPlatformOverride = null;
      tester.view.physicalSize = originalSize;
      tester.view.devicePixelRatio = originalPixelRatio;
    }
  });

  testWidgets('Custom breakpoints adjust size class classification', (
    WidgetTester tester,
  ) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.macOS;
    final originalSize = tester.view.physicalSize;
    final originalPixelRatio = tester.view.devicePixelRatio;

    Future<void> captureWidth(
      double width,
      void Function(
        DeviceSizeClass sizeClass,
        DeviceType deviceType,
        bool desktopMobile,
        bool desktopTablet,
        bool desktopDesktop,
        bool desktopAtLeastTablet,
        bool desktopAtLeastDesktop,
      )
      assertions,
    ) async {
      tester.view.physicalSize = Size(width, 900);
      tester.view.devicePixelRatio = 1.0;

      late DeviceSizeClass capturedSizeClass;
      late DeviceType capturedDeviceType;
      late bool capturedDesktopMobile;
      late bool capturedDesktopTablet;
      late bool capturedDesktopDesktop;
      late bool capturedDesktopAtLeastTablet;
      late bool capturedDesktopAtLeastDesktop;

      await tester.pumpWidget(
        MaterialApp(
          home: ScaleKitBuilder(
            designWidth: 375,
            designHeight: 812,
            breakpoints: const ScaleBreakpoints(
              mobileMaxWidth: 520,
              tabletMaxWidth: 920,
              desktopMaxWidth: 1500,
              largeDesktopMaxWidth: 2100,
            ),
            child: Builder(
              builder: (context) {
                final scale = ScaleManager.instance;
                capturedSizeClass = scale.screenSizeClass;
                capturedDeviceType = scale.deviceTypeFor(
                  DeviceClassificationSource.size,
                );
                capturedDesktopMobile = context.isDesktopMobileSize;
                capturedDesktopTablet = context.isDesktopTabletSize;
                capturedDesktopDesktop = context.isDesktopDesktopOrLarger;
                capturedDesktopAtLeastTablet = context.isDesktopAtLeastTablet;
                capturedDesktopAtLeastDesktop = context.isDesktopAtLeastDesktop;
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      assertions(
        capturedSizeClass,
        capturedDeviceType,
        capturedDesktopMobile,
        capturedDesktopTablet,
        capturedDesktopDesktop,
        capturedDesktopAtLeastTablet,
        capturedDesktopAtLeastDesktop,
      );
    }

    try {
      await captureWidth(480, (
        sizeClass,
        deviceType,
        dMobile,
        dTablet,
        dDesk,
        dMinTablet,
        dMinDesk,
      ) {
        expect(sizeClass, DeviceSizeClass.mobile);
        expect(deviceType, DeviceType.mobile);
        expect(dMobile, isTrue);
        expect(dTablet, isFalse);
        expect(dDesk, isFalse);
        expect(dMinTablet, isFalse);
        expect(dMinDesk, isFalse);
      });

      await captureWidth(980, (
        sizeClass,
        deviceType,
        dMobile,
        dTablet,
        dDesk,
        dMinTablet,
        dMinDesk,
      ) {
        expect(sizeClass, DeviceSizeClass.largeTablet);
        expect(deviceType, DeviceType.desktop);
        expect(dMobile, isFalse);
        expect(dTablet, isTrue);
        expect(dDesk, isFalse);
        expect(dMinTablet, isTrue);
        expect(dMinDesk, isTrue);
      });

      await captureWidth(1700, (
        sizeClass,
        deviceType,
        dMobile,
        dTablet,
        dDesk,
        dMinTablet,
        dMinDesk,
      ) {
        expect(sizeClass, DeviceSizeClass.largeDesktop);
        expect(deviceType, DeviceType.desktop);
        expect(dMobile, isFalse);
        expect(dTablet, isFalse);
        expect(dDesk, isTrue);
        expect(dMinTablet, isTrue);
        expect(dMinDesk, isTrue);
      });
    } finally {
      debugDefaultTargetPlatformOverride = null;
      tester.view.physicalSize = originalSize;
      tester.view.devicePixelRatio = originalPixelRatio;
    }
  });

  testWidgets('Number extensions work correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ScaleKitBuilder(
          designWidth: 375,
          designHeight: 812,
          designType: DeviceType.mobile,
          child: Scaffold(
            body: Builder(
              builder: (context) {
                // Test number extensions
                final width = 200.w;
                final height = 100.h;
                final fontSize = 16.sp;
                final radius = 12.r;

                expect(width, greaterThan(0));
                expect(height, greaterThan(0));
                expect(fontSize, greaterThan(0));
                expect(radius, greaterThan(0));

                return const SizedBox();
              },
            ),
          ),
        ),
      ),
    );
  });

  testWidgets(
    'ScaleKitBuilder preserves state of descendants when viewport changes',
    (WidgetTester tester) async {
      final originalSize = tester.view.physicalSize;
      final originalPixelRatio = tester.view.devicePixelRatio;
      addTearDown(() {
        tester.view.physicalSize = originalSize;
        tester.view.devicePixelRatio = originalPixelRatio;
      });

      final initCount = ValueNotifier<int>(0);
      final buildCount = ValueNotifier<int>(0);
      addTearDown(() {
        initCount.dispose();
        buildCount.dispose();
      });

      await tester.pumpWidget(
        MaterialApp(
          home: ScaleKitBuilder(
            designWidth: 375,
            designHeight: 812,
            child: _StatefulProbe(initCount: initCount, buildCount: buildCount),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(initCount.value, 1);
      expect(buildCount.value, 1);

      // Simulate a viewport change large enough to trigger ScaleKit recalculation.
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;
      await tester.pump();
      await tester.pumpAndSettle();

      // initState should not run again, but the widget should rebuild.
      expect(initCount.value, 1);
      expect(buildCount.value, greaterThan(1));
    },
  );
}

class _StatefulProbe extends StatefulWidget {
  const _StatefulProbe({required this.initCount, required this.buildCount});

  final ValueNotifier<int> initCount;
  final ValueNotifier<int> buildCount;

  @override
  State<_StatefulProbe> createState() => _StatefulProbeState();
}

class _StatefulProbeState extends State<_StatefulProbe> {
  @override
  void initState() {
    super.initState();
    widget.initCount.value++;
  }

  @override
  Widget build(BuildContext context) {
    widget.buildCount.value++;
    // Access a scaled value inside build to ensure extensions register scope dependencies.
    final width = context.scaleWidth(100);
    return Text('scaled=$width');
  }
}
