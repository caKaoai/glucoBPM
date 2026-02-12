import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/nav_bar/nav/nav_widget.dart';
import '/plan/home_plan/home_plan_widget.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'health_plan_model.dart';
export 'health_plan_model.dart';

class HealthPlanWidget extends StatefulWidget {
  const HealthPlanWidget({super.key});

  static String routeName = 'HealthPlan';
  static String routePath = '/healthPlan';

  @override
  State<HealthPlanWidget> createState() => _HealthPlanWidgetState();
}

class _HealthPlanWidgetState extends State<HealthPlanWidget>
    with TickerProviderStateMixin {
  late HealthPlanModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HealthPlanModel());

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
        body: NestedScrollView(
          floatHeaderSlivers: false,
          headerSliverBuilder: (context, _) => [
            SliverAppBar(
              pinned: false,
              floating: false,
              backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
              automaticallyImplyLeading: false,
              title: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 5.0, 0.0),
                child: Text(
                  'AI Care',
                  style: FlutterFlowTheme.of(context).headlineMedium.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).headlineMediumFamily,
                        color: FlutterFlowTheme.of(context).primaryText,
                        fontSize: 28.0,
                        letterSpacing: 0.0,
                        useGoogleFonts: !FlutterFlowTheme.of(context)
                            .headlineMediumIsCustom,
                      ),
                ),
              ),
              actions: [],
              centerTitle: false,
              elevation: 0.0,
            )
          ],
          body: Builder(
            builder: (context) {
              return Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(20.0, 10.0, 0.0, 0.0),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 12.0),
                              child: Text(
                                'Heart Health',
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
                            ),
                            Builder(
                              builder: (context) {
                                final health = FFAppState()
                                    .hearthHealth
                                    .where((e) => e.type == 'heart')
                                    .toList();

                                return SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: List.generate(health.length,
                                            (healthIndex) {
                                      final healthItem = health[healthIndex];
                                      return wrapWithModel(
                                        model: _model.homePlanModels1.getModel(
                                          healthIndex.toString(),
                                          healthIndex,
                                        ),
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: HomePlanWidget(
                                          key: Key(
                                            'Keypoc_${healthIndex.toString()}',
                                          ),
                                          info: healthItem,
                                          type: 'Heart Health',
                                        ),
                                      );
                                    })
                                        .divide(SizedBox(width: 12.0))
                                        .addToEnd(SizedBox(width: 20.0)),
                                  ),
                                );
                              },
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 16.0, 20.0, 12.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Activity',
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
                                  Expanded(
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        context.pushNamed(
                                          MoreViewWidget.routeName,
                                          queryParameters: {
                                            'infoOfPaln': serializeParam(
                                              FFAppState()
                                                  .hearthHealth
                                                  .where((e) =>
                                                      e.type == 'activity')
                                                  .toList(),
                                              ParamType.DataStruct,
                                              isList: true,
                                            ),
                                            'title': serializeParam(
                                              'Activity',
                                              ParamType.String,
                                            ),
                                          }.withoutNulls,
                                        );
                                      },
                                      child: Text(
                                        'Show More >',
                                        textAlign: TextAlign.end,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMediumFamily,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .accent1,
                                              fontSize: 13.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w500,
                                              useGoogleFonts:
                                                  !FlutterFlowTheme.of(context)
                                                      .bodyMediumIsCustom,
                                            ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Builder(
                              builder: (context) {
                                final health = FFAppState()
                                    .hearthHealth
                                    .where((e) => e.type == 'activity')
                                    .toList()
                                    .take(3)
                                    .toList();

                                return SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: List.generate(health.length,
                                            (healthIndex) {
                                      final healthItem = health[healthIndex];
                                      return wrapWithModel(
                                        model: _model.homePlanModels2.getModel(
                                          healthItem.name,
                                          healthIndex,
                                        ),
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: HomePlanWidget(
                                          key: Key(
                                            'Keyoo7_${healthItem.name}',
                                          ),
                                          info: healthItem,
                                          type: 'Activity',
                                        ),
                                      );
                                    })
                                        .divide(SizedBox(width: 12.0))
                                        .addToEnd(SizedBox(width: 20.0)),
                                  ),
                                );
                              },
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 16.0, 20.0, 12.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Text(
                                      'DASH Diet',
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
                                  Expanded(
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        context.pushNamed(
                                          MoreViewWidget.routeName,
                                          queryParameters: {
                                            'infoOfPaln': serializeParam(
                                              FFAppState()
                                                  .hearthHealth
                                                  .where(
                                                      (e) => e.type == 'diet')
                                                  .toList(),
                                              ParamType.DataStruct,
                                              isList: true,
                                            ),
                                            'title': serializeParam(
                                              'DASH Diet',
                                              ParamType.String,
                                            ),
                                          }.withoutNulls,
                                        );
                                      },
                                      child: Text(
                                        'Show More >',
                                        textAlign: TextAlign.end,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMediumFamily,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .accent1,
                                              fontSize: 13.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w500,
                                              useGoogleFonts:
                                                  !FlutterFlowTheme.of(context)
                                                      .bodyMediumIsCustom,
                                            ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Builder(
                              builder: (context) {
                                final health = FFAppState()
                                    .hearthHealth
                                    .where((e) => e.type == 'diet')
                                    .toList()
                                    .take(3)
                                    .toList();

                                return SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: List.generate(health.length,
                                            (healthIndex) {
                                      final healthItem = health[healthIndex];
                                      return wrapWithModel(
                                        model: _model.homePlanModels3.getModel(
                                          healthItem.name,
                                          healthIndex,
                                        ),
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: HomePlanWidget(
                                          key: Key(
                                            'Keyo02_${healthItem.name}',
                                          ),
                                          info: healthItem,
                                          type: 'DASH Diet',
                                        ),
                                      );
                                    })
                                        .divide(SizedBox(width: 12.0))
                                        .addToEnd(SizedBox(width: 20.0)),
                                  ),
                                );
                              },
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 16.0, 20.0, 12.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Lifestyle',
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
                                  Expanded(
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        context.pushNamed(
                                          MoreViewWidget.routeName,
                                          queryParameters: {
                                            'infoOfPaln': serializeParam(
                                              FFAppState()
                                                  .hearthHealth
                                                  .where((e) =>
                                                      e.type == 'lifestyle')
                                                  .toList(),
                                              ParamType.DataStruct,
                                              isList: true,
                                            ),
                                            'title': serializeParam(
                                              'Lifestyle',
                                              ParamType.String,
                                            ),
                                          }.withoutNulls,
                                        );
                                      },
                                      child: Text(
                                        'Show More >',
                                        textAlign: TextAlign.end,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMediumFamily,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .accent1,
                                              fontSize: 13.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w500,
                                              useGoogleFonts:
                                                  !FlutterFlowTheme.of(context)
                                                      .bodyMediumIsCustom,
                                            ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Builder(
                              builder: (context) {
                                final health = FFAppState()
                                    .hearthHealth
                                    .where((e) => e.type == 'lifestyle')
                                    .toList()
                                    .take(3)
                                    .toList();

                                return SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: List.generate(health.length,
                                            (healthIndex) {
                                      final healthItem = health[healthIndex];
                                      return wrapWithModel(
                                        model: _model.homePlanModels4.getModel(
                                          healthItem.name,
                                          healthIndex,
                                        ),
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: HomePlanWidget(
                                          key: Key(
                                            'Keyh1x_${healthItem.name}',
                                          ),
                                          info: healthItem,
                                          type: 'Lifestyle',
                                        ),
                                      );
                                    })
                                        .divide(SizedBox(width: 12.0))
                                        .addToEnd(SizedBox(width: 20.0)),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ).animateOnPageLoad(
                          animationsMap['columnOnPageLoadAnimation']!),
                    ),
                  ),
                  wrapWithModel(
                    model: _model.navModel,
                    updateCallback: () => safeSetState(() {}),
                    child: NavWidget(
                      index: 2,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
