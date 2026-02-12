import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'pro_plan_sheet_model.dart';
export 'pro_plan_sheet_model.dart';

class ProPlanSheetWidget extends StatefulWidget {
  const ProPlanSheetWidget({super.key});

  @override
  State<ProPlanSheetWidget> createState() => _ProPlanSheetWidgetState();
}

class _ProPlanSheetWidgetState extends State<ProPlanSheetWidget>
    with TickerProviderStateMixin {
  late ProPlanSheetModel _model;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProPlanSheetModel());

    animationsMap.addAll({
      'containerOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        applyInitialState: true,
        effectsBuilder: () => [
          MoveEffect(
            curve: Curves.linear,
            delay: 0.0.ms,
            duration: 500.0.ms,
            begin: Offset(
                0.0,
                valueOrDefault<double>(
                  800.0,
                  800.0,
                )),
            end: Offset(0.0, 0.0),
          ),
        ],
      ),
      'containerOnActionTriggerAnimation': AnimationInfo(
        trigger: AnimationTrigger.onActionTrigger,
        applyInitialState: true,
        effectsBuilder: null,
      ),
      'columnOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeOut,
            delay: 120.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
    });
    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(0.0),
              bottomRight: Radius.circular(0.0),
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
            border: Border.all(
              color: Color(0xCC0F0F0F),
              width: 1.0,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  FlutterFlowIconButton(
                    borderRadius: 8.0,
                    buttonSize: 45.0,
                    icon: Icon(
                      Icons.close,
                      color: FlutterFlowTheme.of(context).accent2,
                      size: 28.0,
                    ),
                    onPressed: () async {
                      await Future.wait([
                        Future(() async {
                          HapticFeedback.lightImpact();
                        }),
                        Future(() async {
                          if (animationsMap[
                                  'containerOnActionTriggerAnimation'] !=
                              null) {
                            await animationsMap[
                                    'containerOnActionTriggerAnimation']!
                                .controller
                                .forward(from: 0.0);
                          }
                        }),
                      ]);
                      Navigator.pop(context, true);
                    },
                  ),
                  Expanded(
                    child: Text(
                      'Measurement Type',
                      textAlign: TextAlign.center,
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyMediumFamily,
                            color: FlutterFlowTheme.of(context).accent2,
                            fontSize: 22.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w600,
                            useGoogleFonts: !FlutterFlowTheme.of(context)
                                .bodyMediumIsCustom,
                          ),
                    ),
                  ),
                  FlutterFlowIconButton(
                    borderRadius: 8.0,
                    buttonSize: 45.0,
                    icon: Icon(
                      Icons.close,
                      color: Colors.transparent,
                      size: 28.0,
                    ),
                    onPressed: true
                        ? null
                        : () {
                            print('IconButton pressed ...');
                          },
                  ),
                ]
                    .addToStart(SizedBox(width: 25.0))
                    .addToEnd(SizedBox(width: 25.0)),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(25.0, 0.0, 25.0, 0.0),
                child: Image.asset(
                  'assets/images/proPlan.png',
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(25.0, 20.0, 25.0, 0.0),
                child: FFButtonWidget(
                  onPressed: () async {
                    await Future.wait([
                      Future(() async {
                        HapticFeedback.lightImpact();
                      }),
                      Future(() async {
                        if (animationsMap[
                                'containerOnActionTriggerAnimation'] !=
                            null) {
                          await animationsMap[
                                  'containerOnActionTriggerAnimation']!
                              .controller
                              .forward(from: 0.0);
                        }
                      }),
                    ]);
                    Navigator.pop(context, true);
                  },
                  text: 'Get Premium Now',
                  options: FFButtonOptions(
                    width: double.infinity,
                    height: 50.0,
                    padding:
                        EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                    iconPadding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: FlutterFlowTheme.of(context).primary,
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).titleSmallFamily,
                          color: Colors.white,
                          fontSize: 18.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w500,
                          useGoogleFonts:
                              !FlutterFlowTheme.of(context).titleSmallIsCustom,
                        ),
                    elevation: 0.0,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
            ]
                .divide(SizedBox(height: 15.0))
                .addToStart(SizedBox(height: 25.0))
                .addToEnd(SizedBox(height: 25.0)),
          ).animateOnPageLoad(animationsMap['columnOnPageLoadAnimation']!),
        )
            .animateOnPageLoad(animationsMap['containerOnPageLoadAnimation']!)
            .animateOnActionTrigger(
          animationsMap['containerOnActionTriggerAnimation']!,
          effects: [
            MoveEffect(
              curve: Curves.linear,
              delay: 0.0.ms,
              duration: 500.0.ms,
              begin: Offset(0.0, 0.0),
              end: Offset(
                  0.0,
                  valueOrDefault<double>(
                    800.0,
                    800.0,
                  )),
            ),
          ],
        ),
      ],
    );
  }
}
