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

class OxygenTrendChart extends StatefulWidget {
  const OxygenTrendChart({
    super.key,
    this.width,
    this.height,
    this.bloodiNfo,
    this.action,
  });

  final double? width;
  final double? height;
  final List<BloodInfoStruct>? bloodiNfo;
  final Future Function(BloodInfoStruct? bllodInfo)? action;

  @override
  State<OxygenTrendChart> createState() => _OxygenTrendChartState();
}

class _OxygenTrendChartState extends State<OxygenTrendChart> {
  static const double barWidth = 48;
  static const double chartHeight = 200;

  final ScrollController _chartCtrl = ScrollController();

  late final List<OxyData> records;
  int selectedIndex = 0;
  List<DateTime> currentWeekDates = [];

  /// REAL chart viewport width (measured)
  double _chartViewportWidth = 0;

  @override
  void initState() {
    super.initState();

    records = _convertBloodInfoToOxyData();
    selectedIndex = records.isNotEmpty ? records.length - 1 : 0;

    if (records.isNotEmpty) {
      currentWeekDates = _getWeekDates(records[selectedIndex].date);
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (records.isNotEmpty) {
        _scrollToIndex(selectedIndex, animate: false);
      }
    });
  }

  // ---------------------------------------------------------------------------
  // DATA CONVERSION (UTC → LOCAL, uses spo2)
  // ---------------------------------------------------------------------------
  List<OxyData> _convertBloodInfoToOxyData() {
    if (widget.bloodiNfo == null || widget.bloodiNfo!.isEmpty) {
      return [];
    }

    final List<OxyData> list = [];

    for (final bloodInfo in widget.bloodiNfo!) {
      if (!bloodInfo.hasSpo2()) continue;

      DateTime? localDateTime;

      try {
        // ✅ time is ISO UTC → convert to LOCAL
        if (bloodInfo.hasTime() && bloodInfo.time.isNotEmpty) {
          localDateTime = DateTime.parse(bloodInfo.time).toLocal();
        }

        // 🔁 fallback (safety only)
        else if (bloodInfo.hasCreatedAt() && bloodInfo.createdAt.isNotEmpty) {
          localDateTime = DateTime.parse(bloodInfo.createdAt).toLocal();
        }
      } catch (_) {
        continue;
      }

      if (localDateTime == null) continue;

      list.add(
        OxyData(
          date: localDateTime, // ✅ LOCAL datetime
          spo2: bloodInfo.spo2,
          source: bloodInfo,
        ),
      );
    }

    // IMPORTANT: sort by LOCAL time
    list.sort((a, b) => a.date.compareTo(b.date));

    return list;
  }

  // ---------------------------------------------------------------------------
  // WEEK HELPERS
  // ---------------------------------------------------------------------------
  DateTime _getWeekStart(DateTime date) {
    return DateUtils.dateOnly(
      date.subtract(Duration(days: date.weekday - 1)),
    );
  }

  List<DateTime> _getWeekDates(DateTime date) {
    final start = _getWeekStart(date);
    return List.generate(7, (i) => start.add(Duration(days: i)));
  }

  // ---------------------------------------------------------------------------
  // 🔥 EXACT CENTER SNAP ON TAP (THIS IS THE FIX)
  // ---------------------------------------------------------------------------
  void _scrollToIndex(int index, {bool animate = true}) {
    if (!_chartCtrl.hasClients || records.isEmpty) return;

    setState(() {
      selectedIndex = index;
      currentWeekDates = _getWeekDates(records[index].date);
    });

    final double centerOffset = _chartViewportWidth / 2 - barWidth / 2;

    // SAME padding used by ListView
    final double horizontalPadding = centerOffset;

    double targetOffset = index * barWidth - centerOffset + horizontalPadding;

    targetOffset = targetOffset.clamp(
      0.0,
      _chartCtrl.position.maxScrollExtent,
    );

    if (animate) {
      _chartCtrl.animateTo(
        targetOffset,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOutCubic,
      );
    } else {
      _chartCtrl.jumpTo(targetOffset);
    }
  }

  // ---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    if (records.isEmpty) {
      return const Center(child: Text('No oxygen data'));
    }

    final current = records[selectedIndex];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${DateFormat.MMMMEEEEd().format(current.date)}, ${DateFormat.jm().format(current.date).toUpperCase()}",
          style: const TextStyle(
            fontSize: 11,
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),

        Row(
          children: [
            Text(
              "${current.spo2} %",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: current.color,
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: current.color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                current.status,
                style: TextStyle(
                  color: current.color,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        // =================== CHART ===================
        SizedBox(
          height: chartHeight,
          child: Row(
            children: [
              const _OxyYAxisLabels(height: chartHeight),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    _chartViewportWidth = constraints.maxWidth;

                    final double padding =
                        _chartViewportWidth / 2 - barWidth / 2;

                    return Stack(
                      children: [
                        Positioned.fill(
                          child: CustomPaint(
                            painter: _OxyGridPainter(),
                          ),
                        ),
                        ListView.builder(
                          controller: _chartCtrl,
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          padding: EdgeInsets.symmetric(horizontal: padding),
                          itemCount: records.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                _scrollToIndex(index);
                                widget.action?.call(records[index].source);
                              },
                              child: SizedBox(
                                width: barWidth,
                                child: CustomPaint(
                                  painter: _OxygenLinePainter(
                                    data: records,
                                    index: index,
                                    selectedIndex: selectedIndex,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            width: 1,
                            color: Colors.grey.shade400,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),

        // =================== CALENDAR ===================
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: currentWeekDates.map((d) {
              final isSel = DateUtils.isSameDay(d, records[selectedIndex].date);
              final hasData =
                  records.any((e) => DateUtils.isSameDay(e.date, d));

              return Expanded(
                child: Container(
                  width: 36,
                  height: 65,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: isSel ? Colors.red : Colors.transparent,
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(DateFormat.E().format(d).toUpperCase(),
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .bodyMediumFamily,
                                fontSize: 12.0,
                                letterSpacing: 0.0,
                                color: isSel
                                    ? Colors.white
                                    : (hasData
                                        ? Colors.red
                                        : Colors.grey.shade500),
                                fontWeight: FontWeight.w500,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .bodyMediumIsCustom,
                              )),
                      const SizedBox(
                        height: 2,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Text('${d.day}',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .bodyMediumFamily,
                                    fontSize: 14.0,
                                    letterSpacing: 0.0,
                                    color: isSel
                                        ? Colors.red
                                        : (hasData
                                            ? Colors.black
                                            : Colors.grey.shade700),
                                    fontWeight: FontWeight.w600,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
                                            .bodyMediumIsCustom,
                                  )),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _chartCtrl.dispose();
    super.dispose();
  }
}

class _OxyYAxisLabels extends StatelessWidget {
  const _OxyYAxisLabels({required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    const values = [100, 80, 60, 40, 20, 0];
    return SizedBox(
      width: 32,
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: values
            .map((v) => Text(
                  v.toString(),
                  style: const TextStyle(fontSize: 11, color: Colors.grey),
                ))
            .toList(),
      ),
    );
  }
}

class _OxyGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final grid = Paint()
      ..color = Colors.grey.withOpacity(0.25)
      ..strokeWidth = 1;

    for (int v = 0; v <= 100; v += 20) {
      final y = size.height - (v / 100) * size.height;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }
  }

  @override
  bool shouldRepaint(_) => false;
}

class _OxygenLinePainter extends CustomPainter {
  final List<OxyData> data;
  final int index;
  final int selectedIndex;

  _OxygenLinePainter({
    required this.data,
    required this.index,
    required this.selectedIndex,
  });

  double _y(double v, double h) => h - (v / 100) * h;

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;

    final centerX = size.width / 2;

    // Draw connecting line segment to next point
    if (index < data.length - 1) {
      final curr = data[index];
      final next = data[index + 1];

      final linePaint = Paint()
        ..color = Colors.grey.withOpacity(0.4)
        ..strokeWidth = 2
        ..strokeCap = StrokeCap.round;

      canvas.drawLine(
        Offset(centerX, _y(curr.spo2.toDouble(), size.height)),
        Offset(centerX + size.width, _y(next.spo2.toDouble(), size.height)),
        linePaint,
      );
    }

    // Draw dot
    final isSelected = index == selectedIndex;
    final dotPaint = Paint()..color = data[index].color;

    // Draw glow for selected dot
    if (isSelected) {
      final glowPaint = Paint()
        ..color = data[index].color.withOpacity(0.3)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);

      canvas.drawCircle(
        Offset(centerX, _y(data[index].spo2.toDouble(), size.height)),
        10,
        glowPaint,
      );
    }

    canvas.drawCircle(
      Offset(centerX, _y(data[index].spo2.toDouble(), size.height)),
      isSelected ? 7 : 5,
      dotPaint,
    );
  }

  @override
  bool shouldRepaint(_) => true;
}

class OxyData {
  final DateTime date;
  final int spo2;
  final BloodInfoStruct source;

  OxyData({
    required this.date,
    required this.spo2,
    required this.source,
  });

  Color get color {
    if (spo2 >= 95) return const Color(0xFF22C55E); // Green
    if (spo2 >= 90) return const Color(0xFFF59E0B); // Orange
    return const Color(0xFFEF4444); // Red
  }

  String get status {
    if (spo2 >= 95) return "Normal";
    if (spo2 >= 90) return "Low";
    return "Critical";
  }
}
