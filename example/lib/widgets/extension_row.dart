import 'package:flutter/material.dart';
import 'package:flutter_scale_kit/flutter_scale_kit.dart';

class ExtensionRow extends StatelessWidget {
  final String label;
  final String code;
  final double value;

  const ExtensionRow({
    super.key,
    required this.label,
    required this.code,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.0.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14.0.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  code,
                  style: TextStyle(
                    fontSize: 11.0.sp,
                    color: Colors.grey.shade600,
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
          ),
          Text(
            value.toStringAsFixed(1),
            style: TextStyle(fontSize: 14.0.sp, color: Colors.deepPurple),
          ),
        ],
      ),
    );
  }
}

