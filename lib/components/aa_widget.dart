import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'aa_model.dart';
export 'aa_model.dart';

class AaWidget extends StatefulWidget {
  const AaWidget({super.key});

  @override
  State<AaWidget> createState() => _AaWidgetState();
}

class _AaWidgetState extends State<AaWidget> {
  late AaModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AaModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
