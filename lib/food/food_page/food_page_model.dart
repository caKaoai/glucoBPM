import '/auth/nav/nav_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'food_page_widget.dart' show FoodPageWidget;
import 'package:flutter/material.dart';

class FoodPageModel extends FlutterFlowModel<FoodPageWidget> {
  ///  State fields for stateful widgets in this page.

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
