// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:io';
import 'package:health/health.dart';

Future<List<HealthInfoStruct>> fetchInfo() async {
  // Add your function code here!
  final health = Health();
  final now = DateTime.now();

  // 31 days: from 30 days ago to today
  final startDate =
      DateTime(now.year, now.month, now.day).subtract(const Duration(days: 30));
  const int daysToFetch = 31;

  debugPrint(
    '📅 Fetching 31 days: ${DateFormat('yyyy-MM-dd').format(startDate)} to ${DateFormat('yyyy-MM-dd').format(now)}',
  );

  final rawData = await _fetchRange(
    health,
    startDate,
    daysToFetch,
  );

  final summary = <HealthInfoStruct>[];

  for (final item in rawData) {
    final date = DateTime.parse(item['date'] as String).toLocal();
    final rangeStr =
        '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';

    summary.add(
      createHealthInfoStruct(
        date: rangeStr,
        steps: (item['steps'] as int?) ?? 0,
        activeEnergy: (item['activeEnergy'] as int?) ?? 0,
        restingEnergy: (item['restingEnergy'] as int?) ?? 0,
        distance: (item['distance'] as double?) ?? 0.0,
      ),
    );
  }

  return summary;
}

// Fetch a range of health data for N days, using full-day intervals
Future<List<Map<String, dynamic>>> _fetchRange(
  Health health,
  DateTime startDate,
  int daysToFetch,
) async {
  final entries = <Map<String, dynamic>>[];

  for (int i = 0; i < daysToFetch; i++) {
    final dayStart = DateTime(startDate.year, startDate.month, startDate.day)
        .add(Duration(days: i));
    final dayEnd = dayStart.add(const Duration(days: 1));

    debugPrint('📆 [$i] Fetching $dayStart → $dayEnd');

    // STEPS
    int steps = 0;
    try {
      steps = await health.getTotalStepsInInterval(dayStart, dayEnd) ?? 0;
    } catch (e, s) {
      debugPrint("❌ getTotalStepsInInterval error: $e\n$s");
    }

    // DISTANCE
    double distance = 0.0;
    try {
      final distTypes = Platform.isIOS
          ? [HealthDataType.DISTANCE_WALKING_RUNNING]
          : [HealthDataType.DISTANCE_DELTA];

      final distData = await health.getHealthDataFromTypes(
        types: distTypes,
        startTime: dayStart,
        endTime: dayEnd,
      );

      for (final p in _dedup(distData)) {
        distance += _toDouble(p.value);
      }
      distance /= 1000; // meters → km
    } catch (e, s) {
      debugPrint("❌ Distance error: $e\n$s");
    }

    // ACTIVE ENERGY
    double activeEnergy = 0.0;
    try {
      final calTypes = Platform.isIOS
          ? [HealthDataType.ACTIVE_ENERGY_BURNED]
          : [HealthDataType.TOTAL_CALORIES_BURNED];

      final calData = await health.getHealthDataFromTypes(
        types: calTypes,
        startTime: dayStart,
        endTime: dayEnd,
      );

      for (final p in _dedup(calData)) {
        activeEnergy += _toDouble(p.value);
      }
    } catch (e, s) {
      debugPrint("❌ Active energy error: $e\n$s");
    }

    // RESTING ENERGY
    double restingEnergy = 0.0;
    try {
      final restData = await health.getHealthDataFromTypes(
        types: [HealthDataType.BASAL_ENERGY_BURNED],
        startTime: dayStart,
        endTime: dayEnd,
      );

      for (final p in _dedup(restData)) {
        restingEnergy += _toDouble(p.value);
      }
    } catch (e, s) {
      debugPrint("❌ Resting energy error: $e\n$s");
    }

    final dateStr =
        '${dayStart.year}-${dayStart.month.toString().padLeft(2, '0')}-${dayStart.day.toString().padLeft(2, '0')}';

    debugPrint(
        '📊 $dateStr: steps=$steps, dist=${distance.toStringAsFixed(2)}, active=$activeEnergy, resting=$restingEnergy');

    // Skip empty days
    final bool isAllZero = steps == 0 &&
        distance == 0.0 &&
        activeEnergy.round() == 0 &&
        restingEnergy.round() == 0;

    if (isAllZero) {
      debugPrint('⏭️ Skipping empty health day: $dateStr');
      continue;
    }

    entries.add({
      'date': dateStr,
      'steps': steps,
      'distance': double.parse(distance.toStringAsFixed(2)),
      'activeEnergy': activeEnergy.round(),
      'restingEnergy': restingEnergy.round(),
    });
  }

  return entries;
}

List<HealthDataPoint> _dedup(List<HealthDataPoint> points) {
  final seen = <String>{};
  final result = <HealthDataPoint>[];

  for (final p in points) {
    final key = '${p.type}-${p.dateFrom}-${p.dateTo}';
    if (!seen.contains(key)) {
      seen.add(key);
      result.add(p);
    }
  }
  return result;
}

double _toDouble(dynamic v) {
  if (v == null) return 0.0;
  if (v is num) return v.toDouble();
  if (v is NumericHealthValue) return v.numericValue.toDouble();
  return 0.0;
}
