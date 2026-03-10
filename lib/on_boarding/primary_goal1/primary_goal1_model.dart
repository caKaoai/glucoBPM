import '/flutter_flow/flutter_flow_util.dart';
import 'primary_goal1_widget.dart' show PrimaryGoal1Widget;
import 'package:flutter/material.dart';

class PrimaryGoal1Model extends FlutterFlowModel<PrimaryGoal1Widget> {
  ///  Local state fields for this component.

  List<String> selectedKey = [];
  void addToSelectedKey(String item) => selectedKey.add(item);
  void removeFromSelectedKey(String item) => selectedKey.remove(item);
  void removeAtIndexFromSelectedKey(int index) => selectedKey.removeAt(index);
  void insertAtIndexInSelectedKey(int index, String item) =>
      selectedKey.insert(index, item);
  void updateSelectedKeyAtIndex(int index, Function(String) updateFn) =>
      selectedKey[index] = updateFn(selectedKey[index]);

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
