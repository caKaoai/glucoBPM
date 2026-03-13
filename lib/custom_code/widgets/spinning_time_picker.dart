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

import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class SpinningTimePicker extends StatefulWidget {
  const SpinningTimePicker({
    super.key,
    this.width,
    this.height,
    this.selectedDay,
    this.returnVal,
  });

  final double? width;
  final double? height;
  final int? selectedDay;
  final Future Function(dynamic dateTime)? returnVal;

  @override
  State<SpinningTimePicker> createState() => _SpinningTimePickerState();
}

class _SpinningTimePickerState extends State<SpinningTimePicker> {
  int selectedHour = 1;
  int selectedMinute = 0;
  int selectedPeriod = 0; // 0 AM 1 PM

  late FixedExtentScrollController hourCtrl;
  late FixedExtentScrollController minuteCtrl;
  late FixedExtentScrollController periodCtrl;

  @override
  void initState() {
    super.initState();

    DateTime now = DateTime.now();

    int hour = now.hour;
    int minute = now.minute;

    int hour12 = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    int period = hour >= 12 ? 1 : 0;

    selectedHour = hour12;
    selectedMinute = minute;
    selectedPeriod = period;

    hourCtrl = FixedExtentScrollController(initialItem: hour12 - 1);
    minuteCtrl = FixedExtentScrollController(initialItem: minute);
    periodCtrl = FixedExtentScrollController(initialItem: period);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      confirmTime();
    });
  }

  DateTime getSelectedDateTimeInUTC() {
    DateTime baseDate =
        DateTime.now().subtract(Duration(days: widget.selectedDay ?? 0));

    int hour24 = selectedHour;

    if (selectedPeriod == 1 && selectedHour != 12) {
      hour24 = selectedHour + 12;
    } else if (selectedPeriod == 0 && selectedHour == 12) {
      hour24 = 0;
    }

    DateTime localDateTime = DateTime(
      baseDate.year,
      baseDate.month,
      baseDate.day,
      hour24,
      selectedMinute,
    );

    return localDateTime.toUtc();
  }

  void confirmTime() {
    if (widget.returnVal != null) {
      DateTime utcDateTime = getSelectedDateTimeInUTC();
      DateTime localDateTime = utcDateTime.toLocal();

      String title;
      String formattedDate;

      if (widget.selectedDay == 0) {
        title = "Today";
        formattedDate = "Today";
      } else if (widget.selectedDay == 1) {
        title = "Yesterday";
        formattedDate = "Yesterday";
      } else {
        const months = [
          'Jan',
          'Feb',
          'Mar',
          'Apr',
          'May',
          'Jun',
          'Jul',
          'Aug',
          'Sep',
          'Oct',
          'Nov',
          'Dec'
        ];

        String month = months[localDateTime.month - 1];
        formattedDate = "$month ${localDateTime.day}";
        title = formattedDate;
      }

      String time = _formatLocalTime(localDateTime);

      widget.returnVal!({
        "title": title,
        "time": utcDateTime,
        "format_time": "$formattedDate, $time",
      });
    }
  }

  String _formatLocalTime(DateTime dateTime) {
    int hour = dateTime.hour;
    String period = hour >= 12 ? 'PM' : 'AM';

    if (hour > 12) hour -= 12;
    if (hour == 0) hour = 12;

    String minute = dateTime.minute.toString().padLeft(2, '0');

    return "$hour:$minute $period";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ?? 280,
      height: widget.height ?? 220,
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          /// CENTER SELECTION CARD
          Positioned(
            child: Container(
              height: 56,
              margin: const EdgeInsets.symmetric(horizontal: 18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Color(0xFFF1F5F9)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 2,
                    offset: const Offset(0, 3),
                  )
                ],
              ),
            ),
          ),

          /// PICKERS
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// HOUR
              SizedBox(
                width: 70,
                child: ListWheelScrollView.useDelegate(
                  controller: hourCtrl,
                  itemExtent: 60,
                  physics: const FixedExtentScrollPhysics(),
                  perspective: 0.001,
                  // removes 3D wheel effect
                  diameterRatio: 1000,
                  // makes it look flat
                  onSelectedItemChanged: (i) {
                    setState(() {
                      selectedHour = i + 1;
                    });
                    confirmTime();
                  },
                  childDelegate: ListWheelChildBuilderDelegate(
                    builder: (context, i) {
                      if (i < 0 || i >= 12) return null;

                      return Center(
                        child: Text(
                          "${i + 1}",
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .bodyMediumFamily,
                                color: selectedHour == i + 1
                                    ? FlutterFlowTheme.of(context).primaryText
                                    : FlutterFlowTheme.of(context).text1,
                                fontSize: selectedHour == i + 1 ? 24 : 18,
                                fontWeight: selectedHour == i + 1
                                    ? FontWeight.w700
                                    : FontWeight.w500,
                                letterSpacing: 0,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .bodyMediumIsCustom,
                              ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              /// COLON
              Text(
                ":",
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: FlutterFlowTheme.of(context).primaryText,
                      letterSpacing: 0,
                      useGoogleFonts:
                          !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                    ),
              ),

              /// MINUTE
              SizedBox(
                width: 70,
                child: ListWheelScrollView.useDelegate(
                  controller: minuteCtrl,
                  itemExtent: 60,
                  physics: const FixedExtentScrollPhysics(),
                  perspective: 0.001, // remove wheel curve
                  diameterRatio: 1000, // flat scroll
                  onSelectedItemChanged: (i) {
                    setState(() {
                      selectedMinute = i;
                    });
                    confirmTime();
                  },
                  childDelegate: ListWheelChildBuilderDelegate(
                    builder: (context, i) {
                      if (i < 0 || i >= 60) return null;

                      return Center(
                        child: Text(
                          i.toString().padLeft(2, '0'),
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .bodyMediumFamily,
                                fontSize: selectedMinute == i ? 24 : 18,
                                fontWeight: selectedMinute == i
                                    ? FontWeight.w700
                                    : FontWeight.w500,
                                color: selectedMinute == i
                                    ? FlutterFlowTheme.of(context).primaryText
                                    : FlutterFlowTheme.of(context).text1,
                                letterSpacing: 0,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .bodyMediumIsCustom,
                              ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(width: 8),

              /// AM PM
              SizedBox(
                width: 70,
                child: CupertinoPicker(
                  scrollController: periodCtrl,
                  itemExtent: 48,
                  magnification: 1.1,
                  useMagnifier: true,
                  selectionOverlay: const SizedBox(),
                  onSelectedItemChanged: (i) {
                    setState(() {
                      selectedPeriod = i;
                    });
                    confirmTime();
                  },
                  children: [
                    Center(
                      child: Text(
                        "AM",
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).bodyMediumFamily,
                              fontSize: selectedPeriod == 0 ? 20 : 18,
                              fontWeight: selectedPeriod == 0
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                              color: selectedPeriod == 0
                                  ? FlutterFlowTheme.of(context).primary
                                  : const Color(0xFFCBD5E1),
                              letterSpacing: 0,
                              useGoogleFonts: !FlutterFlowTheme.of(context)
                                  .bodyMediumIsCustom,
                            ),
                      ),
                    ),
                    Center(
                      child: Text(
                        "PM",
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).bodyMediumFamily,
                              fontSize: selectedPeriod == 1 ? 20 : 18,
                              fontWeight: selectedPeriod == 1
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                              color: selectedPeriod == 1
                                  ? FlutterFlowTheme.of(context).primary
                                  : const Color(0xFFCBD5E1),
                              letterSpacing: 0,
                              useGoogleFonts: !FlutterFlowTheme.of(context)
                                  .bodyMediumIsCustom,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
