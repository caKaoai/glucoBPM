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

import 'package:ip_country_lookup/ip_country_lookup.dart';
import 'package:ip_country_lookup/models/ip_country_data_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String?> getUserCountryFromIP() async {
  // Add your function code here!
  IpCountryData? countryData;
  try {
    countryData = await IpCountryLookup().getIpLocationData();
    FFAppState().countryCode = countryData.country_code!;
    FFAppState().updateUserDataStruct(
      (e) => e..ipAddress = countryData?.ip!,
    );
    return countryData
        .country_code; // Use `result.countryName` for full country name
  } catch (e) {
    print('Error getting country from IP: $e');
    return null;
  }
}
