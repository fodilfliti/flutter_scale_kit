import 'package:flutter/material.dart';
import 'package:flutter_scale_kit/flutter_scale_kit.dart';

class TipCard extends StatelessWidget {
  final String title;
  final String description;

  const TipCard({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14.0.sp,
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade900,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 4.0.h),
        Text(
          description,
          style: TextStyle(fontSize: 12.0.sp, color: Colors.blue.shade700),
          softWrap: true,
          overflow: TextOverflow.visible,
        ),
      ],
    );
  }
}

