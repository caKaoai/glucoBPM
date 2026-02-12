import '/flutter_flow/flutter_flow_util.dart';
import '/nav_bar/nav/nav_widget.dart';
import '/index.dart';
import 'aicare_widget.dart' show AicareWidget;
import 'package:flutter/material.dart';

class AicareModel extends FlutterFlowModel<AicareWidget> {
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
