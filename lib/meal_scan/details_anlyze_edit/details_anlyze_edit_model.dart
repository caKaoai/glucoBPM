import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/meal_scan/diabetic_insight/diabetic_insight_widget.dart';
import 'details_anlyze_edit_widget.dart' show DetailsAnlyzeEditWidget;
import 'package:flutter/material.dart';

class DetailsAnlyzeEditModel extends FlutterFlowModel<DetailsAnlyzeEditWidget> {
  ///  Local state fields for this page.

  double? foodSize;

  dynamic userMealTime;

  MealStruct? mealParsInfo;
  void updateMealParsInfoStruct(Function(MealStruct) updateFn) {
    updateFn(mealParsInfo ??= MealStruct());
  }

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Bottom Sheet - EditIngredient] action in Row widget.
  List<String>? newIngedients;
  // Stores action output result for [Bottom Sheet - MealTime] action in Container widget.
  dynamic selectedMealTime;
  // Models for DiabeticInsight dynamic component.
  late FlutterFlowDynamicModels<DiabeticInsightModel> diabeticInsightModels;
  // Stores action output result for [Backend Call - API (Update Meal)] action in Button widget.
  ApiCallResponse? updateMeal;

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
