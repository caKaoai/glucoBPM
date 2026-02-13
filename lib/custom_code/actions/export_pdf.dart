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
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';

Future exportPdf(
  BuildContext context,
  String? startDate,
  String? endDate,
) async {
  // Add your function code here!
  try {
    final pdf = pw.Document();

    if (startDate == null || endDate == null) {
      print("Start or End date is null");
      return;
    }

    final parseFormatter = DateFormat('d/M/yyyy');

    final DateTime start = parseFormatter.parse(startDate);
    final DateTime end = parseFormatter.parse(endDate);

    // 🔹 Filter data by date range
    List<BPMinfoStruct> allData = FFAppState().bpmInfos;

    final filtered = allData.where((e) {
      if (!e.hasCreatedAt()) return false;
      final d = DateTime.parse(e.createdAt).toLocal();
      return d.isAfter(start.subtract(Duration(days: 1))) &&
          d.isBefore(end.add(Duration(days: 1)));
    }).toList();

    if (filtered.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "No heart rate data available for selected date range",
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                  color: FlutterFlowTheme.of(context).primary,
                  fontSize: 14.0,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w500,
                  useGoogleFonts:
                      !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                ),
          ),
          duration: Duration(seconds: 2),
          backgroundColor: FlutterFlowTheme.of(context).secondary,
        ),
      );
      return;
    }

    // 🔹 Calculations
    final pulses = filtered.map((e) => e.pluse).toList();
    final hrvs = filtered.map((e) => e.hrv).toList();

    final avgPulse = (pulses.reduce((a, b) => a + b) / pulses.length).round();
    final minPulse = pulses.reduce((a, b) => a < b ? a : b);
    final maxPulse = pulses.reduce((a, b) => a > b ? a : b);

    final avgHRV = (hrvs.reduce((a, b) => a + b) / hrvs.length).round();
    final minHRV = hrvs.reduce((a, b) => a < b ? a : b);
    final maxHRV = hrvs.reduce((a, b) => a > b ? a : b);

    final exportDate = DateFormat('yyyy/MM/dd').format(DateTime.now());

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Padding(
            padding: const pw.EdgeInsets.all(24),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                /// 🔹 TITLE
                pw.Center(
                  child: pw.Text(
                    "Heart Health Report",
                    style: pw.TextStyle(
                      fontSize: 20,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
                pw.SizedBox(height: 20),

                /// 🔹 HEADER INFO
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text("Gender: ${FFAppState().userData.gender}"),
                        pw.Text("Age: ${FFAppState().userData.age}"),
                      ],
                    ),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.end,
                      children: [
                        pw.Text("Date Range: ${startDate} - ${endDate}"),
                        pw.Text("Export Date: $exportDate"),
                      ],
                    ),
                  ],
                ),

                pw.SizedBox(height: 30),

                /// 🔹 CHART AREA (Simple Graph Simulation)
                pw.Container(
                  height: 220,
                  child: pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.stretch,
                    children: [
                      /// 🟢 LEFT Y AXIS NUMBERS
                      pw.Container(
                        width: 30,
                        child: pw.Column(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: List.generate(
                            11,
                            (index) {
                              final value = 200 - (index * 20);
                              return pw.Text(
                                value.toString(),
                                style: pw.TextStyle(fontSize: 8),
                              );
                            },
                          ),
                        ),
                      ),

                      /// 🔵 CHART AREA
                      pw.Expanded(
                        child: pw.CustomPaint(
                          painter: (PdfGraphics canvas, PdfPoint size) {
                            final pulses = filtered
                                .map((e) => e.pluse.toDouble())
                                .toList();
                            if (pulses.isEmpty) return;

                            const maxY = 200.0;
                            const gridStep = 20.0;

                            final chartWidth = size.x;
                            final chartHeight = size.y;

                            /// Grid lines
                            canvas
                              ..setStrokeColor(PdfColors.grey300)
                              ..setLineWidth(0.8);

                            for (double yValue = 0;
                                yValue <= maxY;
                                yValue += gridStep) {
                              final yPos =
                                  chartHeight - (yValue / maxY * chartHeight);

                              canvas.drawLine(
                                0,
                                yPos,
                                chartWidth,
                                yPos,
                              );
                            }

                            /// Top border
                            canvas
                              ..setStrokeColor(PdfColors.grey700)
                              ..setLineWidth(1.2)
                              ..drawLine(0, 0, chartWidth, 0);

                            /// Draw points
                            final widthStep = pulses.length > 1
                                ? chartWidth / (pulses.length - 1)
                                : chartWidth / 2;

                            PdfPoint? previousPoint;

                            for (int i = 0; i < pulses.length; i++) {
                              final pulse = pulses[i].clamp(0, maxY);

                              final x =
                                  pulses.length > 1 ? widthStep * i : widthStep;

                              final y =
                                  chartHeight - (pulse / maxY * chartHeight);

                              final currentPoint = PdfPoint(x, y);

                              if (previousPoint != null) {
                                canvas
                                  ..setStrokeColor(PdfColors.red)
                                  ..setLineWidth(1.5)
                                  ..drawLine(
                                    previousPoint.x,
                                    previousPoint.y,
                                    currentPoint.x,
                                    currentPoint.y,
                                  );
                              }

                              canvas
                                ..setFillColor(PdfColors.red)
                                ..drawEllipse(
                                  currentPoint.x - 3,
                                  currentPoint.y - 3,
                                  6,
                                  6,
                                )
                                ..fillPath();

                              previousPoint = currentPoint;
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                pw.SizedBox(height: 30),

                /// 🔹 HEART RATE SUMMARY
                pw.Text("Heart Rate:",
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 10),

                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text("Average Pulse: $avgPulse bpm",
                        textAlign: pw.TextAlign.center),
                    pw.Text("Min Pulse: $minPulse bpm",
                        textAlign: pw.TextAlign.center),
                    pw.Text("Max Pulse: $maxPulse bpm",
                        textAlign: pw.TextAlign.center),
                  ],
                ),

                pw.SizedBox(height: 10),

                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text("Average HRV: $avgHRV bpm"),
                    pw.Text("Min HRV: $minHRV bpm"),
                    pw.Text("Max HRV: $maxHRV bpm"),
                  ],
                ),

                pw.SizedBox(height: 20),

                /// 🔹 TABLE
                pw.Table.fromTextArray(
                  headers: ['Date', 'Pulse', 'HRV', 'Index'],
                  data: filtered.map((e) {
                    final date = DateFormat('dd/MM/yyyy')
                        .format(DateTime.parse(e.createdAt).toLocal());
                    return [
                      date,
                      e.pluse.toString(),
                      e.hrv.toString(),
                      e.status.isEmpty ? "Normal" : e.status,
                    ];
                  }).toList(),
                ),

                pw.SizedBox(height: 30),

                /// 🔹 NOTICE
                pw.Text(
                  "Notice:\nAs we utilize PPG for assessing HRV and pulse, the accuracy may fluctuate depending on the measurement method employed, potentially leading to errors. It's important to note that this report is not designed for medical diagnosis purposes, but it can serve as a helpful reference when discussing your physical state with a healthcare professional.",
                  style: pw.TextStyle(fontSize: 9),
                ),
              ],
            ),
          );
        },
      ),
    );

    // 🔹 Save & Share
    final bytes = await pdf.save();

    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/heart_health_report.pdf');
    await file.writeAsBytes(bytes);

    await Share.shareXFiles(
      [XFile(file.path)],
      text: 'Heart Health Report',
    );
  } catch (e) {
    print("PDF ERROR:: $e");
  }
}
