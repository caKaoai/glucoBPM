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

import 'package:gluco_pal/custom_code/widgets/age_ruler.dart';
import 'package:flutter/services.dart';

class WeightRuler extends StatefulWidget {
  const WeightRuler({
    super.key,
    this.width,
    this.height,
    this.initVal,
    this.returnWeight,
    this.type,
    this.min,
    this.max,
  });

  final double? width;
  final double? height;
  final int? initVal;
  final Future Function(int weighttInfo)? returnWeight;
  final int? type;
  final int? min;
  final int? max;

  @override
  State<WeightRuler> createState() => _WeightRulerState();
}

class _WeightRulerState extends State<WeightRuler> {
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

    // ── Original logic ────────────────────────────────────────────
    if (widget.type == 0) {
      minValue = 10;
      maxValue = 700;
      unit = 'lbs';
    } else {
      minValue = 10;
      maxValue = 300;
      unit = 'kg';
    }

    if (widget.initVal != null) {
      if (unit == 'kg') {
        selectedValue =
            (widget.initVal! / 1000).round().clamp(minValue, maxValue);
      } else {
        selectedValue =
            (widget.initVal! / 453.592).round().clamp(minValue, maxValue);
      }
    } else {
      selectedValue = minValue;
    }

    _scrollController = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.returnWeight != null) {
        int grams = 0;
        if (unit == 'kg') {
          grams = selectedValue * 1000;
        } else if (unit == 'lbs') {
          grams = (selectedValue * 453.592).round();
        }
        widget.returnWeight!(grams);
      }
    });
    // ── End original logic ────────────────────────────────────────
  }

  double _offsetFor(int value) => (value - minValue) * tickSpacing;

  // ── Original logic — untouched ────────────────────────────────────────────
  void _onScroll() {
    if (!_scrollController.hasClients) return;
    int newValue = (minValue + (_scrollController.offset / tickSpacing).round())
        .clamp(minValue, maxValue);
    if (newValue != selectedValue) {
      setState(() => selectedValue = newValue);
      if (widget.returnWeight != null) {
        int grams = 0;
        if (unit == 'kg') {
          grams = newValue * 1000;
        } else if (unit == 'lbs') {
          grams = (newValue * 453.592).round();
        }
        widget.returnWeight!(grams);
      }

      // Haptic feedback on tick change
      if (newValue % 5 == 0) {
        HapticFeedback.mediumImpact();
      } else {
        HapticFeedback.selectionClick();
      }
    }
  }
  // ── End original logic ────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // ── Value label (AgeRuler style) ──────────────────────────────
        RichText(
          text: TextSpan(
            text: '$selectedValue',
            style: const TextStyle(
              color: primaryColor,
              fontSize: 24,
              fontWeight: FontWeight.w900,
              height: 1,
            ),
            children: [
              TextSpan(
                text: '  $unit',
                style: const TextStyle(
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
                      final isMajor = value % 5 == 0;
                      final isSelected = value == selectedValue;

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
                                  '$value',
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
