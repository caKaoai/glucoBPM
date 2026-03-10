import '/flutter_flow/flutter_flow_util.dart';
import 'primary_goal4_widget.dart' show PrimaryGoal4Widget;
import 'package:flutter/material.dart';

class PrimaryGoal4Model extends FlutterFlowModel<PrimaryGoal4Widget> {
  ///  Local state fields for this component.

  List<String> indexVal = [];
  void addToIndexVal(String item) => indexVal.add(item);
  void removeFromIndexVal(String item) => indexVal.remove(item);
  void removeAtIndexFromIndexVal(int index) => indexVal.removeAt(index);
  void insertAtIndexInIndexVal(int index, String item) =>
      indexVal.insert(index, item);
  void updateIndexValAtIndex(int index, Function(String) updateFn) =>
      indexVal[index] = updateFn(indexVal[index]);

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
