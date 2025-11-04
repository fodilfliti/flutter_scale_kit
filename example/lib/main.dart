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
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Scale Kit Example'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: context.scalePadding(all: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Device Info Card
            Card(
              child: Padding(
                padding: context.scalePadding(all: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Device Information',
                      style: TextStyle(
                        fontSize: context.scaleFontSize(20),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: context.scaleHeight(12)),
                    Text(
                      'Device Type: ${context.isMobile ? "Mobile" : context.isTablet ? "Tablet" : "Desktop"}',
                      style: TextStyle(fontSize: context.scaleFontSize(16)),
                    ),
                    Text(
                      'Screen Width: ${MediaQuery.of(context).size.width.toStringAsFixed(1)}',
                      style: TextStyle(fontSize: context.scaleFontSize(16)),
                    ),
                    Text(
                      'Screen Height: ${MediaQuery.of(context).size.height.toStringAsFixed(1)}',
                      style: TextStyle(fontSize: context.scaleFontSize(16)),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: context.scaleHeight(20)),
            
            // Scaled Container Example
            Text(
              'Scaled Container',
              style: TextStyle(
                fontSize: context.scaleFontSize(18),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: context.scaleHeight(12)),
            Container(
              width: context.scaleWidth(200),
              height: context.scaleHeight(100),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: context.scaleBorderRadius(all: 12),
              ),
              child: Center(
                child: Text(
                  'Scaled Box',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: context.scaleFontSize(16),
                  ),
                ),
              ),
            ),
            SizedBox(height: context.scaleHeight(20)),
            
            // Responsive Padding Example
            Text(
              'Responsive Padding',
              style: TextStyle(
                fontSize: context.scaleFontSize(18),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: context.scaleHeight(12)),
            Container(
              padding: context.scalePadding(
                horizontal: 20,
                vertical: 16,
              ),
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: context.scaleBorderRadius(all: 8),
              ),
              child: Text(
                'This container has responsive padding',
                style: TextStyle(fontSize: context.scaleFontSize(14)),
              ),
            ),
            SizedBox(height: context.scaleHeight(20)),
            
            // Responsive Text Example
            Text(
              'Responsive Text Sizes',
              style: TextStyle(
                fontSize: context.scaleFontSize(18),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: context.scaleHeight(12)),
            Text(
              'Large Text (24px)',
              style: TextStyle(fontSize: context.scaleFontSize(24)),
            ),
            SizedBox(height: context.scaleHeight(8)),
            Text(
              'Medium Text (18px)',
              style: TextStyle(fontSize: context.scaleFontSize(18)),
            ),
            SizedBox(height: context.scaleHeight(8)),
            Text(
              'Small Text (14px)',
              style: TextStyle(fontSize: context.scaleFontSize(14)),
            ),
            SizedBox(height: context.scaleHeight(30)),
            
            // Using ScaleConfig directly
            Text(
              'Using ScaleConfig',
              style: TextStyle(
                fontSize: context.scaleFontSize(18),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: context.scaleHeight(12)),
            Builder(
              builder: (context) {
                final scale = FlutterScaleKit.of(context);
                return Container(
                  width: scale.getWidth(150),
                  height: scale.getHeight(80),
                  decoration: BoxDecoration(
                    color: Colors.purple.shade200,
                    borderRadius: scale.getBorderRadius(all: 10),
                  ),
                  child: Center(
                    child: Text(
                      'ScaleConfig',
                      style: TextStyle(
                        fontSize: scale.getFontSize(16),
                        fontWeight: FontWeight.bold,
                      ),
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
}

