import '/flutter_flow/flutter_flow_util.dart';
import 'calories_burn_widget.dart' show CaloriesBurnWidget;
import 'package:flutter/material.dart';

class CaloriesBurnModel extends FlutterFlowModel<CaloriesBurnWidget> {
  ///  Local state fields for this page.

  List<String> intensity = ['low', 'moderate', 'high'];
  void addToIntensity(String item) => intensity.add(item);
  void removeFromIntensity(String item) => intensity.remove(item);
  void removeAtIndexFromIntensity(int index) => intensity.removeAt(index);
  void insertAtIndexInIntensity(int index, String item) =>
      intensity.insert(index, item);
  void updateIntensityAtIndex(int index, Function(String) updateFn) =>
      intensity[index] = updateFn(intensity[index]);

  String? selectedIntensity = 'moderate';

  String timeInfo = 'now';

  List<String> timeList = ['now', 'hour_ago', 'custom_time'];
  void addToTimeList(String item) => timeList.add(item);
  void removeFromTimeList(String item) => timeList.remove(item);
  void removeAtIndexFromTimeList(int index) => timeList.removeAt(index);
  void insertAtIndexInTimeList(int index, String item) =>
      timeList.insert(index, item);
  void updateTimeListAtIndex(int index, Function(String) updateFn) =>
      timeList[index] = updateFn(timeList[index]);

  int? selectMin;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
