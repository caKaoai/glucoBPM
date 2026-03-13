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

import 'package:google_fonts/google_fonts.dart';
import 'package:toastification/toastification.dart';

Future customTostNotification(
  BuildContext context,
  String? message,
  Color? msgColor,
  int? toastType,
) async {
  // Add your function code here!
  ToastificationType type;
  IconData icon;

  switch (toastType) {
    case 0: // success
      type = ToastificationType.success;
      icon = Icons.check_circle;
      break;
    case 1: // error
      type = ToastificationType.error;
      icon = Icons.error_outline;
      break;
    case 2: // info
      type = ToastificationType.info;
      icon = Icons.info;
      break;
    case 3: // warning
      type = ToastificationType.warning;
      icon = Icons.warning;
      break;
    default:
      type = ToastificationType.info;
      icon = Icons.info_outline;
  }

  toastification.show(
    context: context,
    title: Text(
      message!.isNotEmpty ? message : "",
      style: FlutterFlowTheme.of(context).titleSmall.override(
            font: GoogleFonts.manrope(
              fontWeight: FontWeight.w500,
              fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
            ),
            color: FlutterFlowTheme.of(context).primaryText,
            fontSize: 12.0,
            letterSpacing: 0.0,
            fontWeight: FontWeight.normal,
            fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
          ),
    ),
    icon: Icon(icon, color: msgColor!),
    type: type,
    style: ToastificationStyle.minimal,
    alignment: Alignment.bottomCenter,
    autoCloseDuration: const Duration(seconds: 3),
    borderRadius: BorderRadius.circular(6),
    showProgressBar: false,
    closeButtonShowType: CloseButtonShowType.always,
  );
}
