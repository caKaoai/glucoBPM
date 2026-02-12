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

class SugarSegmentBar extends StatefulWidget {
  const SugarSegmentBar({
    super.key,
    this.width,
    this.height,
    this.calltype,
    this.vmgdlVal,
    this.mmoiVal,
  });

  final double? width;
  final double? height;
  final int? calltype;
  final int? vmgdlVal;
  final double? mmoiVal;

  @override
  State<SugarSegmentBar> createState() => _SugarSegmentBarState();
}

class _SugarSegmentBarState extends State<SugarSegmentBar> {
  // ------------------------------------------------------------
  double get _value {
    return widget.calltype == 0
        ? (widget.vmgdlVal ?? 0).toDouble()
        : (widget.mmoiVal ?? 0);
  }

  // ------------------------------------------------------------
  String get _label {
    if (widget.calltype == 0) {
      if (_value <= 69) return 'Low';
      if (_value <= 99) return 'Normal';
      if (_value <= 125) return 'Prediabetes';
      return 'Diabetes';
    } else {
      if (_value <= 3.8) return 'Low';
      if (_value <= 5.5) return 'Normal';
      if (_value <= 6.9) return 'Prediabetes';
      return 'Diabetes';
    }
  }

  // ------------------------------------------------------------
  String get _rangeText {
    if (widget.calltype == 0) {
      if (_value <= 69) return '0–69 mg/dL';
      if (_value <= 99) return '70–99 mg/dL';
      if (_value <= 125) return '100–125 mg/dL';
      return '126–380 mg/dL';
    } else {
      if (_value <= 3.8) return '0–3.8 mmol/L';
      if (_value <= 5.5) return '3.9–5.5 mmol/L';
      if (_value <= 6.9) return '5.6–6.9 mmol/L';
      return '7–21.1 mmol/L';
    }
  }

  // ------------------------------------------------------------
  Color get _statusColor {
    if (widget.calltype == 0) {
      if (_value <= 69) return const Color(0xFF2196F3);
      if (_value <= 99) return const Color(0xFF4CAF50);
      if (_value <= 125) return const Color(0xFFFFA500);
      return const Color(0xFFE53935);
    } else {
      if (_value <= 3.8) return const Color(0xFF2196F3);
      if (_value <= 5.5) return const Color(0xFF4CAF50);
      if (_value <= 6.9) return const Color(0xFFFFA500);
      return const Color(0xFFE53935);
    }
  }

  // ------------------------------------------------------------

  // ------------------------------------------------------------

  Widget _bar() {
    const double pointerSize = 16;
    final double v = _value;
    final bool isMgdl = widget.calltype == 0;

    final List<_Segment> segments = isMgdl
        ? const [
            _Segment(min: 0, max: 69, flex: 69),
            _Segment(min: 70, max: 99, flex: 30),
            _Segment(min: 100, max: 125, flex: 26),
            _Segment(min: 126, max: 380, flex: 255),
          ]
        : const [
            _Segment(min: 0, max: 3.8, flex: 38),
            _Segment(min: 3.9, max: 5.5, flex: 17),
            _Segment(min: 5.6, max: 6.9, flex: 14),
            _Segment(min: 7.0, max: 21.1, flex: 142),
          ];

    final double totalFlex = segments.fold(0, (sum, s) => sum + s.flex);

    return LayoutBuilder(
      builder: (context, constraints) {
        final double barWidth = constraints.maxWidth;

        double consumedFlex = 0;
        double pointerFlex = 0;

        for (final seg in segments) {
          if (v >= seg.max) {
            consumedFlex += seg.flex;
          } else if (v >= seg.min) {
            final ratio = (v - seg.min) / (seg.max - seg.min);
            pointerFlex = consumedFlex + ratio * seg.flex;
            break;
          }
        }

        final double pointerX = (pointerFlex / totalFlex) * barWidth;

        return SizedBox(
          height: 20,
          child: Stack(
            clipBehavior: Clip.none, // 👈 REQUIRED
            children: [
              Row(
                children: isMgdl
                    ? [
                        _seg(69, const Color(0xFF2196F3), left: true),
                        _seg(30, const Color(0xFF4CAF50)),
                        _seg(26, const Color(0xFFFFA500)),
                        _seg(255, const Color(0xFFE53935), right: true),
                      ]
                    : [
                        _seg(38, const Color(0xFF2196F3), left: true),
                        _seg(17, const Color(0xFF4CAF50)),
                        _seg(14, const Color(0xFFFFA500)),
                        _seg(142, const Color(0xFFE53935), right: true),
                      ],
              ),
              Positioned(
                left: pointerX - pointerSize / 2,
                top: -12, // 👈 place above bar
                child: CustomPaint(
                  size: const Size(pointerSize, pointerSize),
                  painter: _PointerPainter(color: _statusColor),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _seg(int flex, Color color, {bool left = false, bool right = false}) {
    return Expanded(
      flex: flex,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.horizontal(
            left: left ? Radius.circular(widget.height! / 2) : Radius.zero,
            right: right ? Radius.circular(widget.height! / 2) : Radius.zero,
          ),
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 8,
              height: 8,
              decoration:
                  BoxDecoration(color: _statusColor, shape: BoxShape.circle),
            ),
            const SizedBox(width: 6),
            Text(
              _label,
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                    letterSpacing: 0.0,
                    useGoogleFonts:
                        !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          _rangeText,
          style: FlutterFlowTheme.of(context).bodyMedium.override(
                fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                letterSpacing: 0.0,
                useGoogleFonts:
                    !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
        ),
        const SizedBox(height: 26),
        _bar(),
      ],
    );
  }
}

class _Segment {
  final double min;
  final double max;
  final int flex;

  const _Segment({
    required this.min,
    required this.max,
    required this.flex,
  });
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
