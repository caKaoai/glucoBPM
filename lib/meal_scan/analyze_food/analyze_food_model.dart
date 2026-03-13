import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'analyze_food_widget.dart' show AnalyzeFoodWidget;
import 'package:flutter/material.dart';

class AnalyzeFoodModel extends FlutterFlowModel<AnalyzeFoodWidget> {
  ///  Local state fields for this page.

  MealStruct? foodInfo;
  void updateFoodInfoStruct(Function(MealStruct) updateFn) {
    updateFn(foodInfo ??= MealStruct());
  }

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (analyzeFoodMultiLanguage)] action in AnalyzeFood widget.
  ApiCallResponse? mealInfo;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
