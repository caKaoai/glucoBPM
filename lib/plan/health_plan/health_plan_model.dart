import '/flutter_flow/flutter_flow_util.dart';
import '/nav_bar/nav/nav_widget.dart';
import '/plan/home_plan/home_plan_widget.dart';
import '/index.dart';
import 'health_plan_widget.dart' show HealthPlanWidget;
import 'package:flutter/material.dart';

class HealthPlanModel extends FlutterFlowModel<HealthPlanWidget> {
  ///  State fields for stateful widgets in this page.

  // Models for homePlan dynamic component.
  late FlutterFlowDynamicModels<HomePlanModel> homePlanModels1;
  // Models for homePlan dynamic component.
  late FlutterFlowDynamicModels<HomePlanModel> homePlanModels2;
  // Models for homePlan dynamic component.
  late FlutterFlowDynamicModels<HomePlanModel> homePlanModels3;
  // Models for homePlan dynamic component.
  late FlutterFlowDynamicModels<HomePlanModel> homePlanModels4;
  // Model for nav component.
  late NavModel navModel;

  @override
  void initState(BuildContext context) {
    homePlanModels1 = FlutterFlowDynamicModels(() => HomePlanModel());
    homePlanModels2 = FlutterFlowDynamicModels(() => HomePlanModel());
    homePlanModels3 = FlutterFlowDynamicModels(() => HomePlanModel());
    homePlanModels4 = FlutterFlowDynamicModels(() => HomePlanModel());
    navModel = createModel(context, () => NavModel());
  }

  @override
  void dispose() {
    homePlanModels1.dispose();
    homePlanModels2.dispose();
    homePlanModels3.dispose();
    homePlanModels4.dispose();
    navModel.dispose();
  }
}
