import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/meal_scan/meal_time/meal_time_widget.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'calories_burn_model.dart';
export 'calories_burn_model.dart';

class CaloriesBurnWidget extends StatefulWidget {
  const CaloriesBurnWidget({super.key});

  static String routeName = 'caloriesBurn';
  static String routePath = '/caloriesBurn';

  @override
  State<CaloriesBurnWidget> createState() => _CaloriesBurnWidgetState();
}

class _CaloriesBurnWidgetState extends State<CaloriesBurnWidget> {
  late CaloriesBurnModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CaloriesBurnModel());
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
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: Icon(
              Icons.chevron_left_sharp,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 30.0,
            ),
            onPressed: () async {
              context.pop();
            },
          ),
          title: Text(
            FFLocalizations.of(context).getText(
              'eqf3cvft' /* Log Activity */,
            ),
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: FlutterFlowTheme.of(context).headlineMediumFamily,
                  color: FlutterFlowTheme.of(context).primaryText,
                  fontSize: 18.0,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.bold,
                  useGoogleFonts:
                      !FlutterFlowTheme.of(context).headlineMediumIsCustom,
                ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 16.0),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              borderRadius: BorderRadius.circular(32.0),
                              border: Border.all(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                width: 1.0,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    width: 48.0,
                                    height: 48.0,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 2.0,
                                          color: Color(0x0D000000),
                                          offset: Offset(
                                            0.0,
                                            1.0,
                                          ),
                                        )
                                      ],
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          FFLocalizations.of(context).getText(
                                            'q3g2vjrk' /* Walking */,
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMediumFamily,
                                                fontSize: 18.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.bold,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMediumIsCustom,
                                              ),
                                        ),
                                        Text(
                                          FFLocalizations.of(context).getText(
                                            'h8h7ujaw' /* Low intensity, steady state */,
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMediumFamily,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                letterSpacing: 0.0,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMediumIsCustom,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Icon(
                                    Icons.chevron_right,
                                    color: Color(0xFFCBD5E1),
                                    size: 24.0,
                                  ),
                                ].divide(SizedBox(width: 16.0)),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 16.0),
                          child: Text(
                            FFLocalizations.of(context).getText(
                              'knafkqv3' /* Duration */,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .bodyMediumFamily,
                                  fontSize: 18.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .bodyMediumIsCustom,
                                ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 16.0),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Color(0xFFF8FAFC),
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          FFLocalizations.of(context).getText(
                                            'bdfd9iyb' /* Minutes */,
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMediumFamily,
                                                fontSize: 16.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w600,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMediumIsCustom,
                                              ),
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          borderRadius:
                                              BorderRadius.circular(100.0),
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  12.0, 4.0, 12.0, 4.0),
                                          child: Text(
                                            valueOrDefault<String>(
                                              _model.selectMin?.toString(),
                                              '0',
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumFamily,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                  fontSize: 18.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.bold,
                                                  useGoogleFonts:
                                                      !FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumIsCustom,
                                                ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  custom_widgets.AgeRuler(
                                    width: double.infinity,
                                    height: 100.0,
                                    min: 10,
                                    max: 180,
                                    initVal: 30,
                                    age: (ageVal) async {
                                      _model.selectMin = ageVal;
                                      safeSetState(() {});
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 16.0),
                          child: Text(
                            FFLocalizations.of(context).getText(
                              'ois7js4v' /* Intensity */,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .bodyMediumFamily,
                                  fontSize: 18.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .bodyMediumIsCustom,
                                ),
                          ),
                        ),
                        Builder(
                          builder: (context) {
                            final intensityInfo = _model.intensity.toList();

                            return Row(
                              mainAxisSize: MainAxisSize.max,
                              children: List.generate(intensityInfo.length,
                                  (intensityInfoIndex) {
                                final intensityInfoItem =
                                    intensityInfo[intensityInfoIndex];
                                return Expanded(
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      _model.selectedIntensity =
                                          intensityInfoItem;
                                      safeSetState(() {});
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: valueOrDefault<Color>(
                                          intensityInfoItem ==
                                                  _model.selectedIntensity
                                              ? Color(0x19F20D0D)
                                              : Color(0xFFF8FAFC),
                                          Color(0xFFF8FAFC),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(100.0),
                                        border: Border.all(
                                          color: valueOrDefault<Color>(
                                            intensityInfoItem ==
                                                    _model.selectedIntensity
                                                ? FlutterFlowTheme.of(context)
                                                    .primary
                                                : Color(0xFFF8FAFC),
                                            Color(0xFFF8FAFC),
                                          ),
                                          width: 2.0,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(12.0),
                                        child: Text(
                                          valueOrDefault<String>(
                                            functions.languagefuncation(
                                                intensityInfoItem,
                                                FFLocalizations.of(context)
                                                    .languageCode,
                                                FFAppState().translationsCSV),
                                            'Low',
                                          ),
                                          textAlign: TextAlign.center,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMediumFamily,
                                                color: valueOrDefault<Color>(
                                                  intensityInfoItem ==
                                                          _model
                                                              .selectedIntensity
                                                      ? FlutterFlowTheme.of(
                                                              context)
                                                          .primary
                                                      : FlutterFlowTheme.of(
                                                              context)
                                                          .primaryText,
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                                ),
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w600,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMediumIsCustom,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }).divide(SizedBox(width: 12.0)),
                            );
                          },
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 32.0, 0.0, 16.0),
                          child: Text(
                            FFLocalizations.of(context).getText(
                              '2hbflxt3' /* Time of Activity */,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .bodyMediumFamily,
                                  fontSize: 18.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .bodyMediumIsCustom,
                                ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 12.0),
                          child: Builder(
                            builder: (context) {
                              final timeI =
                                  _model.timeList.toList().take(2).toList();

                              return Row(
                                mainAxisSize: MainAxisSize.max,
                                children:
                                    List.generate(timeI.length, (timeIIndex) {
                                  final timeIItem = timeI[timeIIndex];
                                  return Expanded(
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        _model.timeInfo = timeIItem;
                                        safeSetState(() {});
                                      },
                                      child: Container(
                                        width: 100.0,
                                        decoration: BoxDecoration(
                                          color: valueOrDefault<Color>(
                                            timeIItem == _model.timeInfo
                                                ? Color(0x1AF20D0D)
                                                : Color(0xFFF8FAFC),
                                            Color(0xFFF8FAFC),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(100.0),
                                          border: Border.all(
                                            color: valueOrDefault<Color>(
                                              timeIItem == _model.timeInfo
                                                  ? FlutterFlowTheme.of(context)
                                                      .primary
                                                  : Color(0xFFF1F5F9),
                                              Color(0xFFF1F5F9),
                                            ),
                                            width: 2.0,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(17.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              FaIcon(
                                                FontAwesomeIcons.clock,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                size: 20.0,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  valueOrDefault<String>(
                                                    functions.languagefuncation(
                                                        timeIItem,
                                                        FFLocalizations.of(
                                                                context)
                                                            .languageCode,
                                                        FFAppState()
                                                            .translationsCSV),
                                                    'Now',
                                                  ),
                                                  style:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumFamily,
                                                            color:
                                                                valueOrDefault<
                                                                    Color>(
                                                              timeIItem ==
                                                                      _model
                                                                          .timeInfo
                                                                  ? FlutterFlowTheme.of(
                                                                          context)
                                                                      .primary
                                                                  : FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .primaryText,
                                                            ),
                                                            fontSize: 16.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            useGoogleFonts:
                                                                !FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumIsCustom,
                                                          ),
                                                ),
                                              ),
                                            ].divide(SizedBox(width: 12.0)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }).divide(SizedBox(width: 16.0)),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 30.0),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              _model.timeInfo = _model.timeList.lastOrNull!;
                              safeSetState(() {});
                              await showModalBottomSheet(
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                enableDrag: false,
                                context: context,
                                builder: (context) {
                                  return GestureDetector(
                                    onTap: () {
                                      FocusScope.of(context).unfocus();
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                    },
                                    child: Padding(
                                      padding: MediaQuery.viewInsetsOf(context),
                                      child: MealTimeWidget(),
                                    ),
                                  );
                                },
                              ).then((value) => safeSetState(() {}));
                            },
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100.0),
                                border: Border.all(
                                  color: Color(0xFFF1F5F9),
                                  width: 2.0,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(17.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    FaIcon(
                                      FontAwesomeIcons.clock,
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      size: 20.0,
                                    ),
                                    Expanded(
                                      child: Text(
                                        valueOrDefault<String>(
                                          functions.languagefuncation(
                                              _model.timeList.lastOrNull,
                                              FFLocalizations.of(context)
                                                  .languageCode,
                                              FFAppState().translationsCSV),
                                          'Custom Time',
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMediumFamily,
                                              fontSize: 16.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w500,
                                              useGoogleFonts:
                                                  !FlutterFlowTheme.of(context)
                                                      .bodyMediumIsCustom,
                                            ),
                                      ),
                                    ),
                                    Icon(
                                      Icons.chevron_right,
                                      color: FlutterFlowTheme.of(context).text1,
                                      size: 20.0,
                                    ),
                                  ].divide(SizedBox(width: 12.0)),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Lottie.asset(
                          'assets/jsons/loading_barline.json',
                          width: MediaQuery.sizeOf(context).width * 1.0,
                          height: 20.0,
                          fit: BoxFit.contain,
                          animate: true,
                        ),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: Image.asset(
                                'assets/images/dot_line2.png',
                              ).image,
                            ),
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(32.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 16.0),
                                  child: Container(
                                    width: 48.0,
                                    height: 48.0,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 2.0,
                                          color: Color(0x0D000000),
                                          offset: Offset(
                                            0.0,
                                            1.0,
                                          ),
                                        )
                                      ],
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.interests_sharp,
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      size: 24.0,
                                    ),
                                  ),
                                ),
                                Text(
                                  FFLocalizations.of(context).getText(
                                    'f0i3g0ss' /* Estimated burn will appear her... */,
                                  ),
                                  textAlign: TextAlign.center,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .bodyMediumFamily,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
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
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 24.0),
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 56.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
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
                      },
                      text: FFLocalizations.of(context).getText(
                        '1rowrp3y' /* CALCULATE BURN */,
                      ),
                      icon: Icon(
                        Icons.electric_bolt_outlined,
                        size: 24.0,
                      ),
                      options: FFButtonOptions(
                        width: double.infinity,
                        height: 56.0,
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 0.0, 16.0, 0.0),
                        iconAlignment: IconAlignment.start,
                        iconPadding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 2.5, 0.0, 0.0),
                        color: FlutterFlowTheme.of(context).primary,
                        textStyle: FlutterFlowTheme.of(context)
                            .titleSmall
                            .override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).titleSmallFamily,
                              color: Colors.white,
                              fontSize: 18.0,
                              letterSpacing: 0.9,
                              fontWeight: FontWeight.w800,
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
        ),
      ),
    );
  }
}
