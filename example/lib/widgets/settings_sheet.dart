import 'package:flutter/material.dart';
import 'package:flutter_scale_kit/flutter_scale_kit.dart';

class SettingsSheet extends StatelessWidget {
  final ValueNotifier<bool> enabled;
  final bool autoScale;
  final bool autoScaleLandscape;
  final bool autoScalePortrait;
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
                            onSave(
                              tempEnabled,
                              tempAutoScale,
                              tempAutoScaleLandscape,
                              tempAutoScalePortrait,
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
