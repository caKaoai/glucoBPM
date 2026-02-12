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

import 'package:permission_handler/permission_handler.dart';

import 'package:app_settings/app_settings.dart';
import 'dart:io';

import 'package:health/health.dart';

Future redirectSetting(int callType) async {
  // Add your function code here!

  if (callType == 0) {
    await openAppSettings();
    return;
  }
  final health = Health();

  final types = [
    HealthDataType.ACTIVE_ENERGY_BURNED,
    HealthDataType.BLOOD_GLUCOSE,
    HealthDataType.BLOOD_OXYGEN,
    HealthDataType.BLOOD_PRESSURE_SYSTOLIC,
    HealthDataType.BLOOD_PRESSURE_DIASTOLIC,
    HealthDataType.BODY_TEMPERATURE,
    HealthDataType.HEART_RATE,
    HealthDataType.BASAL_ENERGY_BURNED,
    HealthDataType.STEPS,
    if (Platform.isIOS) HealthDataType.DISTANCE_WALKING_RUNNING,
    if (Platform.isAndroid) HealthDataType.DISTANCE_DELTA,
  ];

  try {
    // 🔹 Step 1: Silent check
    bool hasPermission = await health.hasPermissions(types) ?? false;

    if (hasPermission) {
      print("Health permission already granted");
      return;
    }

    // 🔹 Step 2: Request permission
    bool granted = await health.requestAuthorization(types);

    if (granted) {
      print("Health permission granted after request");
      return;
    }

    // 🔹 Step 3: If still not granted → Open settings
    print("Permission denied. Redirecting to settings...");
    await AppSettings.openAppSettings(
      type: AppSettingsType.settings,
    );
  } catch (e) {
    print("Health permission error: $e");

    await AppSettings.openAppSettings(
      type: AppSettingsType.settings,
    );
  }
}
