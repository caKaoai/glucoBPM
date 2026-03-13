import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'diabetic_insight_model.dart';
export 'diabetic_insight_model.dart';

class DiabeticInsightWidget extends StatefulWidget {
  const DiabeticInsightWidget({
    super.key,
    required this.daibaticInfo,
  });

  final InfoStruct? daibaticInfo;

  @override
  State<DiabeticInsightWidget> createState() => _DiabeticInsightWidgetState();
}

class _DiabeticInsightWidgetState extends State<DiabeticInsightWidget> {
  late DiabeticInsightModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DiabeticInsightModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: valueOrDefault<Color>(
          functions.returnProgressColor(widget.daibaticInfo?.ranking,
              FFAppState().config.diabeticInsightColor.toList(), 1),
          Color(0x1916A34A),
        ),
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: valueOrDefault<Color>(
            functions.returnProgressColor(widget.daibaticInfo?.ranking,
                FFAppState().config.diabeticInsightColor.toList(), 1),
            Color(0x1916A34A),
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: 40.0,
              height: 40.0,
              decoration: BoxDecoration(
                color: valueOrDefault<Color>(
                  functions.returnProgressColor(widget.daibaticInfo?.ranking,
                      FFAppState().config.diabeticInsightColor.toList(), 0),
                  Color(0xFF16A34A),
                ),
                shape: BoxShape.circle,
              ),
              child: Builder(
                builder: (context) {
                  if (widget.daibaticInfo?.ranking == 'good') {
                    return Icon(
                      FFIcons.kicon48,
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      size: 20.0,
                    );
                  } else if (widget.daibaticInfo?.ranking == 'average') {
                    return Icon(
                      FFIcons.kicon49,
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      size: 18.0,
                    );
                  } else {
                    return Icon(
                      FFIcons.kicon47,
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      size: 20.0,
                    );
                  }
                },
              ),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    valueOrDefault<String>(
                      widget.daibaticInfo?.title,
                      'Medium Fiber',
                    ),
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).bodyMediumFamily,
                          color: FlutterFlowTheme.of(context).primaryText,
                          fontSize: 16.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.bold,
                          useGoogleFonts:
                              !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                        ),
                  ),
                  Text(
                    valueOrDefault<String>(
                      widget.daibaticInfo?.description,
                      '8g of fiber helps slow down glucose absorption.',
                    ),
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).bodyMediumFamily,
                          color: FlutterFlowTheme.of(context).secondaryText,
                          fontSize: 12.0,
                          letterSpacing: 0.0,
                          useGoogleFonts:
                              !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                        ),
                  ),
                ],
              ),
            ),
          ].divide(SizedBox(width: 16.0)),
        ),
      ),
    );
  }
}
