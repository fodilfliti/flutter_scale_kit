# UI patterns

Follow `scale_kit.yaml` `style` if present (see [styles.md](styles.md)). If there is no yaml, ask once. Examples below are **design_system** (recommended).

## Decide in one line

- Normal UI → tokens + `SK*` / `SKit.roundedContainerSize` (first example)
- Many values on one screen → `appDesign.compute()` once
- One leftover Flutter widget or odd px → `.w` / `.sp` / `.rSafe`
- Column count only → `SKit.responsiveInt`
- Two different trees → `SKResponsiveBuilder`

---

## Canonical screen (tokens + SK + SKit)

```dart
@override
Widget build(BuildContext context) {
  return SKit.paddingSize(
    all: SKSize.md,
    child: SKit.roundedContainerSize(
      all: SKSize.md,
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SKText('Dashboard', fontSize: 20, fontWeight: FontWeight.w600),
          SKit.vSpaceSize(SKSize.sm),
          SKText('Auto-scales with the canvas.', fontSize: 14),
        ],
      ),
    ),
  );
}
```

## Busy screen (compute once)

```dart
final v = appDesign.compute();
return SKPadding(
  padding: v.paddingMd!,
  child: SKContainer(
    padding: v.paddingMd,
    decoration: BoxDecoration(borderRadius: v.borderRadiusMd),
    child: SKText('Dashboard', fontSize: 20),
  ),
);
```

## Enum padding without a theme object

```dart
SKit.paddingSize(
  horizontal: SKSize.lg,
  vertical: SKSize.sm,
  child: child,
);
```

## Clamp one size (still one layout)

```dart
Row(
  children: [
    SKImage.asset('assets/logo.png', width: 48), // SK scales
    SKit.hSpaceSize(SKSize.sm),
    Expanded(child: SKText('Title', fontSize: 16)),
  ],
)
```

If a raw Flutter child would grow too wide on desktop:

```dart
SizedBox(width: 280.wMax(400), child: const LegacyChart())
```

## Responsive grid (counts only)

```dart
final columns = SKit.responsiveInt(
  context: context,
  mobile: 2,
  tablet: 4,
  desktop: 6,
);
GridView.count(crossAxisCount: columns, children: items);
```

## Different trees per device

```dart
SKResponsiveBuilder(
  mobile: (_) => const MobileHome(),
  tablet: (_) => const TabletHome(),
  desktop: (_) => const DesktopHome(),
);
```

## Migrate an existing widget tree

Replace classes; leave numbers as design-px (no `.w` unless staying on raw Flutter widgets):

- `Container` → `SKContainer`
- `Text` → `SKText` (move `style.fontSize` to `fontSize:`)
- `Padding` → `SKPadding`
- `TextField` → `SKTextField`
- `ElevatedButton` → `SKElevatedButton`

## Mix with extensions (raw Flutter only)

```dart
Container(
  width: 200.wMax(360),
  padding: EdgeInsets.all(16).w,
  decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.rSafe)),
  child: Text('Hello', style: TextStyle(fontSize: 16.sp)),
);
```

## Platform chrome vs size

```dart
if (context.isIOSPlatform) return const CupertinoToolbar();
if (context.isDesktopSize) return const WideSidebar();
```

Do not treat “Windows + small window” as a phone unless you intend that (`lockDesktopAsMobile` or size-class checks).
