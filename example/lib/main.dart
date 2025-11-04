import 'package:flutter/material.dart';
import 'package:flutter_scale_kit/flutter_scale_kit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Scale Kit Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ScaleKitExample(),
    );
  }
}

class ScaleKitExample extends StatelessWidget {
  const ScaleKitExample({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaleKitBuilder(
      designWidth: 375,
      designHeight: 812,
      designType: DeviceType.mobile,
      child: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final scaleKit = ScaleManager.instance;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Scale Kit Example'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Device Info Card
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Device Information',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      'Device Type: ${DeviceDetector.detectFromContext(context).name}',
                      style: TextStyle(fontSize: 16.sp),
                    ),
                    Text(
                      'Screen Width: ${scaleKit.screenWidth.toStringAsFixed(1)}',
                      style: TextStyle(fontSize: 16.sp),
                    ),
                    Text(
                      'Screen Height: ${scaleKit.screenHeight.toStringAsFixed(1)}',
                      style: TextStyle(fontSize: 16.sp),
                    ),
                    Text(
                      'Pixel Ratio: ${scaleKit.pixelRatio.toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 16.sp),
                    ),
                    Text(
                      'Status Bar Height: ${scaleKit.statusBarHeight.toStringAsFixed(1)}',
                      style: TextStyle(fontSize: 16.sp),
                    ),
                    Text(
                      'Scale Width: ${scaleKit.scaleWidth.toStringAsFixed(3)}',
                      style: TextStyle(fontSize: 16.sp),
                    ),
                    Text(
                      'Scale Height: ${scaleKit.scaleHeight.toStringAsFixed(3)}',
                      style: TextStyle(fontSize: 16.sp),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.h),
            
            // Scaled Container Example
            Text(
              'Scaled Container',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12.h),
            Container(
              width: 200.w,
              height: 100.h,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Center(
                child: Text(
                  'Scaled Box',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            
            // Responsive Padding Example
            Text(
              'Responsive Padding',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                'This container has responsive padding',
                style: TextStyle(fontSize: 14.sp),
              ),
            ),
            SizedBox(height: 20.h),
            
            // Screen Percentage Example
            Text(
              'Screen Percentage',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12.h),
            Container(
              width: 0.5.sw, // 50% of screen width
              height: 100.h,
              decoration: BoxDecoration(
                color: Colors.orange.shade200,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Center(
                child: Text(
                  '50% Screen Width',
                  style: TextStyle(fontSize: 14.sp),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            
            // Responsive Text Example
            Text(
              'Responsive Text Sizes',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              'Large Text (24px)',
              style: TextStyle(fontSize: 24.sp),
            ),
            SizedBox(height: 8.h),
            Text(
              'Medium Text (18px)',
              style: TextStyle(fontSize: 18.sp),
            ),
            SizedBox(height: 8.h),
            Text(
              'Small Text (14px)',
              style: TextStyle(fontSize: 14.sp),
            ),
            SizedBox(height: 20.h),
            
            // Using ScaleManager directly
            Text(
              'Using ScaleManager Directly',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12.h),
            Builder(
              builder: (context) {
                final scale = ScaleManager.instance;
                return Container(
                  width: scale.getWidth(150),
                  height: scale.getHeight(80),
                  decoration: BoxDecoration(
                    color: Colors.purple.shade200,
                    borderRadius: BorderRadius.circular(scale.getRadius(10)),
                  ),
                  child: Center(
                    child: Text(
                      'ScaleManager',
                      style: TextStyle(
                        fontSize: scale.getFontSize(16),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 20.h),
            
            // Helper Properties Example
            Text(
              'Helper Properties',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12.h),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('pixelRatio: ${scaleKit.pixelRatio}', style: TextStyle(fontSize: 14.sp)),
                    Text('screenWidth: ${scaleKit.screenWidth}', style: TextStyle(fontSize: 14.sp)),
                    Text('screenHeight: ${scaleKit.screenHeight}', style: TextStyle(fontSize: 14.sp)),
                    Text('statusBarHeight: ${scaleKit.statusBarHeight}', style: TextStyle(fontSize: 14.sp)),
                    Text('bottomBarHeight: ${scaleKit.bottomBarHeight}', style: TextStyle(fontSize: 14.sp)),
                    Text('textScaleFactor: ${scaleKit.textScaleFactor}', style: TextStyle(fontSize: 14.sp)),
                    Text('orientation: ${scaleKit.orientation.name}', style: TextStyle(fontSize: 14.sp)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
