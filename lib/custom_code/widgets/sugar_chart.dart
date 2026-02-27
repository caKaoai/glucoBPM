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

import 'dart:async';
import 'package:syncfusion_flutter_charts/charts.dart';

class SugarChart extends StatefulWidget {
  const SugarChart({
    super.key,
    this.width,
    this.height,
    this.sugarInfo,
    this.colorCircle,
  });

  final double? width;
  final double? height;
  final List<BloodInfoStruct>? sugarInfo;
  final Color? colorCircle;

  @override
  State<SugarChart> createState() => _SugarChartState();
}

class _SugarChartState extends State<SugarChart> {
  // ================= CONSTANTS =================
  static const int maxRecords = 7;
  static const double dayWidth = 56;
  static const int daysPerWeek = 7;

  // ================= STATE =================
  List<_SugarPoint> chartPoints = [];
  List<DateTime> calendarDates = [];

  int selectedIndex = 0;
  int _visibleWeekIndex = 0;

  final ScrollController _calendarCtrl = ScrollController();
  bool _calendarScrollEnabled = false;
  Timer? _scrollTimer;

  // ================= LIFECYCLE =================
  @override
  void initState() {
    super.initState();
    _prepareChartPoints();
    _prepareCalendarDates();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (chartPoints.isNotEmpty) {
        _scrollCalendarTo(_strip(chartPoints[selectedIndex].dateTime));
      }
    });
  }

  @override
  void didUpdateWidget(covariant SugarChart oldWidget) {
    super.didUpdateWidget(oldWidget);
    _prepareChartPoints();
    _prepareCalendarDates();
  }

  @override
  void dispose() {
    _calendarCtrl.dispose();
    _scrollTimer?.cancel();
    super.dispose();
  }

  // ================= TIME =================
  DateTime _localTime(BloodInfoStruct b) {
    final timeStr = b.time ?? '';

    // 1️⃣ Full ISO datetime (preferred)
    try {
      if (timeStr.contains('T')) {
        return DateTime.parse(timeStr).toLocal();
      }
    } catch (_) {}

    // 2️⃣ Time-only (HH:mm) → attach to date
    try {
      // Expecting date is like "31/1/2026" or "Jan 31"
      final dateStr = b.date ?? '';
      if (dateStr.isNotEmpty) {
        DateTime baseDate;

        // dd/MM/yyyy
        if (dateStr.contains('/')) {
          baseDate = DateFormat('d/M/yyyy').parse(dateStr);
        } else {
          // MMM d
          final now = DateTime.now();
          final d = DateFormat('MMM d').parse(dateStr);
          baseDate = DateTime(now.year, d.month, d.day);
        }

        final t = DateFormat('HH:mm').parse(timeStr);

        return DateTime(
          baseDate.year,
          baseDate.month,
          baseDate.day,
          t.hour,
          t.minute,
        );
      }
    } catch (_) {}

    // 3️⃣ Absolute fallback (never crash)
    return DateTime.now();
  }

  DateTime _strip(DateTime d) => DateTime(d.year, d.month, d.day);

  bool _sameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  int _weekIndex(int dayIndex) => dayIndex ~/ daysPerWeek;

  // ================= DATA (ONCE ONLY) =================
  void _prepareChartPoints() {
    final List<_SugarPoint> records = [];

    for (final b in widget.sugarInfo!) {
      if (b.mgDl <= 0) continue;

      records.add(
        _SugarPoint(
          dateTime: _localTime(b),
          value: b.mgDl.toDouble(),
        ),
      );
    }

    // Sort by time
    records.sort((a, b) => a.dateTime.compareTo(b.dateTime));

    // Keep last 7 records if needed
    chartPoints = records.length > maxRecords
        ? records.sublist(records.length - maxRecords)
        : records;

    selectedIndex = chartPoints.isNotEmpty ? chartPoints.length - 1 : 0;
  }

  // ================= CALENDAR =================
  void _prepareCalendarDates() {
    calendarDates.clear();

    if (chartPoints.isEmpty) return;

    // Get first and last chart dates
    final firstChartDate = _strip(chartPoints.first.dateTime);
    final lastChartDate = _strip(chartPoints.last.dateTime);

    // 🔹 Align first date to Monday
    final startOfFirstWeek =
        firstChartDate.subtract(Duration(days: firstChartDate.weekday - 1));

    // 🔹 Align last date to Monday
    final startOfLastWeek =
        lastChartDate.subtract(Duration(days: lastChartDate.weekday - 1));

    // 🔹 End of last week = Monday + 6 days (Sunday)
    final endOfLastWeek = startOfLastWeek.add(const Duration(days: 6));

    DateTime current = startOfFirstWeek;

    while (!current.isAfter(endOfLastWeek)) {
      calendarDates.add(current);
      current = current.add(const Duration(days: 1));
    }
  }

  // ================= SCROLL CONTROL =================
  void _enableCalendarScroll() {
    setState(() => _calendarScrollEnabled = true);

    _scrollTimer?.cancel();
    _scrollTimer = Timer(const Duration(seconds: 2), () {
      setState(() => _calendarScrollEnabled = false);
    });
  }

  void _scrollCalendarTo(DateTime date) {
    final idx = calendarDates.indexWhere((d) => _sameDay(d, date));
    if (idx == -1) return;

    final targetWeek = _weekIndex(idx);
    if (targetWeek == _visibleWeekIndex) return;

    _visibleWeekIndex = targetWeek;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _calendarCtrl.animateTo(
        targetWeek * daysPerWeek * dayWidth,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOutCubic,
      );
    });
  }

  // ================= UI =================
  @override
  Widget build(BuildContext context) {
    if (chartPoints.isEmpty) {
      return const SizedBox(
        height: 220,
        child: Center(child: Text('No data')),
      );
    }

    final selected = chartPoints[selectedIndex];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ================= HEADER =================
          Text(DateFormat('d MMM, HH:mm').format(selected.dateTime),
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                    fontSize: 12.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w500,
                    color: FlutterFlowTheme.of(context).customColor2,
                    useGoogleFonts:
                        !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                  )),
          const SizedBox(height: 6),
          Row(
            children: [
              Expanded(
                child: Text(
                  '${selected.value.toInt()} mg/dL',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).bodyMediumFamily,
                        fontSize: 22.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w500,
                        color: bloodSugarColorStatus(BloodInfoStruct(
                                    mgDl: selected.value.toInt()))
                                ?.color ??
                            Color(0xFFB2FF65),
                        useGoogleFonts:
                            !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                      ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  color: bloodSugarColorStatus(
                              BloodInfoStruct(mgDl: selected.value.toInt()))
                          ?.color!
                          .withOpacity(0.2) ??
                      Color(0xFFB2FF65).withOpacity(0.2),
                ),
                child: Padding(
                  padding: EdgeInsetsGeometry.symmetric(
                      horizontal: 6.0, vertical: 4.0),
                  child: Text(
                    '${bloodSugarColorStatus(BloodInfoStruct(mgDl: selected.value.toInt()))?.sugarState}',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).bodyMediumFamily,
                          fontSize: 14.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w500,
                          color: bloodSugarColorStatus(BloodInfoStruct(
                                      mgDl: selected.value.toInt()))
                                  ?.color ??
                              Color(0xFFB2FF65),
                          useGoogleFonts:
                              !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                        ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // ================= CHART (UNCHANGED) =================
          SizedBox(
            height: 180,
            child: SfCartesianChart(
              plotAreaBorderWidth: 0,
              primaryXAxis: const CategoryAxis(isVisible: false),
              primaryYAxis: NumericAxis(
                minimum: 0,
                maximum: 390,
                interval: 130,
                axisLine: const AxisLine(width: 0),
                majorTickLines: const MajorTickLines(size: 0),
                majorGridLines: MajorGridLines(
                  dashArray: const [6, 6],
                  color: Colors.grey.withOpacity(.2),
                ),
              ),
              series: [
                SplineSeries<_SugarPoint, String>(
                  dataSource: chartPoints,
                  xValueMapper: (p, _) =>
                      DateFormat('HH:mm').format(p.dateTime),
                  yValueMapper: (p, _) => p.value,
                  color: const Color(0xFFFF8A65),
                  width: 2,
                  markerSettings: const MarkerSettings(
                    isVisible: true,
                    width: 8,
                    height: 8,
                    color: Color(0xFFFF8A65),
                  ),
                  onPointTap: (details) {
                    setState(() {
                      selectedIndex = details.pointIndex!;
                    });
                    _enableCalendarScroll();
                    _scrollCalendarTo(
                      _strip(chartPoints[selectedIndex].dateTime),
                    );
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // ================= CALENDAR =================
          SizedBox(
            height: 64,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final double itemWidth = constraints.maxWidth / 7;

                return ListView.builder(
                  controller: _calendarCtrl,
                  physics: _calendarScrollEnabled
                      ? const BouncingScrollPhysics()
                      : const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: calendarDates.length,
                  itemBuilder: (_, i) {
                    final d = calendarDates[i];

                    final idx = chartPoints.lastIndexWhere(
                      (p) => _sameDay(_strip(p.dateTime), d),
                    );

                    final isSelected = _sameDay(
                      _strip(chartPoints[selectedIndex].dateTime),
                      d,
                    );

                    return GestureDetector(
                      onTap: idx == -1
                          ? null
                          : () {
                              setState(() {
                                selectedIndex = idx;
                              });
                              _enableCalendarScroll();
                              _scrollCalendarTo(d);
                            },
                      child: Container(
                        width: itemWidth,
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        decoration: isSelected
                            ? BoxDecoration(
                                borderRadius: BorderRadius.circular(26.0),
                                color: Colors.red,
                              )
                            : null,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              DateFormat('EEE').format(d).toUpperCase(),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .bodyMediumFamily,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w500,
                                    color:
                                        isSelected ? Colors.white : Colors.grey,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
                                            .bodyMediumIsCustom,
                                  ),
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                  color: Colors.white, shape: BoxShape.circle),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '${d.day}',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .bodyMediumFamily,
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w600,
                                        color: isSelected
                                            ? Colors.red
                                            : Colors.black,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .bodyMediumIsCustom,
                                      ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ================= MODEL =================
class _SugarPoint {
  final DateTime dateTime;
  final double value;

  _SugarPoint({
    required this.dateTime,
    required this.value,
  });
}
