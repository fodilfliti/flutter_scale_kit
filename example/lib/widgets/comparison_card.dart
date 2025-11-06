import 'package:flutter/material.dart';
import 'package:flutter_scale_kit/flutter_scale_kit.dart';

/// A card showing side-by-side comparison between different approaches
class ComparisonCard extends StatelessWidget {
  final String title;
  final String? description;
  final List<ComparisonItem> items;

  const ComparisonCard({
    super.key,
    required this.title,
    this.description,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
        side: BorderSide(color: Colors.grey.shade200, width: 1),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade900,
              ),
            ),
            if (description != null) ...[
              SizedBox(height: 8.h),
              Text(
                description!,
                style: TextStyle(
                  fontSize: 13.sp,
                  color: Colors.grey.shade700,
                  height: 1.4,
                ),
              ),
            ],
            SizedBox(height: 16.h),
            ...items.map((item) => _buildComparisonItem(item)),
          ],
        ),
      ),
    );
  }

  Widget _buildComparisonItem(ComparisonItem item) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: item.color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4.r),
                  border: Border.all(color: item.color, width: 1),
                ),
                child: Text(
                  item.label,
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                    color: item.color,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          if (item.code != null)
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: SelectableText(
                item.code!,
                style: TextStyle(
                  fontSize: 11.sp,
                  fontFamily: 'monospace',
                  color: Colors.grey.shade100,
                ),
              ),
            ),
          if (item.result != null) ...[
            SizedBox(height: 8.h),
            Container(
              decoration: BoxDecoration(
                color: item.color.withOpacity(0.05),
                borderRadius: BorderRadius.circular(6.r),
                border: Border.all(
                  color: item.color.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: item.result!,
            ),
          ],
        ],
      ),
    );
  }
}

class ComparisonItem {
  final String label;
  final Color color;
  final String? code;
  final Widget? result;
  final String? note;

  ComparisonItem({
    required this.label,
    required this.color,
    this.code,
    this.result,
    this.note,
  });
}
