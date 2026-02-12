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
import 'package:gluco_b_p_m/custom_code/widgets/bp_segmented_bar.dart';

/// callType = 0 = blood Pressure calltype = 1 = blood oxygen calltype = 2 =
/// blood sugar
class CustomChart extends StatefulWidget {
  const CustomChart({
    super.key,
    this.width,
    this.height,
    this.colorCircle,
    this.bloodInfo,
    this.presssureInfo,
    this.callType,
  });

  final double? width;
  final double? height;
  final Color? colorCircle;
  final List<BloodInfoStruct>? bloodInfo;
  final Future Function(BloodInfoStruct? result)? presssureInfo;
  final int? callType;

  @override
  State<CustomChart> createState() => _CustomChartState();
}

class _CustomChartState extends State<CustomChart> {
  List<_ChartEntry> entries = [];
  int? selectedIndex;
  double yMin = 0;
  double yMax = 240;

  @override
  void initState() {
    super.initState();
    _prepareEntries();
    _setDefaultSelected();
    _calculateYAxisBounds();
  }

  void _prepareEntries() {
    entries.clear();
    final infos = widget.bloodInfo ?? <BloodInfoStruct>[];
    final callType = widget.callType ?? 0;

    // Group for repeated day labels
    final Map<String, int> labelCount = {};
    for (final b in infos) {
      DateTime? dt;
      try {
        dt = DateTime.parse(b.time).toLocal();
      } catch (_) {}

      if (dt == null) continue;

      final now = DateTime.now();
      final isToday =
          dt.year == now.year && dt.month == now.month && dt.day == now.day;
      final displayLabel = isToday ? "Today" : DateFormat("d MMM").format(dt);

      // Make label unique per entry
      labelCount[displayLabel] = (labelCount[displayLabel] ?? 0) + 1;
      final uniqueLabel = '$displayLabel#${labelCount[displayLabel]! - 1}';

      // Determine values based on callType
      double value1 = 0;
      double value2 = 0;
      bool shouldInclude = false;

      if (callType == 0) {
        // Blood Pressure - only include if both systolic and diastolic are available and > 0
        if (b.systolic != null &&
            b.systolic > 0 &&
            b.diastolic != null &&
            b.diastolic > 0) {
          value1 = b.systolic.toDouble();
          value2 = b.diastolic.toDouble();
          shouldInclude = true;
        }
      } else if (callType == 1) {
        // Blood Oxygen (SPO2) - only include if spo2 exists, is not null, and > 0
        if (b.spo2 != null && b.spo2! > 0) {
          value1 = b.spo2!.toDouble();
          value2 = 0;
          shouldInclude = true;
        }
      } else if (callType == 2) {
        // Blood Sugar - only include if mg_dl or mmoi_l exists, is not null, and > 0
        if (b.mgDl != null && b.mgDl! > 0) {
          value1 = b.mgDl!.toDouble();
          value2 = 0;
          shouldInclude = true;
        } else if (b.mmoiL != null && b.mmoiL! > 0) {
          value1 = b.mmoiL!.toDouble();
          value2 = 0;
          shouldInclude = true;
        }
      }

      // Only add entry if data is available and valid
      if (shouldInclude) {
        entries.add(
          _ChartEntry(
            displayLabel: displayLabel,
            uniqueLabel: uniqueLabel,
            systolic: value1,
            diastolic: value2,
            struct: b,
            dateTime: dt,
          ),
        );
      }
    }

    // Sort by time ascending, and keep only the last 5 entries
    entries.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    if (entries.length > 5) {
      entries = entries.sublist(entries.length - 5);
    }
  }

  void _setDefaultSelected() {
    if (entries.isEmpty) return;

    final now = DateTime.now();
    final todayIndex = entries.lastIndexWhere((e) =>
        e.dateTime.year == now.year &&
        e.dateTime.month == now.month &&
        e.dateTime.day == now.day);

    selectedIndex = todayIndex != -1 ? todayIndex : entries.length - 1;

    // If only one entry, we know after padding it will appear at index 2
    if (entries.length == 1) {
      selectedIndex = 2;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _notifySelection();
      }
    });
  }

  void _sendResult(BloodInfoStruct selected) {
    final callType = widget.callType ?? 0;

    if (callType == 0) {
      final sys = selected.systolic;
      final dia = selected.diastolic;
      final bpRange = getCurrentGrade(sys, dia);
      final bpStatus = bpRange.gradeLabel;

      BloodInfoStruct result =
          BloodInfoStruct(systolic: sys, diastolic: dia, sugarState: bpStatus);
      widget.presssureInfo?.call(result);
    } else if (callType == 1) {
      final spo2 = selected.spo2 ?? 0;
      BloodInfoStruct result = BloodInfoStruct(
          spo2: spo2,
          sugarState:
              oxygenColorStatus(BloodInfoStruct(spo2: spo2), 0)?.sugarState);
      widget.presssureInfo?.call(result);
    } else if (callType == 2) {
      BloodInfoStruct result = BloodInfoStruct(
        mgDl: selected.mgDl,
        mmoiL: selected.mmoiL,
      );
      widget.presssureInfo?.call(result);
    }
  }

  void _notifySelection() {
    if (selectedIndex == null) return;

    BloodInfoStruct selectedStruct;

    // 🔹 Single record case
    if (entries.length == 1) {
      selectedStruct = entries.first.struct;
    }
    // 🔹 Multiple records case
    else {
      if (selectedIndex! < 0 || selectedIndex! >= entries.length) return;
      selectedStruct = entries[selectedIndex!].struct;
    }

    final callType = widget.callType ?? 0;

    if (callType == 0) {
      final sys = selectedStruct.systolic;
      final dia = selectedStruct.diastolic;
      final bpRange = getCurrentGrade(sys, dia);
      final bpStatus = bpRange.gradeLabel;

      BloodInfoStruct result = BloodInfoStruct(
        systolic: sys,
        diastolic: dia,
        sugarState: bpStatus,
      );

      widget.presssureInfo?.call(result);
    } else if (callType == 1) {
      final spo2 = selectedStruct.spo2 ?? 0;

      BloodInfoStruct result = BloodInfoStruct(
        spo2: spo2,
        sugarState: oxygenColorStatus(
          BloodInfoStruct(spo2: spo2),
          0,
        )?.sugarState,
      );

      widget.presssureInfo?.call(result);
    } else if (callType == 2) {
      BloodInfoStruct result = BloodInfoStruct(
        mgDl: selectedStruct.mgDl,
        mmoiL: selectedStruct.mmoiL,
      );

      widget.presssureInfo?.call(result);
    }
  }

  void _calculateYAxisBounds() {
    if (entries.isEmpty) {
      yMin = 0;
      yMax = 240;
      return;
    }

    final callType = widget.callType ?? 0;

    if (callType == 0) {
      // Blood Pressure: 0-240
      final allValues = [
        ...entries.map((e) => e.systolic),
        ...entries.map((e) => e.diastolic),
      ];
      yMin = allValues.reduce((a, b) => a < b ? a : b);
      yMax = allValues.reduce((a, b) => a > b ? a : b);

      // Add padding
      yMin = yMin - 10;
      yMax = yMax + 10;

      // Ensure minimum range
      if (yMax - yMin < 20) {
        yMax = yMin + 20;
      }

      // Clamp to valid range
      yMin = yMin.clamp(0.0, 230.0);
      yMax = yMax.clamp(yMin + 10, 240.0);
    } else if (callType == 1) {
      // Blood Oxygen (SPO2): 0-100
      final allValues = entries.map((e) => e.systolic).toList();
      yMin = allValues.reduce((a, b) => a < b ? a : b);
      yMax = allValues.reduce((a, b) => a > b ? a : b);

      // Add padding
      yMin = yMin - 5;
      yMax = yMax + 5;

      // Ensure minimum range
      if (yMax - yMin < 20) {
        yMax = yMin + 20;
      }

      // Clamp to valid range
      yMin = yMin.clamp(0.0, 90.0);
      yMax = yMax.clamp(yMin + 10, 100.0);
    } else if (callType == 2) {
      // Blood Sugar: 0-390
      final allValues = entries.map((e) => e.systolic).toList();
      yMin = allValues.reduce((a, b) => a < b ? a : b);
      yMax = allValues.reduce((a, b) => a > b ? a : b);

      // Add padding
      yMin = yMin - 20;
      yMax = yMax + 20;

      // Ensure minimum range
      if (yMax - yMin < 20) {
        yMax = yMin + 20;
      }

      // Clamp to valid range
      yMin = yMin.clamp(0.0, 370.0);
      yMax = yMax.clamp(yMin + 20, 390.0);
    }
  }

  double _getYAxisMinimum() {
    final callType = widget.callType ?? 0;
    if (callType == 0) return 0; // Blood Pressure
    if (callType == 1) return 0; // Blood Oxygen
    if (callType == 2) return 0; // Blood Sugar
    return 0;
  }

  double _getYAxisMaximum() {
    final callType = widget.callType ?? 0;
    if (callType == 0) return 240; // Blood Pressure
    if (callType == 1) return 100; // Blood Oxygen
    if (callType == 2) return 390; // Blood Sugar
    return 240;
  }

  double _getYAxisInterval() {
    final callType = widget.callType ?? 0;
    if (callType == 0) return 80; // Blood Pressure: 0, 80, 160, 240
    if (callType == 1) return 25; // Blood Oxygen: 0, 25, 50, 75, 100
    if (callType == 2) return 130; // Blood Sugar: 0, 130, 260, 390
    return 80;
  }

  @override
  Widget build(BuildContext context) {
    final callType = widget.callType ?? 0;

    // If no entries, show empty chart instead of "No data" text
    if (entries.isEmpty) {
      return SizedBox(
        height: 200,
        child: SfCartesianChart(
          plotAreaBorderWidth: 0,
          primaryXAxis: CategoryAxis(
            axisLine: const AxisLine(width: 0),
            majorGridLines: const MajorGridLines(width: 0),
          ),
          primaryYAxis: NumericAxis(
            minimum: _getYAxisMinimum(),
            maximum: _getYAxisMaximum(),
            interval: _getYAxisInterval(),
            axisLine: const AxisLine(width: 0),
            majorGridLines: MajorGridLines(
              dashArray: const [6, 4],
              color: Colors.grey.withOpacity(.3),
            ),
          ),
          series: <LineSeries<_ChartEntry, String>>[],
        ),
      );
    }

    // Create display entries with padding for single entry
    List<_ChartEntry> displayEntries = List.from(entries);

    // If only one entry, add invisible padding entries before and after
    if (displayEntries.length == 1) {
      final singleEntry = displayEntries[0];

      // Add 2 empty entries before
      displayEntries.insert(
          0,
          _ChartEntry(
            displayLabel: '',
            uniqueLabel: 'padding_before_2',
            systolic: 0,
            diastolic: 0,
            struct: singleEntry.struct,
            dateTime: singleEntry.dateTime.subtract(Duration(days: 2)),
            isPadding: true,
          ));
      displayEntries.insert(
          0,
          _ChartEntry(
            displayLabel: '',
            uniqueLabel: 'padding_before_1',
            systolic: 0,
            diastolic: 0,
            struct: singleEntry.struct,
            dateTime: singleEntry.dateTime.subtract(Duration(days: 1)),
            isPadding: true,
          ));

      // Add 2 empty entries after
      displayEntries.add(_ChartEntry(
        displayLabel: '',
        uniqueLabel: 'padding_after_1',
        systolic: 0,
        diastolic: 0,
        struct: singleEntry.struct,
        dateTime: singleEntry.dateTime.add(Duration(days: 1)),
        isPadding: true,
      ));
      displayEntries.add(_ChartEntry(
        displayLabel: '',
        uniqueLabel: 'padding_after_2',
        systolic: 0,
        diastolic: 0,
        struct: singleEntry.struct,
        dateTime: singleEntry.dateTime.add(Duration(days: 2)),
        isPadding: true,
      ));

      // Update selectedIndex to point to the actual entry (now at index 2)
      // if (selectedIndex != null) {
      //   selectedIndex = 2;
      // }
    }

    final List<_ChartDot> dots = [];

    for (int i = 0; i < displayEntries.length; i++) {
      final e = displayEntries[i];
      dots.add(_ChartDot(i, e.uniqueLabel, e.systolic, true, e.struct));

      // Add diastolic only for blood pressure (callType == 0)
      if (callType == 0) {
        dots.add(_ChartDot(i, e.uniqueLabel, e.diastolic, false, e.struct));
      }
    }

    return SizedBox(
      height: 200,
      child: SfCartesianChart(
        plotAreaBorderWidth: 0,
        onAxisLabelTapped: (AxisLabelTapArgs args) {
          final tappedLabel = args.value.toString();
          final foundIdx =
              displayEntries.indexWhere((e) => e.uniqueLabel == tappedLabel);

          // Don't select padding entries
          if (foundIdx != -1 && !displayEntries[foundIdx].isPadding) {
            setState(() {
              selectedIndex = foundIdx;
            });
            _notifySelection();
          }
        },
        primaryXAxis: CategoryAxis(
          axisLine: const AxisLine(width: 0),
          majorGridLines: const MajorGridLines(width: 0),
          labelsExtent: 30,
          labelRotation: 0,
          axisLabelFormatter: (AxisLabelRenderDetails details) {
            final e = displayEntries.firstWhere(
                (e) => e.uniqueLabel == details.text,
                orElse: () => displayEntries[0]);
            return ChartAxisLabel(e.displayLabel, null);
          },
          plotBands: displayEntries.asMap().entries.map((entry) {
            final index = entry.key;
            final isSelected = index == selectedIndex;

            return PlotBand(
              start: index - 0.5,
              end: index + 0.5,
              color: isSelected
                  ? (widget.colorCircle ?? Colors.blue).withOpacity(0.2)
                  : Colors.transparent,
            );
          }).toList(),
        ),
        primaryYAxis: NumericAxis(
          minimum: _getYAxisMinimum(),
          maximum: _getYAxisMaximum(),
          interval: _getYAxisInterval(),
          axisLine: const AxisLine(width: 0),
          majorGridLines: MajorGridLines(
            dashArray: const [6, 4],
            color: Colors.grey.withOpacity(.3),
          ),
        ),
        series: _buildSeriesWithPadding(callType, displayEntries),
        tooltipBehavior: TooltipBehavior(
          enable: false,
          format: 'point.x : point.y',
        ),
      ),
    );
  }

  List<LineSeries<_ChartEntry, String>> _buildSeriesWithPadding(
      int callType, List<_ChartEntry> displayEntries) {
    if (callType == 0) {
      // Blood Pressure - Show both systolic and diastolic
      return [
        // Systolic Line
        LineSeries<_ChartEntry, String>(
          dataSource: displayEntries,
          xValueMapper: (e, i) => e.uniqueLabel,
          yValueMapper: (e, _) => e.isPadding ? null : e.systolic,
          color: Colors.grey.shade300,
          width: 1,
          onPointTap: (ChartPointDetails pointInteractionDetails) {
            final tappedIndex = pointInteractionDetails.pointIndex;
            if (tappedIndex != null &&
                tappedIndex >= 0 &&
                tappedIndex < displayEntries.length &&
                !displayEntries[tappedIndex].isPadding) {
              setState(() {
                selectedIndex = tappedIndex;
              });
              _notifySelection();
            }
          },
          markerSettings: MarkerSettings(
            isVisible: true,
            width: 10,
            height: 10,
            color: widget.colorCircle,
            borderColor: Colors.grey.shade300,
            borderWidth: 2,
            shape: DataMarkerType.circle,
          ),
        ),
        // Diastolic Line
        LineSeries<_ChartEntry, String>(
          dataSource: displayEntries,
          xValueMapper: (e, i) => e.uniqueLabel,
          yValueMapper: (e, _) => e.isPadding ? null : e.diastolic,
          color: Colors.grey.shade300,
          width: 1,
          onPointTap: (ChartPointDetails pointInteractionDetails) {
            final tappedIndex = pointInteractionDetails.pointIndex;
            if (tappedIndex != null &&
                tappedIndex >= 0 &&
                tappedIndex < displayEntries.length &&
                !displayEntries[tappedIndex].isPadding) {
              setState(() {
                selectedIndex = tappedIndex;
              });
              _notifySelection();
            }
          },
          markerSettings: MarkerSettings(
            isVisible: true,
            width: 10,
            height: 10,
            color: widget.colorCircle,
            borderColor: Colors.grey.shade200,
            borderWidth: 2,
            shape: DataMarkerType.circle,
          ),
        ),
      ];
    } else {
      // Blood Oxygen or Blood Sugar - Show only one line
      return [
        LineSeries<_ChartEntry, String>(
          dataSource: displayEntries,
          xValueMapper: (e, i) => e.uniqueLabel,
          yValueMapper: (e, _) => e.isPadding ? null : e.systolic,
          color: Colors.grey.shade300,
          width: 1,
          onPointTap: (ChartPointDetails pointInteractionDetails) {
            final tappedIndex = pointInteractionDetails.pointIndex;
            if (tappedIndex != null &&
                tappedIndex >= 0 &&
                tappedIndex < displayEntries.length &&
                !displayEntries[tappedIndex].isPadding) {
              setState(() {
                selectedIndex = tappedIndex;
              });
              _notifySelection();
            }
          },
          markerSettings: MarkerSettings(
            isVisible: true,
            width: 10,
            height: 10,
            color: widget.colorCircle ?? Colors.blue,
            borderColor: Colors.grey.shade300,
            borderWidth: 2,
            shape: DataMarkerType.circle,
          ),
        ),
      ];
    }
  }
}

class _ChartEntry {
  final String displayLabel; // "Today", "27 Jan", etc.
  final String uniqueLabel; // "Today#0", "Today#1", etc.
  final double systolic; // Also used for SPO2 and Blood Sugar values
  final double diastolic; // Only used for Blood Pressure
  final BloodInfoStruct struct;
  final DateTime dateTime;
  final bool isPadding; // Flag to identify padding entries

  _ChartEntry({
    required this.displayLabel,
    required this.uniqueLabel,
    required this.systolic,
    required this.diastolic,
    required this.struct,
    required this.dateTime,
    this.isPadding = false,
  });
}

class _ChartDot {
  final int entryIndex;
  final String uniqueLabel;
  final double value;
  final bool isSystolic;
  final BloodInfoStruct struct;

  _ChartDot(this.entryIndex, this.uniqueLabel, this.value, this.isSystolic,
      this.struct);
}
