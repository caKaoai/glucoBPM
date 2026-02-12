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

class CustomSrollingList extends StatefulWidget {
  const CustomSrollingList({
    super.key,
    this.width,
    this.height,
    this.minval,
    this.maxval,
    this.selectedval,
    this.initVal,
  });

  final double? width;
  final double? height;
  final int? minval;
  final int? maxval;
  final Future Function(int? retunVal)? selectedval;
  final int? initVal;

  @override
  State<CustomSrollingList> createState() => _CustomSrollingListState();
}

class _CustomSrollingListState extends State<CustomSrollingList> {
  late final ScrollController _controller;
  late int selectedValue;

  static const double itemWidth = 69;

  int get min => widget.minval ?? 0;

  int get max => widget.maxval ?? 100;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initVal ?? min;
    _controller = ScrollController();

    // Scroll to initial value after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_controller.hasClients && widget.initVal != null) {
        final double screenWidth = MediaQuery.of(context).size.width;
        final int index = widget.initVal! - min;
        final double targetOffset = _offsetForIndex(index, screenWidth);

        _controller.jumpTo(targetOffset);
        setState(() => selectedValue = widget.initVal!);
        widget.selectedval?.call(widget.initVal!);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  int _indexFromOffset(double offset, double screenWidth) {
    final double padding = screenWidth / 10.5 - itemWidth / 2;
    final double center = offset + padding;
    return (center / itemWidth).round().clamp(0, max - min);
  }

  double _offsetForIndex(int index, double screenWidth) {
    final double padding = screenWidth / 10.5 - itemWidth / 2;
    return index * itemWidth - padding;
  }

  void _snap(double screenWidth) {
    if (!_controller.hasClients) return;

    final int index = _indexFromOffset(_controller.offset, screenWidth);

    final double target = _offsetForIndex(index, screenWidth);

    // ⚠️ Important: schedule AFTER physics settles
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

    final int value = min + index;

    if (value != selectedValue) {
      setState(() => selectedValue = value);
      widget.selectedval?.call(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double screenWidth = constraints.maxWidth;

        if (screenWidth <= 0) {
          return const SizedBox();
        }

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
                  itemCount: max - min + 1,
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth / 2 - itemWidth / 2,
                  ),
                  itemBuilder: (context, index) {
                    final int value = min + index;
                    final bool isSelected = value == selectedValue;

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
                                fontSize: 30,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w500,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .bodyMediumIsCustom,
                              ),
                          child: Text(value.toString()),
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
