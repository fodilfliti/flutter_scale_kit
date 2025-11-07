import 'package:flutter/material.dart';
import 'package:flutter_scale_kit/flutter_scale_kit.dart';

class SettingsSheet extends StatelessWidget {
  final ValueNotifier<bool> enabled;
  final bool autoScale;
  final bool autoScaleLandscape;
  final bool autoScalePortrait;
  final double? minScale; // null = auto-detect
  final double? maxScale; // null = auto-detect
  final double mobileLandscapeFontBoost;
  final double mobileLandscapeSizeBoost;
  final double tabletLandscapeFontBoost;
  final double tabletLandscapeSizeBoost;
  final double desktopLandscapeFontBoost;
  final double desktopLandscapeSizeBoost;
  final double mobilePortraitFontBoost;
  final double mobilePortraitSizeBoost;
  final double tabletPortraitFontBoost;
  final double tabletPortraitSizeBoost;
  final double desktopPortraitFontBoost;
  final double desktopPortraitSizeBoost;
  final Function(
    bool enabled,
    bool autoScale,
    bool autoScaleLandscape,
    bool autoScalePortrait,
    double? minScale, // null = auto
    double? maxScale, // null = auto
    double mobileLandscapeFontBoost,
    double mobileLandscapeSizeBoost,
    double tabletLandscapeFontBoost,
    double tabletLandscapeSizeBoost,
    double desktopLandscapeFontBoost,
    double desktopLandscapeSizeBoost,
    double mobilePortraitFontBoost,
    double mobilePortraitSizeBoost,
    double tabletPortraitFontBoost,
    double tabletPortraitSizeBoost,
    double desktopPortraitFontBoost,
    double desktopPortraitSizeBoost,
  )
  onSave;

  const SettingsSheet({
    super.key,
    required this.enabled,
    required this.autoScale,
    required this.autoScaleLandscape,
    required this.autoScalePortrait,
    required this.minScale,
    required this.maxScale,
    required this.mobileLandscapeFontBoost,
    required this.mobileLandscapeSizeBoost,
    required this.tabletLandscapeFontBoost,
    required this.tabletLandscapeSizeBoost,
    required this.desktopLandscapeFontBoost,
    required this.desktopLandscapeSizeBoost,
    required this.mobilePortraitFontBoost,
    required this.mobilePortraitSizeBoost,
    required this.tabletPortraitFontBoost,
    required this.tabletPortraitSizeBoost,
    required this.desktopPortraitFontBoost,
    required this.desktopPortraitSizeBoost,
    required this.onSave,
  });

  static void show(
    BuildContext context, {
    required ValueNotifier<bool> enabled,
    required bool autoScale,
    required bool autoScaleLandscape,
    required bool autoScalePortrait,
    required double? minScale,
    required double? maxScale,
    required double mobileLandscapeFontBoost,
    required double mobileLandscapeSizeBoost,
    required double tabletLandscapeFontBoost,
    required double tabletLandscapeSizeBoost,
    required double desktopLandscapeFontBoost,
    required double desktopLandscapeSizeBoost,
    required double mobilePortraitFontBoost,
    required double mobilePortraitSizeBoost,
    required double tabletPortraitFontBoost,
    required double tabletPortraitSizeBoost,
    required double desktopPortraitFontBoost,
    required double desktopPortraitSizeBoost,
    required Function(
      bool enabled,
      bool autoScale,
      bool autoScaleLandscape,
      bool autoScalePortrait,
      double? minScale,
      double? maxScale,
      double mobileLandscapeFontBoost,
      double mobileLandscapeSizeBoost,
      double tabletLandscapeFontBoost,
      double tabletLandscapeSizeBoost,
      double desktopLandscapeFontBoost,
      double desktopLandscapeSizeBoost,
      double mobilePortraitFontBoost,
      double mobilePortraitSizeBoost,
      double tabletPortraitFontBoost,
      double tabletPortraitSizeBoost,
      double desktopPortraitFontBoost,
      double desktopPortraitSizeBoost,
    )
    onSave,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return SettingsSheet(
          enabled: enabled,
          autoScale: autoScale,
          autoScaleLandscape: autoScaleLandscape,
          autoScalePortrait: autoScalePortrait,
          minScale: minScale,
          maxScale: maxScale,
          mobileLandscapeFontBoost: mobileLandscapeFontBoost,
          mobileLandscapeSizeBoost: mobileLandscapeSizeBoost,
          tabletLandscapeFontBoost: tabletLandscapeFontBoost,
          tabletLandscapeSizeBoost: tabletLandscapeSizeBoost,
          desktopLandscapeFontBoost: desktopLandscapeFontBoost,
          desktopLandscapeSizeBoost: desktopLandscapeSizeBoost,
          mobilePortraitFontBoost: mobilePortraitFontBoost,
          mobilePortraitSizeBoost: mobilePortraitSizeBoost,
          tabletPortraitFontBoost: tabletPortraitFontBoost,
          tabletPortraitSizeBoost: tabletPortraitSizeBoost,
          desktopPortraitFontBoost: desktopPortraitFontBoost,
          desktopPortraitSizeBoost: desktopPortraitSizeBoost,
          onSave: onSave,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Stage values locally; apply only when user taps Save
    bool tempEnabled = enabled.value;
    bool tempAutoScale = autoScale;
    bool tempAutoScaleLandscape = autoScaleLandscape;
    bool tempAutoScalePortrait = autoScalePortrait;

    // Manual mode: if either value is non-null, enable manual control
    bool tempUseManualScaleLimits = minScale != null || maxScale != null;
    double tempMinScale = minScale ?? 0.8;
    double tempMaxScale = maxScale ?? 1.2;

    double tempMobileLandscapeFontBoost = mobileLandscapeFontBoost;
    double tempMobileLandscapeSizeBoost = mobileLandscapeSizeBoost;
    double tempTabletLandscapeFontBoost = tabletLandscapeFontBoost;
    double tempTabletLandscapeSizeBoost = tabletLandscapeSizeBoost;
    double tempDesktopLandscapeFontBoost = desktopLandscapeFontBoost;
    double tempDesktopLandscapeSizeBoost = desktopLandscapeSizeBoost;

    double tempMobilePortraitFontBoost = mobilePortraitFontBoost;
    double tempMobilePortraitSizeBoost = mobilePortraitSizeBoost;
    double tempTabletPortraitFontBoost = tabletPortraitFontBoost;
    double tempTabletPortraitSizeBoost = tabletPortraitSizeBoost;
    double tempDesktopPortraitFontBoost = desktopPortraitFontBoost;
    double tempDesktopPortraitSizeBoost = desktopPortraitSizeBoost;

    return StatefulBuilder(
      builder: (context, setModalState) {
        Widget slider(
          String label,
          double value,
          ValueChanged<double> onChanged, {
          double min = 0.8,
          double max = 1.5,
        }) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('$label: ${value.toStringAsFixed(2)}'),
              Slider(
                min: min,
                max: max,
                divisions: ((max - min) * 100).toInt(),
                value: value,
                onChanged: (v) {
                  setModalState(() => onChanged(v));
                },
              ),
            ],
          );
        }

        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Scale Kit Settings',
                        style: TextStyle(
                          fontSize: 20.0.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF6750A4),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        color: Colors.grey.shade700,
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  SwitchListTile(
                    title: const Text('Enabled'),
                    value: tempEnabled,
                    onChanged: (v) {
                      setModalState(() => tempEnabled = v);
                    },
                  ),
                  if (tempEnabled) ...[
                    const Divider(),
                    Row(
                      children: [
                        const Text(
                          'Scale Clamp',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 8),
                        if (!tempUseManualScaleLimits)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green.shade100,
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: Colors.green.shade300),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.auto_awesome,
                                  size: 14,
                                  color: Colors.green.shade700,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'Auto-Intelligent',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.green.shade700,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        if (tempUseManualScaleLimits)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.orange.shade100,
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: Colors.orange.shade300),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.tune,
                                  size: 14,
                                  color: Colors.orange.shade700,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'Manual Override',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.orange.shade700,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    SwitchListTile(
                      title: const Text('Manual Scale Control'),
                      subtitle: Text(
                        tempUseManualScaleLimits
                            ? 'Using custom limits (overrides auto-detection)'
                            : 'Using intelligent auto-detection (recommended)',
                        style: TextStyle(
                          fontSize: 11,
                          color:
                              tempUseManualScaleLimits
                                  ? Colors.orange.shade700
                                  : Colors.green.shade700,
                        ),
                      ),
                      value: tempUseManualScaleLimits,
                      onChanged: (v) {
                        setModalState(() => tempUseManualScaleLimits = v);
                      },
                    ),
                    if (tempUseManualScaleLimits) ...[
                      const SizedBox(height: 8),
                      slider(
                        'Min scale',
                        tempMinScale,
                        (v) {
                          tempMinScale = v;
                          if (tempMinScale > tempMaxScale) {
                            tempMaxScale = v;
                          }
                        },
                        min: 0.5,
                        max: 1.5,
                      ),
                      slider(
                        'Max scale',
                        tempMaxScale,
                        (v) {
                          tempMaxScale = v;
                          if (tempMaxScale < tempMinScale) {
                            tempMinScale = v;
                          }
                        },
                        min: tempMinScale,
                        max: 2.0,
                      ),
                      const SizedBox(height: 8),
                      // Live scale preview
                      Builder(
                        builder: (ctx) {
                          final screenSize = MediaQuery.of(ctx).size;
                          final designWidth = 375.0;
                          final designHeight = 812.0;
                          final rawScaleW = screenSize.width / designWidth;
                          final rawScaleH = screenSize.height / designHeight;
                          final clampedScaleW = rawScaleW.clamp(
                            tempMinScale,
                            tempMaxScale,
                          );
                          final clampedScaleH = rawScaleH.clamp(
                            tempMinScale,
                            tempMaxScale,
                          );

                          // Calculate what auto-detection would choose
                          final orientation = MediaQuery.of(ctx).orientation;
                          final isLandscape =
                              orientation == Orientation.landscape;
                          final screenWidth = screenSize.width;

                          // Simple device type detection (mimics ScaleManager logic)
                          String deviceType;
                          double autoMin, autoMax;
                          if (screenWidth < 600) {
                            deviceType = 'Mobile';
                            if (isLandscape) {
                              autoMin = 0.85;
                              autoMax = 1.25;
                            } else {
                              autoMin = 0.85;
                              autoMax = 1.15;
                            }
                          } else if (screenWidth < 1200) {
                            deviceType = 'Tablet';
                            if (isLandscape) {
                              autoMin = 0.75;
                              autoMax = 1.4;
                            } else {
                              autoMin = 0.8;
                              autoMax = 1.3;
                            }
                          } else {
                            deviceType = 'Desktop';
                            if (isLandscape) {
                              autoMin = 0.6;
                              autoMax = 2.0;
                            } else {
                              autoMin = 0.7;
                              autoMax = 1.8;
                            }
                          }

                          return Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade50,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.blue.shade200),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '📊 Live Scale Preview',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue.shade900,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Screen: ${screenSize.width.toInt()}×${screenSize.height.toInt()}',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey.shade700,
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 6,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.purple.shade100,
                                        borderRadius: BorderRadius.circular(3),
                                      ),
                                      child: Text(
                                        deviceType,
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.purple.shade700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  'Design: ${designWidth.toInt()}×${designHeight.toInt()} • ${isLandscape ? "Landscape" : "Portrait"}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: Colors.green.shade50,
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                      color: Colors.green.shade200,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.tips_and_updates,
                                        size: 12,
                                        color: Colors.green.shade700,
                                      ),
                                      const SizedBox(width: 4),
                                      Expanded(
                                        child: Text(
                                          'Auto: ${autoMin.toStringAsFixed(2)}-${autoMax.toStringAsFixed(2)}x',
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.green.shade700,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Divider(height: 16),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Width',
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: Colors.grey.shade600,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            'Raw: ${rawScaleW.toStringAsFixed(2)}x',
                                            style: TextStyle(
                                              fontSize: 11,
                                              color:
                                                  rawScaleW == clampedScaleW
                                                      ? Colors.green.shade700
                                                      : Colors.orange.shade700,
                                            ),
                                          ),
                                          Text(
                                            'Final: ${clampedScaleW.toStringAsFixed(2)}x',
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue.shade900,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Height',
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: Colors.grey.shade600,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            'Raw: ${rawScaleH.toStringAsFixed(2)}x',
                                            style: TextStyle(
                                              fontSize: 11,
                                              color:
                                                  rawScaleH == clampedScaleH
                                                      ? Colors.green.shade700
                                                      : Colors.orange.shade700,
                                            ),
                                          ),
                                          Text(
                                            'Final: ${clampedScaleH.toStringAsFixed(2)}x',
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue.shade900,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                if (rawScaleW != clampedScaleW ||
                                    rawScaleH != clampedScaleH) ...[
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.warning_amber_rounded,
                                        size: 16,
                                        color: Colors.orange.shade700,
                                      ),
                                      const SizedBox(width: 4),
                                      Expanded(
                                        child: Text(
                                          'Clamping active: scale limited by min/max',
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: Colors.orange.shade700,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                                const SizedBox(height: 8),
                                Text(
                                  'Example: 100.w = ${(100 * clampedScaleW).toStringAsFixed(1)}px',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.purple.shade700,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ], // end if tempUseManualScaleLimits
                  ], // end if tempEnabled
                  if (tempEnabled) ...[
                    const Divider(),
                    SwitchListTile(
                      title: const Text('autoScale'),
                      value: tempAutoScale,
                      onChanged: (v) {
                        setModalState(() => tempAutoScale = v);
                      },
                    ),
                    SwitchListTile(
                      title: const Text('autoScaleLandscape'),
                      value: tempAutoScaleLandscape,
                      onChanged: (v) {
                        setModalState(() => tempAutoScaleLandscape = v);
                      },
                    ),
                    SwitchListTile(
                      title: const Text('autoScalePortrait'),
                      value: tempAutoScalePortrait,
                      onChanged: (v) {
                        setModalState(() => tempAutoScalePortrait = v);
                      },
                    ),
                  ],
                  // Conditional controls based on autoscale flags
                  if (tempAutoScale && tempAutoScaleLandscape) ...[
                    const Divider(),
                    const Text('Landscape Boosts (Mobile/Tablet/Desktop)'),
                    slider(
                      'Mobile Font',
                      tempMobileLandscapeFontBoost,
                      (v) => tempMobileLandscapeFontBoost = v,
                    ),
                    slider(
                      'Mobile Size',
                      tempMobileLandscapeSizeBoost,
                      (v) => tempMobileLandscapeSizeBoost = v,
                    ),
                    slider(
                      'Tablet Font',
                      tempTabletLandscapeFontBoost,
                      (v) => tempTabletLandscapeFontBoost = v,
                    ),
                    slider(
                      'Tablet Size',
                      tempTabletLandscapeSizeBoost,
                      (v) => tempTabletLandscapeSizeBoost = v,
                    ),
                    slider(
                      'Desktop Font',
                      tempDesktopLandscapeFontBoost,
                      (v) => tempDesktopLandscapeFontBoost = v,
                    ),
                    slider(
                      'Desktop Size',
                      tempDesktopLandscapeSizeBoost,
                      (v) => tempDesktopLandscapeSizeBoost = v,
                    ),
                  ],
                  if (tempAutoScale && tempAutoScalePortrait) ...[
                    const Divider(),
                    const Text('Portrait Boosts (Mobile/Tablet/Desktop)'),
                    slider(
                      'Mobile Font',
                      tempMobilePortraitFontBoost,
                      (v) => tempMobilePortraitFontBoost = v,
                    ),
                    slider(
                      'Mobile Size',
                      tempMobilePortraitSizeBoost,
                      (v) => tempMobilePortraitSizeBoost = v,
                    ),
                    slider(
                      'Tablet Font',
                      tempTabletPortraitFontBoost,
                      (v) => tempTabletPortraitFontBoost = v,
                    ),
                    slider(
                      'Tablet Size',
                      tempTabletPortraitSizeBoost,
                      (v) => tempTabletPortraitSizeBoost = v,
                    ),
                    slider(
                      'Desktop Font',
                      tempDesktopPortraitFontBoost,
                      (v) => tempDesktopPortraitFontBoost = v,
                    ),
                    slider(
                      'Desktop Size',
                      tempDesktopPortraitSizeBoost,
                      (v) => tempDesktopPortraitSizeBoost = v,
                    ),
                  ],
                  const SizedBox(height: 12),
                  // Responsive actions: prefer Row aligned to end; fallback to Wrap on compact widths
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final bool isCompact = constraints.maxWidth < 360;
                      final actions = <Widget>[
                        OutlinedButton(
                          onPressed: () {
                            setModalState(() {
                              // Reset staged values to defaults
                              tempEnabled = true;
                              tempAutoScale = true;
                              tempAutoScaleLandscape = true;
                              tempAutoScalePortrait = false;

                              // Reset to auto-detection (null values)
                              tempUseManualScaleLimits = false;
                              tempMinScale = 0.8; // fallback display value
                              tempMaxScale = 1.2; // fallback display value

                              tempMobileLandscapeFontBoost = 1.2;
                              tempMobileLandscapeSizeBoost = 1.2;
                              tempTabletLandscapeFontBoost = 1.2;
                              tempTabletLandscapeSizeBoost = 1.2;
                              tempDesktopLandscapeFontBoost = 1.0;
                              tempDesktopLandscapeSizeBoost = 1.0;

                              tempMobilePortraitFontBoost = 1.0;
                              tempMobilePortraitSizeBoost = 1.0;
                              tempTabletPortraitFontBoost = 1.0;
                              tempTabletPortraitSizeBoost = 1.0;
                              tempDesktopPortraitFontBoost = 1.0;
                              tempDesktopPortraitSizeBoost = 1.0;
                            });
                          },
                          child: const Text('Reset to defaults'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            Navigator.pop(context);
                            // Call onSave with all the values
                            // If manual mode is disabled, pass null to enable auto-detection
                            onSave(
                              tempEnabled,
                              tempAutoScale,
                              tempAutoScaleLandscape,
                              tempAutoScalePortrait,
                              tempUseManualScaleLimits ? tempMinScale : null,
                              tempUseManualScaleLimits ? tempMaxScale : null,
                              tempMobileLandscapeFontBoost,
                              tempMobileLandscapeSizeBoost,
                              tempTabletLandscapeFontBoost,
                              tempTabletLandscapeSizeBoost,
                              tempDesktopLandscapeFontBoost,
                              tempDesktopLandscapeSizeBoost,
                              tempMobilePortraitFontBoost,
                              tempMobilePortraitSizeBoost,
                              tempTabletPortraitFontBoost,
                              tempTabletPortraitSizeBoost,
                              tempDesktopPortraitFontBoost,
                              tempDesktopPortraitSizeBoost,
                            );
                          },
                          child: const Text('Save'),
                        ),
                      ];
                      if (isCompact) {
                        return Wrap(
                          alignment: WrapAlignment.end,
                          spacing: 8,
                          runSpacing: 8,
                          children: actions,
                        );
                      }
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ...actions
                              .expand((w) => [w, const SizedBox(width: 8)])
                              .toList()
                            ..removeLast(),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
