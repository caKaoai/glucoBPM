import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'plan_f_q_start_model.dart';
export 'plan_f_q_start_model.dart';

class PlanFQStartWidget extends StatefulWidget {
  const PlanFQStartWidget({super.key});

  static String routeName = 'PlanFQStart';
  static String routePath = '/planFQStart';

  @override
  State<PlanFQStartWidget> createState() => _PlanFQStartWidgetState();
}

class _PlanFQStartWidgetState extends State<PlanFQStartWidget>
    with TickerProviderStateMixin {
  late PlanFQStartModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PlanFQStartModel());

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
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
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
              if (_model.pageViewCurrentIndex == 0) {
                context.goNamed(HomePageWidget.routeName);
              } else {
                await _model.pageViewController?.previousPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.ease,
                );
              }
            },
          ),
          title: Container(
            width: 200.0,
            child: Align(
              alignment: AlignmentDirectional(-1.0, 1.0),
              child: LinearPercentIndicator(
                percent: () {
                  if (_model.pageViewCurrentIndex == 0) {
                    return 0.33;
                  } else if (_model.pageViewCurrentIndex == 1) {
                    return 0.66;
                  } else {
                    return 1.0;
                  }
                }(),
                width: 200.0,
                lineHeight: 12.0,
                animation: true,
                animateFromLastPercent: true,
                progressColor: FlutterFlowTheme.of(context).primary,
                backgroundColor: Color(0xFFF5DDE9),
                center: Text(
                  '0',
                  style: FlutterFlowTheme.of(context).headlineSmall.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).headlineSmallFamily,
                        fontSize: 0.0,
                        letterSpacing: 0.0,
                        useGoogleFonts:
                            !FlutterFlowTheme.of(context).headlineSmallIsCustom,
                      ),
                ),
                barRadius: Radius.circular(16.0),
                padding: EdgeInsets.zero,
              ),
            ),
          ),
          actions: [
            FlutterFlowIconButton(
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
          ],
          centerTitle: true,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(25.0, 0.0, 25.0, 0.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Align(
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(5.0, 30.0, 5.0, 0.0),
                    child: Text(
                      () {
                        if (_model.pageViewCurrentIndex == 1) {
                          return 'Which Type of Plan Do You Want to Join?';
                        } else if (_model.pageViewCurrentIndex == 2) {
                          return 'Which Type of Exercise Do You Want to Join?';
                        } else {
                          return 'What Health Issues Are You Concerned About?';
                        }
                      }(),
                      textAlign: TextAlign.center,
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyMediumFamily,
                            fontSize: 20.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w600,
                            useGoogleFonts: !FlutterFlowTheme.of(context)
                                .bodyMediumIsCustom,
                          ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    height: 500.0,
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 40.0),
                      child: PageView(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: _model.pageViewController ??=
                            PageController(initialPage: 0),
                        onPageChanged: (_) => safeSetState(() {}),
                        scrollDirection: Axis.horizontal,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 20.0, 0.0, 0.0),
                            child: Builder(
                              builder: (context) {
                                final healthInfo = FFAppState()
                                    .PlanFAQ
                                    .where((e) => e.type == 'health')
                                    .toList();

                                return GridView.builder(
                                  padding: EdgeInsets.zero,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 10.0,
                                    mainAxisSpacing: 10.0,
                                    childAspectRatio: 1.0,
                                  ),
                                  scrollDirection: Axis.vertical,
                                  itemCount: healthInfo.length,
                                  itemBuilder: (context, healthInfoIndex) {
                                    final healthInfoItem =
                                        healthInfo[healthInfoIndex];
                                    return Container(
                                      width: 100.0,
                                      height: 100.0,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: CachedNetworkImageProvider(
                                            valueOrDefault<String>(
                                              healthInfoItem.photo,
                                              'https://images.unsplash.com/photo-1526256262350-7da7584cf5eb?crop=entropy&cs=srgb&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwxNHx8aGVhbHRofGVufDB8fHx8MTc2OTE1Mjk2N3ww&ixlib=rb-4.1.0&q=85',
                                            ),
                                          ),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      child: InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          if (_model.selectIds
                                              .contains(healthInfoItem.id)) {
                                            _model.removeFromSelectIds(
                                                healthInfoItem.id);
                                            safeSetState(() {});
                                          } else {
                                            _model.addToSelectIds(
                                                healthInfoItem.id);
                                            safeSetState(() {});
                                          }
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                Colors.transparent,
                                                Color(0xCC000000)
                                              ],
                                              stops: [0.0, 1.0],
                                              begin: AlignmentDirectional(
                                                  0.0, -1.0),
                                              end: AlignmentDirectional(0, 1.0),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                          ),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 10.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                  healthInfoItem.name,
                                                  textAlign: TextAlign.center,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMediumFamily,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondary,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        useGoogleFonts:
                                                            !FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMediumIsCustom,
                                                      ),
                                                ),
                                                Builder(
                                                  builder: (context) {
                                                    if (!_model.selectIds
                                                        .contains(healthInfoItem
                                                            .id)) {
                                                      return Icon(
                                                        Icons
                                                            .check_box_outline_blank_rounded,
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                        size: 24.0,
                                                      );
                                                    } else {
                                                      return FaIcon(
                                                        FontAwesomeIcons
                                                            .solidCheckSquare,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                        size: 24.0,
                                                      );
                                                    }
                                                  },
                                                ),
                                              ].divide(SizedBox(height: 6.0)),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 20.0, 0.0, 0.0),
                            child: Builder(
                              builder: (context) {
                                final healthInfo = FFAppState()
                                    .PlanFAQ
                                    .where((e) => e.type == 'plan')
                                    .toList();

                                return GridView.builder(
                                  padding: EdgeInsets.zero,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 10.0,
                                    mainAxisSpacing: 10.0,
                                    childAspectRatio: 1.0,
                                  ),
                                  scrollDirection: Axis.vertical,
                                  itemCount: healthInfo.length,
                                  itemBuilder: (context, healthInfoIndex) {
                                    final healthInfoItem =
                                        healthInfo[healthInfoIndex];
                                    return Container(
                                      width: 100.0,
                                      height: 100.0,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: CachedNetworkImageProvider(
                                            valueOrDefault<String>(
                                              healthInfoItem.photo,
                                              'https://images.unsplash.com/photo-1526256262350-7da7584cf5eb?crop=entropy&cs=srgb&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwxNHx8aGVhbHRofGVufDB8fHx8MTc2OTE1Mjk2N3ww&ixlib=rb-4.1.0&q=85',
                                            ),
                                          ),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      child: InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          if (_model.selectIds
                                              .contains(healthInfoItem.id)) {
                                            _model.removeFromSelectIds(
                                                healthInfoItem.id);
                                            safeSetState(() {});
                                          } else {
                                            _model.addToSelectIds(
                                                healthInfoItem.id);
                                            safeSetState(() {});
                                          }
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                Colors.transparent,
                                                Color(0xCC000000)
                                              ],
                                              stops: [0.0, 1.0],
                                              begin: AlignmentDirectional(
                                                  0.0, -1.0),
                                              end: AlignmentDirectional(0, 1.0),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                          ),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 10.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                  healthInfoItem.name,
                                                  textAlign: TextAlign.center,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMediumFamily,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondary,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        useGoogleFonts:
                                                            !FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMediumIsCustom,
                                                      ),
                                                ),
                                                Builder(
                                                  builder: (context) {
                                                    if (!_model.selectIds
                                                        .contains(healthInfoItem
                                                            .id)) {
                                                      return Icon(
                                                        Icons
                                                            .check_box_outline_blank_rounded,
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                        size: 24.0,
                                                      );
                                                    } else {
                                                      return FaIcon(
                                                        FontAwesomeIcons
                                                            .solidCheckSquare,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                        size: 24.0,
                                                      );
                                                    }
                                                  },
                                                ),
                                              ].divide(SizedBox(height: 6.0)),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 20.0, 0.0, 0.0),
                            child: Builder(
                              builder: (context) {
                                final healthInfo = FFAppState()
                                    .PlanFAQ
                                    .where((e) => e.type == 'exercise')
                                    .toList();

                                return GridView.builder(
                                  padding: EdgeInsets.zero,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 10.0,
                                    mainAxisSpacing: 10.0,
                                    childAspectRatio: 1.0,
                                  ),
                                  scrollDirection: Axis.vertical,
                                  itemCount: healthInfo.length,
                                  itemBuilder: (context, healthInfoIndex) {
                                    final healthInfoItem =
                                        healthInfo[healthInfoIndex];
                                    return Container(
                                      width: 100.0,
                                      height: 100.0,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: CachedNetworkImageProvider(
                                            valueOrDefault<String>(
                                              healthInfoItem.photo,
                                              'https://images.unsplash.com/photo-1526256262350-7da7584cf5eb?crop=entropy&cs=srgb&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwxNHx8aGVhbHRofGVufDB8fHx8MTc2OTE1Mjk2N3ww&ixlib=rb-4.1.0&q=85',
                                            ),
                                          ),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      child: InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          if (_model.selectIds
                                              .contains(healthInfoItem.id)) {
                                            _model.removeFromSelectIds(
                                                healthInfoItem.id);
                                            safeSetState(() {});
                                          } else {
                                            _model.addToSelectIds(
                                                healthInfoItem.id);
                                            safeSetState(() {});
                                          }
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                Colors.transparent,
                                                Color(0xCC000000)
                                              ],
                                              stops: [0.0, 1.0],
                                              begin: AlignmentDirectional(
                                                  0.0, -1.0),
                                              end: AlignmentDirectional(0, 1.0),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                          ),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 10.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                  healthInfoItem.name,
                                                  textAlign: TextAlign.center,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMediumFamily,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondary,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        useGoogleFonts:
                                                            !FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMediumIsCustom,
                                                      ),
                                                ),
                                                Builder(
                                                  builder: (context) {
                                                    if (!_model.selectIds
                                                        .contains(healthInfoItem
                                                            .id)) {
                                                      return Icon(
                                                        Icons
                                                            .check_box_outline_blank_rounded,
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                        size: 24.0,
                                                      );
                                                    } else {
                                                      return FaIcon(
                                                        FontAwesomeIcons
                                                            .solidCheckSquare,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                        size: 24.0,
                                                      );
                                                    }
                                                  },
                                                ),
                                              ].divide(SizedBox(height: 6.0)),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 30.0),
                  child: FFButtonWidget(
                    onPressed: () {
                      if ((_model.pageViewCurrentIndex == 0) &&
                          (FFAppState()
                              .PlanFAQ
                              .where((e) => e.type == 'health')
                              .toList()
                              .map((e) => e.id)
                              .toList()
                              .any(_model.selectIds.toList().contains))) {
                        return false;
                      } else if ((_model.pageViewCurrentIndex == 1) &&
                          (FFAppState()
                              .PlanFAQ
                              .where((e) => e.type == 'plan')
                              .toList()
                              .map((e) => e.id)
                              .toList()
                              .any(_model.selectIds.toList().contains))) {
                        return false;
                      } else if ((_model.pageViewCurrentIndex == 2) &&
                          (FFAppState()
                              .PlanFAQ
                              .where((e) => e.type == 'exercise')
                              .toList()
                              .map((e) => e.id)
                              .toList()
                              .any(_model.selectIds.toList().contains))) {
                        return false;
                      } else {
                        return true;
                      }
                    }()
                        ? null
                        : () async {
                            if (_model.pageViewCurrentIndex != 2) {
                              await _model.pageViewController?.nextPage(
                                duration: Duration(milliseconds: 300),
                                curve: Curves.ease,
                              );
                            } else {
                              await Future.wait([
                                Future(() async {
                                  context.goNamed(
                                    HealthPlanWidget.routeName,
                                    extra: <String, dynamic>{
                                      '__transition_info__': TransitionInfo(
                                        hasTransition: true,
                                        transitionType: PageTransitionType.fade,
                                        duration: Duration(milliseconds: 0),
                                      ),
                                    },
                                  );
                                }),
                                Future(() async {
                                  FFAppState().updateUserTrackingStruct(
                                    (e) => e..planFirst = true,
                                  );
                                  safeSetState(() {});
                                }),
                              ]);
                            }
                          },
                    text: 'Continue',
                    options: FFButtonOptions(
                      width: double.infinity,
                      height: 50.0,
                      padding:
                          EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: FlutterFlowTheme.of(context).primary,
                      textStyle: FlutterFlowTheme.of(context)
                          .titleSmall
                          .override(
                            fontFamily:
                                FlutterFlowTheme.of(context).titleSmallFamily,
                            color: Colors.white,
                            fontSize: 18.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w500,
                            useGoogleFonts: !FlutterFlowTheme.of(context)
                                .titleSmallIsCustom,
                          ),
                      elevation: 0.0,
                      borderRadius: BorderRadius.circular(12.0),
                      disabledColor: FlutterFlowTheme.of(context).secondaryText,
                      disabledTextColor: FlutterFlowTheme.of(context).alternate,
                    ),
                    showLoadingIndicator: false,
                  ),
                ),
              ],
            ).animateOnPageLoad(animationsMap['columnOnPageLoadAnimation']!),
          ),
        ),
      ),
    );
  }
}
