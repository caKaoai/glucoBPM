import '/flutter_flow/flutter_flow_util.dart';
import 'add_ingredient_widget.dart' show AddIngredientWidget;
import 'package:flutter/material.dart';

class AddIngredientModel extends FlutterFlowModel<AddIngredientWidget> {
  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
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
