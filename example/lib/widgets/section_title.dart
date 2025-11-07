import 'package:flutter/material.dart';
import 'package:flutter_scale_kit/flutter_scale_kit.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final String subtitle;

  const SectionTitle({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
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
