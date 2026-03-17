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

class _HealthpermissionCheckState extends State<HealthpermissionCheck> {
  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    if (Platform.isAndroid) {
      debugPrint('📲 Starting Android permission check');
      final service = HealthPermissionServiceAndroid();
      final result = await service.handlePermissions();
      debugPrint('📲 Android permission result: $result');
      _updateAppState(service.permissionMap);
    } else {
      debugPrint('📲 Starting iOS permission check');
      final service = HealthPermissionServiceiOS(context);
      final result = await service.handlePermissions();
      debugPrint('📲 iOS permission result: $result');
      _updateAppState(service.permissionMap);
    }
  }

// ----------------------------------------------------------
// UPDATE FFAppState
// ----------------------------------------------------------
  void _updateAppState(Map<HealthDataType, bool> map) {
    FFAppState().update(() {
      FFAppState().HealthPermission = createHealthStruct(
        energy: map[HealthDataType.ACTIVE_ENERGY_BURNED] ?? false,
        glucose: map[HealthDataType.BLOOD_GLUCOSE] ?? false,
        oxygen: map[HealthDataType.BLOOD_OXYGEN] ?? false,
        pressure: (map[HealthDataType.BLOOD_PRESSURE_SYSTOLIC] ?? false) &&
            (map[HealthDataType.BLOOD_PRESSURE_DIASTOLIC] ?? false),
        // temperature: map[HealthDataType.BODY_TEMPERATURE] ?? false,
        heartRate: map[HealthDataType.HEART_RATE] ?? false,
        restingEnergy: map[HealthDataType.BASAL_ENERGY_BURNED] ?? false,
        steps: map[HealthDataType.STEPS] ?? false,
        distance: Platform.isIOS
            ? (map[HealthDataType.DISTANCE_WALKING_RUNNING] ?? false)
            : (map[HealthDataType.DISTANCE_DELTA] ?? false),
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

// ----------------------------------------------------------
// ANDROID SERVICE
// ----------------------------------------------------------
class HealthPermissionServiceAndroid with WidgetsBindingObserver {
  final Health _health = Health();
  Completer<bool>? _completer;

  final Map<HealthDataType, bool> permissionMap = {};

  List<HealthDataType> get _types => [
        HealthDataType.STEPS,
        HealthDataType.ACTIVE_ENERGY_BURNED,
        HealthDataType.TOTAL_CALORIES_BURNED,
        HealthDataType.BLOOD_GLUCOSE,
        HealthDataType.BLOOD_OXYGEN,
        HealthDataType.BLOOD_PRESSURE_SYSTOLIC,
        HealthDataType.BLOOD_PRESSURE_DIASTOLIC,
        HealthDataType.HEART_RATE,
        HealthDataType.BASAL_ENERGY_BURNED,
        HealthDataType.DISTANCE_DELTA,
      ];

  List<HealthDataAccess> get _access =>
      List.filled(_types.length, HealthDataAccess.READ);

  // ✅ CORE PERMISSION CHECK
  bool _isCorePermissionGranted() {
    return (permissionMap[HealthDataType.STEPS] ?? false) ||
        (permissionMap[HealthDataType.HEART_RATE] ?? false) ||
        (permissionMap[HealthDataType.BLOOD_GLUCOSE] ?? false) ||
        (permissionMap[HealthDataType.BLOOD_PRESSURE_SYSTOLIC] ?? false);
  }

  // ✅ CHECK PERMISSIONS
  Future<bool> _checkPermissions() async {
    for (final type in _types) {
      try {
        final granted = await _health.hasPermissions(
              [type],
              permissions: [HealthDataAccess.READ],
            ) ??
            false;

        permissionMap[type] = granted;
      } catch (e) {
        permissionMap[type] = false;
      }
    }

    debugPrint('📋 permissionMap: $permissionMap');

    return _isCorePermissionGranted();
  }

  // ✅ REQUEST
  Future<void> _requestPermissions() async {
    try {
      await _health.requestAuthorization(
        _types,
        permissions: _access,
      );
    } catch (e) {
      debugPrint("❌ request error: $e");
    }
  }

  // ✅ SETTINGS
  Future<void> _openSettings() async {
    try {
      await AppSettings.openAppSettings(
        type: AppSettingsType.settings,
      );
    } catch (e) {
      debugPrint('❌ settings error: $e');
    }
  }

  // ✅ MAIN FLOW
  Future<bool> handlePermissions() async {
    debugPrint('▶️ Android permission flow start');

    bool granted = await _checkPermissions();
    if (granted) return true;

    await _requestPermissions();

    granted = await _checkPermissions();
    if (granted) return true;

    // 🚨 ONLY open settings if NOTHING useful granted
    if (!_isCorePermissionGranted()) {
      _completer = Completer<bool>();
      WidgetsBinding.instance.addObserver(this);

      await _openSettings();

      return _completer!.future;
    }

    // ✅ PARTIAL permission → allow app
    return true;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed && _completer != null) {
      WidgetsBinding.instance.removeObserver(this);

      final granted = await _checkPermissions();
      _completer!.complete(granted);
      _completer = null;
    }
  }
}

// ----------------------------------------------------------
// iOS SERVICE
// ----------------------------------------------------------
class HealthPermissionServiceiOS with WidgetsBindingObserver {
  final Health _health = Health();
  Completer<bool>? _completer;
  final BuildContext context;

  HealthPermissionServiceiOS(this.context);

  // ✅ All permission types for iOS
  List<HealthDataType> get _types => [
        HealthDataType.STEPS,
        HealthDataType.ACTIVE_ENERGY_BURNED,
        HealthDataType.BASAL_ENERGY_BURNED,
        HealthDataType.BLOOD_GLUCOSE,
        HealthDataType.BLOOD_OXYGEN,
        HealthDataType.BLOOD_PRESSURE_SYSTOLIC,
        HealthDataType.BLOOD_PRESSURE_DIASTOLIC,
        // HealthDataType.BODY_TEMPERATURE,
        HealthDataType.HEART_RATE,
        HealthDataType.DISTANCE_WALKING_RUNNING,
      ];

  List<HealthDataAccess> get _access =>
      List.filled(_types.length, HealthDataAccess.READ);

  // Track individual permission status
  final Map<HealthDataType, bool> permissionMap = {};

  // ✅ iOS: Apple hides READ permission status
  // Strategy: attempt read per type → data found = granted
  // STEPS uses 365 days, others use 180 days
  Future<bool> _checkPermissionsByReading({bool requestFirst = true}) async {
    try {
      if (requestFirst) {
        final ok = await _health.requestAuthorization(
          _types,
          permissions: _access,
        );
        debugPrint('📡 requestAuthorization result: $ok');
      }

      bool allGranted = true;
      final now = DateTime.now();

      for (final type in _types) {
        try {
          // ✅ STEPS → 365 days | all others → 180 days
          final duration = type == HealthDataType.STEPS
              ? const Duration(days: 365)
              : const Duration(days: 180);

          final data = await _health.getHealthDataFromTypes(
            types: [type],
            startTime: now.subtract(duration),
            endTime: now,
          );

          permissionMap[type] = data.isNotEmpty;
          if (data.isEmpty) allGranted = false;

          debugPrint(
            '📊 $type → ${data.length} records → ${data.isNotEmpty ? "✅ granted" : "❌ denied/no data"}',
          );
        } catch (e) {
          debugPrint('❌ Read failed for $type: $e');
          permissionMap[type] = false;
          allGranted = false;
        }
      }

      return allGranted;
    } catch (e) {
      debugPrint('❌ _checkPermissionsByReading error: $e');
      return false;
    }
  }

  // ✅ iOS → opens app's Health permission page directly
  Future<void> _openSettings() async {
    try {
      debugPrint('⚙️ Opening iOS Health settings...');
      await AppSettings.openAppSettings(type: AppSettingsType.generalSettings);
    } catch (e) {
      debugPrint('❌ Failed to open iOS settings: $e');
    }
  }

  Future<bool> handlePermissions() async {
    debugPrint('▶️ iOS handlePermissions started');

    // STEP 1 — Request + check via reading
    bool granted = await _checkPermissionsByReading(requestFirst: true);
    debugPrint('▶️ Initial status: $granted');

    if (granted) return true;

    // STEP 2 — Still denied → open Settings and wait for resume
    debugPrint('🚫 Not granted → opening iOS Health settings');
    _completer = Completer<bool>();
    WidgetsBinding.instance.addObserver(this);
    await _openSettings();
    return _completer!.future;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed && _completer != null) {
      debugPrint('🔄 App resumed — re-checking iOS permissions via read');
      WidgetsBinding.instance.removeObserver(this);

      // Skip requestAuthorization on resume — just re-read
      final granted = await _checkPermissionsByReading(requestFirst: false);
      debugPrint('🔄 Status after resume: $granted');
      _completer!.complete(granted);
      _completer = null;
    }
  }
}
