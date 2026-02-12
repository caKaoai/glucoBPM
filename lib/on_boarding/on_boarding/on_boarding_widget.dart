import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'
    as smooth_page_indicator;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'on_boarding_model.dart';
export 'on_boarding_model.dart';

class OnBoardingWidget extends StatefulWidget {
  const OnBoardingWidget({super.key});

  static String routeName = 'onBoarding';
  static String routePath = '/onBoarding';

  @override
  State<OnBoardingWidget> createState() => _OnBoardingWidgetState();
}

class _OnBoardingWidgetState extends State<OnBoardingWidget>
    with TickerProviderStateMixin {
  late OnBoardingModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => OnBoardingModel());

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
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SafeArea(
        top: true,
        child: Padding(
          padding: EdgeInsets.all(25.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 22.0),
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.sizeOf(context).height * 0.6,
                    child: Stack(
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 60.0),
                          child: PageView(
                            controller: _model.pageViewController ??=
                                PageController(initialPage: 0),
                            onPageChanged: (_) async {
                              _model.title = () {
                                if (_model.pageViewCurrentIndex == 1) {
                                  return 'Detailed Report';
                                } else if (_model.pageViewCurrentIndex == 2) {
                                  return 'Track Blood Pressure';
                                } else if (_model.pageViewCurrentIndex == 3) {
                                  return 'GlucoBPM needs your info';
                                } else {
                                  return 'Measure Heartbeat';
                                }
                              }();
                              _model.desc = () {
                                if (_model.pageViewCurrentIndex == 1) {
                                  return 'Get insights into your vital statistics to monitor changes in your mental state.';
                                } else if (_model.pageViewCurrentIndex == 2) {
                                  return 'Track the trends of historical data, high/low blood pressure prompts';
                                } else if (_model.pageViewCurrentIndex == 3) {
                                  return 'Get precise analysis and personalized recommendations';
                                } else {
                                  return 'Measure anytime and anywhere with just your phone';
                                }
                              }();
                              safeSetState(() {});
                            },
                            scrollDirection: Axis.horizontal,
                            children: [
                              Image.asset(
                                'assets/images/o1.png',
                                height: MediaQuery.sizeOf(context).height * 0.6,
                                fit: BoxFit.contain,
                              ),
                              Image.asset(
                                'assets/images/O3.png',
                                height: MediaQuery.sizeOf(context).height * 0.6,
                                fit: BoxFit.contain,
                              ),
                              Image.asset(
                                'assets/images/o12.png',
                                height: MediaQuery.sizeOf(context).height * 0.6,
                                fit: BoxFit.contain,
                              ),
                              Image.asset(
                                'assets/images/O4.png',
                                height: MediaQuery.sizeOf(context).height * 0.6,
                                fit: BoxFit.contain,
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(0.0, 1.0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                32.0, 0.0, 32.0, 0.0),
                            child: smooth_page_indicator.SmoothPageIndicator(
                              controller: _model.pageViewController ??=
                                  PageController(initialPage: 0),
                              count: 4,
                              axisDirection: Axis.horizontal,
                              onDotClicked: (i) async {
                                await _model.pageViewController!.animateToPage(
                                  i,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.ease,
                                );
                                safeSetState(() {});
                              },
                              effect: smooth_page_indicator.SlideEffect(
                                spacing: 6.0,
                                radius: 8.0,
                                dotWidth: 7.0,
                                dotHeight: 7.0,
                                dotColor: Color(0xFFFFD7DD),
                                activeDotColor:
                                    FlutterFlowTheme.of(context).primary,
                                paintStyle: PaintingStyle.fill,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 18.0),
                child: AnimatedDefaultTextStyle(
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).bodyMediumFamily,
                        color: FlutterFlowTheme.of(context).primary,
                        fontSize: 22.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w600,
                        useGoogleFonts:
                            !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                      ),
                  duration: Duration(milliseconds: 600),
                  curve: Curves.easeInOut,
                  child: Text(
                    valueOrDefault<String>(
                      _model.title,
                      'Measure Heartbeat',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(25.0, 0.0, 25.0, 35.0),
                child: AnimatedDefaultTextStyle(
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).bodyMediumFamily,
                        color: FlutterFlowTheme.of(context).secondaryText,
                        fontSize: 16.0,
                        letterSpacing: 0.0,
                        useGoogleFonts:
                            !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                      ),
                  duration: Duration(milliseconds: 600),
                  curve: Curves.easeInOut,
                  child: Text(
                    valueOrDefault<String>(
                      _model.desc,
                      'Measure anytime and anywhere with just your phone',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              FFButtonWidget(
                onPressed: () async {
                  if (_model.pageViewCurrentIndex != 3) {
                    await _model.pageViewController?.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.ease,
                    );
                  } else {
                    context.goNamed(PersonalizedAnalysis1Widget.routeName);
                  }

                  _model.title = () {
                    if (_model.pageViewCurrentIndex == 1) {
                      return 'Detailed Report';
                    } else if (_model.pageViewCurrentIndex == 2) {
                      return 'Track Blood Pressure';
                    } else if (_model.pageViewCurrentIndex == 3) {
                      return 'GlucoBPM needs your info';
                    } else {
                      return 'Measure Heartbeat';
                    }
                  }();
                  _model.desc = () {
                    if (_model.pageViewCurrentIndex == 1) {
                      return 'Get insights into your vital statistics to monitor changes in your mental state.';
                    } else if (_model.pageViewCurrentIndex == 2) {
                      return 'Track the trends of historical data, high/low blood pressure prompts';
                    } else if (_model.pageViewCurrentIndex == 3) {
                      return 'Get precise analysis and personalized recommendations';
                    } else {
                      return 'Measure anytime and anywhere with just your phone';
                    }
                  }();
                  safeSetState(() {});
                },
                text: 'Next',
                options: FFButtonOptions(
                  width: double.infinity,
                  height: 50.0,
                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
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
                showLoadingIndicator: false,
              ),
            ].addToEnd(SizedBox(height: 10.0)),
          ).animateOnPageLoad(animationsMap['columnOnPageLoadAnimation']!),
        ),
      ),
    );
  }
}
