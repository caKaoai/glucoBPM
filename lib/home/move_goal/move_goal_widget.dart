import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'move_goal_model.dart';
export 'move_goal_model.dart';

class MoveGoalWidget extends StatefulWidget {
  const MoveGoalWidget({super.key});

  @override
  State<MoveGoalWidget> createState() => _MoveGoalWidgetState();
}

class _MoveGoalWidgetState extends State<MoveGoalWidget>
    with TickerProviderStateMixin {
  late MoveGoalModel _model;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MoveGoalModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.count = FFAppState().userData.goalSteps;
      safeSetState(() {});
    });

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
    context.watch<FFAppState>();

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
                      Navigator.pop(context);
                    },
                  ),
                  Expanded(
                    child: Text(
                      'Daily Move Goal',
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
                padding: EdgeInsetsDirectional.fromSTEB(25.0, 0.0, 25.0, 10.0),
                child: Text(
                  'Set goals based on your health level or the level of health you want to have each day',
                  textAlign: TextAlign.center,
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).bodyMediumFamily,
                        fontSize: 16.0,
                        letterSpacing: 0.0,
                        useGoogleFonts:
                            !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                      ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(25.0, 0.0, 25.0, 0.0),
                child: Container(
                  width: double.infinity,
                  height: 220.0,
                  decoration: BoxDecoration(
                    color: Color(0xFFF4F6FB),
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      FlutterFlowIconButton(
                        borderRadius: 8.0,
                        buttonSize: 100.0,
                        icon: Icon(
                          FFIcons.kprevious,
                          color: FlutterFlowTheme.of(context).primary,
                          size: 55.0,
                        ),
                        onPressed: () async {
                          if (_model.count! > 500) {
                            _model.count = _model.count! + -500;
                            safeSetState(() {});
                          }
                        },
                      ),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              valueOrDefault<String>(
                                _model.count?.toString(),
                                '0',
                              ),
                              textAlign: TextAlign.center,
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .bodyMediumFamily,
                                    fontSize: 28.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
                                            .bodyMediumIsCustom,
                                  ),
                            ),
                            Text(
                              'Steps',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .bodyMediumFamily,
                                    fontSize: 16.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
                                            .bodyMediumIsCustom,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      FlutterFlowIconButton(
                        borderRadius: 8.0,
                        buttonSize: 100.0,
                        icon: Icon(
                          FFIcons.knext,
                          color: FlutterFlowTheme.of(context).primary,
                          size: 36.0,
                        ),
                        onPressed: () async {
                          _model.count = _model.count! + 500;
                          safeSetState(() {});
                        },
                      ),
                    ]
                        .divide(SizedBox(width: 8.0))
                        .addToStart(SizedBox(width: 15.0))
                        .addToEnd(SizedBox(width: 15.0)),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(25.0, 20.0, 25.0, 0.0),
                child: FFButtonWidget(
                  onPressed: () async {
                    await Future.wait([
                      Future(() async {
                        HapticFeedback.heavyImpact();
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
                    await Future.wait([
                      Future(() async {
                        Navigator.pop(context);
                      }),
                      Future(() async {
                        FFAppState().updateUserDataStruct(
                          (e) => e..goalSteps = _model.count,
                        );
                        safeSetState(() {});
                      }),
                      Future(() async {
                        await UsersTable().update(
                          data: {
                            'goalSteps': FFAppState().userData.goalSteps,
                          },
                          matchingRows: (rows) => rows.eqOrNull(
                            'user_id',
                            currentUserUid,
                          ),
                        );
                      }),
                    ]);
                  },
                  text: 'Save',
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
