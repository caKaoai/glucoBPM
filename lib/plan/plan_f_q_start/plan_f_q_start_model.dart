import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'plan_f_q_start_widget.dart' show PlanFQStartWidget;
import 'package:flutter/material.dart';

class PlanFQStartModel extends FlutterFlowModel<PlanFQStartWidget> {
  ///  Local state fields for this page.

  List<int> selectIds = [];
  void addToSelectIds(int item) => selectIds.add(item);
  void removeFromSelectIds(int item) => selectIds.remove(item);
  void removeAtIndexFromSelectIds(int index) => selectIds.removeAt(index);
  void insertAtIndexInSelectIds(int index, int item) =>
      selectIds.insert(index, item);
  void updateSelectIdsAtIndex(int index, Function(int) updateFn) =>
      selectIds[index] = updateFn(selectIds[index]);

  ///  State fields for stateful widgets in this page.

  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
