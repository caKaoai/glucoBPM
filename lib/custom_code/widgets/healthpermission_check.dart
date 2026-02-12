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

import 'dart:io';
import 'package:app_settings/app_settings.dart';
import 'package:health/health.dart';
import 'package:provider/provider.dart';

class HealthpermissionCheck extends StatefulWidget {
  const HealthpermissionCheck({
    super.key,
    this.width,
    this.height,
  });

  final double? width;
  final double? height;

  @override
  State<HealthpermissionCheck> createState() => _HealthpermissionCheckState();
}

class _HealthpermissionCheckState extends State<HealthpermissionCheck>
    with WidgetsBindingObserver {
  final Health _health = Health();

  final Map<HealthDataType, bool> _permissions = {
    HealthDataType.ACTIVE_ENERGY_BURNED: false,
    HealthDataType.BLOOD_GLUCOSE: false,
    HealthDataType.BLOOD_OXYGEN: false,
    HealthDataType.BLOOD_PRESSURE_SYSTOLIC: false,
    HealthDataType.BLOOD_PRESSURE_DIASTOLIC: false,
    HealthDataType.BODY_TEMPERATURE: false,
    HealthDataType.HEART_RATE: false,
    HealthDataType.BASAL_ENERGY_BURNED: false,
    HealthDataType.STEPS: false,
    if (Platform.isIOS) HealthDataType.DISTANCE_WALKING_RUNNING: false,
    if (Platform.isAndroid) HealthDataType.DISTANCE_DELTA: false,
  };

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _checkAllPermissions();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _checkAllPermissions();
    }
  }

  // ----------------------------------------------------------
  // CORRECT PERMISSION CHECK FLOW
  // ----------------------------------------------------------
  Future<void> _checkAllPermissions() async {
    try {
      final types = _permissions.keys.toList();

      // 🔥 STEP 1 — Request ALL permissions together
      await _health.requestAuthorization(
        types,
        permissions: List.filled(types.length, HealthDataAccess.READ),
      );

      // 🔥 STEP 2 — Validate each permission
      for (final type in types) {
        bool granted = false;

        try {
          if (Platform.isAndroid) {
            // Android → direct permission check
            granted = await _health.hasPermissions([type]) ?? false;
          } else {
            // iOS → validate by reading data
            final data = await _health.getHealthDataFromTypes(
              types: [type],
              startTime: DateTime.now().subtract(const Duration(days: 7)),
              endTime: DateTime.now(),
            );

            granted = data.isNotEmpty;
          }
        } catch (e) {
          granted = false;
        }

        _permissions[type] = granted;
      }
    } catch (e) {
      debugPrint("❌ Permission check error: $e");
    }

    _updateAppState();
  }

  // ----------------------------------------------------------
  // UPDATE FFAppState
  // ----------------------------------------------------------
  void _updateAppState() {
    FFAppState().update(() {
      FFAppState().HealthPermission = createHealthStruct(
        energy: _permissions[HealthDataType.ACTIVE_ENERGY_BURNED] ?? false,
        glucose: _permissions[HealthDataType.BLOOD_GLUCOSE] ?? false,
        oxygen: _permissions[HealthDataType.BLOOD_OXYGEN] ?? false,
        pressure: (_permissions[HealthDataType.BLOOD_PRESSURE_SYSTOLIC] ??
                false) &&
            (_permissions[HealthDataType.BLOOD_PRESSURE_DIASTOLIC] ?? false),
        temperature: _permissions[HealthDataType.BODY_TEMPERATURE] ?? false,
        heartRate: _permissions[HealthDataType.HEART_RATE] ?? false,
        restingEnergy:
            _permissions[HealthDataType.BASAL_ENERGY_BURNED] ?? false,
        steps: _permissions[HealthDataType.STEPS] ?? false,
        distance: Platform.isIOS
            ? (_permissions[HealthDataType.DISTANCE_WALKING_RUNNING] ?? false)
            : (_permissions[HealthDataType.DISTANCE_DELTA] ?? false),
      );
    });

    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    return const SizedBox.shrink();
  }
}
