import 'package:flutter/material.dart';
import 'package:flutter_scale_kit/flutter_scale_kit.dart';
import 'code_snippet.dart';

/// A reusable card for presenting sections with intro, code, and result
class SectionCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? description;
  final String? code;
  final String? codeLanguage;
  final Widget? result;
  final Widget? interactive;
  final EdgeInsets? padding;
  final Color? backgroundColor;

  const SectionCard({
    super.key,
    required this.title,
    this.subtitle,
    this.description,
    this.code,
    this.codeLanguage,
    this.result,
    this.interactive,
    this.padding,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      color: backgroundColor ?? Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
        side: BorderSide(color: Colors.grey.shade200, width: 1),
      ),
      child: Padding(
        padding: padding ?? EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              title,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade900,
              ),
            ),
            // Subtitle
            if (subtitle != null) ...[
              SizedBox(height: 4.h),
              Text(
                subtitle!,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey.shade600,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
            // Description
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
            // Code
            if (code != null) ...[
              SizedBox(height: 12.h),
              CodeSnippet(code: code!, language: codeLanguage),
            ],
            // Result
            if (result != null) ...[
              SizedBox(height: 12.h),
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: Colors.blue.shade200, width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.visibility,
                          size: 16.sp,
                          color: Colors.blue.shade700,
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          'Result:',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.blue.shade700,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    result!,
                  ],
                ),
              ),
            ],
            // Interactive widget
            if (interactive != null) ...[SizedBox(height: 12.h), interactive!],
          ],
        ),
      ),
    );
  }
}
