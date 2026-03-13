import '/flutter_flow/flutter_flow_util.dart';
import 'glucose_home_widget.dart' show GlucoseHomeWidget;
import 'package:flutter/material.dart';

class GlucoseHomeModel extends FlutterFlowModel<GlucoseHomeWidget> {
  ///  Local state fields for this page.

  String? selectMealTime = 'fasting';

  ///  State fields for stateful widgets in this page.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
