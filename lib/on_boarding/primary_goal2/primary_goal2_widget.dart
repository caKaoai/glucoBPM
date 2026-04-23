import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:async';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'primary_goal2_model.dart';
export 'primary_goal2_model.dart';

class PrimaryGoal2Widget extends StatefulWidget {
  const PrimaryGoal2Widget({
    super.key,
    required this.genderList,
  });

  final List<String>? genderList;

  @override
  State<PrimaryGoal2Widget> createState() => _PrimaryGoal2WidgetState();
}

class _PrimaryGoal2WidgetState extends State<PrimaryGoal2Widget>
    with TickerProviderStateMixin {
  late PrimaryGoal2Model _model;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PrimaryGoal2Model());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.weightType = 1;
      safeSetState(() {});
      unawaited(
        () async {
          await action_blocks.getActivity(context);
        }(),
      );
    });

    animationsMap.addAll({
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
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(24.0, 24.0, 24.0, 0.0),
            child: Text(
              valueOrDefault<String>(
                functions.languagefuncation(
                    'personal_health_profile',
                    FFLocalizations.of(context).languageCode,
                    FFAppState().translationsCSV),
                'Personal Health Profile',
              ),
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                    fontSize: 24.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w800,
                    useGoogleFonts:
                        !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                  ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(24.0, 4.0, 24.0, 0.0),
            child: RichText(
              textScaler: MediaQuery.of(context).textScaler,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: valueOrDefault<String>(
                      functions.languagefuncation(
                          'tell_about_yourself_customize',
                          FFLocalizations.of(context).languageCode,
                          FFAppState().translationsCSV),
                      'Tell us about yourself to customize ',
                    ),
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).bodyMediumFamily,
                          color: FlutterFlowTheme.of(context).secondaryText,
                          letterSpacing: 0.0,
                          useGoogleFonts:
                              !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                        ),
                  ),
                  TextSpan(
                    text: ' glucoPal',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).bodyMediumFamily,
                          color: FlutterFlowTheme.of(context).primary,
                          letterSpacing: 0.0,
                          useGoogleFonts:
                              !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                        ),
                  ),
                  TextSpan(
                    text: '.',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).bodyMediumFamily,
                          color: FlutterFlowTheme.of(context).secondaryText,
                          letterSpacing: 0.0,
                          useGoogleFonts:
                              !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                        ),
                  )
                ],
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                      color: FlutterFlowTheme.of(context).text1,
                      letterSpacing: 0.0,
                      useGoogleFonts:
                          !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                    ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(24.0, 15.0, 24.0, 0.0),
            child: Text(
              valueOrDefault<String>(
                functions.languagefuncation(
                    'gender',
                    FFLocalizations.of(context).languageCode,
                    FFAppState().translationsCSV),
                'GENDER',
              ),
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                    color: Color(0xFF94A3B8),
                    fontSize: 11.0,
                    letterSpacing: 1.1,
                    fontWeight: FontWeight.bold,
                    useGoogleFonts:
                        !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                  ),
            ),
          ),
          Builder(
            builder: (context) {
              final gender = widget.genderList!.toList();

              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: List.generate(gender.length, (genderIndex) {
                    final genderItem = gender[genderIndex];
                    return Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(4.0, 12.0, 4.0, 27.5),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          _model.selectedGender = genderItem;
                          safeSetState(() {});
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: valueOrDefault<Color>(
                              genderItem == _model.selectedGender
                                  ? FlutterFlowTheme.of(context).primary
                                  : Color(0xFFF8FAFC),
                              Color(0xFFF8FAFC),
                            ),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 6.0,
                                color: valueOrDefault<Color>(
                                  genderItem == _model.selectedGender
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
                                genderItem == _model.selectedGender
                                    ? FlutterFlowTheme.of(context).primary
                                    : Color(0xFFF1F5F9),
                                Color(0xFFF1F5F9),
                              ),
                              width: 1.0,
                            ),
                          ),
                          child: Align(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  20.0, 10.0, 20.0, 10.0),
                              child: Text(
                                valueOrDefault<String>(
                                  functions.languagefuncation(
                                      genderItem,
                                      FFLocalizations.of(context).languageCode,
                                      FFAppState().translationsCSV),
                                  'Female',
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .bodyMediumFamily,
                                      color: valueOrDefault<Color>(
                                        genderItem == _model.selectedGender
                                            ? FlutterFlowTheme.of(context).info
                                            : Color(0xFF64748B),
                                        Color(0xFF64748B),
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
                    );
                  })
                      .divide(SizedBox(width: 2.0))
                      .addToStart(SizedBox(width: 24.0))
                      .addToEnd(SizedBox(width: 24.0)),
                ),
              );
            },
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
            child: Text(
              valueOrDefault<String>(
                functions.languagefuncation(
                    'diabetes_type',
                    FFLocalizations.of(context).languageCode,
                    FFAppState().translationsCSV),
                'DIABETES TYPE',
              ),
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                    color: Color(0xFF94A3B8),
                    fontSize: 11.0,
                    letterSpacing: 1.1,
                    fontWeight: FontWeight.bold,
                    useGoogleFonts:
                        !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                  ),
            ),
          ),
          Builder(
            builder: (context) {
              final daib = _model.diabetType.toList();

              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: List.generate(daib.length, (daibIndex) {
                    final daibItem = daib[daibIndex];
                    return Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(4.0, 12.0, 4.0, 27.5),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          _model.selectedDaib = daibItem;
                          safeSetState(() {});
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: valueOrDefault<Color>(
                              daibItem == _model.selectedDaib
                                  ? FlutterFlowTheme.of(context).primary
                                  : Color(0xFFF8FAFC),
                              Color(0xFFF8FAFC),
                            ),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 6.0,
                                color: valueOrDefault<Color>(
                                  daibItem == _model.selectedDaib
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
                                daibItem == _model.selectedDaib
                                    ? FlutterFlowTheme.of(context).primary
                                    : Color(0xFFF1F5F9),
                                Color(0xFFF1F5F9),
                              ),
                              width: 1.0,
                            ),
                          ),
                          child: Align(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  20.0, 10.0, 20.0, 10.0),
                              child: Text(
                                valueOrDefault<String>(
                                  functions.languagefuncation(
                                      daibItem,
                                      FFLocalizations.of(context).languageCode,
                                      FFAppState().translationsCSV),
                                  'Type 2',
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .bodyMediumFamily,
                                      color: valueOrDefault<Color>(
                                        daibItem == _model.selectedDaib
                                            ? FlutterFlowTheme.of(context).info
                                            : Color(0xFF64748B),
                                        Color(0xFF64748B),
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
                    );
                  })
                      .divide(SizedBox(width: 2.0))
                      .addToStart(SizedBox(width: 24.0))
                      .addToEnd(SizedBox(width: 24.0)),
                ),
              );
            },
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
            child: Text(
              valueOrDefault<String>(
                functions.languagefuncation(
                    'age',
                    FFLocalizations.of(context).languageCode,
                    FFAppState().translationsCSV),
                'AGE',
              ),
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                    color: Color(0xFF94A3B8),
                    fontSize: 11.0,
                    letterSpacing: 1.1,
                    fontWeight: FontWeight.bold,
                    useGoogleFonts:
                        !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                  ),
            ),
          ),
          custom_widgets.AgeRuler(
            width: double.infinity,
            height: 64.0,
            min: FFAppState().config.age.min,
            max: FFAppState().config.age.max,
            initVal: 30,
            age: (ageVal) async {
              _model.age = ageVal;
              safeSetState(() {});
            },
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(24.0, 30.0, 24.0, 0.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  valueOrDefault<String>(
                    functions.languagefuncation(
                        'height',
                        FFLocalizations.of(context).languageCode,
                        FFAppState().translationsCSV),
                    'HEIGHT',
                  ),
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).bodyMediumFamily,
                        color: Color(0xFF94A3B8),
                        fontSize: 11.0,
                        letterSpacing: 1.1,
                        fontWeight: FontWeight.bold,
                        useGoogleFonts:
                            !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                      ),
                ),
                Container(
                  width: 68.7,
                  height: 22.0,
                  decoration: BoxDecoration(
                    color: Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            _model.heightType = 1;
                            safeSetState(() {});
                          },
                          child: Container(
                            width: 100.0,
                            decoration: BoxDecoration(
                              color: valueOrDefault<Color>(
                                _model.heightType == 1
                                    ? FlutterFlowTheme.of(context).primary
                                    : Color(0xFFF1F5F9),
                                FlutterFlowTheme.of(context).primary,
                              ),
                              borderRadius: BorderRadius.circular(100.0),
                            ),
                            child: Align(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Text(
                                'CM',
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .bodyMediumFamily,
                                      color: valueOrDefault<Color>(
                                        _model.heightType == 1
                                            ? FlutterFlowTheme.of(context).info
                                            : Color(0xFF94A3B8),
                                        Color(0xFF94A3B8),
                                      ),
                                      fontSize: 9.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w800,
                                      useGoogleFonts:
                                          !FlutterFlowTheme.of(context)
                                              .bodyMediumIsCustom,
                                    ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            _model.heightType = 0;
                            safeSetState(() {});
                          },
                          child: Container(
                            width: 100.0,
                            decoration: BoxDecoration(
                              color: valueOrDefault<Color>(
                                _model.heightType == 0
                                    ? FlutterFlowTheme.of(context).primary
                                    : Color(0xFFF1F5F9),
                                FlutterFlowTheme.of(context).primary,
                              ),
                              borderRadius: BorderRadius.circular(100.0),
                            ),
                            child: Align(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Text(
                                'FT',
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .bodyMediumFamily,
                                      color: valueOrDefault<Color>(
                                        _model.heightType == 0
                                            ? FlutterFlowTheme.of(context).info
                                            : Color(0xFF94A3B8),
                                        Color(0xFF94A3B8),
                                      ),
                                      fontSize: 9.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w800,
                                      useGoogleFonts:
                                          !FlutterFlowTheme.of(context)
                                              .bodyMediumIsCustom,
                                    ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            key: ValueKey(_model.heightType!.toString()),
            child: custom_widgets.HeightRuler(
              width: double.infinity,
              height: 64.0,
              type: _model.heightType,
              minval: _model.heightType == 1
                  ? FFAppState().config.height.firstOrNull?.min
                  : FFAppState().config.height.lastOrNull?.min,
              maxval: _model.heightType == 1
                  ? FFAppState().config.height.firstOrNull?.max
                  : FFAppState().config.height.lastOrNull?.max,
              returnHeight: (heightInfo) async {
                _model.height = heightInfo;
                safeSetState(() {});
              },
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(24.0, 30.0, 24.0, 0.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  valueOrDefault<String>(
                    functions.languagefuncation(
                        'WEIGHT',
                        FFLocalizations.of(context).languageCode,
                        FFAppState().translationsCSV),
                    'WEIGHT',
                  ),
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).bodyMediumFamily,
                        color: Color(0xFF94A3B8),
                        fontSize: 11.0,
                        letterSpacing: 1.1,
                        fontWeight: FontWeight.bold,
                        useGoogleFonts:
                            !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                      ),
                ),
                Container(
                  width: 68.7,
                  height: 22.0,
                  decoration: BoxDecoration(
                    color: Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            _model.weightType = 1;
                            safeSetState(() {});
                          },
                          child: Container(
                            width: 100.0,
                            decoration: BoxDecoration(
                              color: valueOrDefault<Color>(
                                _model.weightType == 1
                                    ? FlutterFlowTheme.of(context).primary
                                    : Color(0xFFF1F5F9),
                                FlutterFlowTheme.of(context).primary,
                              ),
                              borderRadius: BorderRadius.circular(100.0),
                            ),
                            child: Align(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Text(
                                'KG',
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .bodyMediumFamily,
                                      color: valueOrDefault<Color>(
                                        _model.weightType == 1
                                            ? FlutterFlowTheme.of(context).info
                                            : Color(0xFF94A3B8),
                                        Color(0xFF94A3B8),
                                      ),
                                      fontSize: 9.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w800,
                                      useGoogleFonts:
                                          !FlutterFlowTheme.of(context)
                                              .bodyMediumIsCustom,
                                    ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            _model.weightType = 0;
                            safeSetState(() {});
                          },
                          child: Container(
                            width: 100.0,
                            decoration: BoxDecoration(
                              color: valueOrDefault<Color>(
                                _model.weightType == 0
                                    ? FlutterFlowTheme.of(context).primary
                                    : Color(0xFFF1F5F9),
                                FlutterFlowTheme.of(context).primary,
                              ),
                              borderRadius: BorderRadius.circular(100.0),
                            ),
                            child: Align(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Text(
                                'LBS',
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .bodyMediumFamily,
                                      color: valueOrDefault<Color>(
                                        _model.weightType == 0
                                            ? FlutterFlowTheme.of(context).info
                                            : Color(0xFF94A3B8),
                                        Color(0xFF94A3B8),
                                      ),
                                      fontSize: 9.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w800,
                                      useGoogleFonts:
                                          !FlutterFlowTheme.of(context)
                                              .bodyMediumIsCustom,
                                    ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            key: ValueKey(
                '${_model.weightType?.toString()}${_model.selectedGender}'),
            child: custom_widgets.WeightRuler(
              width: double.infinity,
              height: 64.0,
              type: valueOrDefault<int>(
                _model.weightType,
                1,
              ),
              min: _model.heightType == 0
                  ? FFAppState().config.weight.firstOrNull?.min
                  : FFAppState().config.height.firstOrNull?.min,
              max: _model.heightType == 0
                  ? FFAppState().config.weight.firstOrNull?.max
                  : FFAppState().config.height.firstOrNull?.max,
              returnWeight: (weighttInfo) async {
                _model.weight = weighttInfo;
                safeSetState(() {});
              },
            ),
          ),
        ],
      ),
    ).animateOnPageLoad(animationsMap['columnOnPageLoadAnimation']!);
  }
}
