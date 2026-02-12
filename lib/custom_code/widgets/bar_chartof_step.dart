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

class BarChartofStep extends StatefulWidget {
  const BarChartofStep({
    super.key,
    this.width,
    this.height,
    this.healthInfo,
  });

  final double? width;
  final double? height;
  final List<HealthInfoStruct>? healthInfo;

  @override
  State<BarChartofStep> createState() => _BarChartofStepState();
}

class _BarChartofStepState extends State<BarChartofStep> {
  static const double barMaxHeight = 60;
  static const double barWidth = 22;
  static const double chartHeight = 120;

  static const List<String> kWeekdays = [
    'MON',
    'TUE',
    'WED',
    'THU',
    'FRI',
    'SAT',
    'SUN'
  ];

  int _selectedIndex = -1;

  List<DateTime> _currentWeek() {
    final now = DateTime.now();
    final monday = now.subtract(Duration(days: now.weekday - 1));
    return List.generate(7, (i) => monday.add(Duration(days: i)));
  }

  String _dateKey(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    final weekDates = _currentWeek();
    final todayKey = _dateKey(DateTime.now());

    final Map<String, int> stepMap = {
      for (final h in widget.healthInfo ?? [])
        if (h.date != null) h.date!: h.steps ?? 0
    };

    final steps = weekDates.map((d) => stepMap[_dateKey(d)] ?? 0).toList();

    final maxStep = steps.fold<int>(1, (a, b) => a > b ? a : b);

    final int selectedIndex = _selectedIndex == -1
        ? weekDates.indexWhere((d) => _dateKey(d) == todayKey)
        : _selectedIndex;

    final int selectedSteps = selectedIndex >= 0 ? steps[selectedIndex] : 0;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFFDFEFF),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          // ---------- HEADER ----------
          Padding(
            padding: const EdgeInsets.only(left: 12, bottom: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('$selectedSteps',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).bodyMediumFamily,
                          fontSize: 20.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFFF9100),
                          useGoogleFonts:
                              !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                        )),
                const SizedBox(width: 2),
                Text('/${FFAppState().userData.goalSteps} Step',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).bodyMediumFamily,
                          fontSize: 18.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w400,
                          color: FlutterFlowTheme.of(context).secondaryText,
                          useGoogleFonts:
                              !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                        )),
              ],
            ),
          ),

          // ---------- CHART ----------
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              height: chartHeight,
              child: Stack(
                children: [
                  // dashed grid (Y-axis hidden)
                  Positioned.fill(
                    child: CustomPaint(
                      painter: _DashedGridPainter(),
                    ),
                  ),

                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(7, (i) {
                        final isSelected = i == selectedIndex;

                        final double height = steps[i] == 0
                            ? 14
                            : (steps[i] / maxStep * barMaxHeight)
                                .clamp(14, barMaxHeight);

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedIndex = i;
                            });
                          },
                          child: SizedBox(
                            width: barWidth,
                            child: steps[i] == 0
                                ? const SizedBox.shrink() // 🔴 NO BAR
                                : Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      width: barWidth,
                                      height:
                                          (steps[i] / maxStep * barMaxHeight)
                                              .clamp(8, barMaxHeight),
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? const Color(0xFFFF9100)
                                            : const Color(0xFFE1E4EE),
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(6.0),
                                            topRight: Radius.circular(6.0)),
                                      ),
                                    ),
                                  ),
                          ),
                        );
                      }),
                    ),
                  ),

                  // baseline
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 1,
                      color: const Color(0xFFCAD2EA),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 12),

          // ---------- CALENDAR ----------
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(7, (i) {
                final isSelected = i == selectedIndex;
                return _DayLabel(
                  day: kWeekdays[i],
                  date: weekDates[i].day,
                  selected: isSelected,
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------- DAY LABEL ----------
class _DayLabel extends StatelessWidget {
  final String day;
  final int date;
  final bool selected;

  const _DayLabel({
    required this.day,
    required this.date,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    if (!selected) {
      return Column(
        children: [
          Text(day,
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                    fontSize: 14.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFAAB1C8),
                    useGoogleFonts:
                        !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                  )),
          const SizedBox(height: 4),
          Text(
            '$date',
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                  fontSize: 14.0,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF272D4E),
                  useGoogleFonts:
                      !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                ),
          ),
        ],
      );
    }

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFFFF4B6E),
            borderRadius: BorderRadius.circular(28),
          ),
          child: Column(
            children: [
              Text(day,
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).bodyMediumFamily,
                        fontSize: 14.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        useGoogleFonts:
                            !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                      )),
              const SizedBox(height: 2),
              Container(
                width: 34,
                height: 34,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(
                    color: const Color(0xFFFF4B6E),
                    width: 2,
                  ),
                ),
                child: Text('$date',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).bodyMediumFamily,
                          fontSize: 14.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFFF4B6E),
                          useGoogleFonts:
                              !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                        )),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ---------- GRID (Y-axis hidden) ----------
class _DashedGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFDCE0ED)
      ..strokeWidth = 0.8;

    const dashWidth = 10;
    const dashSpace = 10;

    for (int i = 0; i < 5; i++) {
      final y = size.height * i / 4;
      double x = 0;
      while (x < size.width) {
        canvas.drawLine(
          Offset(x, y),
          Offset(x + dashWidth, y),
          paint,
        );
        x += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(_) => false;
}
