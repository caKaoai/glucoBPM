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

import 'dart:ui' as ui;

class BloodPressureChart extends StatefulWidget {
  const BloodPressureChart({
    super.key,
    this.width,
    this.height,
  });

  final double? width;
  final double? height;

  @override
  State<BloodPressureChart> createState() => _BloodPressureChartState();
}

class _BloodPressureChartState extends State<BloodPressureChart> {
  // Sample data points (you can customize these)
  final List<BloodPressurePoint> dataPoints = [
    BloodPressurePoint(diastolic: 65, systolic: 95),
    BloodPressurePoint(diastolic: 85, systolic: 125),
    BloodPressurePoint(diastolic: 95, systolic: 165),
  ];

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.5,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: CustomPaint(
          painter: BloodPressureChartPainter(dataPoints: dataPoints),
          child: Container(),
        ),
      ),
    );
  }
}

class BloodPressurePoint {
  final double diastolic;
  final double systolic;

  BloodPressurePoint({required this.diastolic, required this.systolic});
}

class BloodPressureChartPainter extends CustomPainter {
  final List<BloodPressurePoint> dataPoints;

  BloodPressureChartPainter({required this.dataPoints});

  @override
  void paint(Canvas canvas, Size size) {
    // Chart margins
    const double leftMargin = 60;
    const double bottomMargin = 40;
    const double topMargin = 20;
    const double rightMargin = 20;
    final double chartWidth = size.width - leftMargin - rightMargin;
    final double chartHeight = size.height - topMargin - bottomMargin;
    // Axis ranges
    const double minDiastolic = 50;
    const double maxDiastolic = 120;
    const double minSystolic = 80;
    const double maxSystolic = 200;
    // Helper function to convert data coordinates to screen coordinates
    double diastolicToX(double diastolic) {
      return leftMargin +
          ((diastolic - minDiastolic) / (maxDiastolic - minDiastolic)) *
              chartWidth;
    }

    double systolicToY(double systolic) {
      return topMargin +
          chartHeight -
          ((systolic - minSystolic) / (maxSystolic - minSystolic)) *
              chartHeight;
    }

    // Define color zones
    final List<ColorZone> zones = [
      // Hypotension (purple area)
      ColorZone(
        color: const Color(0xFFB39DDB),
        points: [
          Offset(diastolicToX(50), systolicToY(80)),
          Offset(diastolicToX(60), systolicToY(80)),
          Offset(diastolicToX(60), systolicToY(90)),
          Offset(diastolicToX(50), systolicToY(90)),
        ],
        label: 'Hypotension',
      ),
      // Normal (blue area)
      ColorZone(
        color: const Color(0xFF2196F3),
        points: [
          Offset(diastolicToX(60), systolicToY(90)),
          Offset(diastolicToX(80), systolicToY(90)),
          Offset(diastolicToX(80), systolicToY(120)),
          Offset(diastolicToX(60), systolicToY(120)),
        ],
        label: 'Normal',
      ),
      // Grade 1 (yellow area)
      ColorZone(
        color: const Color(0xFFFDD835),
        points: [
          Offset(diastolicToX(80), systolicToY(120)),
          Offset(diastolicToX(90), systolicToY(120)),
          Offset(diastolicToX(90), systolicToY(140)),
          Offset(diastolicToX(80), systolicToY(140)),
        ],
        label: 'Grade 1',
      ),
      // Grade 2 (orange area)
      ColorZone(
        color: const Color(0xFFFF9800),
        points: [
          Offset(diastolicToX(90), systolicToY(140)),
          Offset(diastolicToX(100), systolicToY(140)),
          Offset(diastolicToX(100), systolicToY(160)),
          Offset(diastolicToX(90), systolicToY(160)),
        ],
        label: 'Grade 2',
      ),
      // Grade 3 (deep orange area)
      ColorZone(
        color: const Color(0xFFFF5722),
        points: [
          Offset(diastolicToX(100), systolicToY(160)),
          Offset(diastolicToX(110), systolicToY(160)),
          Offset(diastolicToX(110), systolicToY(180)),
          Offset(diastolicToX(100), systolicToY(180)),
        ],
        label: 'Grade 3',
      ),
      // Grade 4 Hypertension (red area)
      ColorZone(
        color: const Color(0xFFD32F2F),
        points: [
          Offset(diastolicToX(110), systolicToY(180)),
          Offset(diastolicToX(120), systolicToY(180)),
          Offset(diastolicToX(120), systolicToY(200)),
          Offset(diastolicToX(110), systolicToY(200)),
        ],
        label: 'Grade 4 Hypertension',
      ),
      // Extended zones to fill the chart
      // Normal extended right
      ColorZone(
        color: const Color(0xFF2196F3).withOpacity(0.8),
        points: [
          Offset(diastolicToX(80), systolicToY(90)),
          Offset(diastolicToX(90), systolicToY(90)),
          Offset(diastolicToX(90), systolicToY(120)),
          Offset(diastolicToX(80), systolicToY(120)),
        ],
        label: '',
      ),
      // Yellow extended
      ColorZone(
        color: const Color(0xFFFDD835),
        points: [
          Offset(diastolicToX(90), systolicToY(120)),
          Offset(diastolicToX(100), systolicToY(120)),
          Offset(diastolicToX(100), systolicToY(140)),
          Offset(diastolicToX(90), systolicToY(140)),
        ],
        label: '',
      ),
      // Orange extended
      ColorZone(
        color: const Color(0xFFFF9800),
        points: [
          Offset(diastolicToX(100), systolicToY(140)),
          Offset(diastolicToX(110), systolicToY(140)),
          Offset(diastolicToX(110), systolicToY(160)),
          Offset(diastolicToX(100), systolicToY(160)),
        ],
        label: '',
      ),
      // Red extended
      ColorZone(
        color: const Color(0xFFD32F2F),
        points: [
          Offset(diastolicToX(110), systolicToY(160)),
          Offset(diastolicToX(120), systolicToY(160)),
          Offset(diastolicToX(120), systolicToY(200)),
          Offset(diastolicToX(110), systolicToY(200)),
        ],
        label: '',
      ),
    ];
    // Draw gradient zones
    _drawGradientZones(
        canvas, size, leftMargin, topMargin, chartWidth, chartHeight);
    // Draw grid lines
    _drawGridLines(canvas, size, leftMargin, topMargin, bottomMargin,
        chartWidth, chartHeight, diastolicToX, systolicToY);
    // Draw axes
    _drawAxes(canvas, size, leftMargin, topMargin, bottomMargin, chartWidth,
        chartHeight);
    // Draw axis labels
    _drawAxisLabels(canvas, size, leftMargin, topMargin, bottomMargin,
        diastolicToX, systolicToY);
    // Draw zone labels
    _drawZoneLabels(canvas, diastolicToX, systolicToY);
    // Draw data points
    _drawDataPoints(canvas, dataPoints, diastolicToX, systolicToY);
  }

  void _drawGradientZones(Canvas canvas, Size size, double leftMargin,
      double topMargin, double chartWidth, double chartHeight) {
    // Define gradient zones from bottom to top, left to right
    final zones = [
      // Hypotension zone (purple)
      _ZoneGradient(
        rect: Rect.fromLTWH(leftMargin, size.height - 40 - chartHeight * 0.125,
            chartWidth * 0.143, chartHeight * 0.125),
        color: const Color(0xFFB39DDB),
      ),
      // Normal zone (blue)
      _ZoneGradient(
        rect: Rect.fromLTWH(
            leftMargin + chartWidth * 0.143,
            size.height - 40 - chartHeight * 0.333,
            chartWidth * 0.286,
            chartHeight * 0.333),
        color: const Color(0xFF2196F3),
      ),
      // Prehypertension/Grade 1 (yellow)
      _ZoneGradient(
        rect: Rect.fromLTWH(
            leftMargin + chartWidth * 0.429,
            size.height - 40 - chartHeight * 0.5,
            chartWidth * 0.143,
            chartHeight * 0.167),
        color: const Color(0xFFFDD835),
      ),
      // Grade 2 (orange)
      _ZoneGradient(
        rect: Rect.fromLTWH(
            leftMargin + chartWidth * 0.572,
            size.height - 40 - chartHeight * 0.667,
            chartWidth * 0.143,
            chartHeight * 0.167),
        color: const Color(0xFFFF9800),
      ),
      // Grade 3 (deep orange)
      _ZoneGradient(
        rect: Rect.fromLTWH(
            leftMargin + chartWidth * 0.715,
            size.height - 40 - chartHeight * 0.833,
            chartWidth * 0.143,
            chartHeight * 0.166),
        color: const Color(0xFFFF5722),
      ),
      // Grade 4 (red)
      _ZoneGradient(
        rect: Rect.fromLTWH(
            leftMargin + chartWidth * 0.858,
            size.height - 40 - chartHeight,
            chartWidth * 0.142,
            chartHeight * 0.167),
        color: const Color(0xFFD32F2F),
      ),
    ];
    // Create gradient background
    final paint = Paint();
    // Draw complex gradient zones
    for (int y = 0; y < chartHeight.toInt(); y++) {
      for (int x = 0; x < chartWidth.toInt(); x++) {
        final xPos = leftMargin + x;
        final yPos = topMargin + y;
        // Determine color based on position
        Color color =
            _getColorAtPosition(x / chartWidth, 1 - (y / chartHeight));
        paint.color = color;
        canvas.drawRect(
          Rect.fromLTWH(xPos, yPos, 1, 1),
          paint,
        );
      }
    }
  }

  Color _getColorAtPosition(double xRatio, double yRatio) {
    // Purple zone (hypotension) - bottom left
    if (xRatio < 0.143 && yRatio < 0.125) {
      return const Color(0xFFB39DDB);
    }
    // Blue zone (normal)
    if (xRatio >= 0.143 && xRatio < 0.429 && yRatio < 0.333) {
      return const Color(0xFF2196F3);
    }
    // Create gradient effect
    if (yRatio < 0.125) return const Color(0xFFB39DDB);
    if (yRatio < 0.333)
      return Color.lerp(const Color(0xFF2196F3), const Color(0xFFFDD835),
              (xRatio - 0.143) / 0.5) ??
          const Color(0xFF2196F3);
    if (yRatio < 0.5)
      return Color.lerp(const Color(0xFFFDD835), const Color(0xFFFF9800),
              (xRatio - 0.3) / 0.5) ??
          const Color(0xFFFDD835);
    if (yRatio < 0.667)
      return Color.lerp(const Color(0xFFFF9800), const Color(0xFFFF5722),
              (xRatio - 0.4) / 0.5) ??
          const Color(0xFFFF9800);
    if (yRatio < 0.833)
      return Color.lerp(const Color(0xFFFF5722), const Color(0xFFD32F2F),
              (xRatio - 0.5) / 0.5) ??
          const Color(0xFFFF5722);
    return const Color(0xFFD32F2F);
  }

  void _drawGridLines(
      Canvas canvas,
      Size size,
      double leftMargin,
      double topMargin,
      double bottomMargin,
      double chartWidth,
      double chartHeight,
      Function diastolicToX,
      Function systolicToY) {
    final gridPaint = Paint()
      ..color = Colors.white.withOpacity(0.3)
      ..strokeWidth = 1;
    // Vertical grid lines (diastolic)
    for (int i = 60; i <= 110; i += 10) {
      final x = diastolicToX(i.toDouble());
      canvas.drawLine(
        Offset(x, topMargin),
        Offset(x, size.height - bottomMargin),
        gridPaint,
      );
    }
    // Horizontal grid lines (systolic)
    for (int i = 90; i <= 180; i += 20) {
      final y = systolicToY(i.toDouble());
      canvas.drawLine(
        Offset(leftMargin, y),
        Offset(size.width - 20, y),
        gridPaint,
      );
    }
  }

  void _drawAxes(Canvas canvas, Size size, double leftMargin, double topMargin,
      double bottomMargin, double chartWidth, double chartHeight) {
    final axisPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2;
    // X-axis
    canvas.drawLine(
      Offset(leftMargin, size.height - bottomMargin),
      Offset(size.width - 20, size.height - bottomMargin),
      axisPaint,
    );
    // Y-axis
    canvas.drawLine(
      Offset(leftMargin, topMargin),
      Offset(leftMargin, size.height - bottomMargin),
      axisPaint,
    );
  }

  void _drawAxisLabels(
      Canvas canvas,
      Size size,
      double leftMargin,
      double topMargin,
      double bottomMargin,
      Function diastolicToX,
      Function systolicToY) {
    final textStyle = const TextStyle(
      color: Colors.black,
      fontSize: 11,
    );
    // X-axis labels (Diastolic)
    for (int i = 60; i <= 110; i += 10) {
      final textSpan = TextSpan(text: i.toString(), style: textStyle);
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: ui.TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(diastolicToX(i.toDouble()) - textPainter.width / 2,
            size.height - bottomMargin + 10),
      );
    }
    // Y-axis labels (Systolic)
    for (int i = 90; i <= 180; i += 20) {
      final textSpan = TextSpan(text: i.toString(), style: textStyle);
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: ui.TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(leftMargin - textPainter.width - 8,
            systolicToY(i.toDouble()) - textPainter.height / 2),
      );
    }
    // Axis titles
    final titleStyle = const TextStyle(
      color: Colors.black,
      fontSize: 12,
      fontWeight: FontWeight.bold,
    );
    // "Normal" label on left
    final normalSpan = TextSpan(text: 'Normal', style: titleStyle);
    final normalPainter = TextPainter(
      text: normalSpan,
      textDirection: ui.TextDirection.ltr,
    );
    normalPainter.layout();
    canvas.save();
    canvas.translate(15, size.height / 2);
    canvas.rotate(-3.14159 / 2);
    normalPainter.paint(canvas, Offset(-normalPainter.width / 2, 0));
    canvas.restore();
  }

  void _drawZoneLabels(
      Canvas canvas, Function diastolicToX, Function systolicToY) {
    final labelStyle = const TextStyle(
      color: Colors.white,
      fontSize: 10,
      fontWeight: FontWeight.bold,
    );
    final labels = [
      _ZoneLabel('Normal', 70, 105),
      _ZoneLabel('Hypotension', 55, 85),
      _ZoneLabel('Grade 2', 95, 150),
      _ZoneLabel('Grade 3', 105, 170),
      _ZoneLabel('Grade 4 Hypertension', 115, 190),
    ];
    for (final label in labels) {
      final textSpan = TextSpan(text: label.text, style: labelStyle);
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: ui.TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(
          diastolicToX(label.diastolic) - textPainter.width / 2,
          systolicToY(label.systolic) - textPainter.height / 2,
        ),
      );
    }
  }

  void _drawDataPoints(Canvas canvas, List<BloodPressurePoint> points,
      Function diastolicToX, Function systolicToY) {
    final pointPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    final borderPaint = Paint()
      ..color = Colors.blue.shade700
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    for (final point in points) {
      final x = diastolicToX(point.diastolic);
      final y = systolicToY(point.systolic);
      // Draw outer circle (border)
      canvas.drawCircle(Offset(x, y), 6, borderPaint);
      // Draw inner circle
      canvas.drawCircle(Offset(x, y), 5, pointPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class ColorZone {
  final Color color;
  final List<Offset> points;
  final String label;

  ColorZone({
    required this.color,
    required this.points,
    required this.label,
  });
}

class _ZoneGradient {
  final Rect rect;
  final Color color;

  _ZoneGradient({required this.rect, required this.color});
}

class _ZoneLabel {
  final String text;
  final double diastolic;
  final double systolic;

  _ZoneLabel(this.text, this.diastolic, this.systolic);
}
