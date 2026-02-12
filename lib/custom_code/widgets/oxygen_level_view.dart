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

class OxygenLevelView extends StatefulWidget {
  const OxygenLevelView({
    super.key,
    this.width,
    this.height,
    this.lastInfoOxygen,
  });

  final double? width;
  final double? height;
  final int? lastInfoOxygen;

  @override
  State<OxygenLevelView> createState() => _OxygenLevelViewState();
}

class _OxygenLevelViewState extends State<OxygenLevelView> {
  static const double rowHeight = 40;
  static const double rowGap = 6;

  int get activeIndex {
    final oxygen = widget.lastInfoOxygen;
    if (oxygen == null) return 0;

    if (oxygen >= 95 && oxygen <= 100) {
      return 0; // Normal Level
    } else if (oxygen >= 91 && oxygen <= 94) {
      return 1; // Mild Hypoxemia
    } else if (oxygen >= 80 && oxygen <= 90) {
      return 2; // Moderate Hypoxemia
    } else {
      return 3; // Severe Hypoxemia (< 80)
    }
  }

  Color get pointerColor {
    switch (activeIndex) {
      case 0:
        return Color(0xFF2EA610); // Normal Level - Green
      case 1:
        return Color(0xFFFCC640); // Mild Hypoxemia - Yellow
      case 2:
        return Color(0xFFFFA63D); // Moderate Hypoxemia - Orange/Red
      case 3:
        return Color(0xFFD32F2F); // Severe Hypoxemia - Dark Red
      default:
        return Color(0xFF2EA610);
    }
  }

  double get _pointerTop =>
      (activeIndex * (rowHeight + rowGap)) +
      (rowHeight / 2) -
      10; // center arrow

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title text

        const SizedBox(height: 10),

        _row(
          leftText: '95-100%',
          rightText: 'Normal Level',
          leftColor: Color(0xFF2EA610),
          rightColor: Color(0xFFCBE6BD),
          active: activeIndex == 0,
          isFirst: true,
        ),
        _row(
          leftText: '91-94%',
          rightText: 'Mild Hypoxemia',
          leftColor: Color(0xFFFCC640),
          rightColor: Color(0xFFFFEFBB),
          active: activeIndex == 1,
        ),
        _row(
          leftText: '80-90%',
          rightText: 'Moderate Hypoxemia',
          leftColor: Color(0xFFFFA63D),
          rightColor: Color(0xFFF8D9B7),
          active: activeIndex == 2,
        ),
        _row(
          leftText: '< 80%',
          rightText: 'Severe Hypoxemia',
          leftColor: Color(0xFFD32F2F),
          rightColor: Color(0xFFFFCDD2),
          active: activeIndex == 3,
          isLast: true,
        ),
      ],
    );
  }

  Widget _row({
    required String leftText,
    required String rightText,
    required Color leftColor,
    required Color rightColor,
    bool active = false,
    bool isFirst = false,
    bool isLast = false,
  }) {
    return Stack(
      clipBehavior: Clip.none, // Allow pointer to overflow
      alignment: Alignment.centerLeft,
      children: [
        // RIGHT BLOCK
        Container(
          height: 40,
          margin: const EdgeInsets.only(left: 90, right: 5),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: rightColor,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(4),
              bottomRight: const Radius.circular(4),
            ),
          ),
          child: Text(
            rightText,
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                  fontSize: 13.0,
                  letterSpacing: 0.0,
                  color: Color(0xFF59617A),
                  fontWeight: FontWeight.w600,
                  useGoogleFonts:
                      !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                ),
          ),
        ),

        // LEFT BLOCK
        Container(
          width: 90,
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: leftColor,
            borderRadius: BorderRadius.only(
              topLeft: isFirst ? const Radius.circular(4) : Radius.zero,
              topRight: isFirst ? const Radius.circular(4) : Radius.zero,
              bottomLeft: isLast ? const Radius.circular(4) : Radius.zero,
              bottomRight: isLast ? const Radius.circular(4) : Radius.zero,
            ),
          ),
          child: Text(
            leftText,
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                  fontSize: 15.0,
                  letterSpacing: 0.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  useGoogleFonts:
                      !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                ),
          ),
        ),

        // POINTER (ARROW) - Now properly inside Stack
        if (active)
          Positioned(
            right: 0,
            top: (50 / 2) - 10, // Center in the 50px tall left container
            child: CustomPaint(
              size: const Size(16, 20),
              painter: TrianglePointerPainter(
                fillColor: pointerColor,
              ),
            ),
          ),
      ],
    );
  }
}

/// EXACT TRIANGLE ARROW
class TrianglePointerPainter extends CustomPainter {
  final Color fillColor;
  final Color borderColor;

  TrianglePointerPainter({
    required this.fillColor,
    this.borderColor = Colors.white,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final fillPaint = Paint()
      ..color = fillColor
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    // 🔺 LEFT-POINTING TRIANGLE
    final path = Path()
      ..moveTo(size.width, 0) // top-right
      ..lineTo(0, size.height / 2) // tip (left)
      ..lineTo(size.width, size.height) // bottom-right
      ..close();

    canvas.drawPath(path, fillPaint);
    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
