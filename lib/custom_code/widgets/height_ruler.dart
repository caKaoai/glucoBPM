// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:flutter/services.dart';
import 'package:gluco_pal/custom_code/widgets/age_ruler.dart';

class HeightRuler extends StatefulWidget {
  const HeightRuler({
    super.key,
    this.width,
    this.height,
    this.initVal,
    this.returnHeight,
    this.type,
  });

  final double? width;
  final double? height;
  final int? initVal;
  final Future Function(int heightInfo)? returnHeight;
  final int? type;

  @override
  State<HeightRuler> createState() => _HeightRulerState();
}

class _HeightRulerState extends State<HeightRuler> {
  // ── Original logic — untouched ────────────────────────────────────────────
  late int minValue, maxValue, selectedValue;
  late String unit;
  late ScrollController _scrollController;

  static const double tickSpacing = 24.0;
  static const double rulerHeight = 70;
  static const double majorTickHeight = 30;
  static const double minorTickHeight = 14;

  // UI constants matching AgeRuler
  static const Color primaryColor = Color(0xFFE53935);
  bool _initialScrollDone = false;

  @override
  void initState() {
    super.initState();

    // ── Original logic — only ranges updated ─────────────────────
    if (widget.type == 1) {
      // cm mode
      minValue = 120;
      maxValue = 260;
      unit = 'cm';

      selectedValue = minValue + 20;

      if (widget.initVal != null) {
        selectedValue = widget.initVal!.clamp(minValue, maxValue);
      }
    } else {
      // ft/in mode (stored as total inches)
      minValue = 48; // 4 ft
      maxValue = 108; // 9 ft
      unit = 'ft';

      selectedValue = minValue;

      if (widget.initVal != null) {
        final totalInches = (widget.initVal! / 2.54).round();
        selectedValue = totalInches.clamp(minValue, maxValue);
      }
    }

    _scrollController = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.returnHeight != null) {
        widget.returnHeight!(getReturnValue(selectedValue));
      }
    });
  }

  // ── Original logic — untouched ────────────────────────────────────────────
  dynamic getReturnValue(int value, {bool asCm = true}) {
    if (widget.type == 0) {
      // value = totalInches (ft/in mode)
      double cm = value * 2.54;
      if (asCm) return cm.round();
      int feet = value ~/ 12;
      int inches = value % 12;
      return {"feet": feet, "inches": inches, "cm": cm.round()};
    } else {
      // value = cm (cm mode)
      if (asCm) return value;
      double totalInches = value / 2.54;
      int feet = totalInches ~/ 12;
      int inches = (totalInches - feet * 12).round();
      if (inches == 12) {
        feet += 1;
        inches = 0;
      }
      return {"feet": feet, "inches": inches, "cm": value};
    }
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    int newValue = (minValue + (_scrollController.offset / tickSpacing).round())
        .clamp(minValue, maxValue);
    if (newValue != selectedValue) {
      setState(() => selectedValue = newValue);
      if (widget.returnHeight != null) {
        widget.returnHeight!(getReturnValue(newValue));
      }

      // Haptic feedback on tick change
      final bool isCm = widget.type == 1;
      final bool isMajorTick = isCm ? newValue % 5 == 0 : newValue % 12 == 0;
      if (isMajorTick) {
        HapticFeedback.mediumImpact();
      } else {
        HapticFeedback.selectionClick();
      }
    }
  }

  String _formatFeetInches(int totalInches) {
    final feet = totalInches ~/ 12;
    final inches = totalInches % 12;
    return "$feet' $inches\"";
  }

  // ── End original logic ────────────────────────────────────────────────────

  double _offsetFor(int value) => (value - minValue) * tickSpacing;

  @override
  Widget build(BuildContext context) {
    final bool isCm = widget.type == 1;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // ── Value label (AgeRuler style) ──────────────────────────────
        isCm
            ? RichText(
                text: TextSpan(
                  text: '$selectedValue',
                  style: const TextStyle(
                    color: primaryColor,
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    height: 1,
                  ),
                  children: const [
                    TextSpan(
                      text: '  cm',
                      style: TextStyle(
                        color: Color(0xFF94A3B8),
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              )
            : RichText(
                text: TextSpan(
                  text: _formatFeetInches(selectedValue),
                  style: const TextStyle(
                    color: primaryColor,
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    height: 1,
                  ),
                  children: const [
                    TextSpan(
                      text: '  ft',
                      style: TextStyle(
                        color: Color(0xFF94A3B8),
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),

        const SizedBox(height: 6),

        // ── Ruler (AgeRuler style) ─────────────────────────────────────
        LayoutBuilder(builder: (context, constraints) {
          final double containerWidth = constraints.maxWidth;
          final double sidePadding = containerWidth / 2 - tickSpacing / 2;

          if (!_initialScrollDone) {
            _initialScrollDone = true;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (_scrollController.hasClients) {
                _scrollController.jumpTo(_offsetFor(selectedValue));
              }
            });
          }

          return SizedBox(
            height: rulerHeight,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // ── Scrollable ticks ────────────────────────────────
                NotificationListener<ScrollNotification>(
                  onNotification: (notification) {
                    if (notification is ScrollUpdateNotification) {
                      _onScroll();
                    }
                    return false;
                  },
                  child: ListView.builder(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    physics: SnapScrollPhysics(
                      itemExtent: tickSpacing,
                      parent: const ClampingScrollPhysics(),
                    ),
                    itemCount: maxValue - minValue + 1,
                    padding: EdgeInsets.symmetric(horizontal: sidePadding),
                    itemBuilder: (context, index) {
                      final value = minValue + index;
                      // ── Original major tick logic — untouched ──────
                      final bool isMajor =
                          isCm ? value % 5 == 0 : value % 12 == 0;
                      final bool isSelected = value == selectedValue;

                      return SizedBox(
                        width: tickSpacing,
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            // Tick bar
                            Positioned(
                              bottom: 22,
                              child: Container(
                                width: isMajor ? 2.0 : 1.5,
                                height:
                                    isMajor ? majorTickHeight : minorTickHeight,
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? primaryColor
                                      : Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(1),
                                ),
                              ),
                            ),
                            // Label under major ticks
                            if (isMajor)
                              Positioned(
                                bottom: 4,
                                child: Text(
                                  // ── Original label logic — untouched
                                  isCm ? '$value' : "${value ~/ 12}'",
                                  style: TextStyle(
                                    fontSize: 9,
                                    fontWeight: isSelected
                                        ? FontWeight.w700
                                        : FontWeight.w400,
                                    color: isSelected
                                        ? primaryColor
                                        : Colors.grey.shade400,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                // ── Centre indicator bar ─────────────────────────────
                Positioned(
                  top: 8,
                  bottom: 18,
                  child: Container(
                    width: 3.5,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
