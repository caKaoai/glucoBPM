import '/components/history_block_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'pressure_details_widget.dart' show PressureDetailsWidget;
import 'package:flutter/material.dart';

class PressureDetailsModel extends FlutterFlowModel<PressureDetailsWidget> {
  ///  State fields for stateful widgets in this page.

  // Models for historyBlock dynamic component.
  late FlutterFlowDynamicModels<HistoryBlockModel> historyBlockModels;

  @override
  void initState(BuildContext context) {
    historyBlockModels = FlutterFlowDynamicModels(() => HistoryBlockModel());
  }

  @override
  void dispose() {
    historyBlockModels.dispose();
  }
}
