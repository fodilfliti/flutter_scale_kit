import 'package:flutter/material.dart';
import 'package:flutter_scale_kit/flutter_scale_kit.dart';

import 'pages/onboarding_responsive_demo_page.dart';

/// Standalone entry point that mirrors a reporter's `MaterialApp.builder` setup.
///
/// Run from the example app folder:
///   fvm flutter run -t lib/onboarding_landscape_main.dart
void main() {
  runApp(const OnboardingLandscapeApp());
}

class OnboardingLandscapeApp extends StatelessWidget {
  const OnboardingLandscapeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Onboarding landscape repro',
      builder: (context, child) {
        return ScaleKitBuilder(
          designWidth: 402,
          designHeight: 874,
          designType: DeviceType.mobile,
          child: child!,
        );
      },
      home: const OnboardingResponsiveDemoPage(),
    );
  }
}
