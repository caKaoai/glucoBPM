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

class PressureTrendChart extends StatefulWidget {
  const PressureTrendChart({
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
  State<PressureTrendChart> createState() => _PressureTrendChartState();
}

class _PressureTrendChartState extends State<PressureTrendChart> {
  static const double barWidth = 48;
  static const double dateWidth = 56;
  static const double chartHeight = 220;

  final ScrollController _chartCtrl = ScrollController();
  final ScrollController _dateCtrl = ScrollController();

  late final List<BPData> records;
  late final List<DateTime> calendarDays;
  late final List<GlobalKey> _barKeys;

  int selectedIndex = 0;
  late DateTime selectedDate;

  // ------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    records = _buildRecords(widget.bloodiNfo!);
    calendarDays = _buildCalendarDays(records);
    _barKeys = List.generate(records.length, (_) => GlobalKey());

    selectedIndex = records.isEmpty ? 0 : records.length - 1;
    selectedDate = DateUtils.dateOnly(records[selectedIndex].date);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (records.isNotEmpty) {
        _centerBar(selectedIndex, animate: false);
        _scrollCalendarToDate(selectedDate, animate: false);
      }
    });
  }

  // ------------------------------------------------------------
  // BUILD RECORDS (TIME ONLY, SAFE)
  // ------------------------------------------------------------
  List<BPData> _buildRecords(List<BloodInfoStruct> list) {
    final now = DateTime.now();
    final out = <BPData>[];

    for (final e in list) {
      if (e.time == null || e.time!.isEmpty) continue;

      DateTime parsed;
      final t = e.time!;

      if (t.contains('T')) {
        parsed = DateTime.parse(t).toLocal();
      } else if (t.contains(':')) {
        final p = t.split(':');
        parsed = DateTime(
          now.year,
          now.month,
          now.day,
          int.tryParse(p[0]) ?? 0,
          int.tryParse(p[1]) ?? 0,
        );
      } else {
        continue;
      }

      out.add(
        BPData(
          date: parsed,
          sys: e.systolic,
          dia: e.diastolic,
          source: e,
        ),
      );
    }

    out.sort((a, b) => a.date.compareTo(b.date));
    return out;
  }

  // ------------------------------------------------------------
  DateTime _startOfWeek(DateTime d) {
    final day = DateUtils.dateOnly(d);
    return day.subtract(Duration(days: day.weekday - DateTime.monday));
  }

  List<DateTime> _buildCalendarDays(List<BPData> records) {
    final weeks = records.map((e) => _startOfWeek(e.date)).toSet().toList()
      ..sort();

    final days = <DateTime>[];
    for (final w in weeks) {
      for (int i = 0; i < 7; i++) {
        days.add(w.add(Duration(days: i)));
      }
    }
    return days;
  }

  // ------------------------------------------------------------
  // CHART CENTERING (ANCHOR BASED)
  // ------------------------------------------------------------
  void _centerBar(int index, {bool animate = true}) {
    final ctx = _barKeys[index].currentContext;
    if (ctx == null) return;

    Scrollable.ensureVisible(
      ctx,
      alignment: 0.5,
      duration: animate ? const Duration(milliseconds: 300) : Duration.zero,
      curve: Curves.easeOut,
    );
  }

  // ------------------------------------------------------------
  // CALENDAR SCROLL
  // ------------------------------------------------------------
  void _scrollCalendarToDate(DateTime d, {bool animate = true}) {
    final i = calendarDays.indexWhere(
      (e) => DateUtils.isSameDay(e, d),
    );
    if (i == -1) return;

    _dateCtrl.animateTo(
      i * dateWidth,
      duration: animate ? const Duration(milliseconds: 300) : Duration.zero,
      curve: Curves.easeOut,
    );
  }

  // ------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    if (records.isEmpty) return const SizedBox();

    final current = records[selectedIndex];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${current.source.date} ${current.source.time} ",
          style: FlutterFlowTheme.of(context).bodyMedium.override(
                fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                fontSize: 12,
                letterSpacing: 0.0,
                color: Colors.grey.shade500,
                fontWeight: FontWeight.w500,
                useGoogleFonts:
                    !FlutterFlowTheme.of(context).bodyMediumIsCustom,
              ),
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                "${current.sys}/${current.dia} mmHg",
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                      fontSize: 18,
                      letterSpacing: 0.0,
                      color: current.color,
                      fontWeight: FontWeight.w500,
                      useGoogleFonts:
                          !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                    ),
              ),
            ),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: current.color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                current.status,
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                      fontSize: 13,
                      color: current.color,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w500,
                      useGoogleFonts:
                          !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                    ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // ===================== CHART =====================
        SizedBox(
          height: chartHeight,
          child: Row(
            children: [
              const _YAxisLabels(height: chartHeight),
              Expanded(
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: CustomPaint(painter: _BPGridPainter()),
                    ),
                    ListView.builder(
                      controller: _chartCtrl,
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width / 2 -
                            barWidth / 2,
                      ),
                      itemCount: records.length,
                      itemBuilder: (_, i) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex = i;
                              selectedDate =
                                  DateUtils.dateOnly(records[i].date);
                            });

                            _centerBar(i);
                            _scrollCalendarToDate(selectedDate);

                            widget.action?.call(records[i].source);
                          },
                          child: SizedBox(
                            key: _barKeys[i],
                            width: barWidth,
                            child: CustomPaint(
                              painter: _BPBarPainter(
                                records[i],
                                isSelected: i == selectedIndex,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(width: 1, color: Colors.grey.shade400),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // ===================== CALENDAR =====================
        const SizedBox(height: 12),
        SizedBox(
          height: 64,
          child: ListView.builder(
            controller: _dateCtrl,
            scrollDirection: Axis.horizontal,
            itemCount: calendarDays.length,
            itemBuilder: (_, i) {
              final d = calendarDays[i];
              final isSel = DateUtils.isSameDay(d, selectedDate);

              return GestureDetector(
                onTap: () {
                  final idx = records.lastIndexWhere(
                    (e) => DateUtils.isSameDay(e.date, d),
                  );

                  setState(() {
                    selectedDate = d;
                    if (idx != -1) selectedIndex = idx;
                  });

                  _scrollCalendarToDate(d);
                  if (idx != -1) _centerBar(idx);
                },
                child: SizedBox(
                  width: dateWidth,
                  child: Column(
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                        decoration: BoxDecoration(
                            color: isSel ? Colors.red : Colors.transparent,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(100),
                              topRight: Radius.circular(100),
                              bottomLeft: Radius.circular(100),
                              bottomRight: Radius.circular(100),
                            )),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              DateFormat.E().format(d).toUpperCase(),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .bodyMediumFamily,
                                    fontSize: 12.0,
                                    letterSpacing: 0.0,
                                    color: isSel ? Colors.white : Colors.grey,
                                    fontWeight: FontWeight.w600,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
                                            .bodyMediumIsCustom,
                                  ),
                            ),
                            const SizedBox(height: 2),
                            Container(
                              decoration: BoxDecoration(
                                color:
                                    isSel ? Colors.white : Colors.transparent,
                                shape: BoxShape.circle,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Text(d.day.toString(),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMediumFamily,
                                          fontSize: 14.0,
                                          letterSpacing: 0.0,
                                          color:
                                              isSel ? Colors.red : Colors.black,
                                          fontWeight: FontWeight.w600,
                                          useGoogleFonts:
                                              !FlutterFlowTheme.of(context)
                                                  .bodyMediumIsCustom,
                                        )),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

// ===================================================================
// Y AXIS
// ===================================================================
class _YAxisLabels extends StatelessWidget {
  const _YAxisLabels({required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    const values = [250, 200, 150, 100, 50, 0];
    return SizedBox(
      width: 32,
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: values
            .map(
              (v) => Text(
                v.toString(),
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                      fontSize: 12.5,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w500,
                      useGoogleFonts:
                          !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                    ),
              ),
            )
            .toList(),
      ),
    );
  }
}

// ===================================================================
// GRID
// ===================================================================
class _BPGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final bands = [
      const Color(0xFFFFFF),
      const Color(0xFFFFFF),
      const Color(0xFFFFFF),
      const Color(0xFFFFFF),
    ];

    for (int i = 0; i < 4; i++) {
      canvas.drawRect(
        Rect.fromLTWH(
          0,
          size.height * i / 4,
          size.width,
          size.height / 4,
        ),
        Paint()..color = bands[i],
      );
    }

    final grid = Paint()
      ..color = Colors.grey.withOpacity(0.25)
      ..strokeWidth = 1;

    for (int v = 0; v <= 250; v += 50) {
      final y = size.height - (v / 250) * size.height;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }
  }

  @override
  bool shouldRepaint(_) => false;
}

// ===================================================================
// BAR
// ===================================================================
class _BPBarPainter extends CustomPainter {
  final BPData data;
  final bool isSelected;

  _BPBarPainter(this.data, {required this.isSelected});

  double _y(double v, double h) => h - (v / 250) * h;

  @override
  void paint(Canvas canvas, Size size) {
    final glow = Paint()
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 16
      ..color = data.color.withOpacity(0.25);

    final main = Paint()
      ..strokeCap = StrokeCap.round
      ..strokeWidth = isSelected ? 12 : 8
      ..color = data.color;

    final x = size.width / 2;

    if (isSelected) {
      canvas.drawLine(
        Offset(x, _y(data.sys.toDouble(), size.height)),
        Offset(x, _y(data.dia.toDouble(), size.height)),
        glow,
      );
    }

    canvas.drawLine(
      Offset(x, _y(data.sys.toDouble(), size.height)),
      Offset(x, _y(data.dia.toDouble(), size.height)),
      main,
    );
  }

  @override
  bool shouldRepaint(_) => true;
}

// ===================================================================
// RANGE + MODEL
// ===================================================================
class BPRange {
  final int sysMin, sysMax;
  final int diaMin, diaMax;
  final Color color;
  final String label;

  const BPRange(
    this.sysMin,
    this.sysMax,
    this.diaMin,
    this.diaMax,
    this.color,
    this.label,
  );

  bool match(int s, int d) =>
      s >= sysMin && s <= sysMax && d >= diaMin && d <= diaMax;
}

const bpRanges = [
  BPRange(0, 89, 0, 59, Color(0xFF3B82F6), "Low"),
  BPRange(90, 129, 60, 84, Color(0xFF049F12), "Normal"),
  BPRange(130, 139, 85, 89, Color(0xFFFDD782), "Elevated"),
  BPRange(140, 300, 90, 200, Color(0xFFEF4444), "High"),
];

class BPData {
  final DateTime date;
  final int sys;
  final int dia;
  final BloodInfoStruct source;

  BPData({
    required this.date,
    required this.sys,
    required this.dia,
    required this.source,
  });

  BPRange get range => bpRanges.firstWhere((r) => r.match(sys, dia));

  Color get color => range.color;

  String get status => range.label;
}
