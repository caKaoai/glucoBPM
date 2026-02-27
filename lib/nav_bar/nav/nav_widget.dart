import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/permissions_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'nav_model.dart';
export 'nav_model.dart';

/// New Component Gen
class NavWidget extends StatefulWidget {
  const NavWidget({
    super.key,
    required this.index,
  });

  final int? index;

  @override
  State<NavWidget> createState() => _NavWidgetState();
}

class _NavWidgetState extends State<NavWidget> {
  late NavModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NavModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.index = widget.index;
      safeSetState(() {});
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

    return Stack(
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0.0, 30.0, 0.0, 0.0),
          child: Container(
            height: 70.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: Image.asset(
                  'assets/images/bg_(1).png',
                ).image,
              ),
              boxShadow: [
                BoxShadow(
                  blurRadius: 30.0,
                  color: Color(0x44D7D7D7),
                  offset: Offset(
                    0.0,
                    -20.0,
                  ),
                  spreadRadius: 0.0,
                )
              ],
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(12.0, 12.0, 12.0, 12.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        await Future.wait([
                          Future(() async {
                            _model.index = 0;
                            safeSetState(() {});
                          }),
                          Future(() async {
                            context.goNamed(
                              HomePageWidget.routeName,
                              extra: <String, dynamic>{
                                '__transition_info__': TransitionInfo(
                                  hasTransition: true,
                                  transitionType: PageTransitionType.fade,
                                  duration: Duration(milliseconds: 0),
                                ),
                              },
                            );
                          }),
                        ]);
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Icon(
                            FFIcons.khome,
                            color: valueOrDefault<Color>(
                              _model.index == 0
                                  ? FlutterFlowTheme.of(context).primary
                                  : FlutterFlowTheme.of(context).customColor3,
                              FlutterFlowTheme.of(context).customColor3,
                            ),
                            size: 22.0,
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 4.0, 0.0, 0.0),
                            child: AnimatedDefaultTextStyle(
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    font: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    color: valueOrDefault<Color>(
                                      _model.index == 0
                                          ? FlutterFlowTheme.of(context).primary
                                          : FlutterFlowTheme.of(context)
                                              .customColor3,
                                      FlutterFlowTheme.of(context).customColor3,
                                    ),
                                    fontSize: 12.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeOut,
                              child: Text(
                                'Home',
                              ),
                            ),
                          ),
                        ],
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
                        await Future.wait([
                          Future(() async {
                            _model.index = 1;
                            safeSetState(() {});
                          }),
                          Future(() async {
                            context.goNamed(
                              AicareWidget.routeName,
                              extra: <String, dynamic>{
                                '__transition_info__': TransitionInfo(
                                  hasTransition: true,
                                  transitionType: PageTransitionType.fade,
                                  duration: Duration(milliseconds: 0),
                                ),
                              },
                            );
                          }),
                        ]);
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Icon(
                            FFIcons.khealthcare,
                            color: valueOrDefault<Color>(
                              _model.index == 1
                                  ? FlutterFlowTheme.of(context).primary
                                  : FlutterFlowTheme.of(context).customColor3,
                              FlutterFlowTheme.of(context).customColor3,
                            ),
                            size: 26.0,
                          ),
                          AnimatedDefaultTextStyle(
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  font: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                                  color: valueOrDefault<Color>(
                                    _model.index == 1
                                        ? FlutterFlowTheme.of(context).primary
                                        : FlutterFlowTheme.of(context)
                                            .customColor3,
                                    FlutterFlowTheme.of(context).customColor3,
                                  ),
                                  fontSize: 12.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeOut,
                            child: Text(
                              'AI Care',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        await Future.wait([
                          Future(() async {
                            _model.index = 2;
                            safeSetState(() {});
                          }),
                          Future(() async {
                            if (FFAppState().UserTracking.planFirst) {
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
                            } else {
                              context.goNamed(
                                PlanOnBoardingWidget.routeName,
                                extra: <String, dynamic>{
                                  '__transition_info__': TransitionInfo(
                                    hasTransition: true,
                                    transitionType: PageTransitionType.fade,
                                    duration: Duration(milliseconds: 0),
                                  ),
                                },
                              );
                            }
                          }),
                        ]);
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Icon(
                            FFIcons.kclipboard,
                            color: valueOrDefault<Color>(
                              _model.index == 2
                                  ? FlutterFlowTheme.of(context).primary
                                  : FlutterFlowTheme.of(context).customColor3,
                              FlutterFlowTheme.of(context).customColor3,
                            ),
                            size: 22.0,
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 4.0, 0.0, 0.0),
                            child: AnimatedDefaultTextStyle(
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    font: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    color: valueOrDefault<Color>(
                                      _model.index == 2
                                          ? FlutterFlowTheme.of(context).primary
                                          : FlutterFlowTheme.of(context)
                                              .customColor3,
                                      FlutterFlowTheme.of(context).customColor3,
                                    ),
                                    fontSize: 12.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeOut,
                              child: Text(
                                'Plan',
                              ),
                            ),
                          ),
                        ],
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
                        await Future.wait([
                          Future(() async {
                            _model.index = 3;
                            safeSetState(() {});
                          }),
                          Future(() async {
                            context.goNamed(
                              SettingPageWidget.routeName,
                              extra: <String, dynamic>{
                                '__transition_info__': TransitionInfo(
                                  hasTransition: true,
                                  transitionType: PageTransitionType.fade,
                                  duration: Duration(milliseconds: 0),
                                ),
                              },
                            );
                          }),
                        ]);
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Icon(
                            FFIcons.ksetting,
                            color: valueOrDefault<Color>(
                              _model.index == 3
                                  ? FlutterFlowTheme.of(context).primary
                                  : FlutterFlowTheme.of(context).customColor3,
                              FlutterFlowTheme.of(context).customColor3,
                            ),
                            size: 22.0,
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 4.0, 0.0, 0.0),
                            child: AnimatedDefaultTextStyle(
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .bodyMediumFamily,
                                    color: valueOrDefault<Color>(
                                      _model.index == 3
                                          ? FlutterFlowTheme.of(context).primary
                                          : FlutterFlowTheme.of(context)
                                              .customColor3,
                                      FlutterFlowTheme.of(context).customColor3,
                                    ),
                                    fontSize: 12.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
                                            .bodyMediumIsCustom,
                                  ),
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeOut,
                              child: Text(
                                'Settings',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ].divide(SizedBox(width: 16.0)),
              ),
            ),
          ),
        ),
        Align(
          alignment: AlignmentDirectional(0.0, -1.0),
          child: InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () async {
              await requestPermission(cameraPermission);
              if (await getPermissionStatus(cameraPermission)) {
                context.pushNamed(BPMTrackingWidget.routeName);
              } else {
                await actions.redirectSetting(
                  0,
                );
              }
            },
            child: Container(
              width: 60.0,
              height: 60.0,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).primary,
                shape: BoxShape.circle,
              ),
              alignment: AlignmentDirectional(0.0, 0.0),
              child: Align(
                alignment: AlignmentDirectional(0.0, 0.0),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Lottie.asset(
                    'assets/jsons/Heart_Rate_white.json',
                    width: 80.0,
                    height: 80.0,
                    fit: BoxFit.cover,
                    animate: true,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
