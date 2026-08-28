# API map (usage)

Import: `package:flutter_scale_kit/flutter_scale_kit.dart`

## Bootstrap

`ScaleKitBuilder` — required ancestor.

Important fields: `designWidth`, `designHeight`, `designType` (default mobile), `minScale` / `maxScale` (omit for auto), `autoScaleLandscape` (default true), `autoScalePortrait` (default false), `enabled` / `enabledListenable`, `lockDesktopPlatforms`, `lockDesktopAsTablet`, `lockDesktopAsMobile`, `breakpoints` (`ScaleBreakpoints`), `sizeChangeThreshold`.

## Extensions (`num`)

| API | Use |
| --- | --- |
| `.w` `.h` | width / height |
| `.sp` | font |
| `.spf` | font × system text scale |
| `.r` | full radius (pills/circles) |
| `.rSafe` | clamped radius (cards) |
| `.rFixed` | no scale |
| `.sw` `.sh` | % of screen |
| `.wMax` `.wMin` `.wClamp` | same for `h`, `sp`, `r`, `sw`, `sh` |
| `12.horizontalSpace` `16.verticalSpace` | gap widgets |

Also: `EdgeInsets.all(12).w`, `BorderRadius.circular(16).h`, `Radius.circular(24).w`.

## SK widgets (pass raw design numbers)

`SKContainer`, `SKPadding`, `SKMargin`, `SKText`, `SKIcon`, `SKCard`, `SKDivider`, `SKAppBar`, `SKListTile`, `SKSwitch`, `SKSwitchListTile`, `SKTextField`, `SKTextFormField`, `SKElevatedButton`, `SKTextButton`, `SKOutlinedButton`, `SKIconButton`, `SKActionChip`, `SKFilterChip`, `SKChoiceChip`, `SKInputChip`, `SKImage.asset/network/file/memory`.

Const gaps: `HSpace`, `VSpace`, `SSpace`, `SKSizedBox`.

## SKit helpers

`SKit.padding` / `paddingSize` / `paddingEdgeInsets` / `paddingEdgeInsetsSize`  
`SKit.margin` / `marginSize`  
`SKit.roundedContainer` / `roundedContainerSize` (`radiusMode: SKRadiusMode.safe` default)  
`SKit.pad()` `SKit.margin()` `SKit.rounded()` — defaults from `setDefault*`  
`SKit.hSpace` `vSpace` `hSpaceSize` `vSpaceSize`  
`SKit.text` / `textFull` / `textStyleFull`  
`SKit.responsiveInt` / `responsiveDouble`

## Tokens

`SKSize`: xs, sm, md, lg, xl, xxl  
`SKTextSize`: s6…s52  

`setPaddingSizes` `setMarginSizes` `setRadiusSizes` `setSpacingSizes` `setTextSizes`  
`setDefaultPadding` `setDefaultMargin` `setDefaultRadius` `setDefaultSpacing` `setDefaultTextSize`

`SizeValues.custom` / `.material3()` / `.tailwind()`  
`TextSizeValues.custom` / `.material3()`

`ScaleKitDesignValues` → `.compute()` → `ScaleKitDesignValuesSet` (scaled `EdgeInsets`, `BorderRadius`, `TextStyle`). Call `compute()` once per build/screen.

Deprecated: `SKitTheme` → `ScaleKitDesignValues`.

## Responsive layouts

`SKResponsive` — separate builders: `mobile`, `mobileLandscape`, `tablet`, `tabletLandscape`, `desktop`  
`SKResponsiveBuilder` — same **or** `builder: (context, device, orientation)`  

Fallback: desktop → tablet → mobile; landscape → portrait of that device.

Flags: `deviceTypeOverride`, `desktopAs`, `lockDesktopAsTablet`, `lockDesktopAsMobile`.

## Device queries

`context.isMobile` `isTablet` `isDesktop`  
`context.isMobilePlatform` `isAndroidPlatform` `isIOSPlatform` `isDesktopPlatform` `isWebPlatform`  
`context.screenSizeClass` and `isMobileSize` / `isTabletSize` / `isDesktopSize` / …  
`DeviceMetricsMixin` on `State` for the same flags without extra context plumbing.

`DeviceType`: mobile, tablet, desktop, web  
`DeviceClassificationSource`: responsive, platform, size

## Fonts / theme

`FontConfig.instance.setDefaultFont(googleFont: ...)` or `customFontFamily:`  
`setLanguageFont(LanguageFontConfig(languageCode: 'ja', googleFont: ...))`  
`setLanguageGroupFont(LanguageGroupFontConfig(languageCodes: ['ar','fa','ur'], googleFont: ...))`

`ResponsiveThemeData.create(context: context, colorScheme: ..., useMaterial3: true)`

If the app uses **`flutter_scale_theme_kit`**: do **not** use `ResponsiveThemeData.create` as the full theme. Use:

`appST.light.copyWith(textTheme: appST.light.createResponsiveTextTheme(appST.light.textTheme))`  
(same for `appST.dark`). Requires a `BuildContext` under `ScaleKitBuilder`.

## Engine (rarely)

`ScaleManager.instance.getWidth/getHeight/getFontSize/getRadius`  
`screenWidth` `orientation` `deviceType` `platformCategory` `screenSizeClass`
