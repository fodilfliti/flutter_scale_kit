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

                // Test that scale factors respect min/max constraints
                expect(scale.scaleWidth, greaterThanOrEqualTo(0.8));
                expect(scale.scaleWidth, lessThanOrEqualTo(1.2));

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
                final scaledWidth = scale.getWidth(100);

                // Scaled width should be proportional to scale factor
                expect(scaledWidth, equals(100 * scale.scaleWidth));

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
                final scaledHeight = scale.getHeight(100);

                // Scaled height should be proportional to scale factor
                expect(scaledHeight, equals(100 * scale.scaleHeight));

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
    addTearDown(() => debugDefaultTargetPlatformOverride = null);

    final originalSize = tester.view.physicalSize;
    final originalPixelRatio = tester.view.devicePixelRatio;
    tester.view.physicalSize = const Size(500, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.physicalSize = originalSize;
      tester.view.devicePixelRatio = originalPixelRatio;
    });

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
  });

  testWidgets('Desktop lock keeps desktop layout when width is desktop', (
    WidgetTester tester,
  ) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.macOS;
    addTearDown(() => debugDefaultTargetPlatformOverride = null);

    final originalSize = tester.view.physicalSize;
    final originalPixelRatio = tester.view.devicePixelRatio;
    tester.view.physicalSize = const Size(1400, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.physicalSize = originalSize;
      tester.view.devicePixelRatio = originalPixelRatio;
    });

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
  });

  testWidgets('Custom breakpoints adjust size class classification', (
    WidgetTester tester,
  ) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.macOS;
    addTearDown(() => debugDefaultTargetPlatformOverride = null);

    final originalSize = tester.view.physicalSize;
    final originalPixelRatio = tester.view.devicePixelRatio;
    addTearDown(() {
      tester.view.physicalSize = originalSize;
      tester.view.devicePixelRatio = originalPixelRatio;
    });

    Future<void> captureWidth(
      double width,
      void Function(DeviceSizeClass sizeClass, DeviceType deviceType)
      assertions,
    ) async {
      tester.view.physicalSize = Size(width, 900);
      tester.view.devicePixelRatio = 1.0;

      late DeviceSizeClass capturedSizeClass;
      late DeviceType capturedDeviceType;

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
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      assertions(capturedSizeClass, capturedDeviceType);
    }

    await captureWidth(480, (sizeClass, deviceType) {
      expect(sizeClass, DeviceSizeClass.mobile);
      expect(deviceType, DeviceType.mobile);
    });

    await captureWidth(980, (sizeClass, deviceType) {
      expect(sizeClass, DeviceSizeClass.largeTablet);
      expect(deviceType, DeviceType.tablet);
    });

    await captureWidth(1700, (sizeClass, deviceType) {
      expect(sizeClass, DeviceSizeClass.largeDesktop);
      expect(deviceType, DeviceType.desktop);
    });
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
}
