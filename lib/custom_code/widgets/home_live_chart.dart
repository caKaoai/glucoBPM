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

import 'dart:math' as math;
import 'package:fl_chart/fl_chart.dart';

class HomeLiveChart extends StatefulWidget {
  const HomeLiveChart({
    super.key,
    this.width,
    this.height,
  });

  final double? width;
  final double? height;

  @override
  State<HomeLiveChart> createState() => _HomeLiveChartState();
}

class _HomeLiveChartState extends State<HomeLiveChart>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  final List<FlSpot> _chartSpots = const [
    FlSpot(0, 3.2),
    FlSpot(1, 3.35),
    FlSpot(2, 3.6),
    FlSpot(3, 3.95),
    FlSpot(4, 4.15),
    FlSpot(5, 4.2),
    FlSpot(6, 4.05),
    FlSpot(7, 3.8),
    FlSpot(8, 3.45),
    FlSpot(9, 3.7),
    FlSpot(10, 4.45),
  ];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutCubic,
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<FlSpot> _buildAnimatedSpots(double t) {
    if (_chartSpots.isEmpty) return [];

    if (_chartSpots.length == 1) return _chartSpots;

    final double scaled = (_chartSpots.length - 1) * t;
    final int fullIndex = scaled.floor().clamp(0, _chartSpots.length - 1);
    final double remainder = scaled - fullIndex;

    final List<FlSpot> result = [];

    for (int i = 0; i <= fullIndex; i++) {
      result.add(_chartSpots[i]);
    }

    if (fullIndex < _chartSpots.length - 1) {
      final FlSpot a = _chartSpots[fullIndex];
      final FlSpot b = _chartSpots[fullIndex + 1];

      result.add(
        FlSpot(
          a.x + ((b.x - a.x) * remainder),
          a.y + ((b.y - a.y) * remainder),
        ),
      );
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    const lineColor = Color(0xFFFF0A3C);
    const labelColor = Color(0xFF94A3B8);
    const bgColor = Color(0xFFFAFBFD);

    if (_chartSpots.isEmpty) {
      return const SizedBox();
    }

    final minX = _chartSpots.first.x;
    final maxX = _chartSpots.last.x;

    double minY = _chartSpots.first.y;
    double maxY = _chartSpots.first.y;

    for (final spot in _chartSpots) {
      minY = math.min(minY, spot.y);
      maxY = math.max(maxY, spot.y);
    }

    final yPadding = (maxY - minY).abs() < 1 ? 0.8 : (maxY - minY).abs() * 0.45;

    return SizedBox(
      width: widget.width ?? double.infinity,
      height: widget.height ?? 240,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          final animatedSpots = _buildAnimatedSpots(_animation.value);

          return Container(
            decoration: const BoxDecoration(
              color: bgColor,
            ),
            child: LineChart(
              duration: Duration.zero,
              LineChartData(
                minX: minX,
                maxX: maxX,
                minY: minY - yPadding,
                maxY: maxY + yPadding,
                backgroundColor: bgColor,
                clipData: const FlClipData.all(),
                gridData: const FlGridData(show: false),
                borderData: FlBorderData(show: false),
                extraLinesData: ExtraLinesData(
                  horizontalLines: [],
                  verticalLines: [],
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: animatedSpots,
                    isCurved: true,
                    curveSmoothness: 0.35,
                    color: lineColor,
                    barWidth: 4.5,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          lineColor.withOpacity(0.18 * _animation.value),
                          lineColor.withOpacity(0.08 * _animation.value),
                          lineColor.withOpacity(0.02 * _animation.value),
                          Colors.transparent,
                        ],
                        stops: const [0.25, 0.50, 0.75, 1.0],
                      ),
                    ),
                  ),
                ],
                lineTouchData: LineTouchData(
                  enabled: true,
                  handleBuiltInTouches: true,
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipColor: (_) => Colors.white,
                    fitInsideHorizontally: true,
                    fitInsideVertically: true,
                    getTooltipItems: (touchedSpots) {
                      return touchedSpots.map((spot) {
                        return LineTooltipItem(
                          spot.y.toStringAsFixed(1),
                          const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        );
                      }).toList();
                    },
                  ),
                  getTouchedSpotIndicator: (barData, spotIndexes) {
                    return spotIndexes.map((index) {
                      return TouchedSpotIndicatorData(
                        FlLine(
                          color: Colors.transparent,
                          strokeWidth: 0,
                        ),
                        FlDotData(
                          show: true,
                          getDotPainter: (spot, percent, bar, index) {
                            return FlDotCirclePainter(
                              radius: 4,
                              color: lineColor,
                              strokeWidth: 2,
                              strokeColor: Colors.white,
                            );
                          },
                        ),
                      );
                    }).toList();
                  },
                ),
                titlesData: FlTitlesData(
                  show: true,
                  leftTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 42,
                      interval: maxX - minX,
                      getTitlesWidget: (value, meta) {
                        if (value == minX) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 12, left: 70),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '06:00 AM',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .bodyMediumFamily,
                                      color: labelColor,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 1.65,
                                      useGoogleFonts:
                                          !FlutterFlowTheme.of(context)
                                              .bodyMediumIsCustom,
                                    ),
                              ),
                            ),
                          );
                        }

                        if (value == maxX) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 12, right: 90),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.circle,
                                    size: 8,
                                    color: lineColor,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    'LIVE NOW',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMediumFamily,
                                          color: labelColor,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: 1.65,
                                          useGoogleFonts:
                                              !FlutterFlowTheme.of(context)
                                                  .bodyMediumIsCustom,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }

                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
