import '/components/history_block_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'oxygen_details_widget.dart' show OxygenDetailsWidget;
import 'package:flutter/material.dart';

class OxygenDetailsModel extends FlutterFlowModel<OxygenDetailsWidget> {
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
