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

import 'package:mobile_device_identifier/mobile_device_identifier.dart';

Future deviceToken() async {
  // Add your function code here!

  try {
    final deviceId = await MobileDeviceIdentifier().getDeviceId();
    if (FFAppState().userData != null) {
      FFAppState().updateUserDataStruct(
        (e) => e..emi = (deviceId!.isNotEmpty ? deviceId : null)!,
      );
    }
    {
      FFAppState().userData = UserStruct(
        emi: deviceId,
      );
    }

    return deviceId;
  } catch (e) {
    print('Error getting device token: $e');
    return null;
  }
}
