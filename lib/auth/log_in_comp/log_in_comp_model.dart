import '/flutter_flow/flutter_flow_util.dart';
import 'log_in_comp_widget.dart' show LogInCompWidget;
import 'package:flutter/material.dart';

class LogInCompModel extends FlutterFlowModel<LogInCompWidget> {
  ///  State fields for stateful widgets in this component.

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
