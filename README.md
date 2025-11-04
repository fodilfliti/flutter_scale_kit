# Flutter Scale Kit

A powerful and easy-to-use responsive design package for Flutter that helps you create adaptive UIs across different screen sizes.

## Features

- 🎯 **Easy Scaling**: Simple API for scaling width, height, font sizes, and more
- 📱 **Responsive Design**: Automatic scaling based on screen dimensions
- 🔧 **Customizable**: Configure design dimensions and scale constraints
- 🚀 **Extension Methods**: Use context extensions for cleaner code
- 📐 **Padding & Margins**: Responsive padding and margin utilities
- 🎨 **Border Radius**: Responsive border radius support
- 📱 **Device Detection**: Built-in tablet, mobile, and desktop detection

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  flutter_scale_kit: ^0.1.0
```

Then run:

```bash
flutter pub get
```

## Usage

### Basic Usage

```dart
import 'package:flutter_scale_kit/flutter_scale_kit.dart';

// In your widget
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.scaleWidth(200),  // Scaled width
      height: context.scaleHeight(100), // Scaled height
      padding: context.scalePadding(all: 16), // Responsive padding
      child: Text(
        'Hello World',
        style: TextStyle(
          fontSize: context.scaleFontSize(16), // Responsive font size
        ),
      ),
    );
  }
}
```

### Using ScaleConfig

```dart
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final scale = FlutterScaleKit.of(context);
    
    return Container(
      width: scale.getWidth(200),
      height: scale.getHeight(100),
      padding: scale.getPadding(all: 16),
      child: Text(
        'Hello World',
        style: TextStyle(
          fontSize: scale.getFontSize(16),
        ),
      ),
    );
  }
}
```

### Custom Design Dimensions

```dart
final scale = FlutterScaleKit.init(
  context: context,
  designWidth: 375,  // Your design width
  designHeight: 812, // Your design height
  minScale: 0.5,     // Minimum scale factor
  maxScale: 2.0,     // Maximum scale factor
);
```

### Responsive Padding and Margins

```dart
Container(
  padding: context.scalePadding(
    horizontal: 20,
    vertical: 16,
  ),
  margin: context.scaleMargin(
    all: 16,
  ),
  child: Text('Content'),
)
```

### Responsive Border Radius

```dart
Container(
  decoration: BoxDecoration(
    borderRadius: context.scaleBorderRadius(all: 12),
  ),
  child: Text('Rounded'),
)
```

### Device Detection

```dart
if (context.isMobile) {
  // Mobile layout
} else if (context.isTablet) {
  // Tablet layout
} else if (context.isDesktop) {
  // Desktop layout
}
```

## API Reference

### Extension Methods

- `context.scaleWidth(double width)` - Get scaled width
- `context.scaleHeight(double height)` - Get scaled height
- `context.scaleFontSize(double fontSize)` - Get scaled font size
- `context.scaleSize(double size)` - Get scaled size
- `context.scalePadding(...)` - Get responsive padding
- `context.scaleMargin(...)` - Get responsive margin
- `context.scaleBorderRadius(...)` - Get responsive border radius
- `context.isMobile` - Check if device is mobile
- `context.isTablet` - Check if device is tablet
- `context.isDesktop` - Check if device is desktop

### ScaleConfig Methods

- `getWidth(double width)` - Get scaled width
- `getHeight(double height)` - Get scaled height
- `getFontSize(double fontSize)` - Get scaled font size
- `getSize(double size)` - Get scaled size
- `getPadding(...)` - Get responsive padding
- `getMargin(...)` - Get responsive margin
- `getBorderRadius(...)` - Get responsive border radius

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

If you find this package useful, please consider giving it a star ⭐ on GitHub!
