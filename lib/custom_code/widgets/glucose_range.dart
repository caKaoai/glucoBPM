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

import 'package:provider/provider.dart';

import 'package:flutter/services.dart';

class GlucoseRange extends StatefulWidget {
  const GlucoseRange({
    super.key,
    this.width,
    this.height,
    this.selectedValue,
  });

  final double? width;
  final double? height;
  final Future Function(int? returnVal)? selectedValue;

  @override
  State<GlucoseRange> createState() => _GlucoseRangeState();
}

class _GlucoseRangeState extends State<GlucoseRange> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _rulerKey = GlobalKey(); // ✅ to measure ruler width

  final int minValue = FFAppState().config.glucoseRange.first.min;
  final int maxValue = FFAppState().config.glucoseRange.first.max;
  final double tickSpacing = 10;

  int selectedValue = 130;
  double _rulerWidth = 0; // ✅ actual measured width

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_onScroll);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // ✅ measure actual ruler width after layout
      final RenderBox? box =
          _rulerKey.currentContext?.findRenderObject() as RenderBox?;
      if (box != null) {
        _rulerWidth = box.size.width;
      }

      jumpToValue(selectedValue);
      widget.selectedValue?.call(selectedValue);
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    double offset = _scrollController.offset;
    if (offset.isNaN || offset.isInfinite) return;

    // ✅ subtract half tick to align pointer to center of tick item
    double rawIndex = (offset + tickSpacing / 2) / tickSpacing;
    if (rawIndex.isNaN || rawIndex.isInfinite) return;

    int index = rawIndex.floor(); // ✅ floor not round
    int value = (minValue + index).clamp(minValue, maxValue);

    if (value != selectedValue) {
      setState(() {
        selectedValue = value;
      });
      HapticFeedback.selectionClick();
      widget.selectedValue?.call(value);
    }
  }

  void _snap() {
    if (!_scrollController.hasClients) return;

    double offset = _scrollController.offset;
    if (offset.isNaN || offset.isInfinite) return;

    // ✅ same correction in snap
    double rawIndex = (offset + tickSpacing / 2) / tickSpacing;
    if (rawIndex.isNaN || rawIndex.isInfinite) return;

    int index = rawIndex.floor();
    double targetOffset = index * tickSpacing;

    _scrollController.animateTo(
      max(0, targetOffset),
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
    );
  }

  void jumpToValue(int value) {
    if (!_scrollController.hasClients) return;

    // ✅ no change needed here, offset 0 = value 70 is correct
    double offset = (value - minValue) * tickSpacing;
    _scrollController.jumpTo(max(0, offset));
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    double width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        /// RULER
        Container(
          key: _rulerKey, // ✅ attach key to measure real width
          width: width,
          height: 120,
          decoration: BoxDecoration(
            color: const Color(0xffF2F4F7),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              NotificationListener<ScrollEndNotification>(
                onNotification: (n) {
                  _snap();
                  return true;
                },
                child: ListView.builder(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  // ✅ use measured ruler width for exact centering
                  padding: EdgeInsets.symmetric(
                    horizontal: _rulerWidth > 0 ? _rulerWidth / 2 : width / 2,
                  ),
                  itemCount: maxValue - minValue + 1,
                  itemBuilder: (context, i) {
                    int value = minValue + i;
                    bool showLabel = value % 20 == 10;

                    return SizedBox(
                      width: tickSpacing,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        clipBehavior: Clip.none,
                        children: [
                          /// tick mark
                          Container(
                            width: 1.5,
                            height: value % 10 == 0 ? 18 : 8,
                            color: const Color(0xffB8C2CC),
                          ),

                          /// labels
                          if (showLabel)
                            Positioned(
                              bottom: 20,
                              left: -20,
                              right: -20,
                              child: Center(
                                child: Text(
                                  value.toString(),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff7C8B9A),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              /// CENTER POINTER
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.all(4.0),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Container(
                    width: 4,
                    height: 80,
                    color: Colors.red,
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 30),

        /// RANGE BAR
        Container(
          height: 10,
          margin: const EdgeInsets.symmetric(horizontal: 9),
          child: Row(
            children: [
              Expanded(
                flex: 95,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 32,
                child: Container(color: Colors.amber),
              ),
              Expanded(
                flex: 63,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 10),

        /// LEGEND
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
            FFAppState().config.glucoseRange.length - 1,
            (i) {
              int index = i + 1;
              final range = FFAppState().config.glucoseRange[index];

              final colors = [Colors.green, Colors.amber, Colors.red];
              final labels = ["NORMAL", "WARNING", "CRITICAL"];

              return Legend(
                color: colors[i],
                text: i == 2
                    ? "${labels[i]} (> ${range.max})"
                    : "${labels[i]} (${range.min}-${range.max})",
              );
            },
          ),
        ),
      ],
    );
  }
}

class Legend extends StatelessWidget {
  const Legend({
    super.key,
    required this.color,
    required this.text,
  });

  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(
          text,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: Color(0xff6B778C),
          ),
        )
      ],
    );
  }
}
