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

class BpSegmentedBar extends StatefulWidget {
  const BpSegmentedBar({
    super.key,
    this.width,
    this.height,
    this.sysVal,
    this.dia,
    this.callType,
    this.spO2,
  });

  final double? width;
  final double? height;
  final int? sysVal;
  final int? dia;
  final int? callType;
  final int? spO2;

  @override
  State<BpSegmentedBar> createState() => _BpSegmentedBarState();
}

class _BpSegmentedBarState extends State<BpSegmentedBar> {
  int getSegmentIndex() {
    // Use SYS to pick, but you can adjust logic for both
    for (int i = 0; i < bpRanges.length; i++) {
      final range = bpRanges[i];
      if ((widget.sysVal! >= range.sysStart &&
              widget.sysVal! <= range.sysEnd) ||
          (widget.dia! >= range.diaStart && widget.dia! <= range.diaEnd)) {
        return i;
      }
    }
    return 0; // Default to first range
  }

  MapEntry<PressureRange, int> getGradeAndIndex(int sys, int dia) {
    int foundIndex = 0;
    for (int i = 0; i < bpRanges.length; i++) {
      final range = bpRanges[i];
      if ((sys >= range.sysStart && sys <= range.sysEnd) ||
          (dia >= range.diaStart && dia <= range.diaEnd)) {
        foundIndex = i; // don't return, keep going for higher grades
      }
    }
    return MapEntry(bpRanges[foundIndex], foundIndex);
  }

  @override
  Widget build(BuildContext context) {
    // Check callType
    if (widget.callType == 1) {
      return _buildSpO2Bar();
    }

    // Original BP bar (callType == 0)
    final gradeInfo = getGradeAndIndex(widget.sysVal!, widget.dia!);
    final PressureRange grade = gradeInfo.key;
    final int selectedIndex = gradeInfo.value;

    final double segmentWidth = 44;
    final double barHeight = 20;
    final double pointerHeight = 18;
    final double pointerWidth = 18;
    final double radius = 14;

    return Column(
      children: [
        BpGradeText(
          sys: widget.sysVal!,
          dia: widget.dia!,
        ),
        Center(
          child: SizedBox(
            width: segmentWidth * bpRanges.length,
            height: barHeight + pointerHeight,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Segments row
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for (int i = 0; i < bpRanges.length; i++)
                        Container(
                          width: segmentWidth,
                          height: barHeight,
                          decoration: BoxDecoration(
                            color: bpRanges[i].color,
                            borderRadius: BorderRadius.horizontal(
                              left: i == 0
                                  ? Radius.circular(radius)
                                  : Radius.zero,
                              right: i == bpRanges.length - 1
                                  ? Radius.circular(radius)
                                  : Radius.zero,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                // Pointer triangle
                Positioned(
                  left: segmentWidth * selectedIndex +
                      segmentWidth / 2 -
                      pointerWidth / 2,
                  bottom: 18,
                  child: CustomPaint(
                    size: Size(pointerWidth, pointerHeight),
                    painter: _PointerPainter(color: grade.color),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSpO2Bar() {
    final int spO2Value = widget.spO2 ?? 95;
    final SpO2Info info = getSpO2Info(spO2Value);

    // Total bar width
    const double totalWidth = 265;

    // Segment widths (proportional to medical ranges)
    const double severeWidth = totalWidth * 0.80; // 0–79
    const double moderateWidth = totalWidth * 0.11; // 80–90
    const double mildWidth = totalWidth * 0.04; // 91–94
    const double normalWidth = totalWidth * 0.05; // 95–100

    const double barHeight = 16;
    const double pointerSize = 16;
    const double radius = 12;
    const double dividerWidth = 1;

    // Clamp value safely
    final double v = spO2Value.clamp(0, 100).toDouble();

    // Map SpO2 → X position
    double pointerX;
    if (v >= 95) {
      pointerX = severeWidth +
          moderateWidth +
          mildWidth +
          ((v - 95) / 5) * normalWidth;
    } else if (v >= 91) {
      pointerX = severeWidth + moderateWidth + ((v - 91) / 4) * mildWidth;
    } else if (v >= 80) {
      pointerX = severeWidth + ((v - 80) / 11) * moderateWidth;
    } else {
      pointerX = (v / 80) * severeWidth;
    }
    Widget _divider() {
      return Container(
        width: dividerWidth,
        height: 16, // same as barHeight
        color: Colors.white,
      );
    }

    return Column(
      children: [
        SpO2GradeText(spO2: spO2Value),
        Center(
          child: SizedBox(
            width: totalWidth,
            height: barHeight + 26,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Segmented bar
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(
                    children: [
                      _segment(
                        width: severeWidth,
                        color: const Color(0xFFE74C3C),
                        left: true,
                      ),
                      _divider(),
                      _segment(
                        width: moderateWidth,
                        color: const Color(0xFFFBAA47),
                      ),
                      _divider(),
                      _segment(
                        width: mildWidth,
                        color: const Color(0xFFFDD782),
                      ),
                      _divider(),
                      _segment(
                        width: normalWidth,
                        color: const Color(0xFF4CAF50),
                        right: true,
                      ),
                    ],
                  ),
                ),

                // Pointer
                Positioned(
                  left: pointerX - pointerSize / 2,
                  bottom: 25,
                  child: CustomPaint(
                    size: const Size(pointerSize, pointerSize),
                    painter: _PointerPainter(color: info.color),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _segment({
    required double width,
    required Color color,
    bool left = false,
    bool right = false,
  }) {
    return Container(
      width: width,
      height: 16,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.horizontal(
          left: left ? const Radius.circular(12) : Radius.zero,
          right: right ? const Radius.circular(12) : Radius.zero,
        ),
      ),
    );
  }
}

class _PointerPainter extends CustomPainter {
  final Color color;
  final double borderWidth;
  final double scale; // 👈 NEW

  _PointerPainter({
    required this.color,
    this.borderWidth = 2,
    this.scale = 1.25, // 👈 Increase size here (1.2–1.4 ideal)
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Scale canvas from center
    canvas.save();
    canvas.translate(size.width / 2, size.height / 2);
    canvas.scale(scale);
    canvas.translate(-size.width / 2, -size.height / 2);

    // ---- Border paint (white)
    final Paint borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    final Path borderPath = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width / 2, size.height)
      ..lineTo(size.width, 0)
      ..close();

    canvas.drawPath(borderPath, borderPaint);

    // ---- Inner paint (colored triangle)
    final Paint fillPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    final Path innerPath = Path()
      ..moveTo(borderWidth, borderWidth)
      ..lineTo(size.width / 2, size.height - borderWidth)
      ..lineTo(size.width - borderWidth, borderWidth)
      ..close();

    canvas.drawPath(innerPath, fillPaint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _PointerPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.borderWidth != borderWidth ||
        oldDelegate.scale != scale;
  }
}

class BpGradeText extends StatelessWidget {
  final int sys;
  final int dia;

  const BpGradeText({super.key, required this.sys, required this.dia});

  @override
  Widget build(BuildContext context) {
    final PressureRange grade = getCurrentGrade(sys, dia);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.circle, color: grade.color, size: 10),
            const SizedBox(width: 6),
            Text(
              grade.gradeLabel,
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                    color: Color(0xFF232B38),
                    fontSize: 22.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w600,
                    useGoogleFonts:
                        !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 2),
        Text(
          "${grade.desc}",
          style: FlutterFlowTheme.of(context).bodyMedium.override(
                fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                color: Color(0xFF8A97A8),
                fontSize: 16.0,
                letterSpacing: 0.0,
                fontWeight: FontWeight.w500,
                useGoogleFonts:
                    !FlutterFlowTheme.of(context).bodyMediumIsCustom,
              ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}

// New SpO2 Grade Text Widget
class SpO2GradeText extends StatelessWidget {
  final int spO2;

  const SpO2GradeText({super.key, required this.spO2});

  String _spO2RangeText(int value) {
    if (value >= 95) {
      return "95–100 %";
    } else if (value >= 91) {
      return "91–94 %";
    } else if (value >= 80) {
      return "80–90 %";
    } else {
      return "0–79 %";
    }
  }

  @override
  Widget build(BuildContext context) {
    final SpO2Info info = getSpO2Info(spO2);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.circle, color: info.color, size: 10),
            const SizedBox(width: 6),
            Text(
              info.label,
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                    color: Color(0xFF232B38),
                    fontSize: 22.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w600,
                    useGoogleFonts:
                        !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 2),
        Text(
          _spO2RangeText(spO2),
          style: FlutterFlowTheme.of(context).bodyMedium.override(
                fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                color: const Color(0xFF8A97A8),
                fontSize: 16.0,
                letterSpacing: 0.0,
                fontWeight: FontWeight.w500,
                useGoogleFonts:
                    !FlutterFlowTheme.of(context).bodyMediumIsCustom,
              ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}

class PressureRange {
  final int sysStart, sysEnd, diaStart, diaEnd;
  final Color color;
  final String gradeLabel;
  final String desc;

  PressureRange({
    required this.sysStart,
    required this.sysEnd,
    required this.diaStart,
    required this.diaEnd,
    required this.color,
    required this.gradeLabel,
    required this.desc,
  });
}

final List<PressureRange> bpRanges = [
  PressureRange(
    sysStart: 0,
    sysEnd: 89,
    diaStart: 0,
    diaEnd: 59,
    color: Color(0xFFB29EF9),
    gradeLabel: "Hypotension",
    desc: "SYS 0-89 and DIA 0-59",
  ), // purple
  PressureRange(
    sysStart: 90,
    sysEnd: 129,
    diaStart: 60,
    diaEnd: 84,
    color: Color(0xFF3B82F6),
    gradeLabel: "Normal",
    desc: "SYS 90-129 and DIA 60-84",
  ), // blue
  PressureRange(
    sysStart: 130,
    sysEnd: 139,
    diaStart: 85,
    diaEnd: 89,
    color: Color(0xFFFDD782),
    gradeLabel: "Grade 1",
    desc: "SYS 130-139 and DIA 85-89",
  ), // yellow
  PressureRange(
    sysStart: 140,
    sysEnd: 159,
    diaStart: 90,
    diaEnd: 99,
    color: Color(0xFFFBAA47),
    gradeLabel: "Grade 2",
    desc: "SYS 140-159 and DIA 90-99",
  ), // orange
  PressureRange(
    sysStart: 160,
    sysEnd: 179,
    diaStart: 100,
    diaEnd: 109,
    color: Color(0xFFF96B30),
    gradeLabel: "Grade 3",
    desc: "SYS 160-179 and DIA 100-109",
  ), // deep orange
  PressureRange(
    sysStart: 180,
    sysEnd: 220,
    diaStart: 110,
    diaEnd: 130,
    color: Color(0xFFE74C3C),
    gradeLabel: "Grade 4 Hypertension",
    desc: "SYS 180-220 and DIA 110-130",
  ), // red
];

PressureRange getCurrentGrade(int sys, int dia) {
  return bpRanges.lastWhere(
    (range) =>
        (sys >= range.sysStart && sys <= range.sysEnd) ||
        (dia >= range.diaStart && dia <= range.diaEnd),
    orElse: () => bpRanges.first, // Fallback to the first range
  );
}

// SpO2 related classes and functions
class SpO2Info {
  final String label;
  final Color color;

  SpO2Info({required this.label, required this.color});
}

SpO2Info getSpO2Info(int spO2) {
  if (spO2 >= 95) {
    return SpO2Info(label: "Normal", color: Color(0xFF4CAF50)); // Green
  } else if (spO2 >= 90) {
    return SpO2Info(
        label: "Mild Hypoxemia", color: Color(0xFFFDD782)); // Yellow
  } else if (spO2 >= 85) {
    return SpO2Info(
        label: "Moderate Hypoxemia", color: Color(0xFFFBAA47)); // Orange
  } else {
    return SpO2Info(label: "Severe Hypoxemia", color: Color(0xFFE74C3C)); // Red
  }
}
