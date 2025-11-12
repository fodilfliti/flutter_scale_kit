import 'package:flutter/material.dart';
import 'package:flutter_scale_kit/flutter_scale_kit.dart';
import 'section_card.dart';

/// Live Scaling Debug widget - shows real-time scaling values
class LiveScalingDebug extends StatelessWidget {
  const LiveScalingDebug({super.key});

  @override
  Widget build(BuildContext context) {
    final scale = ScaleManager.instance;
    const baseFont = 12.0;
    const baseW = 100.0;
    const baseH = 40.0;
    final scaledFont = scale.getFontSize(baseFont);
    final scaledW = scale.getWidth(baseW);
    final scaledH = scale.getHeight(baseH);
    final desktopMobile = context.isDesktopMobileSize;
    final desktopTablet = context.isDesktopTabletSize;
    final desktopDesktop = context.isDesktopDesktopOrLarger;
    final desktopMinTablet = context.isDesktopAtLeastTablet;
    final desktopMinDesktop = context.isDesktopAtLeastDesktop;

    return SectionCard(
      title: 'Live Scaling Debug',
      subtitle: 'Watch values change on resize/orientation',
      description:
          'Watch how base values are scaled in real-time. Resize the window (desktop/web) or rotate your device to see values update automatically.',
      code: '''final scale = ScaleManager.instance;
const baseFont = 12.0;
const baseW = 100.0;
const baseH = 40.0;

// Get scaled values
final scaledFont = scale.getFontSize(baseFont);
final scaledW = scale.getWidth(baseW);
final scaledH = scale.getHeight(baseH);

// Access scale factors
double scaleWidth = scale.scaleWidth;
double scaleHeight = scale.scaleHeight;
double pixelRatio = scale.devicePixelRatio;
Orientation orientation = scale.orientation;''',
      codeLanguage: 'dart',
      result: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Base vs Scaled (resize window or rotate device):',
            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.h),
          _DebugRow(label: 'Font 12 ->', value: scaledFont),
          _DebugRow(label: 'Width 100 ->', value: scaledW),
          _DebugRow(label: 'Height 40 ->', value: scaledH),
          SizedBox(height: 12.h),
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'pixelRatio=${scale.devicePixelRatio.toStringAsFixed(2)}, '
                  'orientation=${scale.orientation.name}, '
                  'scaleW=${scale.scaleWidth.toStringAsFixed(3)}, '
                  'scaleH=${scale.scaleHeight.toStringAsFixed(3)}',
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: Colors.grey.shade700,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  'deviceType=${scale.deviceType.name}, '
                  'sizeClass=${scale.screenSizeClass.name}',
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: Colors.grey.shade700,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  'desktop-mobile=${desktopMobile ? 'yes' : 'no'}, '
                  'desktop-tablet=${desktopTablet ? 'yes' : 'no'}, '
                  'desktop-desktop=${desktopDesktop ? 'yes' : 'no'}',
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: Colors.grey.shade600,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  '≥tablet=${desktopMinTablet ? 'yes' : 'no'}, '
                  '≥desktop=${desktopMinDesktop ? 'yes' : 'no'}',
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: Colors.grey.shade600,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  'breakpoints → mobile≤${scale.breakpoints.mobileMaxWidth.toStringAsFixed(0)}, '
                  'tablet≤${scale.breakpoints.tabletMaxWidth.toStringAsFixed(0)}, '
                  'desktop≤${scale.breakpoints.desktopMaxWidth.toStringAsFixed(0)}, '
                  'largeDesktop≤${scale.breakpoints.largeDesktopMaxWidth.toStringAsFixed(0)}',
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      interactive: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.orange.shade50,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: Colors.orange.shade200, width: 1),
        ),
        child: Row(
          children: [
            Icon(
              Icons.info_outline,
              size: 18.sp,
              color: Colors.orange.shade700,
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                '💡 Tip: Resize the window (desktop/web) or rotate your device to see values update in real-time.',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.orange.shade900,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DebugRow extends StatelessWidget {
  final String label;
  final double value;

  const _DebugRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: Row(
        children: [
          SizedBox(
            width: 130.w,
            child: Text(label, style: TextStyle(fontSize: 12.sp)),
          ),
          Text(
            value.toStringAsFixed(2),
            style: TextStyle(fontSize: 12.sp, color: Colors.deepPurple),
          ),
        ],
      ),
    );
  }
}
