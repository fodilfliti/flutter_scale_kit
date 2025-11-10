/// Code snippets used throughout the example app
/// This file contains all code examples to keep main.dart clean and focused
class CodeSnippets {
  // Quick Start
  static const quickStart = '''Container(
  width: 200.w,      // Scaled width
  height: 100.h,     // Scaled height
  padding: EdgeInsets.all(16.w),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(12.r),
  ),
  child: Text(
    'Hello World',
    style: TextStyle(fontSize: 16.sp),
  ),
)''';

  // Extension Methods
  static const extensionMethods = '''// Width scaling
200.w           // Scaled width

// Height scaling
100.h           // Scaled height

// Font size scaling
16.sp           // Scaled font size

// Border radius scaling
12.r            // Scaled radius (best for circles)
12.rSafe        // Clamped radius (default for corners)
12.rFixed       // Cached, stays at design value

// Screen percentage
0.5.sw          // 50% of screen width
0.25.sh         // 25% of screen height

// Font size with system factor
16.spf          // Scaled font size with system text scale factor

// Spacing widgets (return SizedBox with scaled dimensions)
12.horizontalSpace        // SizedBox(width: 12.w)
16.verticalSpace          // SizedBox(height: 16.h)''';

  // ScaleKitBuilder
  static const scaleKitBuilder = '''ScaleKitBuilder(
  designWidth: 375,
  designHeight: 812,
  // Orientation-specific flags
  autoScaleLandscape: true,  // default
  autoScalePortrait: false,  // default
  // Optional landscape boosts
  mobileLandscapeFontBoost: 1.2,
  mobileLandscapeSizeBoost: 1.2,
)''';

  // Enable/Disable Toggle
  static const enableToggle = '''final enabled = ValueNotifier<bool>(true);

ScaleKitBuilder(
  designWidth: 375,
  designHeight: 812,
  enabledListenable: enabled, // runtime toggle
  enabled: enabled.value,      // initial
  child: MaterialApp(...),
);

// Toggle anywhere
enabled.value = false; // disables scaling (values returned unmodified)''';

  // SKResponsive
  static const skResponsive = '''SKResponsive(
  mobile: (_) => Text('Mobile', style: TextStyle(fontSize: 12.sp)),
  tablet: (_) => Text('Tablet', style: TextStyle(fontSize: 14.sp)),
  desktop: (_) => Text('Desktop', style: TextStyle(fontSize: 16.sp)),
  mobileLandscape: (_) => Text('Mobile landscape', style: TextStyle(fontSize: 12.sp)),
  tabletLandscape: (_) => Text('Tablet landscape', style: TextStyle(fontSize: 12.sp)),
  desktop: (_) => Text('Desktop', style: TextStyle(fontSize: 12.sp)),
)''';

  // SKResponsiveBuilder
  static const skResponsiveBuilder =
      '''// Pattern 1: Builder with device/orientation info
SKResponsiveBuilder(
  builder: (context, device, orientation) {
    if (device == DeviceType.mobile && orientation == Orientation.landscape) {
      return Text('Mobile Landscape');
    }
    if (device == DeviceType.tablet) {
      return Text('Tablet');
    }
    return Text('Desktop or other');
  },
)

// Pattern 2: Separate builders (like SKResponsive)
SKResponsiveBuilder(
  mobile: (_) => Text('Mobile'),
  tablet: (_) => Text('Tablet'),
  desktop: (_) => Text('Desktop'),
)''';

  // SKit Helper Class
  static const skitHelper = '''final cols = SKit.responsiveInt(
  mobile: 1,
  tablet: 2,
  desktop: 3,
);

final padding = SKit.responsiveDouble(
  mobile: 8,
  tablet: 16,
  desktop: 24,
);

final widget = SKit.responsiveWidget(
  mobile: (_) => Text('Mobile'),
  tablet: (_) => Text('Tablet'),
  desktop: (_) => Text('Desktop'),
);''';

  // Size System
  static const sizeSystem = '''// Configure sizes at app startup (in main())
setPaddingSizes(SizeValues.custom(
  xs: 4, sm: 8, md: 16, lg: 24, xl: 32, xxl: 48,
));
setRadiusSizes(SizeValues.custom(
  xs: 2, sm: 4, md: 8, lg: 12, xl: 16, xxl: 24,
));

// Use size enums throughout your app
SKit.paddingSize(all: SKSize.md, child: widget)
SKit.roundedContainerSize(all: SKSize.lg, color: Colors.blue)

// Set default values for methods without parameters
setDefaultPadding(16);
setDefaultMargin(8);
setDefaultRadius(12);              // Scaled by default

// Then use without parameters
SKit.pad()                         // Uses default padding (16)
SKit.margin()                      // Uses default margin (8)
SKit.rounded()                     // Uses default safe radius (12)
SKit.roundedContainerSize(
  all: SKSize.lg,
  radiusMode: SKRadiusMode.fixed,
)                                  // Keeps corners constant''';

  // Text Size System
  static const textSizeSystem = '''// Use SKTextSize enum
SKit.text('Hello', textSize: SKTextSize.s12)
SKit.text('Hello', textSize: SKTextSize.s14)
SKit.text('Hello', textSize: SKTextSize.s16)
SKit.text('Hello', textSize: SKTextSize.s18)
SKit.text('Hello', textSize: SKTextSize.s20)
SKit.text('Hello', textSize: SKTextSize.s24)
SKit.text('Hello', textSize: SKTextSize.s28)
SKit.text('Hello', textSize: SKTextSize.s32)
SKit.text('Hello', textSize: SKTextSize.s36)
SKit.text('Hello', textSize: SKTextSize.s48)

// Or use fontSize directly
SKit.text('Hello', fontSize: 16)''';

  // ScaleKitDesignValues
  static const designValues =
      '''// Define your design values once (can be const)
const design = ScaleKitDesignValues(
  textSm: 12,
  textMd: 14,
  textLg: 16,
  paddingSm: 8,
  paddingMd: 16,
  paddingLg: 24,
  radiusSm: 8,
  radiusMd: 12,
  radiusLg: 16,
);

// Compute once per build
@override
Widget build(BuildContext context) {
  final values = design.compute();
  
  return Container(
    padding: values.paddingMd,
    decoration: BoxDecoration(
      borderRadius: values.borderRadiusMd,
    ),
    child: Text(
      'Hello',
      style: values.textMd,
    ),
  );
}''';

  // Font Configuration
  static const fontConfig = '''import 'package:google_fonts/google_fonts.dart';

// Configure fonts for different languages
FontConfig.instance.setLanguageFont(
  LanguageFontConfig(
    languageCode: 'ar',
    googleFont: GoogleFonts.almarai,
  ),
);

FontConfig.instance.setLanguageGroupFont(
  LanguageGroupFontConfig(
    languageCodes: ['ar', 'fa', 'ur'],
    googleFont: GoogleFonts.almarai,
  ),
);

// Set default font
FontConfig.instance.setDefaultFont(
  googleFont: GoogleFonts.inter,
);''';

  // Optimized Widgets
  static const optimizedWidgets = '''// SKPadding - Optimized padding widget
SKPadding(
  all: 16,
  child: Text('Hello'),
)

// SKContainer - Optimized container
SKContainer(
  padding: EdgeInsets.all(16.w),
  decoration: BoxDecoration(
    color: Colors.blue,
    borderRadius: BorderRadius.circular(12.r),
  ),
  child: Text('Hello'),
)

// SKMargin - Optimized margin
SKMargin(
  12,
  child: Text('Hello'),
)

// HSpace, VSpace, SSpace - Optimized spacing
HSpace(8)  // Horizontal spacing
VSpace(8)  // Vertical spacing
SSpace(8)  // Square spacing''';

  // SKit Helper Methods
  static const skitMethods = '''// Padding
SKit.padding(all: 16, child: widget)
SKit.paddingSize(all: SKSize.md, child: widget)

// Margin
SKit.margin(12, child: widget)
SKit.marginSize(all: SKSize.md, child: widget)

// Rounded container with border
SKit.roundedContainer(
  all: 12,
  color: Colors.blue.shade50,
  borderColor: Colors.blue,
  borderWidth: 2,
  // radiusMode defaults to SKRadiusMode.safe
)

// Spacing
SKit.hSpace(8)           // Horizontal spacing
SKit.vSpace(8)           // Vertical spacing
SKit.sSpace(8)           // Square spacing

// Text
SKit.text('Hello', textSize: SKTextSize.s16)
SKit.text('Hello', fontSize: 16)''';

  // Rounded Container with Borders
  static const roundedContainerBorders = '''// Border on all sides
SKit.roundedContainer(
  all: 12,
  color: Colors.blue.shade50,
  borderColor: Colors.blue,
  borderWidth: 2,
)

// Border on specific sides only
SKit.roundedContainer(
  all: 12,
  color: Colors.green.shade50,
  borderTop: true,
  borderBottom: true,
  borderColor: Colors.green,
  borderWidth: 2,
)

// Different colors and widths per side
SKit.roundedContainer(
  all: 12,
  color: Colors.pink.shade50,
  borderTop: true,
  borderTopColor: Colors.red,
  borderTopWidth: 3,
  borderBottom: true,
  borderBottomColor: Colors.blue,
  borderBottomWidth: 2,
)''';

  // Rounded Container advanced decoration
  static const roundedContainerDecorations =
      '''// Gradient with elevation helper
SKit.roundedContainer(
  all: 16,
  gradient: const LinearGradient(
    colors: [Color(0xFF7F7FD5), Color(0xFF86A8E7)],
  ),
  elevation: 8,
  shadowColor: Colors.black45,
  padding: EdgeInsets.all(20),
  child: const Text(
    'Elevated gradient card',
    style: TextStyle(color: Colors.white),
  ),
)

// Background image with custom box shadow
SKit.roundedContainer(
  all: 20,
  backgroundImage: const DecorationImage(
    image: AssetImage('assets/images/rounded_bg.png'),
    fit: BoxFit.cover,
    colorFilter: ColorFilter.mode(Colors.black38, BlendMode.darken),
  ),
  boxShadow: const [
    BoxShadow(
      color: Colors.black26,
      blurRadius: 24,
      offset: Offset(0, 14),
    ),
  ],
  padding: EdgeInsets.all(24),
  child: const Text(
    'Background image + shadow',
    style: TextStyle(color: Colors.white),
  ),
);''';

  // Live Scaling Debug
  static const liveScalingDebug = '''final scale = ScaleManager.instance;
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
Orientation orientation = scale.orientation;''';

  // Performance Tips
  static const performanceTips =
      '''// 1. Use ScaleKitDesignValues for const widgets
const design = ScaleKitDesignValues(
  textMd: 14,
  paddingMd: 16,
  radiusMd: 12,
);
final values = design.compute(); // Compute once per build
// Use values everywhere with const widgets

// 2. Use size enums for consistency
SKit.paddingSize(all: SKSize.md, child: widget)
SKit.text('Hello', textSize: SKTextSize.s16)

// 3. Set default values
setDefaultPadding(16);
setDefaultMargin(8);
SKit.pad()  // Uses default

// 4. Use optimized widgets
SKPadding, SKContainer, SKMargin, HSpace, VSpace

// 5. Compute close to usage
@override
Widget build(BuildContext context) {
  final values = theme.compute(); // Compute here, not globally
  return ListView(...);
}''';

  // Comparison snippets
  static const comparisonScaleKit = '''Container(
  width: 200.w,
  height: 100.h,
  child: Text('Hello', style: TextStyle(fontSize: 16.sp)),
)''';

  static const comparisonScreenUtil = '''Container(
  width: 200.w,
  height: 100.h,
  child: Text('Hello', style: TextStyle(fontSize: 16.sp)),
)''';

  static const comparisonRawFlutter = '''Container(
  width: 200,
  height: 100,
  child: Text('Hello', style: TextStyle(fontSize: 16)),
)''';

  // Custom Size Values
  static const customSizeValues = '''// In main() or app initialization
setPaddingSizes(SizeValues.custom(
  xs: 4, sm: 8, md: 16, lg: 24, xl: 32, xxl: 48,
));
setRadiusSizes(SizeValues.custom(
  xs: 2, sm: 4, md: 8, lg: 12, xl: 16, xxl: 24,
));

// Now SKSize.md uses your custom values
SKit.paddingSize(all: SKSize.md)  // Uses 16 instead of default 8''';

  // Default Values
  static const defaultValues = '''// Set defaults once
setDefaultPadding(20);
setDefaultMargin(10);
setDefaultRadius(15);
setDefaultSpacing(12);

// Use without parameters
SKit.pad()              // Uses default (20)
SKit.margin()           // Uses default (10)
SKit.rounded()         // Uses default (15)
SKit.spacing()         // Uses default (12)''';

  // Context Extensions
  static const contextExtensions = '''// Scaling extensions
Container(
  padding: context.scalePadding(horizontal: 20, vertical: 16),
  margin: context.scaleMargin(all: 8),
  decoration: BoxDecoration(
    borderRadius: context.scaleBorderRadius(all: 10),
  ),
  child: const Text('Content'),
)

// Device detection
if (context.isMobile) {
  // Mobile layout
} else if (context.isTablet) {
  // Tablet layout
} else if (context.isDesktop) {
  // Desktop layout
}

// Other extensions
context.scaleWidth(200)
context.scaleHeight(100)
context.scaleFontSize(16)
context.scaleSize(12)''';

  // ScaleManager Direct API
  static const scaleManagerDirect = '''final scale = ScaleManager.instance;

Container(
  width: scale.getWidth(200),
  height: scale.getHeight(100),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(scale.getRadius(12)),
  ),
  child: Text(
    'Hello',
    style: TextStyle(fontSize: scale.getFontSize(16)),
  ),
)

// Screen percentage
Container(
  width: scale.getScreenWidth(0.75),  // 75% of screen width
  height: scale.getScreenHeight(0.5), // 50% of screen height
)

// Other methods
scale.getFontSizeWithFactor(16)  // With system text scale factor
scale.getScreenWidth(0.5)        // 50% of screen width
scale.getScreenHeight(0.25)      // 25% of screen height''';

  // Device Information
  static const deviceInformation = '''final scaleKit = ScaleManager.instance;

// Device properties
double screenWidth = scaleKit.screenWidth;
double screenHeight = scaleKit.screenHeight;
double pixelRatio = scaleKit.pixelRatio;
double statusBarHeight = scaleKit.statusBarHeight;
double bottomBarHeight = scaleKit.bottomBarHeight;
double textScaleFactor = scaleKit.textScaleFactor;
double scaleWidth = scaleKit.scaleWidth;
double scaleHeight = scaleKit.scaleHeight;
Orientation orientation = scaleKit.orientation;

// Safe area
double topSafeHeight = scaleKit.topSafeHeight;
double bottomSafeHeight = scaleKit.bottomSafeHeight;
double safeAreaHeight = scaleKit.safeAreaHeight;
double safeAreaWidth = scaleKit.safeAreaWidth;

// Device detection
DeviceType deviceType = DeviceDetector.detectFromContext(context);
bool isMobile = context.isMobile;
bool isTablet = context.isTablet;
bool isDesktop = context.isDesktop;''';
}
