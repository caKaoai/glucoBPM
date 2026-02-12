import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'b_p_m_tracking_widget.dart' show BPMTrackingWidget;
import 'package:flutter/material.dart';

class BPMTrackingModel extends FlutterFlowModel<BPMTrackingWidget> {
  ///  Local state fields for this page.

  int? index;

  ///  State fields for stateful widgets in this page.

  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  // Stores action output result for [Bottom Sheet - ProPlanSheet] action in Tab widget.
  bool? isDissmiss;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    tabBarController?.dispose();
  }
}
