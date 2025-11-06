import 'package:flutter/material.dart';
import 'package:flutter_scale_kit/flutter_scale_kit.dart';

/// Heavy page using Scale Kit with SKitTheme for performance comparison
class HeavyScaleKitPage extends StatelessWidget {
  const HeavyScaleKitPage({super.key});

  static const _theme = SKitTheme(
    textSm: 12,
    textMd: 14,
    textLg: 16,
    paddingSm: 8,
    paddingMd: 12,
    spacingSm: 6,
    spacingMd: 12,
    radiusSm: 8,
    radiusMd: 10,
  );

  @override
  Widget build(BuildContext context) {
    final v = _theme.compute();
    return Scaffold(
      appBar: AppBar(title: const Text('Scale Kit Heavy Page')),
      body: ListView.builder(
        padding: v.paddingHorizontal,
        itemCount: 600,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(bottom: v.spacingMd ?? 12),
            child: SKContainer(
              padding: v.paddingMd,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: v.borderRadiusMd,
                border: Border.all(color: Colors.grey.shade300, width: 1.w),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: v.widthSm ?? 56.w,
                    height: v.heightSm ?? 56.w,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: v.borderRadiusSm,
                    ),
                  ),
                  SizedBox(width: v.spacingMd ?? 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Item #$index - Title',
                          style: v.textLg?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: v.spacingSm ?? 6),
                        Text(
                          'Subtitle lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                          'Phasellus efficitur, neque a interdum congue, justo arcu.',
                          style: v.textSm?.copyWith(
                            color: Colors.grey.shade700,
                          ),
                        ),
                        SizedBox(height: v.spacingMd ?? 12),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              size: (v.textSm?.fontSize ?? 12),
                              color: Colors.orange,
                            ),
                            SizedBox(width: v.spacingSm ?? 6),
                            Text('4.${index % 10}', style: v.textSm),
                            SizedBox(width: v.spacingMd ?? 12),
                            Icon(
                              Icons.timer,
                              size: (v.textSm?.fontSize ?? 12),
                              color: Colors.blueGrey,
                            ),
                            SizedBox(width: v.spacingSm ?? 6),
                            Text('${(index % 50) + 1}m', style: v.textSm),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
