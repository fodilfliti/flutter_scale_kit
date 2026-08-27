# Project styles (user picks one)

Look for `scale_kit.yaml` or `.scalekit.yaml` at the **app root**. If `style` is set, **follow it**. Do not switch styles mid-project unless the user asks.

If the file is **missing**, ask **once** (see [init.md](init.md)), then write the file.

## `design_system` (recommended)

Best default: tokens + `SK*` + `SKit.*Size`. Short, consistent, uses the strongest APIs.

```dart
SKit.paddingSize(
  all: SKSize.md,
  child: SKit.roundedContainerSize(
    all: SKSize.md,
    child: Column(
      children: [
        SKText('Title', fontSize: 20, fontWeight: FontWeight.w600),
        SKit.vSpaceSize(SKSize.sm),
        SKText('Body', fontSize: 14),
      ],
    ),
  ),
);
```

Busy screen: `final v = appDesign.compute();` then `v.paddingMd`.

## `drop_in`

Fast migration: `SK*` with raw design-px, little token use. Still no `.w` on SK widgets.

```dart
SKPadding(
  padding: EdgeInsets.all(16),
  child: SKContainer(
    height: 48,
    child: SKText('Save', fontSize: 16),
  ),
);
```

## `extensions`

ScreenUtil-like: keep Flutter widgets, scale with `.w` / `.sp` / `.rSafe`.

```dart
Padding(
  padding: EdgeInsets.all(16.w),
  child: Container(
    height: 48.h,
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.rSafe)),
    child: Text('Save', style: TextStyle(fontSize: 16.sp)),
  ),
);
```

## `hybrid`

New UI = `design_system`. Leftover / third-party widgets = `.w` / `.sp` / clamps.

```dart
SKit.paddingSize(
  all: SKSize.md,
  child: Column(
    children: [
      SKText('Title', fontSize: 18),
      SKit.vSpaceSize(SKSize.sm),
      SizedBox(width: 200.wMax(360), child: const LegacyChart()),
    ],
  ),
);
```

## All styles still

- Need `ScaleKitBuilder` in `main`
- Never `SKContainer(width: 120.w)`
- `SKResponsive` only when **structure** changes
- `SKit.responsiveInt` for column counts
