import '/flutter_flow/flutter_flow_util.dart';
import 'edit_ingredient_widget.dart' show EditIngredientWidget;
import 'package:flutter/material.dart';

class EditIngredientModel extends FlutterFlowModel<EditIngredientWidget> {
  ///  Local state fields for this page.

  bool isEdit = false;

  String? name;

  List<String> ingredientLocal = [];
  void addToIngredientLocal(String item) => ingredientLocal.add(item);
  void removeFromIngredientLocal(String item) => ingredientLocal.remove(item);
  void removeAtIndexFromIngredientLocal(int index) =>
      ingredientLocal.removeAt(index);
  void insertAtIndexInIngredientLocal(int index, String item) =>
      ingredientLocal.insert(index, item);
  void updateIngredientLocalAtIndex(int index, Function(String) updateFn) =>
      ingredientLocal[index] = updateFn(ingredientLocal[index]);

  ///  State fields for stateful widgets in this page.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Stores action output result for [Bottom Sheet - addIngredient] action in Container widget.
  String? ingred;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
