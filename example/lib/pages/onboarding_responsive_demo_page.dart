import 'package:flutter/material.dart';
import 'package:flutter_scale_kit/flutter_scale_kit.dart';

/// Reproduces a community report: iPhone landscape showed `DeviceType.tablet`
/// and `SKText` looked too small while `mobileLandscape` layout still ran.
///
/// Matches their setup: `ScaleKitBuilder` inside `MaterialApp.builder`,
/// design 402×874, `SKResponsiveBuilder` with portrait/landscape branches.
class OnboardingResponsiveDemoPage extends StatelessWidget {
  const OnboardingResponsiveDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    const isFirstStep = true;

    void nextStep() {}
    void onBackPressed() {}

    return Scaffold(
      body: SKPadding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _DebugBanner(),
            Expanded(
              child: SKResponsiveBuilder(
                mobile:
                    (context) => Column(
                      children: [
                        Expanded(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SKResponsiveBuilder(
                                  builder:
                                      (context, device, orientation) =>
                                          Text(device.toString()),
                                ),
                                SKText(
                                  'PORTRAIT',
                                  style: TextStyle(fontSize: 18),
                                ),
                                const SizedBox(height: 20),
                                const Text(
                                  'This onboarding journey will help you get started.',
                                ),
                              ],
                            ),
                          ),
                        ),
                        _NavRow(
                          isFirstStep: isFirstStep,
                          onBackPressed: onBackPressed,
                          onContinue: nextStep,
                        ),
                      ],
                    ),
                mobileLandscape:
                    (context) => Row(
                      children: [
                        Expanded(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SKResponsiveBuilder(
                                  builder:
                                      (context, device, orientation) =>
                                          Text(device.toString()),
                                ),
                                SKText(
                                  'LANDSCAPE',
                                  style: TextStyle(fontSize: 18),
                                ),
                                const SizedBox(height: 20),
                                const Text(
                                  'This onboarding journey will help you get started.',
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: _NavRow(
                            isFirstStep: isFirstStep,
                            onBackPressed: onBackPressed,
                            onContinue: nextStep,
                          ),
                        ),
                      ],
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DebugBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final scale = ScaleManager.instance;
    final size = MediaQuery.sizeOf(context);
    return Card(
      color: Colors.amber.shade50,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Debug (rotate device to compare)',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            SizedBox(height: 6),
            Text(
              'Logical size: ${size.width.toStringAsFixed(0)} × ${size.height.toStringAsFixed(0)}',
            ),
            Text('Shortest side: ${size.shortestSide.toStringAsFixed(0)}'),
            Text('responsive deviceType: ${scale.deviceType}'),
            Text('platform deviceType: ${scale.platformDeviceType}'),
            Text('size deviceType: ${scale.sizeDeviceType}'),
            Text('isResponsiveMobile: ${context.isResponsiveMobile}'),
            Text('isMobileViewport (width): ${context.isMobileViewport}'),
            Text('isMobilePlatform: ${context.isMobilePlatform}'),
            Text(
              'font scale (16.sp equivalent): ${scale.getFontSize(16).toStringAsFixed(2)}',
            ),
          ],
        ),
      ),
    );
  }
}

class _NavRow extends StatelessWidget {
  const _NavRow({
    required this.isFirstStep,
    required this.onBackPressed,
    required this.onContinue,
  });

  final bool isFirstStep;
  final VoidCallback onBackPressed;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[
      if (!isFirstStep)
        Flexible(
          child: TextButton(
            onPressed: onBackPressed,
            child: const Text('Back'),
          ),
        )
      else
        const SizedBox.shrink(),
      Flexible(
        child: FilledButton(
          onPressed: onContinue,
          child: const Text('Continue'),
        ),
      ),
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: children,
    );
  }
}
