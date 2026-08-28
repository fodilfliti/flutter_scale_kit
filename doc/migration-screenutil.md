# Migrating from flutter_screenutil

Most `flutter_screenutil` code keeps working after a mechanical swap. This page covers the differences that actually matter.

> Supplement to the [README](../README.md#migration), which has the short version. Read this for
> the three migration strategies and the full gotcha list.

- [Setup](#setup)
- [Extension mapping](#extension-mapping)
- [The radius difference](#the-radius-difference)
- [Widget replacements](#widget-replacements)
- [Migration strategies](#migration-strategies)
- [Gotchas](#gotchas)

---

## Setup

Replace `ScreenUtilInit` with `ScaleKitBuilder`:

```dart
// Before
ScreenUtilInit(
  designSize: const Size(375, 812),
  minTextAdapt: true,
  builder: (context, child) => MaterialApp(home: const HomePage()),
);

// After
ScaleKitBuilder(
  designWidth: 375,
  designHeight: 812,
  designType: DeviceType.mobile,
  child: MaterialApp(home: const HomePage()),
);
```

`ScaleKitBuilder` takes a `child`, not a `builder`. If you need a context that can see Scale Kit (for `ResponsiveThemeData.create`), wrap in a `Builder`.

| flutter_screenutil | Scale Kit |
| --- | --- |
| `designSize: Size(375, 812)` | `designWidth: 375, designHeight: 812` |
| `builder: (context, child) => ...` | `child: ...` |
| `minTextAdapt` | Automatic — limits are chosen per device |
| `splitScreenMode` | Automatic |
| `ScreenUtil().setWidth(x)` | `x.w` or `ScaleManager.instance.getWidth(x)` |
| `ScreenUtil().screenWidth` | `ScaleManager.instance.screenWidth` |

---

## Extension mapping

These behave the same, so a find-and-replace is usually enough:

| flutter_screenutil | Scale Kit | Note |
| --- | --- | --- |
| `.w` | `.w` | Identical |
| `.h` | `.h` | Identical |
| `.sp` | `.sp` | Identical |
| `.sw` | `.sw` | Identical |
| `.sh` | `.sh` | Identical |
| `.r` | `.rSafe` | **See below** — semantics differ |
| `.spMin` | `.spMin(min)` | Scale Kit takes an explicit bound |
| `.spMax` | `.spMax(max)` | Scale Kit takes an explicit bound |

Scale Kit adds constraint variants for every extension: `.wClamp(min, max)`, `.hMax(max)`, `.spClamp(min, max)`, `.swClamp(min, max)`, and so on.

---

## The radius difference

This is the one migration trap.

In `flutter_screenutil`, `.r` is a general scale factor. In Scale Kit there are three explicit radius modes:

| Scale Kit | Behavior | Use for |
| --- | --- | --- |
| `.rSafe` | Scaled with gentle clamping | **Cards, sheets, containers** — closest to screenutil `.r` |
| `.r` | Fully scaled, no clamp | Pills, circular avatars, fully rounded chips |
| `.rFixed` | Never scaled | Hairlines and borders that must stay exact |

When migrating, **map screenutil `.r` to `.rSafe`**. Using bare `.r` on a large screen can round a card far more than you intended.

```dart
// Before (screenutil)
BorderRadius.circular(12.r)

// After
BorderRadius.circular(12.rSafe)
```

---

## Widget replacements

Optional, but this is where Scale Kit saves the most code. `SK*` widgets take **raw design numbers** and scale internally, so the extensions disappear:

```dart
// Before
Container(
  width: 200.w,
  height: 100.h,
  padding: EdgeInsets.all(16.w),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(12.r),
  ),
  child: Text('Hi', style: TextStyle(fontSize: 16.sp)),
)

// After
SKContainer(
  width: 200,
  height: 100,
  padding: EdgeInsets.all(16),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(12), // rSafe applied automatically
  ),
  child: SKText('Hi', fontSize: 16),
)
```

Search-and-replace pairs:

`Container` → `SKContainer`, `Text` → `SKText`, `Padding` → `SKPadding`, `Icon` → `SKIcon`, `Card` → `SKCard`, `Divider` → `SKDivider`, `AppBar` → `SKAppBar`, `ListTile` → `SKListTile`, `TextField` → `SKTextField`, `TextFormField` → `SKTextFormField`, `ElevatedButton` → `SKElevatedButton`, `TextButton` → `SKTextButton`, `OutlinedButton` → `SKOutlinedButton`, `IconButton` → `SKIconButton`, `Switch` → `SKSwitch`, `Image` → `SKImage`.

---

## Migration strategies

Pick one based on how much time you have.

### 1. Swap the root only (5 minutes)

Replace `ScreenUtilInit` with `ScaleKitBuilder`, change `.r` to `.rSafe`, and stop. Everything else keeps working. You immediately gain the cache, LRU protection, and rebuild optimization.

### 2. Add drop-in widgets (gradual)

Do the root swap, then search-replace widget classes file by file. **Remove the extension suffixes as you go** — `SKContainer(width: 200)`, not `SKContainer(width: 200.w)`.

### 3. Full design system (new screens)

New screens use tokens and `SK*` widgets; old screens keep `.w`. See [Design system](design-system.md).

---

## Gotchas

**Do not double-scale.** After swapping to an `SK*` widget, drop the extension:

```dart
SKContainer(width: 200)     // correct
SKContainer(width: 200.w)   // wrong — scaled twice
```

Scale Kit detects already-scaled values in most paths, but writing raw numbers inside `SK*` widgets is the rule that always holds.

**`ScaleKitBuilder` must be above `MaterialApp`,** not inside a route. One builder for the whole app; do not nest a second one.

**Portrait boosts are off by default.** `flutter_screenutil` has no equivalent. If your app felt different after rotating, see [orientation boosts](scaling-engine.md#orientation-boosts).

**`google_fonts` is not a dependency here.** If you used screenutil alongside Google Fonts, keep `google_fonts` in your own pubspec and pass builders into `FontConfig`.
