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

import 'dart:math' as math;
import 'dart:ui' as ui;

class BMICal extends StatefulWidget {
  const BMICal({
    super.key,
    this.width,
    this.height,
    this.userWeight, // grams
    this.userHeight, // cm in STRING
  });

  final double? width;
  final double? height;
  final int? userWeight; // weight in GRAMS
  final int? userHeight; // height in CM (String)

  @override
  State<BMICal> createState() => _BMICalState();
}

class _BMICalState extends State<BMICal> {
  static const double _width = 260.0;
  static const double _height = 120.0;

  // ---------------------------
  // ⭐ FIXED BMI CALCULATION
  // ---------------------------
  double _calculateBMI() {
    try {
      if (widget.userWeight == null || widget.userHeight == null) {
        return 0.0;
      }

      // grams → kg
      final double weightKg = widget.userWeight! / 1000.0;

      // cm → meters
      final double heightM = widget.userHeight! / 100.0;

      if (weightKg <= 0 || heightM <= 0) return 0.0;

      final bmi = weightKg / (heightM * heightM);

      // ✅ Update app state ONCE per value
      WidgetsBinding.instance.addPostFrameCallback((_) {
        FFAppState().update(() {
          FFAppState().updateUserDataStruct(
            (e) => e..bmi = bmi,
          );
        });
      });

      return bmi;
    } catch (e) {
      print("BMI ERROR: $e");
      return 0.0;
    }
  }

  Color _segmentColorForBMI(double bmi) {
    if (bmi < 16) return const Color(0xFFD9D9D9);
    if (bmi < 18.5) return const Color(0xFF5276A8);
    if (bmi < 25) return const Color(0xFF03DA20);
    if (bmi < 30) return const Color(0xFFD4E987);
    if (bmi < 35) return const Color(0xFFF9B24F);
    return const Color(0xFFF14756);
  }

  @override
  Widget build(BuildContext context) {
    final double bmi = _calculateBMI().clamp(15.0, 40.0);

    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Center(
        child: SizedBox(
          width: _width,
          height: _height,
          child: CustomPaint(
            painter: BMISemicirclePainter(
              bmi: bmi,
              bmiColor: _segmentColorForBMI(bmi),
            ),
          ),
        ),
      ),
    );
  }
}

class BMISemicirclePainter extends CustomPainter {
  final double bmi;
  final Color bmiColor;

  BMISemicirclePainter({required this.bmi, required this.bmiColor});

  static const double minBMI = 15;
  static const double maxBMI = 40;

  final List<Map<String, dynamic>> segments = const [
    {'start': 15.0, 'end': 16.0, 'color': Color(0xFFD9D9D9)},
    {'start': 16.0, 'end': 18.5, 'color': Color(0xFF5276A8)},
    {'start': 18.5, 'end': 25.0, 'color': Color(0xFF03DA20)},
    {'start': 25.0, 'end': 30.0, 'color': Color(0xFFD4E987)},
    {'start': 30.0, 'end': 35.0, 'color': Color(0xFFF9B24F)},
    {'start': 35.0, 'end': 40.0, 'color': Color(0xFFF14756)},
  ];

  final List<Map<String, dynamic>> labels = const [
    {'value': 15.0, 'text': '15', 'color': Color(0xFFD9D9D9)},
    {'value': 16.0, 'text': '16', 'color': Color(0xFFD9D9D9)},
    {'value': 18.5, 'text': '18.5', 'color': Color(0xFF5276A8)},
    {'value': 25.0, 'text': '25', 'color': Color(0xFF03DA20)},
    {'value': 30.0, 'text': '30', 'color': Color(0xFFD4E987)},
    {'value': 35.0, 'text': '35', 'color': Color(0xFFF9B24F)},
    {'value': 40.0, 'text': '40', 'color': Color(0xFFF14756)},
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height * 1.12;
    final radius = size.width * 0.47;

    // --------------------------
    // 1. Colored Semicircle Background
    // --------------------------
    final fillRadius = radius - 25;
    final fillRect =
        Rect.fromCircle(center: Offset(cx, cy), radius: fillRadius);
    final fillPaint = Paint()
      ..color = bmiColor.withOpacity(0.90)
      ..style = PaintingStyle.fill;

    canvas.drawArc(fillRect, math.pi, math.pi, true, fillPaint);

    // --------------------------
    // 2. Outer Colored Segments
    // --------------------------
    final arcRect = Rect.fromCircle(center: Offset(cx, cy), radius: radius);

    const startAngle = math.pi;
    const sweepAngle = math.pi;

    for (final seg in segments) {
      final startPct = (seg['start'] - minBMI) / (maxBMI - minBMI);
      final endPct = (seg['end'] - minBMI) / (maxBMI - minBMI);

      final paint = Paint()
        ..color = seg['color']
        ..style = PaintingStyle.stroke
        ..strokeWidth = 13
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(
        arcRect,
        startAngle + startPct * sweepAngle,
        (endPct - startPct) * sweepAngle,
        false,
        paint,
      );
    }

    // --------------------------
    // 3. Center BMI Text
    // --------------------------
    final text = bmi.toStringAsFixed(1);

    final tp = TextPainter(
      text: TextSpan(
        text: text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 33,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: ui.TextDirection.ltr,
    )..layout();

    tp.paint(
      canvas,
      Offset(cx - tp.width / 2, cy - fillRadius * 0.4 - tp.height / 2),
    );

    // --------------------------
    // 4. Labels Above Arc
    // --------------------------
    for (final label in labels) {
      final value = label['value'];
      final pct = (value - minBMI) / (maxBMI - minBMI);
      final angle = startAngle + pct * math.pi;

      final lx = cx + (radius + 16) * math.cos(angle);
      final ly = cy + (radius + 16) * math.sin(angle);

      final painter = TextPainter(
        text: TextSpan(
          text: label['text'],
          style: TextStyle(
            color: label['color'],
            fontWeight: FontWeight.w600,
            fontSize: (value == 25 || value == 30) ? 13 : 10,
          ),
        ),
        textDirection: ui.TextDirection.ltr,
      )..layout();

      painter.paint(
        canvas,
        Offset(lx - painter.width / 2, ly - painter.height / 2),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
