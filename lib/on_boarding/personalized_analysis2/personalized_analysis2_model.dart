import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'personalized_analysis2_widget.dart' show PersonalizedAnalysis2Widget;
import 'package:flutter/material.dart';

class PersonalizedAnalysis2Model
    extends FlutterFlowModel<PersonalizedAnalysis2Widget> {
  ///  Local state fields for this page.

  int? weight;

  /// 0=kg, 1=Ibs
  int? weightType;

  /// 0=cm, 1=ft
  int? heightType;

  int? height;

  /// only use for the custom widget update
  String? heightKey;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
