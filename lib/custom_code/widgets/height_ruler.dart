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
  late int minValue, maxValue, selectedValue;
  late String unit;
  late ScrollController _scrollController;
  bool _isSnapping = false;

  static const double tickSpacing = 24.0;
  static const double rulerHeight = 70;
  static const double majorTickHeight = 30;
  static const double minorTickHeight = 14;

  void initState() {
    super.initState();

    if (widget.type == 1) {
      // cm mode
      minValue = 120;
      maxValue = 220;
      unit = 'cm';

      // ✅ default
      selectedValue = minValue + 20;

      if (widget.initVal != null) {
        selectedValue = widget.initVal!.clamp(minValue, maxValue);
      }
    } else {
      // ft/in mode (stored as total inches)
      minValue = 48; // 4 ft
      maxValue = 86; // 7 ft 2 in
      unit = 'ft';

      // ✅ default value
      selectedValue = minValue;

      if (widget.initVal != null) {
        final totalInches = (widget.initVal! / 2.54).round();
        selectedValue = totalInches.clamp(minValue, maxValue);
      }
    }

    _scrollController = ScrollController(
      initialScrollOffset: (selectedValue - minValue) * tickSpacing,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.returnHeight != null) {
        widget.returnHeight!(getReturnValue(selectedValue));
      }
    });
  }

  dynamic getReturnValue(int value, {bool asCm = true}) {
    if (widget.type == 0) {
      // value = totalInches (ft/in mode)
      double cm = value * 2.54;
      if (asCm) return cm.round(); // Return integer cm
      int feet = value ~/ 12;
      int inches = value % 12;
      return {"feet": feet, "inches": inches, "cm": cm.round()};
    } else {
      // value = cm (cm mode)
      if (asCm) return value;
      // Convert cm to feet/inches, rounding inches properly
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
    int newValue = (minValue + (_scrollController.offset / tickSpacing).round())
        .clamp(minValue, maxValue);
    if (newValue != selectedValue) {
      setState(() => selectedValue = newValue);
      if (widget.returnHeight != null)
        widget.returnHeight!(getReturnValue(newValue));
    }
  }

  void _onEndDrag() {
    if (_isSnapping) return;
    _isSnapping = true;
    final double offset = _scrollController.offset;
    final int snapValue = (offset / tickSpacing).round();
    final double snapOffset = snapValue * tickSpacing;
    _scrollController
        .animateTo(
      snapOffset,
      duration: const Duration(milliseconds: 80),
      curve: Curves.easeOut,
    )
        .whenComplete(() {
      _isSnapping = false;
    });
  }

  String _formatFeetInches(int totalInches) {
    final feet = totalInches ~/ 12;
    final inches = totalInches % 12;
    return "$feet' $inches\"";
  }

  @override
  Widget build(BuildContext context) {
    final int divisions = maxValue - minValue;
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isCm = widget.type == 1;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Selected Value Display
        isCm
            ? RichText(
                text: TextSpan(
                  text: '$selectedValue',
                  style: FlutterFlowTheme.of(context).titleSmall.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).titleSmallFamily,
                        color: Colors.black,
                        fontSize: 24,
                        letterSpacing: 0.0,
                        useGoogleFonts:
                            !FlutterFlowTheme.of(context).titleSmallIsCustom,
                      ),
                  children: [
                    TextSpan(
                      text: ' $unit',
                      style: FlutterFlowTheme.of(context).titleSmall.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).titleSmallFamily,
                            color: Colors.black,
                            letterSpacing: 0.0,
                            useGoogleFonts: !FlutterFlowTheme.of(context)
                                .titleSmallIsCustom,
                          ),
                    ),
                  ],
                ),
              )
            : Text(
                _formatFeetInches(selectedValue),
                style: FlutterFlowTheme.of(context).titleSmall.override(
                      fontFamily: FlutterFlowTheme.of(context).titleSmallFamily,
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      useGoogleFonts:
                          !FlutterFlowTheme.of(context).titleSmallIsCustom,
                    ),
              ),
        // Ruler
        SizedBox(
          height: rulerHeight,
          width: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children: [
              NotificationListener<ScrollNotification>(
                onNotification: (notification) {
                  if (notification is ScrollUpdateNotification) {
                    _onScroll();
                  } else if (notification is ScrollEndNotification) {
                    _onEndDrag();
                  }
                  return false;
                },
                child: ListView.builder(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: divisions + 1,
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth / 2.14 - tickSpacing,
                  ),
                  itemBuilder: (context, index) {
                    final value = minValue + index;
                    // --- Major tick: every 5 cm, or every inch (with foot label) ---
                    final bool isMajor =
                        isCm ? value % 5 == 0 : value % 12 == 0;
                    final bool isSelected = value == selectedValue;
                    return Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          width: tickSpacing,
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 22.0),
                            child: Container(
                              width: isMajor ? 2 : 2,
                              height:
                                  isMajor ? majorTickHeight : minorTickHeight,
                              color: isSelected
                                  ? Colors.grey.shade400
                                  : Colors.grey.shade400,
                            ),
                          ),
                        ),
                        if (isMajor)
                          Text(
                            isCm ? '$value' : '${value ~/ 12}\'',
                            // show foot label for ft/in mode
                            style: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .titleSmallFamily,
                                  color: isSelected
                                      ? FlutterFlowTheme.of(context).primary
                                      : Colors.grey.shade400,
                                  fontSize: 12,
                                  fontWeight: isSelected
                                      ? FontWeight.w600
                                      : FontWeight.normal,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .titleSmallIsCustom,
                                ),
                          ),
                      ],
                    );
                  },
                ),
              ),
              // Center Red Bar Overlay
              Positioned(
                top: 12,
                bottom: 20,
                child: Container(
                  width: 3.5,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primary,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
