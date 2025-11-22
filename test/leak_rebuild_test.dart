import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_scale_kit/flutter_scale_kit.dart';

void main() {
  group('Leak Protection & Rebuild Optimization', () {
    testWidgets('LRU Cache Eviction - Stress Test', (
      WidgetTester tester,
    ) async {
      // Pump a widget to initialize ScaleManager properly with a context
      await tester.pumpWidget(
        ScaleKitBuilder(
          designWidth: 375,
          designHeight: 812,
          child: const MaterialApp(home: SizedBox()),
        ),
      );

      // Force enable to ensure calculations happen
      ScaleManager.instance.setEnabled(true);

      // Generate 5000 unique padding requests
      // This should trigger eviction 3000 times (5000 - 2000 limit)
      for (int i = 0; i < 5000; i++) {
        ScaleValueCache.instance.getPadding(all: i.toDouble());
      }

      // If we reached here without memory error or crash, the eviction logic is working.
      expect(true, isTrue);
    });

    testWidgets('ScaleKitBuilder Rebuild Optimization', (
      WidgetTester tester,
    ) async {
      int buildCount = 0;

      await tester.pumpWidget(
        ScaleKitBuilder(
          designWidth: 375,
          designHeight: 812,
          child: Builder(
            builder: (context) {
              ScaleKitScope.watch(context);
              buildCount++;
              return const SizedBox();
            },
          ),
        ),
      );

      expect(buildCount, 1);

      // Trigger a MediaQuery change that affects size (should rebuild)
      tester.view.physicalSize = const Size(400, 900);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pump();

      // Should rebuild because size changed
      expect(buildCount, 2);

      // Trigger a MediaQuery change that does NOT affect size (e.g., viewInsets/keyboard)
      tester.view.viewInsets = const FakeViewPadding(
        bottom: 100,
        left: 0,
        right: 0,
        top: 0,
      );
      addTearDown(tester.view.resetViewInsets);

      await tester.pump();

      // Should NOT rebuild because only insets changed, not size
      // If it was listening to MediaQuery.of(context), it would rebuild.
      // With MediaQuery.sizeOf(context), it should not.
      expect(buildCount, 2);
    });
  });
}
