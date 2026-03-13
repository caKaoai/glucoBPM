import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/meal_scan/diabetic_insight/diabetic_insight_widget.dart';
import 'details_anlyze_screen_widget.dart' show DetailsAnlyzeScreenWidget;
import 'package:flutter/material.dart';

class DetailsAnlyzeScreenModel
    extends FlutterFlowModel<DetailsAnlyzeScreenWidget> {
  ///  Local state fields for this page.

  double? foodSize;

  dynamic userMealTime;

  MealStruct? mealParsInfo;
  void updateMealParsInfoStruct(Function(MealStruct) updateFn) {
    updateFn(mealParsInfo ??= MealStruct());
  }

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Bottom Sheet - MealTime] action in Container widget.
  dynamic selectedMealTime;
  // Models for DiabeticInsight dynamic component.
  late FlutterFlowDynamicModels<DiabeticInsightModel> diabeticInsightModels;
  // Stores action output result for [Backend Call - API (Insert Meal)] action in Button widget.
  ApiCallResponse? insertMeal;

  @override
  void initState(BuildContext context) {
    diabeticInsightModels =
        FlutterFlowDynamicModels(() => DiabeticInsightModel());
  }

  @override
  void dispose() {
    diabeticInsightModels.dispose();
  }
}
