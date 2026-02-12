import '/components/history_block_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/home/diabetes_chart/diabetes_chart_widget.dart';
import '/index.dart';
import 'sugar_details_page_widget.dart' show SugarDetailsPageWidget;
import 'package:flutter/material.dart';

class SugarDetailsPageModel extends FlutterFlowModel<SugarDetailsPageWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for DiabetesChart component.
  late DiabetesChartModel diabetesChartModel;
  // Models for historyBlock dynamic component.
  late FlutterFlowDynamicModels<HistoryBlockModel> historyBlockModels;

  @override
  void initState(BuildContext context) {
    diabetesChartModel = createModel(context, () => DiabetesChartModel());
    historyBlockModels = FlutterFlowDynamicModels(() => HistoryBlockModel());
  }

  @override
  void dispose() {
    diabetesChartModel.dispose();
    historyBlockModels.dispose();
  }
}
