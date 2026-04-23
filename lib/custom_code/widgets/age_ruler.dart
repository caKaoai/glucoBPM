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

import 'package:flutter/physics.dart';
import 'package:flutter/services.dart';

class AgeRuler extends StatefulWidget {
  const AgeRuler({
    super.key,
    this.width,
    this.height,
    this.age,
    this.min,
    this.max,
    this.initVal,
  });

  final double? width;
  final double? height;
  final Future Function(int? ageVal)? age;
  final int? min;
  final int? max;
  final int? initVal;

  @override
  State<AgeRuler> createState() => _AgeRulerState();
}

class _AgeRulerState extends State<AgeRuler> {
  late int minValue;
  late int maxValue;
  static const double tickSpacing = 24.0;
  static const double rulerHeight = 70.0;
  static const double majorTickHeight = 30.0;
  static const double minorTickHeight = 14.0;
  static const Color primaryColor = Color(0xFFE53935);

  late int selectedValue;
  late ScrollController _scrollController;
  bool _initialScrollDone = false;

  @override
  void initState() {
    super.initState();
    minValue = widget.min ?? 10;
    maxValue = widget.max ?? 120;
    selectedValue = (widget.initVal ?? minValue).clamp(minValue, maxValue);
    _scrollController = ScrollController();
  }

  double _offsetFor(int value) => (value - minValue) * tickSpacing;

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final int newValue =
        (minValue + (_scrollController.offset / tickSpacing).round())
            .clamp(minValue, maxValue);
    if (newValue != selectedValue) {
      setState(() => selectedValue = newValue);
      widget.age?.call(selectedValue);

      // ── Haptic feedback on every tick change ──────────────────────
      // Heavy impact on every 5th value (major tick), light on minor ticks
      if (newValue % 5 == 0) {
        HapticFeedback.mediumImpact();
      } else {
        HapticFeedback.selectionClick();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // ── Value label ───────────────────────────────────────────────
        RichText(
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
                text: '  YRS',
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

        // ── Ruler ─────────────────────────────────────────────────────
        LayoutBuilder(builder: (context, constraints) {
          final double containerWidth = constraints.maxWidth;
          final double sidePadding = containerWidth / 2 - tickSpacing / 2;

          if (!_initialScrollDone) {
            _initialScrollDone = true;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (_scrollController.hasClients) {
                _scrollController.jumpTo(_offsetFor(selectedValue));
                widget.age?.call(selectedValue);
              }
            });
          }

          return SizedBox(
            height: rulerHeight,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // ── Scrollable ticks ──────────────────────────────────
                NotificationListener<ScrollNotification>(
                  onNotification: (n) {
                    if (n is ScrollUpdateNotification) _onScroll();
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
                      final int value = minValue + index;
                      final bool isMajor = value % 5 == 0;
                      final bool isSelected = value == selectedValue;

                      return SizedBox(
                        width: tickSpacing,
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
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

                // ── Centre indicator bar ──────────────────────────────
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

// ── Smooth snapping physics ──────────────────────────────────────────────────

class SnapScrollPhysics extends ScrollPhysics {
  final double itemExtent;

  const SnapScrollPhysics({required this.itemExtent, super.parent});

  @override
  SnapScrollPhysics applyTo(ScrollPhysics? ancestor) =>
      SnapScrollPhysics(itemExtent: itemExtent, parent: buildParent(ancestor));

  double _snapOffset(double offset) =>
      (offset / itemExtent).round() * itemExtent;

  @override
  Simulation? createBallisticSimulation(
      ScrollMetrics position, double velocity) {
    final double currentSnap = _snapOffset(position.pixels);
    if (velocity.abs() < toleranceFor(position).velocity &&
        (position.pixels - currentSnap).abs() <
            toleranceFor(position).distance) {
      return null;
    }

    final SpringDescription spring = SpringDescription.withDampingRatio(
      mass: 0.5,
      stiffness: 150.0,
      ratio: 1.2,
    );

    final double frictionTarget = position.pixels + velocity * 0.15;
    final double snapTarget = _snapOffset(frictionTarget).clamp(
      position.minScrollExtent,
      position.maxScrollExtent,
    );

    return SpringSimulation(spring, position.pixels, snapTarget, velocity);
  }

  @override
  double get minFlingVelocity => 50.0;
}
