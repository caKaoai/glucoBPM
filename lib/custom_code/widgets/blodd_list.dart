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

class BloddList extends StatefulWidget {
  const BloddList({
    super.key,
    this.width,
    this.height,
    this.mivVal,
    this.maxVal,
    this.initval,
    this.onSelected,
  });

  final double? width;
  final double? height;
  final double? mivVal;
  final double? maxVal;
  final double? initval;
  final Future Function(double? reurtunVal)? onSelected;

  @override
  State<BloddList> createState() => _BloddListState();
}

class _BloddListState extends State<BloddList> {
  late final ScrollController _controller;
  late double selectedValue;

  static const double itemWidth = 69;
  static const double step = 0.1;

  double get min => widget.mivVal ?? 0.5;

  double get max => widget.maxVal ?? 21.1;

  int get totalItems => ((max - min) / step).round() + 1;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initval ?? min;
    _controller = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_controller.hasClients) return;

      final double screenWidth = MediaQuery.of(context).size.width;
      final int index =
          ((selectedValue - min) / step).round().clamp(0, totalItems - 1);

      final double targetOffset = _offsetForIndex(index, screenWidth);
      _controller.jumpTo(targetOffset);

      widget.onSelected?.call(selectedValue);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // ---------- SCROLL MATH ----------

  int _indexFromOffset(double offset, double screenWidth) {
    final double padding = screenWidth / 10.5 - itemWidth / 2;
    final double center = offset + padding;

    return (center / itemWidth).round().clamp(0, totalItems - 1);
  }

  double _offsetForIndex(int index, double screenWidth) {
    final double padding = screenWidth / 10.5 - itemWidth / 2;
    return index * itemWidth - padding;
  }

  void _snap(double screenWidth) {
    if (!_controller.hasClients) return;

    final int index = _indexFromOffset(_controller.offset, screenWidth);
    final double target = _offsetForIndex(index, screenWidth);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_controller.hasClients) return;

      _controller.animateTo(
        target,
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
      );
    });
  }

  void _updateValue(double screenWidth) {
    if (!_controller.hasClients) return;

    final int index = _indexFromOffset(_controller.offset, screenWidth);
    final double value = min + index * step;

    if ((value - selectedValue).abs() > 0.0001) {
      setState(() => selectedValue = value);
      widget.onSelected?.call(value);
    }
  }

  // ---------- UI ----------

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double screenWidth = constraints.maxWidth;

        if (screenWidth <= 0) return const SizedBox();

        return SizedBox(
          height: 60,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // LEFT indicator
              Positioned(
                left: screenWidth / 2 - itemWidth / 2,
                child: _indicator(),
              ),

              // RIGHT indicator
              Positioned(
                right: screenWidth / 2 - itemWidth / 2,
                child: _indicator(),
              ),

              NotificationListener<ScrollNotification>(
                onNotification: (notification) {
                  if (notification is ScrollUpdateNotification) {
                    _updateValue(screenWidth);
                  }

                  if (notification is ScrollEndNotification) {
                    _snap(screenWidth);
                  }
                  return false;
                },
                child: ListView.builder(
                  controller: _controller,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: totalItems,
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth / 2 - itemWidth / 2,
                  ),
                  itemBuilder: (context, index) {
                    final double value = min + index * step;
                    final bool isSelected =
                        (value - selectedValue).abs() < 0.0001;

                    return SizedBox(
                      width: itemWidth,
                      child: Center(
                        child: AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 120),
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .bodyMediumFamily,
                                color: isSelected
                                    ? Colors.red
                                    : Colors.grey.shade400,
                                fontSize: isSelected ? 28 : 24,
                                fontWeight: FontWeight.w500,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .bodyMediumIsCustom,
                              ),
                          child: Text(
                            value.toStringAsFixed(1),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _indicator() {
    return Container(
      width: 2,
      height: 36,
      color: Colors.red.withOpacity(0.6),
    );
  }
}
