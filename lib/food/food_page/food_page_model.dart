import '/auth/nav/nav_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/food/food_comp/food_comp_widget.dart';
import 'food_page_widget.dart' show FoodPageWidget;
import 'package:flutter/material.dart';

class FoodPageModel extends FlutterFlowModel<FoodPageWidget> {
  ///  State fields for stateful widgets in this page.

  // Models for FoodComp dynamic component.
  late FlutterFlowDynamicModels<FoodCompModel> foodCompModels;
  // Model for nav component.
  late NavModel navModel;

  @override
  void initState(BuildContext context) {
    foodCompModels = FlutterFlowDynamicModels(() => FoodCompModel());
    navModel = createModel(context, () => NavModel());
  }

  @override
  void dispose() {
    foodCompModels.dispose();
    navModel.dispose();
  }
}
