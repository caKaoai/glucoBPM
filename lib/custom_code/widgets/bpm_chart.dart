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

import 'package:syncfusion_flutter_charts/charts.dart';

class BpmChart extends StatefulWidget {
  const BpmChart({
    super.key,
    this.width,
    this.height,
    this.retunVal,
  });

  final double? width;
  final double? height;
  final Future Function(BPMinfoStruct? bpmData)? retunVal;

  @override
  State<BpmChart> createState() => _BpmChartState();
}

class _BpmChartState extends State<BpmChart> {
  List<_BpmChartEntry> entries = [];
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _prepareEntries();
    _setDefaultSelected();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _notifySelection();
    });
  }

  // ------------------------------------------------------------------
  void _prepareEntries() {
    entries.clear();

    final infos = FFAppState().bpmInfos ?? <BPMinfoStruct>[];

    final Map<String, int> labelCount = {};

    for (final b in infos) {
      DateTime? dt;
      try {
        dt = DateTime.parse(b.createdAt).toLocal();
      } catch (_) {}

      if (dt == null) continue;
      if (!b.hasPluse() && !b.hasHrv()) continue;

      final now = DateTime.now();
      final isToday =
          dt.year == now.year && dt.month == now.month && dt.day == now.day;

      final displayLabel = isToday ? 'Today' : DateFormat('d MMM').format(dt);

      labelCount[displayLabel] = (labelCount[displayLabel] ?? 0) + 1;
      final uniqueLabel = '$displayLabel#${labelCount[displayLabel]! - 1}';

      entries.add(
        _BpmChartEntry(
          displayLabel: displayLabel,
          uniqueLabel: uniqueLabel,
          bpm: b.pluse.toDouble(),
          hrv: b.hrv.toDouble(),
          dateTime: dt,
        ),
      );
    }

    // Sort by time and keep last 5
    entries.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    if (entries.length > 5) {
      entries = entries.sublist(entries.length - 5);
    }
  }

  // ------------------------------------------------------------------
  void _setDefaultSelected() {
    if (entries.isEmpty) return;
    selectedIndex = entries.length - 1; // last by default
  }

  void _notifySelection() {
    if (entries.isEmpty) return;

    // When single entry, always use the real entry
    final realEntry =
        entries.length == 1 ? entries.first : entries[selectedIndex];

    widget.retunVal?.call(
      BPMinfoStruct(
        createdAt: realEntry.dateTime.toIso8601String(),
        pluse: realEntry.bpm.round(),
        hrv: realEntry.hrv.round(),
      ),
    );
  }

  // ------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    if (entries.isEmpty) {
      return SizedBox(
        height: widget.height ?? 220,
        child: SfCartesianChart(
          plotAreaBorderWidth: 0,
          primaryXAxis: CategoryAxis(
            axisLine: const AxisLine(width: 0),
            majorGridLines: const MajorGridLines(width: 0),
          ),
          primaryYAxis: NumericAxis(
            minimum: 0,
            maximum: 240,
            interval: 80,
            axisLine: const AxisLine(width: 0),
            majorGridLines: MajorGridLines(
              dashArray: const [6, 6],
              color: Colors.blueGrey.withOpacity(.3),
            ),
          ),
          series: const [],
        ),
      );
    }

    // --------------------------------------------------------------
    // Padding logic for single entry (center dot)
    List<_BpmChartEntry> displayEntries = List.from(entries);

    if (displayEntries.length == 1) {
      final e = displayEntries.first;

      displayEntries.insert(
        0,
        e.padding(e.dateTime.subtract(const Duration(days: 2))),
      );
      displayEntries.insert(
        0,
        e.padding(e.dateTime.subtract(const Duration(days: 1))),
      );
      displayEntries.add(
        e.padding(e.dateTime.add(const Duration(days: 1))),
      );
      displayEntries.add(
        e.padding(e.dateTime.add(const Duration(days: 2))),
      );

      selectedIndex = 2;
    }

    return SizedBox(
      width: widget.width,
      height: 220,
      child: SfCartesianChart(
        plotAreaBorderWidth: 0,

        // ---------------- X AXIS ----------------
        primaryXAxis: CategoryAxis(
          axisLine: const AxisLine(width: 0),
          majorGridLines: const MajorGridLines(width: 0),
          labelsExtent: 34,
          axisLabelFormatter: (details) {
            final e = displayEntries.firstWhere(
              (e) => e.uniqueLabel == details.text,
              orElse: () => displayEntries[0],
            );
            return ChartAxisLabel(e.displayLabel, null);
          },
          plotBands: [
            PlotBand(
              start: selectedIndex - 0.5,
              end: selectedIndex + 0.5,
              color: const Color(0xFFFFE6EA), // pink highlight
            ),
          ],
        ),

        // ---------------- Y AXIS ----------------
        primaryYAxis: NumericAxis(
          minimum: 0,
          maximum: 240,
          interval: 80,
          axisLine: const AxisLine(width: 0),
          majorGridLines: MajorGridLines(
            dashArray: const [6, 6],
            color: Colors.blueGrey.withOpacity(.3),
          ),
        ),

        tooltipBehavior: TooltipBehavior(enable: false),

        series: [
          // ---------------- BPM (BLUE) ----------------
          LineSeries<_BpmChartEntry, String>(
            dataSource: displayEntries,
            xValueMapper: (e, _) => e.uniqueLabel,
            yValueMapper: (e, _) => e.isPadding ? null : e.bpm,
            color: Colors.red.withOpacity(.25),
            width: 1.5,
            markerSettings: const MarkerSettings(
              isVisible: true,
              width: 12,
              height: 12,
              color: Colors.red,
              shape: DataMarkerType.circle,
            ),
            onPointTap: (d) {
              if (d.pointIndex != null &&
                  !displayEntries[d.pointIndex!].isPadding) {
                setState(() => selectedIndex = d.pointIndex!);
                _notifySelection();
              }
            },
          ),

          // ---------------- HRV (RED) ----------------
          LineSeries<_BpmChartEntry, String>(
            dataSource: displayEntries,
            xValueMapper: (e, _) => e.uniqueLabel,
            yValueMapper: (e, _) => e.isPadding ? null : e.hrv,
            color: Colors.blue.withOpacity(.25),
            width: 1.5,
            markerSettings: const MarkerSettings(
              isVisible: true,
              width: 12,
              height: 12,
              color: Colors.blue,
              shape: DataMarkerType.circle,
            ),
            onPointTap: (d) {
              if (d.pointIndex != null &&
                  !displayEntries[d.pointIndex!].isPadding) {
                setState(() => selectedIndex = d.pointIndex!);
                _notifySelection();
              }
            },
          ),
        ],
      ),
    );
  }
}

// ===================================================================
// INTERNAL ENTRY MODEL
// ===================================================================

class _BpmChartEntry {
  final String displayLabel;
  final String uniqueLabel;
  final double bpm;
  final double hrv;
  final DateTime dateTime;
  final bool isPadding;

  _BpmChartEntry({
    required this.displayLabel,
    required this.uniqueLabel,
    required this.bpm,
    required this.hrv,
    required this.dateTime,
    this.isPadding = false,
  });

  _BpmChartEntry padding(DateTime dt) => _BpmChartEntry(
        displayLabel: '',
        uniqueLabel: 'padding_$dt',
        bpm: bpm,
        hrv: hrv,
        dateTime: dt,
        isPadding: true,
      );
}
