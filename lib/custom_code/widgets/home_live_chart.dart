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
  int selectedIndex = 11;

  late AnimationController _controller;
  late Animation<double> _animation;

  final List<double> values = [
    28,
    38,
    32,
    52,
    60,
    45,
    58,
    50,
    30,
    24,
    40,
    65,
  ];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const barColor = Color(0xFFFFC7CF);
    const activeColor = Color(0xFFFF0A3C);
    const labelColor = Color(0xFF94A3B8);

    return SizedBox(
      width: widget.width ?? double.infinity,
      height: 180,
      child: Column(
        children: [
          Expanded(
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceBetween,
                    maxY: 80,

                    /// remove grid
                    gridData: const FlGridData(show: false),

                    /// remove border
                    borderData: FlBorderData(show: false),

                    /// remove axis labels
                    titlesData: const FlTitlesData(
                      leftTitles:
                          AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      rightTitles:
                          AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      topTitles:
                          AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      bottomTitles:
                          AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    ),

                    /// bar tap detection
                    barTouchData: BarTouchData(
                      enabled: false,
                      touchTooltipData: BarTouchTooltipData(),
                      touchCallback: (event, response) {
                        if (event is FlTapUpEvent && response?.spot != null) {
                          setState(() {
                            selectedIndex =
                                response!.spot!.touchedBarGroupIndex;
                          });
                        }
                      },
                    ),

                    /// bar groups
                    barGroups: List.generate(values.length, (index) {
                      final isActive = index == selectedIndex;

                      return BarChartGroupData(
                        x: index,
                        barRods: [
                          BarChartRodData(
                            toY: values[index] * _animation.value,
                            width: 10,
                            color: isActive ? activeColor : barColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ],
                      );
                    }),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "06:00 AM",
                  style: TextStyle(
                    color: labelColor,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.6,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.circle,
                      size: 8,
                      color: activeColor,
                    ),
                    SizedBox(width: 6),
                    Text(
                      "LIVE NOW",
                      style: TextStyle(
                        color: labelColor,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.6,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
