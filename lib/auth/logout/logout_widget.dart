import '/auth/supabase_auth/auth_util.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'logout_model.dart';
export 'logout_model.dart';

class LogoutWidget extends StatefulWidget {
  const LogoutWidget({super.key});

  @override
  State<LogoutWidget> createState() => _LogoutWidgetState();
}

class _LogoutWidgetState extends State<LogoutWidget>
    with TickerProviderStateMixin {
  late LogoutModel _model;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LogoutModel());

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
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
            border: Border.all(
              color: Color(0xCC0F0F0F),
              width: 1.0,
            ),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  FFLocalizations.of(context).getText(
                    'lz5qihxi' /* Sign out */,
                  ),
                  textAlign: TextAlign.center,
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).bodyMediumFamily,
                        color: FlutterFlowTheme.of(context).accent2,
                        fontSize: 22.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w600,
                        useGoogleFonts:
                            !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                      ),
                ),
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(25.0, 0.0, 25.0, 25.0),
                  child: Text(
                    FFLocalizations.of(context).getText(
                      'ekoxnjfw' /* Staying signed in will help yo... */,
                    ),
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
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
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
                          Navigator.pop(context);
                        },
                        text: FFLocalizations.of(context).getText(
                          'xse1zzof' /* Cancel */,
                        ),
                        options: FFButtonOptions(
                          width: 200.0,
                          height: 50.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 16.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          textStyle: FlutterFlowTheme.of(context)
                              .titleSmall
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .titleSmallFamily,
                                color: FlutterFlowTheme.of(context).primary,
                                fontSize: 18.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w500,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .titleSmallIsCustom,
                              ),
                          elevation: 0.0,
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).primary,
                          ),
                          borderRadius: BorderRadius.circular(100.0),
                        ),
                      ),
                    ),
                    Expanded(
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
                          await Future.wait([
                            Future(() async {
                              GoRouter.of(context).prepareAuthEvent();
                              await authManager.signOut();
                              GoRouter.of(context).clearRedirectLocation();
                            }),
                            Future(() async {
                              FFAppState().userData = UserStruct();
                              safeSetState(() {});
                            }),
                          ]);

                          context.goNamedAuth(
                              SplashScreenWidget.routeName, context.mounted);
                        },
                        text: FFLocalizations.of(context).getText(
                          'qzjapw40' /* Yes */,
                        ),
                        options: FFButtonOptions(
                          width: 200.0,
                          height: 50.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 16.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: FlutterFlowTheme.of(context).primary,
                          textStyle: FlutterFlowTheme.of(context)
                              .titleSmall
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .titleSmallFamily,
                                color: Colors.white,
                                fontSize: 18.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w500,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .titleSmallIsCustom,
                              ),
                          elevation: 0.0,
                          borderRadius: BorderRadius.circular(100.0),
                        ),
                      ),
                    ),
                  ].divide(SizedBox(width: 15.0)),
                ),
              ]
                  .divide(SizedBox(height: 15.0))
                  .addToStart(SizedBox(height: 25.0))
                  .addToEnd(SizedBox(height: 25.0)),
            ).animateOnPageLoad(animationsMap['columnOnPageLoadAnimation']!),
          ),
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
