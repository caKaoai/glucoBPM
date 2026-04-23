import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'meal_time_model.dart';
export 'meal_time_model.dart';

class MealTimeWidget extends StatefulWidget {
  const MealTimeWidget({super.key});

  @override
  State<MealTimeWidget> createState() => _MealTimeWidgetState();
}

class _MealTimeWidgetState extends State<MealTimeWidget>
    with TickerProviderStateMixin {
  late MealTimeModel _model;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MealTimeModel());

    animationsMap.addAll({
      'containerOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        applyInitialState: true,
        effectsBuilder: () => [
          MoveEffect(
            curve: Curves.linear,
            delay: 0.0.ms,
            duration: 600.0.ms,
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
            curve: Curves.easeInOut,
            delay: 120.0.ms,
            duration: 1500.0.ms,
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
              topLeft: Radius.circular(18.0),
              topRight: Radius.circular(18.0),
            ),
            border: Border.all(
              color: Color(0x7F0F0F0F),
              width: 0.25,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    FFLocalizations.of(context).getText(
                      'ghm9n8yw' /* Select Meal Time */,
                    ),
                    textAlign: TextAlign.center,
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).bodyMediumFamily,
                          fontSize: 24.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.bold,
                          useGoogleFonts:
                              !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                        ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                    child: Text(
                      FFLocalizations.of(context).getText(
                        'tm0hvk03' /* When did you have this meal? */,
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyMediumFamily,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            letterSpacing: 0.0,
                            useGoogleFonts: !FlutterFlowTheme.of(context)
                                .bodyMediumIsCustom,
                          ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 32.0, 0.0, 32.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            _model.selectedVal = 0;
                            safeSetState(() {});
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: valueOrDefault<Color>(
                                _model.selectedVal == 0
                                    ? FlutterFlowTheme.of(context).primary
                                    : Color(0xFFF1F5F9),
                                Color(0xFFF1F5F9),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 6.0,
                                  color: valueOrDefault<Color>(
                                    _model.selectedVal == 0
                                        ? Color(0x27E31B23)
                                        : Colors.transparent,
                                    Colors.transparent,
                                  ),
                                  offset: Offset(
                                    0.0,
                                    4.0,
                                  ),
                                  spreadRadius: 2.0,
                                )
                              ],
                              borderRadius: BorderRadius.circular(100.0),
                              border: Border.all(
                                color: valueOrDefault<Color>(
                                  _model.selectedVal == 0
                                      ? FlutterFlowTheme.of(context).primary
                                      : Color(0xFFE2E8F0),
                                  Color(0xFFE2E8F0),
                                ),
                                width: 1.0,
                              ),
                            ),
                            child: Align(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    24.0, 12.0, 24.0, 12.0),
                                child: Text(
                                  FFLocalizations.of(context).getText(
                                    'al36yxb4' /* Today */,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .bodyMediumFamily,
                                        color: valueOrDefault<Color>(
                                          _model.selectedVal == 0
                                              ? FlutterFlowTheme.of(context)
                                                  .info
                                              : Color(0xFF475569),
                                          Color(0xFF475569),
                                        ),
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .bodyMediumIsCustom,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            _model.selectedVal = 1;
                            safeSetState(() {});
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: valueOrDefault<Color>(
                                _model.selectedVal == 1
                                    ? FlutterFlowTheme.of(context).primary
                                    : Color(0xFFF1F5F9),
                                Color(0xFFF1F5F9),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 6.0,
                                  color: valueOrDefault<Color>(
                                    _model.selectedVal == 1
                                        ? Color(0x27E31B23)
                                        : Colors.transparent,
                                    Colors.transparent,
                                  ),
                                  offset: Offset(
                                    0.0,
                                    4.0,
                                  ),
                                  spreadRadius: 2.0,
                                )
                              ],
                              borderRadius: BorderRadius.circular(100.0),
                              border: Border.all(
                                color: valueOrDefault<Color>(
                                  _model.selectedVal == 1
                                      ? FlutterFlowTheme.of(context).primary
                                      : Color(0xFFE2E8F0),
                                  Color(0xFFE2E8F0),
                                ),
                                width: 1.0,
                              ),
                            ),
                            child: Align(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    24.0, 12.0, 24.0, 12.0),
                                child: Text(
                                  FFLocalizations.of(context).getText(
                                    'qju2j0dn' /* Yesterday */,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .bodyMediumFamily,
                                        color: valueOrDefault<Color>(
                                          _model.selectedVal == 1
                                              ? FlutterFlowTheme.of(context)
                                                  .info
                                              : Color(0xFF475569),
                                          Color(0xFF475569),
                                        ),
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .bodyMediumIsCustom,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            _model.selectedVal = 2;
                            safeSetState(() {});
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: valueOrDefault<Color>(
                                _model.selectedVal == 2
                                    ? FlutterFlowTheme.of(context).primary
                                    : Color(0xFFF1F5F9),
                                Color(0xFFF1F5F9),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 6.0,
                                  color: valueOrDefault<Color>(
                                    _model.selectedVal == 2
                                        ? Color(0x27E31B23)
                                        : Colors.transparent,
                                    Colors.transparent,
                                  ),
                                  offset: Offset(
                                    0.0,
                                    4.0,
                                  ),
                                  spreadRadius: 2.0,
                                )
                              ],
                              borderRadius: BorderRadius.circular(100.0),
                              border: Border.all(
                                color: valueOrDefault<Color>(
                                  _model.selectedVal == 2
                                      ? FlutterFlowTheme.of(context).primary
                                      : Color(0xFFE2E8F0),
                                  Color(0xFFE2E8F0),
                                ),
                                width: 1.0,
                              ),
                            ),
                            child: Align(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    24.0, 12.0, 24.0, 12.0),
                                child: Text(
                                  valueOrDefault<String>(
                                    functions.twoDayAgoDate(),
                                    'Oct 01',
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .bodyMediumFamily,
                                        color: valueOrDefault<Color>(
                                          _model.selectedVal == 2
                                              ? FlutterFlowTheme.of(context)
                                                  .info
                                              : Color(0xFF475569),
                                          Color(0xFF475569),
                                        ),
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .bodyMediumIsCustom,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]
                          .divide(SizedBox(width: 12.0))
                          .addToStart(SizedBox(width: 11.0))
                          .addToEnd(SizedBox(width: 11.0)),
                    ),
                  ),
                  Container(
                    key: ValueKey(_model.selectedVal!.toString()),
                    width: double.infinity,
                    height: 200.0,
                    child: custom_widgets.SpinningTimePicker(
                      width: double.infinity,
                      height: 200.0,
                      selectedDay: _model.selectedVal,
                      returnVal: (dateTime) async {
                        _model.dayTime = dateTime;
                        safeSetState(() {});
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(24.0),
                    child: Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 56.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 10.0,
                                color: Color(0x32F20D0D),
                                offset: Offset(
                                  0.0,
                                  6.0,
                                ),
                                spreadRadius: 2.0,
                              )
                            ],
                            borderRadius: BorderRadius.circular(100.0),
                          ),
                        ),
                        FFButtonWidget(
                          onPressed: () async {
                            HapticFeedback.heavyImpact();
                            Navigator.pop(context, _model.dayTime);
                          },
                          text: FFLocalizations.of(context).getText(
                            'nsi4z64m' /* Confirm Time */,
                          ),
                          options: FFButtonOptions(
                            width: double.infinity,
                            height: 56.0,
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 0.0, 16.0, 0.0),
                            iconAlignment: IconAlignment.end,
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 2.5, 0.0, 0.0),
                            color: FlutterFlowTheme.of(context).primary,
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .titleSmallFamily,
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .titleSmallIsCustom,
                                ),
                            elevation: 0.0,
                            borderRadius: BorderRadius.circular(100.0),
                          ),
                          showLoadingIndicator: false,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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
                    600.0,
                    600.0,
                  )),
            ),
          ],
        ),
      ],
    );
  }
}
