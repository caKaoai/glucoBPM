import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/nav_bar/nav/nav_widget.dart';
import '/index.dart';
import 'home_page_widget.dart' show HomePageWidget;
import 'package:flutter/material.dart';

class HomePageModel extends FlutterFlowModel<HomePageWidget> {
  ///  Local state fields for this page.

  BloodInfoStruct? pressureInfo;
  void updatePressureInfoStruct(Function(BloodInfoStruct) updateFn) {
    updateFn(pressureInfo ??= BloodInfoStruct());
  }

  BloodInfoStruct? oxygen;
  void updateOxygenStruct(Function(BloodInfoStruct) updateFn) {
    updateFn(oxygen ??= BloodInfoStruct());
  }

  BloodInfoStruct? sugar;
  void updateSugarStruct(Function(BloodInfoStruct) updateFn) {
    updateFn(sugar ??= BloodInfoStruct());
  }

  BPMinfoStruct? bpmInfo;
  void updateBpmInfoStruct(Function(BPMinfoStruct) updateFn) {
    updateFn(bpmInfo ??= BPMinfoStruct());
  }

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - fetchInfo] action in HomePage widget.
  List<HealthInfoStruct>? healthInfo;
  // Model for nav component.
  late NavModel navModel;

  @override
  void initState(BuildContext context) {
    navModel = createModel(context, () => NavModel());
  }

  @override
  void dispose() {
    navModel.dispose();
  }
}
