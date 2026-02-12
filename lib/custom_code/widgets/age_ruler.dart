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
  late int minValue, maxValue, selectedValue;

  late ScrollController _scrollController;
  bool _isSnapping = false;
  static const double tickSpacing = 24.0;
  static const double rulerHeight = 70;
  static const double majorTickHeight = 30;
  static const double minorTickHeight = 14;

  @override
  void initState() {
    super.initState();

    minValue = 10;
    maxValue = 120;

    selectedValue = widget.initVal?.clamp(minValue, maxValue) ?? minValue;
    _scrollController = ScrollController(
      initialScrollOffset: (selectedValue - minValue) * tickSpacing,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.age?.call(selectedValue);
    });
  }

  void _onScroll() {
    int newValue = (minValue + (_scrollController.offset / tickSpacing).round())
        .clamp(minValue, maxValue);
    if (newValue != selectedValue) {
      setState(() => selectedValue = newValue);
      widget.age?.call(selectedValue);
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

  @override
  Widget build(BuildContext context) {
    final int divisions = maxValue - minValue;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Selected Value Display
        RichText(
          text: TextSpan(
            text: '$selectedValue',
            style: FlutterFlowTheme.of(context).titleSmall.override(
                  fontFamily: FlutterFlowTheme.of(context).titleSmallFamily,
                  color: Colors.black,
                  letterSpacing: 0.0,
                  fontSize: 24,
                  useGoogleFonts:
                      !FlutterFlowTheme.of(context).titleSmallIsCustom,
                ),
            children: [
              TextSpan(
                text: 'year',
                style: FlutterFlowTheme.of(context).titleSmall.override(
                      fontFamily: FlutterFlowTheme.of(context).titleSmallFamily,
                      color: Colors.black,
                      letterSpacing: 0.0,
                      useGoogleFonts:
                          !FlutterFlowTheme.of(context).titleSmallIsCustom,
                    ),
              ),
            ],
          ),
        ),

        // Ruler
        SizedBox(
          height: rulerHeight,
          width: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // The horizontal ruler
              NotificationListener<ScrollNotification>(
                onNotification: (notification) {
                  if (notification is ScrollUpdateNotification) {
                    _onScroll();
                  } else if (notification is ScrollEndNotification) {
                    _onEndDrag();
                  }
                  return false; // IMPORTANT: don’t swallow notifications
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
                    final isMajor = value % 5 == 0;
                    final isSelected = value == selectedValue;
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
                                    : Colors.grey.shade400),
                          ),
                        ),
                        if (isMajor)
                          Text(
                            '$value',
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
