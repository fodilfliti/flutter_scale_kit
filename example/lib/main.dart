import 'package:flutter/material.dart';
import 'package:flutter_scale_kit/flutter_scale_kit.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  // Configure FontConfig for different languages (optional)
  // If not configured, Flutter's default font will be used
  FontConfig.instance.setLanguageFont(
    LanguageFontConfig(languageCode: 'ar', googleFont: GoogleFonts.almarai),
  );

  FontConfig.instance.setLanguageFont(
    LanguageFontConfig(languageCode: 'en', googleFont: GoogleFonts.inter),
  );

  // Configure font for language group
  FontConfig.instance.setLanguageGroupFont(
    LanguageGroupFontConfig(
      languageCodes: ['ar', 'fa', 'ur'],
      googleFont: GoogleFonts.almarai,
    ),
  );

  // Set default font (used when no specific language config exists)
  FontConfig.instance.setDefaultFont(googleFont: GoogleFonts.inter);

  runApp(const MyApp());
}

/// Main app widget - ScaleKitBuilder wraps MaterialApp at the top level
/// This allows ScaleKit to be available throughout the entire app
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaleKitBuilder(
      designWidth: 375,
      designHeight: 812,
      designType: DeviceType.mobile,
      child: MaterialApp(
        title: 'Flutter Scale Kit - Complete Examples',
        debugShowCheckedModeBanner: false,
        theme: ResponsiveThemeData.create(
          context: context,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
            brightness: Brightness.light,
          ),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}

/// Main example page with comprehensive demonstrations
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Scale Kit Examples'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Quick Start Section
            _buildSectionTitle(
              '🚀 Quick Start',
              'Extension methods (.w, .h, .sp)',
            ),
            SizedBox(height: 12.h),
            _buildQuickStartExample(),
            SizedBox(height: 24.h),

            // Extension Methods
            _buildSectionTitle(
              '📐 Extension Methods',
              'All available extensions',
            ),
            SizedBox(height: 12.h),
            _buildExtensionMethodsExample(),
            SizedBox(height: 24.h),

            // SKit Helper Class
            _buildSectionTitle(
              '🛠️ SKit Helper Class',
              'Short and easy to use',
            ),
            SizedBox(height: 12.h),
            _buildSKitHelperExample(),
            SizedBox(height: 24.h),

            // Size System
            _buildSectionTitle('📏 Size System', 'xs, sm, md, lg, xl, xxl'),
            SizedBox(height: 12.h),
            _buildSizeSystemExample(),
            SizedBox(height: 24.h),

            // Text Size System
            _buildSectionTitle('🔤 Text Size System', 'SKTextSize (s6 to s52)'),
            SizedBox(height: 12.h),
            _buildTextSizeSystemExample(),
            SizedBox(height: 24.h),

            // SKitTheme - Centralized Design
            _buildSectionTitle(
              '🎨 SKitTheme',
              'Define all values in one place',
            ),
            SizedBox(height: 12.h),
            _buildSKitThemeExample(),
            SizedBox(height: 24.h),

            // Font Configuration
            _buildSectionTitle(
              '🔤 Font Configuration',
              'Automatic font selection per language',
            ),
            SizedBox(height: 12.h),
            _buildFontConfigExample(),
            SizedBox(height: 24.h),

            // Optimized Widgets
            _buildSectionTitle(
              '⚡ Optimized Widgets',
              'SKPadding, SKContainer, HSpace, VSpace',
            ),
            SizedBox(height: 12.h),
            _buildOptimizedWidgetsExample(),
            SizedBox(height: 24.h),

            // Context Extensions
            _buildSectionTitle(
              '🔗 Context Extensions',
              'context.scalePadding(), context.isMobile',
            ),
            SizedBox(height: 12.h),
            _buildContextExtensionsExample(context),
            SizedBox(height: 24.h),

            // ScaleManager Direct Usage
            _buildSectionTitle('⚙️ ScaleManager', 'Direct API access'),
            SizedBox(height: 12.h),
            _buildScaleManagerExample(),
            SizedBox(height: 24.h),

            // Device Information
            _buildSectionTitle(
              '📱 Device Information',
              'All available properties',
            ),
            SizedBox(height: 12.h),
            _buildDeviceInfoExample(context),
            SizedBox(height: 24.h),

            // Performance Tips
            _buildSectionTitle('💡 Performance Tips', 'Best practices'),
            SizedBox(height: 12.h),
            _buildPerformanceTipsExample(),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.grey.shade600,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }

  // ============================================================================
  // QUICK START EXAMPLE
  // ============================================================================
  Widget _buildQuickStartExample() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Basic Usage (Like flutter_screenutil)',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.h),
            Container(
              width: 200.w,
              height: 100.h,
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(12.r),
              ),
              padding: EdgeInsets.all(16.w),
              child: Center(
                child: Text(
                  '200.w × 100.h',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              'Code:',
              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
            ),
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(4.r),
              ),
              child: Text(
                'Container(\n'
                '  width: 200.w,\n'
                '  height: 100.h,\n'
                '  borderRadius: BorderRadius.circular(12.r),\n'
                '  child: Text(\'Hello\', style: TextStyle(fontSize: 16.sp)),\n'
                ')',
                style: TextStyle(
                  fontSize: 11.sp,
                  fontFamily: 'monospace',
                  color: Colors.grey.shade800,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================================
  // EXTENSION METHODS EXAMPLE
  // ============================================================================
  Widget _buildExtensionMethodsExample() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'All Extension Methods',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.h),
            _buildExtensionRow('.w - Width scaling', '200.w', 200.w),
            _buildExtensionRow('.h - Height scaling', '100.h', 100.h),
            _buildExtensionRow('.sp - Font size', '16.sp', 16.sp),
            _buildExtensionRow('.r - Border radius', '12.r', 12.r),
            _buildExtensionRow('.sw - Screen width %', '0.5.sw', 0.5.sw),
            _buildExtensionRow('.sh - Screen height %', '0.3.sh', 0.3.sh),
            _buildExtensionRow('.spf - Font with factor', '14.spf', 14.spf),
            SizedBox(height: 12.h),
            Container(
              width: 0.5.sw,
              height: 80.h,
              decoration: BoxDecoration(
                color: Colors.orange.shade100,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Center(
                child: Text(
                  '50% Screen Width',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExtensionRow(String label, String code, double value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
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
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  code,
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: Colors.grey.shade600,
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
          ),
          Text(
            value.toStringAsFixed(1),
            style: TextStyle(fontSize: 14.sp, color: Colors.deepPurple),
          ),
        ],
      ),
    );
  }

  // ============================================================================
  // SKIT HELPER CLASS EXAMPLE
  // ============================================================================
  Widget _buildSKitHelperExample() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'SKit Helper Methods',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.h),
            Text(
              'Padding:',
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.h),
            SKit.padding(
              all: 16,
              child: Container(
                color: Colors.blue.shade100,
                padding: EdgeInsets.all(8.w),
                child: Text(
                  'SKit.padding(all: 16)',
                  style: TextStyle(fontSize: 14.sp),
                ),
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              'Margin:',
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.h),
            SKit.margin(
              12,
              Container(
                color: Colors.green.shade100,
                padding: EdgeInsets.all(8.w),
                child: Text(
                  'SKit.margin(12)',
                  style: TextStyle(fontSize: 14.sp),
                ),
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              'Rounded Container:',
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.h),
            SKit.roundedContainer(
              all: 16,
              color: Colors.purple.shade100,
              child: Padding(
                padding: EdgeInsets.all(12.w),
                child: Text(
                  'SKit.roundedContainer(all: 16)',
                  style: TextStyle(fontSize: 14.sp),
                ),
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              'Container with Border (All Sides):',
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.h),
            SKit.roundedContainer(
              all: 12,
              color: Colors.blue.shade50,
              borderColor: Colors.blue,
              borderWidth: 2,
              child: Padding(
                padding: EdgeInsets.all(12.w),
                child: Text(
                  'Border on all sides',
                  style: TextStyle(fontSize: 14.sp),
                ),
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              'Container with Border on Specific Sides:',
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.h),
            SKit.roundedContainer(
              all: 12,
              color: Colors.green.shade50,
              borderTop: true,
              borderBottom: true,
              borderColor: Colors.green,
              borderWidth: 2,
              child: Padding(
                padding: EdgeInsets.all(12.w),
                child: Text(
                  'Border on top & bottom only',
                  style: TextStyle(fontSize: 14.sp),
                ),
              ),
            ),
            SizedBox(height: 8.h),
            SKit.roundedContainer(
              all: 12,
              color: Colors.orange.shade50,
              borderLeft: true,
              borderRight: true,
              borderColor: Colors.orange,
              borderWidth: 2,
              child: Padding(
                padding: EdgeInsets.all(12.w),
                child: Text(
                  'Border on left & right only',
                  style: TextStyle(fontSize: 14.sp),
                ),
              ),
            ),
            SizedBox(height: 8.h),
            SKit.roundedContainer(
              all: 12,
              color: Colors.pink.shade50,
              borderTop: true,
              borderTopColor: Colors.red,
              borderTopWidth: 3,
              borderBottom: true,
              borderBottomColor: Colors.blue,
              borderBottomWidth: 2,
              child: Padding(
                padding: EdgeInsets.all(12.w),
                child: Text(
                  'Different colors & widths',
                  style: TextStyle(fontSize: 14.sp),
                ),
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              'Spacing:',
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.h),
            Row(
              children: [
                Container(
                  width: 40.w,
                  height: 40.w,
                  color: Colors.red.shade200,
                ),
                SKit.hSpace(16),
                Container(
                  width: 40.w,
                  height: 40.w,
                  color: Colors.blue.shade200,
                ),
                SKit.hSpace(24),
                Container(
                  width: 40.w,
                  height: 40.w,
                  color: Colors.green.shade200,
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Column(
              children: [
                Container(
                  width: 100.w,
                  height: 40.w,
                  color: Colors.orange.shade200,
                ),
                SKit.vSpace(16),
                Container(
                  width: 100.w,
                  height: 40.w,
                  color: Colors.pink.shade200,
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Text(
              'Text:',
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.h),
            SKit.text(
              'SKit.text() with scaled fontSize',
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
            SizedBox(height: 8.h),
            Text(
              'SKit.textStyle() for custom styles',
              style: SKit.textStyle(
                fontSize: 14,
                color: Colors.blue,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================================
  // SIZE SYSTEM EXAMPLE
  // ============================================================================
  Widget _buildSizeSystemExample() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Size System (SKSize)',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.h),
            Text(
              'Default: xs=2, sm=4, md=8, lg=12, xl=16, xxl=24',
              style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade600),
            ),
            SizedBox(height: 12.h),
            // Size enum examples
            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: [
                _buildSizeBox('xs', SKSize.xs, Colors.red.shade100),
                _buildSizeBox('sm', SKSize.sm, Colors.orange.shade100),
                _buildSizeBox('md', SKSize.md, Colors.yellow.shade100),
                _buildSizeBox('lg', SKSize.lg, Colors.green.shade100),
                _buildSizeBox('xl', SKSize.xl, Colors.blue.shade100),
                _buildSizeBox('xxl', SKSize.xxl, Colors.purple.shade100),
              ],
            ),
            SizedBox(height: 16.h),
            Text(
              'Using Size Enums:',
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.h),
            SKit.paddingSize(
              all: SKSize.md,
              child: SKit.roundedContainerSize(
                all: SKSize.md,
                color: Colors.purple.shade100,
                child: Padding(
                  padding: SKit.paddingEdgeInsetsSize(all: SKSize.sm),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'SKit.paddingSize(all: SKSize.md)',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'SKit.roundedContainerSize(all: SKSize.md)',
                        style: TextStyle(fontSize: 12.sp),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'Custom Size Values:',
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.h),
            Builder(
              builder: (context) {
                setPaddingSizes(
                  SizeValues.custom(
                    xs: 4,
                    sm: 8,
                    md: 16,
                    lg: 24,
                    xl: 32,
                    xxl: 48,
                  ),
                );
                setRadiusSizes(
                  SizeValues.custom(
                    xs: 2,
                    sm: 4,
                    md: 8,
                    lg: 12,
                    xl: 16,
                    xxl: 24,
                  ),
                );
                return SKit.paddingSize(
                  all: SKSize.md,
                  child: SKit.roundedContainerSize(
                    all: SKSize.md,
                    color: Colors.green.shade100,
                    child: Padding(
                      padding: SKit.paddingEdgeInsetsSize(all: SKSize.sm),
                      child: Text(
                        'Custom sizes: md padding=16, md radius=8',
                        style: TextStyle(fontSize: 12.sp),
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 16.h),
            Text(
              'Default Values (Use without parameters):',
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.h),
            Builder(
              builder: (context) {
                setDefaultPadding(20);
                setDefaultMargin(10);
                setDefaultRadius(15);
                setDefaultSpacing(12);
                return SKit.pad(
                  SKit.margin(
                    SKit.rounded(
                      null,
                      Padding(
                        padding: EdgeInsets.all(12.w),
                        child: Column(
                          children: [
                            Text(
                              'SKit.pad() - uses default (20)',
                              style: TextStyle(fontSize: 12.sp),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              'SKit.margin() - uses default (10)',
                              style: TextStyle(fontSize: 12.sp),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              'SKit.rounded() - uses default (15)',
                              style: TextStyle(fontSize: 12.sp),
                            ),
                          ],
                        ),
                      ),
                      Colors.orange.shade100,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSizeBox(String label, SKSize size, Color color) {
    final value = paddingSizes.get(size);
    return Container(
      width: 50.w + value.toDouble(),
      height: 50.h + value.toDouble(),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.bold),
          ),
          Text(value.toStringAsFixed(0), style: TextStyle(fontSize: 9.sp)),
        ],
      ),
    );
  }

  // ============================================================================
  // TEXT SIZE SYSTEM EXAMPLE
  // ============================================================================
  Widget _buildTextSizeSystemExample() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Text Size System (SKTextSize)',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.h),
            Text(
              'Sizes: s6, s8, s10, s11, s12, s13, s14, s15, s16, s17, s18, s20, s22, s24, s26, s28, s30, s32, s34, s36, s40, s48, s52',
              style: TextStyle(fontSize: 11.sp, color: Colors.grey.shade600),
            ),
            SizedBox(height: 12.h),
            // Small sizes
            Text(
              'Small Sizes:',
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.h),
            SKit.text('s10 - Small labels', textSize: SKTextSize.s10),
            SKit.text('s12 - Body small', textSize: SKTextSize.s12),
            SKit.text('s14 - Body medium (default)', textSize: SKTextSize.s14),
            SizedBox(height: 12.h),
            // Medium sizes
            Text(
              'Medium Sizes:',
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.h),
            SKit.text('s16 - Body large', textSize: SKTextSize.s16),
            SKit.text('s18 - Subheadline', textSize: SKTextSize.s18),
            SizedBox(height: 12.h),
            // Large sizes
            Text(
              'Large Sizes:',
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.h),
            SKit.text(
              's20 - Headline small',
              textSize: SKTextSize.s20,
              fontWeight: FontWeight.bold,
            ),
            SKit.text(
              's24 - Headline large',
              textSize: SKTextSize.s24,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(height: 12.h),
            // Very large sizes
            Text(
              'Very Large Sizes:',
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.h),
            SKit.text(
              's32 - Display',
              textSize: SKTextSize.s32,
              fontWeight: FontWeight.bold,
            ),
            SKit.text(
              's48 - Hero text',
              textSize: SKTextSize.s48,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(height: 12.h),
            Text(
              'Using textStyle() with SKTextSize:',
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.h),
            Text(
              'Custom text with SKit.textStyle(textSize: SKTextSize.s18)',
              style: SKit.textStyle(
                textSize: SKTextSize.s18,
                color: Colors.deepPurple,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              'Custom Text Sizes:',
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.h),
            Builder(
              builder: (context) {
                setTextSizes(
                  TextSizeValues.custom(s14: 15, s16: 17, s18: 20, s24: 26),
                );
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Custom s14=15, s16=17, s18=20, s24=26',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    SKit.text('s14 (now 15)', textSize: SKTextSize.s14),
                    SKit.text('s16 (now 17)', textSize: SKTextSize.s16),
                    SKit.text('s18 (now 20)', textSize: SKTextSize.s18),
                    SKit.text('s24 (now 26)', textSize: SKTextSize.s24),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================================
  // SKITTHEME EXAMPLE
  // ============================================================================
  Widget _buildSKitThemeExample() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'SKitTheme - Centralized Design System',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.h),
            Text(
              'Define all your design tokens in one place, compute once, use everywhere!',
              style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade600),
            ),
            SizedBox(height: 12.h),
            Builder(
              builder: (context) {
                // Define all design tokens in one place
                const theme = SKitTheme(
                  // Text sizes
                  textXs: 10,
                  textSm: 12,
                  textMd: 14,
                  textLg: 16,
                  textXl: 18,
                  textXxl: 24,
                  // Padding values
                  paddingXs: 4,
                  paddingSm: 8,
                  paddingMd: 16,
                  paddingLg: 24,
                  paddingXl: 32,
                  // Margin values
                  marginXs: 4,
                  marginSm: 8,
                  marginMd: 16,
                  marginLg: 24,
                  // Radius values
                  radiusXs: 2,
                  radiusSm: 4,
                  radiusMd: 8,
                  radiusLg: 12,
                  radiusXl: 16,
                  // Spacing values
                  spacingXs: 4,
                  spacingSm: 8,
                  spacingMd: 16,
                  spacingLg: 24,
                  spacingXl: 32,
                );

                // Compute once - all values are now scaled
                final values = theme.compute();

                // Use const widgets everywhere with pre-computed values
                return Column(
                  children: [
                    SKPadding(
                      padding: values.paddingMd!,
                      child: SKContainer(
                        decoration: BoxDecoration(
                          color: Colors.purple.shade100,
                          borderRadius: values.borderRadiusMd,
                        ),
                        padding: values.paddingSm!,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Using SKitTheme.compute()',
                              style: values.textLg?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            if (values.spacingSm != null)
                              SizedBox(height: values.spacingSm!),
                            Text(
                              'Text: textMd (14)',
                              style: values.textMd?.copyWith(
                                color: Colors.black87,
                              ),
                            ),
                            if (values.spacingXs != null)
                              SizedBox(height: values.spacingXs!),
                            Text(
                              'Text: textSm (12)',
                              style: values.textSm?.copyWith(
                                color: Colors.black87,
                              ),
                            ),
                            if (values.spacingXs != null)
                              SizedBox(height: values.spacingXs!),
                            Text(
                              'Padding: paddingMd (16)',
                              style: values.textSm?.copyWith(
                                color: Colors.black87,
                              ),
                            ),
                            Text(
                              'Radius: radiusMd (8)',
                              style: values.textSm?.copyWith(
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (values.spacingMd != null)
                      SizedBox(height: values.spacingMd!),
                    Text(
                      'All values defined once, computed once, used everywhere!',
                      style: values.textSm?.copyWith(
                        color: Colors.grey.shade600,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================================
  // FONT CONFIGURATION EXAMPLE
  // ============================================================================
  Widget _buildFontConfigExample() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Font Configuration - Automatic Font Selection',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.h),
            Text(
              'Configure fonts for different languages. All TextStyles automatically use the configured font for the current language.',
              style: TextStyle(fontSize: 14.sp),
            ),
            SizedBox(height: 16.h),
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Current Language: ${FontConfig.instance.currentLanguageCode}',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade900,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'All TextStyles automatically use the configured font for this language.',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.blue.shade800,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'Example TextStyles:',
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.h),
            Text(
              'This text uses FontConfig automatically',
              style: TextStyle(fontSize: 16.sp),
            ),
            SizedBox(height: 8.h),
            Text(
              'Bold text also uses FontConfig',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.h),
            Text(
              'Small text with FontConfig',
              style: TextStyle(fontSize: 12.sp),
            ),
            SizedBox(height: 16.h),
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(4.r),
              ),
              child: Text(
                '// Configure in main():\n'
                'FontConfig.instance.setLanguageFont(\n'
                '  LanguageFontConfig(\n'
                '    languageCode: \'ar\',\n'
                '    googleFont: GoogleFonts.almarai,\n'
                '  ),\n'
                ');\n'
                '\n'
                '// Use anywhere - automatically applies:\n'
                'Text(\'Hello\', style: TextStyle(fontSize: 16.sp))\n'
                '// Or via theme:\n'
                'ResponsiveThemeData.create(context: context)',
                style: TextStyle(
                  fontSize: 11.sp,
                  fontFamily: 'monospace',
                  color: Colors.grey.shade800,
                ),
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              'Note: If no font is configured, Flutter\'s default font is used.',
              style: TextStyle(
                fontSize: 12.sp,
                fontStyle: FontStyle.italic,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================================
  // OPTIMIZED WIDGETS EXAMPLE
  // ============================================================================
  Widget _buildOptimizedWidgetsExample() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Optimized Widgets (SKPadding, SKContainer, HSpace, VSpace)',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.h),
            SKPadding(
              padding: SKit.paddingEdgeInsets(all: 16),
              child: SKContainer(
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: SKit.borderRadius(all: 12),
                ),
                padding: SKit.paddingEdgeInsets(all: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'SKPadding + SKContainer',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Using optimized widgets for better performance',
                      style: TextStyle(fontSize: 12.sp),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              'Spacing Widgets:',
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.h),
            Row(
              children: [
                Container(
                  width: 30.w,
                  height: 30.w,
                  color: Colors.red.shade200,
                ),
                SKit.hSpace(12),
                Container(
                  width: 30.w,
                  height: 30.w,
                  color: Colors.green.shade200,
                ),
                SKit.hSpace(16),
                Container(
                  width: 30.w,
                  height: 30.w,
                  color: Colors.blue.shade200,
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 100.w,
                  height: 30.w,
                  color: Colors.orange.shade200,
                ),
                SKit.vSpace(12),
                Container(
                  width: 100.w,
                  height: 30.w,
                  color: Colors.pink.shade200,
                ),
              ],
            ),
            SizedBox(height: 12.h),
            SKMargin(
              margin: SKit.marginEdgeInsets(all: 12),
              child: Container(
                padding: EdgeInsets.all(12.w),
                color: Colors.green.shade100,
                child: Text(
                  'SKMargin - Container with margin',
                  style: TextStyle(fontSize: 14.sp),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================================
  // CONTEXT EXTENSIONS EXAMPLE
  // ============================================================================
  Widget _buildContextExtensionsExample(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Context Extensions',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.h),
            Container(
              padding: context.scalePadding(horizontal: 20, vertical: 16),
              margin: context.scaleMargin(all: 8),
              decoration: BoxDecoration(
                color: Colors.amber.shade100,
                borderRadius: context.scaleBorderRadius(all: 10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'context.scalePadding(horizontal: 20, vertical: 16)',
                    style: TextStyle(fontSize: 12.sp),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'context.scaleMargin(all: 8)',
                    style: TextStyle(fontSize: 12.sp),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'context.scaleBorderRadius(all: 10)',
                    style: TextStyle(fontSize: 12.sp),
                  ),
                  SizedBox(height: 12.h),
                  Divider(),
                  SizedBox(height: 8.h),
                  Text(
                    'Device Detection:',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Is Mobile: ${context.isMobile}',
                    style: TextStyle(fontSize: 12.sp),
                  ),
                  Text(
                    'Is Tablet: ${context.isTablet}',
                    style: TextStyle(fontSize: 12.sp),
                  ),
                  Text(
                    'Is Desktop: ${context.isDesktop}',
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================================
  // SCALEMANAGER EXAMPLE
  // ============================================================================
  Widget _buildScaleManagerExample() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ScaleManager Direct API',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.h),
            Builder(
              builder: (context) {
                final scale = ScaleManager.instance;
                return Container(
                  width: scale.getWidth(200),
                  height: scale.getHeight(125),
                  decoration: BoxDecoration(
                    color: Colors.purple.shade200,
                    borderRadius: BorderRadius.circular(scale.getRadius(12)),
                  ),
                  padding: EdgeInsets.all(16.r),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'ScaleManager.instance',
                        style: TextStyle(
                          fontSize: scale.getFontSize(14),
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'getWidth(200) × getHeight(100)',
                        style: TextStyle(
                          fontSize: scale.getFontSize(12),
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            SizedBox(height: 12.h),
            Builder(
              builder: (context) {
                final scale = ScaleManager.instance;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Screen Percentage:',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Container(
                      width: scale.getScreenWidth(0.75),
                      height: 60.h,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade200,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Center(
                        child: Text(
                          '75% Screen Width',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================================
  // DEVICE INFORMATION EXAMPLE
  // ============================================================================
  Widget _buildDeviceInfoExample(BuildContext context) {
    final scaleKit = ScaleManager.instance;
    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Device Information',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.h),
            _buildInfoRow(
              'Device Type',
              DeviceDetector.detectFromContext(context).name,
            ),
            _buildInfoRow(
              'Screen Width',
              '${scaleKit.screenWidth.toStringAsFixed(1)}px',
            ),
            _buildInfoRow(
              'Screen Height',
              '${scaleKit.screenHeight.toStringAsFixed(1)}px',
            ),
            _buildInfoRow(
              'Pixel Ratio',
              scaleKit.pixelRatio.toStringAsFixed(2),
            ),
            _buildInfoRow('Orientation', scaleKit.orientation.name),
            _buildInfoRow(
              'Status Bar Height',
              '${scaleKit.statusBarHeight.toStringAsFixed(1)}px',
            ),
            _buildInfoRow(
              'Bottom Bar Height',
              '${scaleKit.bottomBarHeight.toStringAsFixed(1)}px',
            ),
            _buildInfoRow(
              'Top Safe Height',
              '${scaleKit.topSafeHeight.toStringAsFixed(1)}px',
            ),
            _buildInfoRow(
              'Bottom Safe Height',
              '${scaleKit.bottomSafeHeight.toStringAsFixed(1)}px',
            ),
            _buildInfoRow(
              'Safe Area Height',
              '${scaleKit.safeAreaHeight.toStringAsFixed(1)}px',
            ),
            _buildInfoRow(
              'Safe Area Width',
              '${scaleKit.safeAreaWidth.toStringAsFixed(1)}px',
            ),
            _buildInfoRow(
              'Text Scale Factor',
              scaleKit.textScaleFactor.toStringAsFixed(2),
            ),
            _buildInfoRow(
              'Scale Width',
              scaleKit.scaleWidth.toStringAsFixed(3),
            ),
            _buildInfoRow(
              'Scale Height',
              scaleKit.scaleHeight.toStringAsFixed(3),
            ),
            _buildInfoRow('Is Mobile', context.isMobile.toString()),
            _buildInfoRow('Is Tablet', context.isTablet.toString()),
            _buildInfoRow('Is Desktop', context.isDesktop.toString()),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140.w,
            child: Text(
              '$label:',
              style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 13.sp, color: Colors.grey.shade700),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================================
  // PERFORMANCE TIPS EXAMPLE
  // ============================================================================
  Widget _buildPerformanceTipsExample() {
    return Card(
      elevation: 2,
      color: Colors.blue.shade50,
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.lightbulb_outline, size: 20.sp, color: Colors.blue),
                SizedBox(width: 8.w),
                Text(
                  'Performance Tips & Best Practices',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade900,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            _buildTip(
              '1. Use SKitTheme for const widgets',
              'Define all design tokens once, compute once, use everywhere with const widgets for optimal performance.',
            ),
            SizedBox(height: 12.h),
            _buildTip(
              '2. Use size enums for consistency',
              'Use SKSize (xs, sm, md, lg, xl, xxl) and SKTextSize (s6 to s52) for consistent sizing across your app.',
            ),
            SizedBox(height: 12.h),
            _buildTip(
              '3. Set default values',
              'Use setDefaultPadding(), setDefaultMargin(), etc. to use methods without parameters (e.g., SKit.pad()).',
            ),
            SizedBox(height: 12.h),
            _buildTip(
              '4. Use optimized widgets',
              'SKPadding, SKContainer, HSpace, VSpace are optimized for performance and can be used with const.',
            ),
            SizedBox(height: 12.h),
            _buildTip(
              '5. Cache is automatic',
              'ScaleKitBuilder automatically clears cache only on size/orientation changes - no manual cache management needed.',
            ),
            SizedBox(height: 12.h),
            _buildTip(
              '6. Extension methods are convenient',
              'Use .w, .h, .sp, .r, .sw, .sh for quick scaling - they\'re cached and optimized.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTip(String title, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade900,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          description,
          style: TextStyle(fontSize: 12.sp, color: Colors.blue.shade700),
        ),
      ],
    );
  }
}
