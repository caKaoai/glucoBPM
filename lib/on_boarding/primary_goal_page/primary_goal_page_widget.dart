import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/on_boarding/primary_goal1/primary_goal1_widget.dart';
import '/on_boarding/primary_goal2/primary_goal2_widget.dart';
import '/on_boarding/primary_goal3/primary_goal3_widget.dart';
import '/on_boarding/primary_goal4/primary_goal4_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/permissions_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'primary_goal_page_model.dart';
export 'primary_goal_page_model.dart';

class PrimaryGoalPageWidget extends StatefulWidget {
  const PrimaryGoalPageWidget({super.key});

  static String routeName = 'PrimaryGoalPage';
  static String routePath = '/primaryGoalPage';

  @override
  State<PrimaryGoalPageWidget> createState() => _PrimaryGoalPageWidgetState();
}

class _PrimaryGoalPageWidgetState extends State<PrimaryGoalPageWidget> {
  late PrimaryGoalPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PrimaryGoalPageModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xFFF2F2F7),
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            disabledIconColor: valueOrDefault<Color>(
              _model.pageViewCurrentIndex == 0
                  ? Colors.transparent
                  : FlutterFlowTheme.of(context).primaryText,
              FlutterFlowTheme.of(context).primaryText,
            ),
            icon: Icon(
              Icons.chevron_left_sharp,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 30.0,
            ),
            onPressed: (_model.pageViewCurrentIndex == 0)
                ? null
                : () async {
                    if (_model.pageViewCurrentIndex != 0) {
                      await _model.pageViewController?.previousPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.ease,
                      );
                      _model.progressVal =
                          (_model.pageViewCurrentIndex + 1) * 0.25;
                      safeSetState(() {});
                    }
                  },
          ),
          title: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Step ${valueOrDefault<String>(
                  (_model.pageViewCurrentIndex + 1).toString(),
                  '1',
                )} of 4',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                      color: Color(0xFF8E8E93),
                      fontSize: 10.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.bold,
                      useGoogleFonts:
                          !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                    ),
              ),
              LinearPercentIndicator(
                percent: _model.progressVal!,
                lineHeight: 6.0,
                animation: true,
                animateFromLastPercent: true,
                progressColor: Color(0xFFE31E24),
                backgroundColor: Color(0xFFE5E7EB),
                center: Text(
                  FFLocalizations.of(context).getText(
                    '0clwk2zl' /* 0 */,
                  ),
                  style: FlutterFlowTheme.of(context).headlineSmall.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).headlineSmallFamily,
                        fontSize: 0.0,
                        letterSpacing: 0.0,
                        useGoogleFonts:
                            !FlutterFlowTheme.of(context).headlineSmallIsCustom,
                      ),
                ),
                barRadius: Radius.circular(100.0),
                padding: EdgeInsets.zero,
              ),
              Container(
                width: 0.0,
                height: 0.0,
                child: custom_widgets.HealthpermissionCheck(
                  width: 0.0,
                  height: 0.0,
                ),
              ),
            ].divide(SizedBox(height: 6.0)),
          ),
          actions: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 20.0, 0.0),
              child: FlutterFlowIconButton(
                borderRadius: 8.0,
                buttonSize: 40.0,
                icon: Icon(
                  Icons.arrow_back,
                  color: FlutterFlowTheme.of(context).info,
                  size: 24.0,
                ),
                onPressed: true
                    ? null
                    : () {
                        print('IconButton pressed ...');
                      },
              ),
            ),
          ],
          centerTitle: true,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  FlutterFlowTheme.of(context).secondary,
                  Color(0xFFF2F2F7),
                  Color(0xFFF2F2F7)
                ],
                stops: [0.0, 0.7, 1.0],
                begin: AlignmentDirectional(0.0, -1.0),
                end: AlignmentDirectional(0, 1.0),
              ),
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 20.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      child: PageView(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: _model.pageViewController ??=
                            PageController(initialPage: 0),
                        scrollDirection: Axis.horizontal,
                        children: [
                          wrapWithModel(
                            model: _model.primaryGoal1Model,
                            updateCallback: () => safeSetState(() {}),
                            updateOnChange: true,
                            child: PrimaryGoal1Widget(),
                          ),
                          wrapWithModel(
                            model: _model.primaryGoal2Model,
                            updateCallback: () => safeSetState(() {}),
                            updateOnChange: true,
                            child: PrimaryGoal2Widget(
                              genderList: _model.genderList,
                            ),
                          ),
                          wrapWithModel(
                            model: _model.primaryGoal3Model,
                            updateCallback: () => safeSetState(() {}),
                            child: PrimaryGoal3Widget(),
                          ),
                          wrapWithModel(
                            model: _model.primaryGoal4Model,
                            updateCallback: () => safeSetState(() {}),
                            child: PrimaryGoal4Widget(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(24.0, 20.0, 24.0, 24.0),
                    child: Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 60.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 10.0,
                                color: Color(0x33E31E24),
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
                        Builder(
                          builder: (context) {
                            if (_model.pageViewCurrentIndex == 0) {
                              return FFButtonWidget(
                                onPressed: ((_model.pageViewCurrentIndex ==
                                            0) &&
                                        !(_model.primaryGoal1Model.selectedKey
                                            .isNotEmpty))
                                    ? null
                                    : () async {
                                        HapticFeedback.heavyImpact();
                                        await Future.wait([
                                          Future(() async {
                                            FFAppState().updateUserDataStruct(
                                              (e) => e
                                                ..goal = _model
                                                    .primaryGoal1Model
                                                    .selectedKey
                                                    .toList(),
                                            );
                                            safeSetState(() {});
                                          }),
                                          Future(() async {
                                            await _model.pageViewController
                                                ?.nextPage(
                                              duration:
                                                  Duration(milliseconds: 300),
                                              curve: Curves.ease,
                                            );
                                          }),
                                        ]);
                                        _model.progressVal =
                                            (_model.pageViewCurrentIndex + 1) *
                                                0.25;
                                        safeSetState(() {});
                                      },
                                text: valueOrDefault<String>(
                                  functions.languagefuncation(
                                      'next',
                                      FFLocalizations.of(context).languageCode,
                                      FFAppState().translationsCSV),
                                  'Next',
                                ),
                                icon: Icon(
                                  Icons.arrow_forward_sharp,
                                  size: 20.0,
                                ),
                                options: FFButtonOptions(
                                  width: double.infinity,
                                  height: 60.0,
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16.0, 0.0, 16.0, 0.0),
                                  iconAlignment: IconAlignment.end,
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 2.5, 0.0, 0.0),
                                  color: valueOrDefault<Color>(
                                    (_model.primaryGoal1Model.selectedKey
                                                .isNotEmpty) &&
                                            (_model.pageViewCurrentIndex == 0)
                                        ? FlutterFlowTheme.of(context).primary
                                        : Color(0x65F20D0D),
                                    FlutterFlowTheme.of(context).primary,
                                  ),
                                  textStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .titleSmallFamily,
                                        color: Colors.white,
                                        fontSize: 18.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.bold,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .titleSmallIsCustom,
                                      ),
                                  elevation: 0.0,
                                  borderRadius: BorderRadius.circular(100.0),
                                ),
                                showLoadingIndicator: false,
                              );
                            } else if (_model.pageViewCurrentIndex == 1) {
                              return FFButtonWidget(
                                onPressed: () async {
                                  HapticFeedback.heavyImpact();
                                  await Future.wait([
                                    Future(() async {
                                      FFAppState().updateUserDataStruct(
                                        (e) => e
                                          ..gender = _model
                                              .primaryGoal2Model.selectedGender
                                          ..age = _model.primaryGoal2Model.age
                                          ..height =
                                              _model.primaryGoal2Model.height
                                          ..weight =
                                              _model.primaryGoal2Model.weight
                                          ..heightUnit = _model
                                                      .primaryGoal2Model
                                                      .heightType ==
                                                  1
                                              ? 'cm'
                                              : 'ft'
                                          ..weightUnit = _model
                                                      .primaryGoal2Model
                                                      .weightType ==
                                                  1
                                              ? 'kg'
                                              : 'lbs'
                                          ..daibType = _model
                                              .primaryGoal2Model.selectedDaib,
                                      );
                                      safeSetState(() {});
                                    }),
                                    Future(() async {
                                      await _model.pageViewController?.nextPage(
                                        duration: Duration(milliseconds: 300),
                                        curve: Curves.ease,
                                      );
                                    }),
                                  ]);
                                  _model.progressVal =
                                      (_model.pageViewCurrentIndex + 1) * 0.25;
                                  safeSetState(() {});
                                },
                                text: valueOrDefault<String>(
                                  functions.languagefuncation(
                                      'save_profile',
                                      FFLocalizations.of(context).languageCode,
                                      FFAppState().translationsCSV),
                                  'Save Profile',
                                ),
                                icon: FaIcon(
                                  FontAwesomeIcons.check,
                                  size: 18.0,
                                ),
                                options: FFButtonOptions(
                                  width: double.infinity,
                                  height: 60.0,
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
                                        fontSize: 18.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.bold,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .titleSmallIsCustom,
                                      ),
                                  elevation: 0.0,
                                  borderRadius: BorderRadius.circular(100.0),
                                ),
                                showLoadingIndicator: false,
                              );
                            } else if (_model.pageViewCurrentIndex == 2) {
                              return FFButtonWidget(
                                key: ValueKey(FFAppState()
                                    .HealthPermission
                                    .steps
                                    .toString()),
                                onPressed: () async {
                                  HapticFeedback.heavyImpact();
                                  if (!FFAppState().HealthPermission.steps) {
                                    await actions.redirectSetting(
                                      1,
                                    );
                                  }
                                  if (FFAppState().HealthPermission.steps) {
                                    await _model.pageViewController?.nextPage(
                                      duration: Duration(milliseconds: 300),
                                      curve: Curves.ease,
                                    );
                                    _model.progressVal =
                                        (_model.pageViewCurrentIndex + 1) *
                                            0.25;
                                    safeSetState(() {});
                                  }
                                },
                                text: valueOrDefault<String>(
                                  functions.languagefuncation(
                                      'sync_with_apple_health',
                                      FFLocalizations.of(context).languageCode,
                                      FFAppState().translationsCSV),
                                  'Sync with Apple Health',
                                ),
                                options: FFButtonOptions(
                                  width: double.infinity,
                                  height: 60.0,
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
                                        fontSize: 17.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.bold,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .titleSmallIsCustom,
                                      ),
                                  elevation: 0.0,
                                  borderRadius: BorderRadius.circular(100.0),
                                ),
                                showLoadingIndicator: false,
                              );
                            } else {
                              return FFButtonWidget(
                                onPressed: () async {
                                  HapticFeedback.heavyImpact();
                                  await requestPermission(cameraPermission);
                                  if (await getPermissionStatus(
                                      cameraPermission)) {
                                    context.goNamed(
                                      LogInWidget.routeName,
                                      extra: <String, dynamic>{
                                        '__transition_info__': TransitionInfo(
                                          hasTransition: true,
                                          transitionType:
                                              PageTransitionType.fade,
                                          duration: Duration(milliseconds: 0),
                                        ),
                                      },
                                    );
                                  } else {
                                    await actions.redirectSetting(
                                      0,
                                    );
                                  }
                                },
                                text: valueOrDefault<String>(
                                  functions.languagefuncation(
                                      'enable_camera_access',
                                      FFLocalizations.of(context).languageCode,
                                      FFAppState().translationsCSV),
                                  'Enable Camera Access',
                                ),
                                icon: Icon(
                                  FFIcons.kicon40,
                                  size: 15.0,
                                ),
                                options: FFButtonOptions(
                                  width: double.infinity,
                                  height: 60.0,
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16.0, 0.0, 16.0, 0.0),
                                  iconAlignment: IconAlignment.start,
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(
                                      5.0, 2.5, 5.0, 0.0),
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
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .titleSmallIsCustom,
                                      ),
                                  elevation: 0.0,
                                  borderRadius: BorderRadius.circular(100.0),
                                ),
                                showLoadingIndicator: false,
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(32.0, 0.0, 32.0, 0.0),
                    child: Builder(
                      builder: (context) {
                        if (_model.pageViewCurrentIndex == 0) {
                          return Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                FFIcons.k33,
                                color: Color(0xFF8E8E93),
                                size: 13.0,
                              ),
                              Align(
                                alignment: AlignmentDirectional(0.0, 0.0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 2.0, 0.0, 0.0),
                                  child: Text(
                                    valueOrDefault<String>(
                                      functions.languagefuncation(
                                          'secure_clinical_encryption',
                                          FFLocalizations.of(context)
                                              .languageCode,
                                          FFAppState().translationsCSV),
                                      'SECURE CLINICAL ENCRYPTION',
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          font: GoogleFonts.inter(
                                            fontWeight: FontWeight.bold,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                          color: Color(0xFF8E8E93),
                                          fontSize: 10.0,
                                          letterSpacing: 1.5,
                                          fontWeight: FontWeight.bold,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                  ),
                                ),
                              ),
                            ].divide(SizedBox(width: 2.25)),
                          );
                        } else if (_model.pageViewCurrentIndex == 1) {
                          return InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              await launchURL(FFAppState().config.policy);
                            },
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  valueOrDefault<String>(
                                    functions.languagefuncation(
                                        'your_privacy_is_our_priority',
                                        FFLocalizations.of(context)
                                            .languageCode,
                                        FFAppState().translationsCSV),
                                    'YOUR PRIVACY IS OUR PRIORITY.',
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .bodyMediumFamily,
                                        color: Color(0xFF94A3B8),
                                        fontSize: 10.0,
                                        letterSpacing: 2.0,
                                        fontWeight: FontWeight.bold,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .bodyMediumIsCustom,
                                      ),
                                ),
                                Text(
                                  valueOrDefault<String>(
                                    functions.languagefuncation(
                                        'privacy_policy',
                                        FFLocalizations.of(context)
                                            .languageCode,
                                        FFAppState().translationsCSV),
                                    'PRIVACY POLICY',
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .bodyMediumFamily,
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        fontSize: 10.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.bold,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .bodyMediumIsCustom,
                                      ),
                                ),
                              ],
                            ),
                          );
                        } else if (_model.pageViewCurrentIndex == 2) {
                          return InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              await _model.pageViewController?.nextPage(
                                duration: Duration(milliseconds: 300),
                                curve: Curves.ease,
                              );
                              _model.progressVal =
                                  (_model.pageViewCurrentIndex + 1) * 0.25;
                              safeSetState(() {});
                            },
                            child: Text(
                              valueOrDefault<String>(
                                functions.languagefuncation(
                                    'skip_for_now',
                                    FFLocalizations.of(context).languageCode,
                                    FFAppState().translationsCSV),
                                'Skip for now',
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    font: GoogleFonts.manrope(
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    color: Color(0xFF94A3B8),
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                            ),
                          );
                        } else {
                          return Text(
                            valueOrDefault<String>(
                              functions.languagefuncation(
                                  'camera_food_nutrition_usage',
                                  FFLocalizations.of(context).languageCode,
                                  FFAppState().translationsCSV),
                              'We use your camera only to identify food items and calculate nutrition facts.',
                            ),
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  font: GoogleFonts.manrope(
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                                  color: Color(0xFF94A3B8),
                                  fontSize: 11.0,
                                  letterSpacing: 0.8,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
