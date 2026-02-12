import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'add_blood_sugar_widget.dart' show AddBloodSugarWidget;
import 'package:flutter/material.dart';

class AddBloodSugarModel extends FlutterFlowModel<AddBloodSugarWidget> {
  ///  Local state fields for this component.

  int? selectdeVal;

  int? mgDl;

  double? mmol;

  BloodInfoStruct? finalVal;
  void updateFinalValStruct(Function(BloodInfoStruct) updateFn) {
    updateFn(finalVal ??= BloodInfoStruct());
  }

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Bottom Sheet - sugarState] action in Container widget.
  String? sugarState;
  DateTime? datePicked1;
  DateTime? datePicked2;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
