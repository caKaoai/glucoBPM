import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
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
    return Stack(
      children: [
        Container(
          height: 105.3,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(25.0, 0.0, 25.0, 0.0),
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
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          FFIcons.k28,
                          color: valueOrDefault<Color>(
                            _model.index == 0
                                ? FlutterFlowTheme.of(context).primary
                                : FlutterFlowTheme.of(context).text1,
                            FlutterFlowTheme.of(context).text1,
                          ),
                          size: 22.0,
                        ),
                        AnimatedDefaultTextStyle(
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    font: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    color: valueOrDefault<Color>(
                                      _model.index == 0
                                          ? FlutterFlowTheme.of(context).primary
                                          : FlutterFlowTheme.of(context).text1,
                                      FlutterFlowTheme.of(context).text1,
                                    ),
                                    fontSize: 10.0,
                                    letterSpacing: 1.2,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeOut,
                          child: Text(
                            FFLocalizations.of(context).getText(
                              '9qm68qe1' /* HOME */,
                            ),
                          ),
                        ),
                      ].divide(SizedBox(height: 6.0)),
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
                            FoodPageWidget.routeName,
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
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          FFIcons.k27,
                          color: valueOrDefault<Color>(
                            _model.index == 1
                                ? FlutterFlowTheme.of(context).primary
                                : FlutterFlowTheme.of(context).text1,
                            FlutterFlowTheme.of(context).text1,
                          ),
                          size: 22.0,
                        ),
                        AnimatedDefaultTextStyle(
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    font: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    color: valueOrDefault<Color>(
                                      _model.index == 1
                                          ? FlutterFlowTheme.of(context).primary
                                          : FlutterFlowTheme.of(context).text1,
                                      FlutterFlowTheme.of(context).text1,
                                    ),
                                    fontSize: 10.0,
                                    letterSpacing: 1.2,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeOut,
                          child: Text(
                            FFLocalizations.of(context).getText(
                              '7ntpvgft' /* FOOD */,
                            ),
                          ),
                        ),
                      ].divide(SizedBox(height: 6.0)),
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
                          _model.index = 2;
                          safeSetState(() {});
                        }),
                      ]);
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          FFIcons.k26,
                          color: valueOrDefault<Color>(
                            _model.index == 2
                                ? FlutterFlowTheme.of(context).primary
                                : FlutterFlowTheme.of(context).text1,
                            FlutterFlowTheme.of(context).text1,
                          ),
                          size: 22.0,
                        ),
                        AnimatedDefaultTextStyle(
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    font: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    color: valueOrDefault<Color>(
                                      _model.index == 2
                                          ? FlutterFlowTheme.of(context).primary
                                          : FlutterFlowTheme.of(context).text1,
                                      FlutterFlowTheme.of(context).text1,
                                    ),
                                    fontSize: 10.0,
                                    letterSpacing: 1.2,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeOut,
                          child: Text(
                            FFLocalizations.of(context).getText(
                              'qju0u15a' /* HEALTH */,
                            ),
                          ),
                        ),
                      ].divide(SizedBox(height: 6.0)),
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
                      ]);
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          FFIcons.k25,
                          color: valueOrDefault<Color>(
                            _model.index == 3
                                ? FlutterFlowTheme.of(context).primary
                                : FlutterFlowTheme.of(context).text1,
                            FlutterFlowTheme.of(context).text1,
                          ),
                          size: 22.0,
                        ),
                        AnimatedDefaultTextStyle(
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    font: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    color: valueOrDefault<Color>(
                                      _model.index == 3
                                          ? FlutterFlowTheme.of(context).primary
                                          : FlutterFlowTheme.of(context).text1,
                                      FlutterFlowTheme.of(context).text1,
                                    ),
                                    fontSize: 10.0,
                                    letterSpacing: 1.2,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeOut,
                          child: Text(
                            FFLocalizations.of(context).getText(
                              '7ek940ta' /* REPORTS */,
                            ),
                          ),
                        ),
                      ].divide(SizedBox(height: 6.0)),
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
                          _model.index = 4;
                          safeSetState(() {});
                        }),
                      ]);
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          FFIcons.k24,
                          color: valueOrDefault<Color>(
                            _model.index == 4
                                ? FlutterFlowTheme.of(context).primary
                                : FlutterFlowTheme.of(context).text1,
                            FlutterFlowTheme.of(context).text1,
                          ),
                          size: 22.0,
                        ),
                        AnimatedDefaultTextStyle(
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    font: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    color: valueOrDefault<Color>(
                                      _model.index == 4
                                          ? FlutterFlowTheme.of(context).primary
                                          : FlutterFlowTheme.of(context).text1,
                                      FlutterFlowTheme.of(context).text1,
                                    ),
                                    fontSize: 10.0,
                                    letterSpacing: 1.2,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeOut,
                          child: Text(
                            FFLocalizations.of(context).getText(
                              'aat8aa9m' /* PROFILE */,
                            ),
                          ),
                        ),
                      ].divide(SizedBox(height: 6.0)),
                    ),
                  ),
                ),
              ].divide(SizedBox(width: 16.0)),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: 1.0,
          decoration: BoxDecoration(
            color: Color(0xFFF1F5F9),
          ),
        ),
      ],
    );
  }
}
