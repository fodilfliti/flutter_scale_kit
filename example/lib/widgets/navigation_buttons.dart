import 'package:flutter/material.dart';
import 'package:flutter_scale_kit/flutter_scale_kit.dart';
import '../pages/heavy_screenutil_page.dart';
import '../pages/heavy_scalekit_page.dart';

class NavigationButtons extends StatelessWidget {
  const NavigationButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(
          '🧪 Performance Stress Test',
          'Compare flutter_screenutil vs Scale Kit',
        ),
        SizedBox(height: 12.0.h),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const HeavyScreenUtilPage(),
                    ),
                  );
                },
                child: const Text('Open flutter_screenutil Heavy Page'),
              ),
            ),
            SizedBox(width: 12.0.w),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const HeavyScaleKitPage(),
                    ),
                  );
                },
                child: const Text('Open Scale Kit Heavy Page'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 24.0.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF6750A4),
            letterSpacing: -0.5,
          ),
        ),
        SizedBox(height: 6.0.h),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 14.0.sp,
            color: Colors.grey.shade600,
            fontStyle: FontStyle.italic,
            height: 1.3,
          ),
        ),
      ],
    );
  }
}
