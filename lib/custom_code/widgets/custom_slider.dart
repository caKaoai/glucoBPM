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

class CustomSlider extends StatefulWidget {
  const CustomSlider({
    super.key,
    this.width,
    this.height,
    this.returnVal,
    this.initVal,
  });

  final double? width;
  final double? height;
  final Future Function(double? selectVal)? returnVal;
  final double? initVal;

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  double value = 1.0;
  final List<double> steps = [0.5, 1.0, 1.5, 2.0];

  @override
  void initState() {
    super.initState();

    if (widget.initVal != null) {
      value = widget.initVal!;
    }

    // return initial value after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.returnVal != null) {
        widget.returnVal!(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 6,
            activeTrackColor: const Color(0xFFD3D6DB),
            inactiveTrackColor: const Color(0xFFD3D6DB),
            thumbColor: Colors.red,
            thumbShape: const RoundSliderThumbShape(
              enabledThumbRadius: 12,
            ),
            overlayShape: const RoundSliderOverlayShape(
              overlayRadius: 0,
            ),
            trackShape: const RoundedRectSliderTrackShape(),
          ),
          child: Slider(
            value: value,
            min: 0.5,
            max: 2.0,
            divisions: 3,
            onChanged: (v) {
              setState(() {
                value = v;
              });
              if (widget.returnVal != null) {
                widget.returnVal!(value);
              }
            },
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: steps.map((e) {
              return Text(
                "${e.toStringAsFixed(1)}x",
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF9AA1AB),
                  fontWeight: FontWeight.w600,
                ),
              );
            }).toList(),
          ),
        )
      ],
    );
  }
}
