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

                return const SizedBox();
              },
            ),
          ),
        ),
      ),
    );
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
