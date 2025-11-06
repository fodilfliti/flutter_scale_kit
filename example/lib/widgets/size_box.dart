import 'package:flutter/material.dart';
import 'package:flutter_scale_kit/flutter_scale_kit.dart';

class SizeBox extends StatelessWidget {
  final String label;
  final SKSize size;
  final Color color;

  const SizeBox({
    super.key,
    required this.label,
    required this.size,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final value = paddingSizes.get(size);
    return Container(
      width: 50.0.w + value.toDouble(),
      height: 50.0.h + value.toDouble(),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.0.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 10.0.sp, fontWeight: FontWeight.bold),
          ),
          Text(value.toStringAsFixed(0), style: TextStyle(fontSize: 9.0.sp)),
        ],
      ),
    );
  }
}

