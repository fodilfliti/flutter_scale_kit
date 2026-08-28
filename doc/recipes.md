# Recipes

Copy-paste patterns for common screens and situations.

> Supplement to the [README](../README.md), which documents every API inline. These are worked
> examples that combine them.

- [Card and section](#card-and-section)
- [Responsive grid](#responsive-grid)
- [Layout switcher](#layout-switcher)
- [Spacing in rows and columns](#spacing-in-rows-and-columns)
- [RTL-safe padding](#rtl-safe-padding)
- [Device branching in a State class](#device-branching-in-a-state-class)
- [Testing](#testing)
- [Runtime on/off toggle](#runtime-onoff-toggle)

---

## Card and section

```dart
SKit.roundedContainer(
  all: 16,
  color: Colors.white,
  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
  borderColor: Colors.black12,
  borderWidth: 1,
  radiusMode: SKRadiusMode.safe,
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SKit.text('Dashboard', textSize: SKTextSize.s20, fontWeight: FontWeight.w600),
      SizedBox(height: 12.h),
      SKit.text(
        'All metrics auto-scale with the screen.',
        textSize: SKTextSize.s16,
        color: Colors.grey.shade600,
      ),
    ],
  ),
);
```

With design tokens configured, the same card gets shorter:

```dart
SKit.paddingSize(
  all: SKSize.md,
  child: SKit.roundedContainerSize(
    all: SKSize.md,
    color: Colors.white,
    child: Column(
      children: [
        SKText('Dashboard', fontSize: 20, fontWeight: FontWeight.w600),
        SKit.vSpaceSize(SKSize.sm),
        SKText('All metrics auto-scale.', fontSize: 14),
      ],
    ),
  ),
);
```

---

## Responsive grid

Change the **column count**, not the layout:

```dart
@override
Widget build(BuildContext context) {
  final columns = SKit.responsiveInt(
    context: context,
    mobile: 2,
    tablet: 4,
    desktop: 6,
  );

  return GridView.count(
    crossAxisCount: columns,
    children: items.map((e) => ProductCard(item: e)).toList(),
  );
}
```

Do **not** wrap the grid in `SKResponsive` for this — one value is enough.

---

## Layout switcher

Use a responsive builder only when the **structure** differs:

```dart
SKResponsiveBuilder(
  mobile: (_) => const BottomNavShell(),      // bottom navigation
  tablet: (_) => const NavigationRailShell(), // side rail
  desktop: (_) => const SplitViewShell(),     // master + detail
  mobileLandscape: (_) => const NavigationRailShell(),
);
```

---

## Spacing in rows and columns

```dart
Row(
  children: [
    const Avatar(),
    12.horizontalSpace,
    const Expanded(child: Title()),
    8.horizontalSpace,
    const MoreButton(),
  ],
);

Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    const Header(),
    16.verticalSpace,
    const Body(),
  ],
);
```

With tokens: `SKit.hSpaceSize(SKSize.sm)` and `SKit.vSpaceSize(SKSize.md)`.

---

## RTL-safe padding

`start` and `end` resolve against `Directionality`, so one definition serves both directions:

```dart
SKit.padding(start: 24, end: 12, vertical: 16, child: content);

// Or via context
Container(
  padding: context.scalePadding(start: 24, end: 12, vertical: 16),
  child: content,
);
```

---

## Device branching in a State class

When you need device info without passing `BuildContext` around:

```dart
class DashboardState extends State<Dashboard>
    with DeviceMetricsMixin<Dashboard> {
  @override
  Widget build(BuildContext context) {
    if (isDesktop) return const DesktopDashboard();
    if (isTablet) return const TabletDashboard();
    return const MobileDashboard();
  }

  @override
  void onDeviceMetricsChanged(Size previous, Size current) {
    debugPrint('Metrics changed: $current');
  }
}
```

---

## Testing

Widgets that use `.w`, `.sp`, or `SK*` need a `ScaleKitBuilder` ancestor. Wrap the widget under test:

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_scale_kit/flutter_scale_kit.dart';

Future<void> pumpScaled(WidgetTester tester, Widget child) {
  return tester.pumpWidget(
    MaterialApp(
      home: ScaleKitBuilder(
        designWidth: 375,
        designHeight: 812,
        designType: DeviceType.mobile,
        child: Scaffold(body: child),
      ),
    ),
  );
}

void main() {
  testWidgets('card renders', (tester) async {
    await pumpScaled(tester, const ProductCard());
    expect(find.byType(ProductCard), findsOneWidget);
  });
}
```

To test a specific screen size, set the surface size before pumping:

```dart
tester.view.physicalSize = const Size(1200, 800);
tester.view.devicePixelRatio = 1.0;
addTearDown(tester.view.reset);
```

To assert on scaled values, read them through `ScaleManager` inside a `Builder` so the scope is active:

```dart
await tester.pumpWidget(
  MaterialApp(
    home: ScaleKitBuilder(
      designWidth: 375,
      designHeight: 812,
      child: Builder(
        builder: (context) {
          final scale = ScaleManager.instance;
          expect(scale.getWidth(100) / scale.getWidth(1), closeTo(100, 1e-9));
          return const SizedBox();
        },
      ),
    ),
  ),
);
```

If you want raw numbers in a test, disable scaling: `ScaleKitBuilder(enabled: false, ...)`.

---

## Runtime on/off toggle

Useful for comparing Scale Kit against vanilla Flutter sizing:

```dart
final enabled = ValueNotifier<bool>(true);

ScaleKitBuilder(
  designWidth: 375,
  designHeight: 812,
  enabled: enabled.value,      // initial
  enabledListenable: enabled,  // runtime switch
  child: MaterialApp(home: const HomePage()),
);

// Flip it anywhere
enabled.value = false;
```

While disabled, `.w` / `.h` / `.sp` and the `ScaleManager` methods return values unmodified. Re-enable to restore scaling immediately. The example app exposes this behind the tune icon.
