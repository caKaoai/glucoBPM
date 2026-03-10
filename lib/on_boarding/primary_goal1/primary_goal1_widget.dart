import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'primary_goal1_model.dart';
export 'primary_goal1_model.dart';

class PrimaryGoal1Widget extends StatefulWidget {
  const PrimaryGoal1Widget({super.key});

  @override
  State<PrimaryGoal1Widget> createState() => _PrimaryGoal1WidgetState();
}

class _PrimaryGoal1WidgetState extends State<PrimaryGoal1Widget>
    with TickerProviderStateMixin {
  late PrimaryGoal1Model _model;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PrimaryGoal1Model());

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
                    'primary_goal_question',
                    FFLocalizations.of(context).languageCode,
                    FFAppState().translationsCSV),
                'What is your primary goal?',
              ),
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                    color: Color(0xFF1C1C1E),
                    fontSize: 30.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.bold,
                    useGoogleFonts:
                        !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                  ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(24.0, 12.0, 24.0, 40.0),
            child: Text(
              valueOrDefault<String>(
                functions.languagefuncation(
                    'personalize_your_journey_health',
                    FFLocalizations.of(context).languageCode,
                    FFAppState().translationsCSV),
                'Personalize your journey for better health outcomes.',
              ),
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                    color: Color(0xFF8E8E93),
                    fontSize: 16.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w500,
                    useGoogleFonts:
                        !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                  ),
            ),
          ),
          Builder(
            builder: (context) {
              final textInfo = FFAppState().config.onboardingGoalText.toList();

              return Column(
                mainAxisSize: MainAxisSize.max,
                children: List.generate(textInfo.length, (textInfoIndex) {
                  final textInfoItem = textInfo[textInfoIndex];
                  return Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 20.0),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        if (_model.selectedKey.contains(textInfoItem.title)) {
                          _model.removeFromSelectedKey(textInfoItem.title);
                          safeSetState(() {});
                        } else {
                          _model.addToSelectedKey(textInfoItem.title);
                          safeSetState(() {});
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        height: 130.0,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 20.0,
                              color: valueOrDefault<Color>(
                                _model.selectedKey.contains(textInfoItem.title)
                                    ? Color(0x33E31E24)
                                    : Colors.transparent,
                                Colors.transparent,
                              ),
                              offset: Offset(
                                0.0,
                                0.0,
                              ),
                              spreadRadius: 0.0,
                            )
                          ],
                          borderRadius: BorderRadius.circular(24.0),
                          border: Border.all(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            width: 1.0,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                width: 64.0,
                                height: 64.0,
                                decoration: BoxDecoration(
                                  color: Color(0xFFFEF2F2),
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                                child: Builder(
                                  builder: (context) {
                                    if (textInfoIndex == 0) {
                                      return Icon(
                                        FFIcons.kicon1,
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        size: 30.0,
                                      );
                                    } else if (textInfoIndex == 1) {
                                      return Icon(
                                        FFIcons.kicon2,
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        size: 30.0,
                                      );
                                    } else if (textInfoIndex == 2) {
                                      return Icon(
                                        FFIcons.kicon3,
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        size: 26.0,
                                      );
                                    } else {
                                      return Icon(
                                        FFIcons.kicon4,
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        size: 26.0,
                                      );
                                    }
                                  },
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      valueOrDefault<String>(
                                        functions.languagefuncation(
                                            textInfoItem.title,
                                            FFLocalizations.of(context)
                                                .languageCode,
                                            FFAppState().translationsCSV),
                                        'Manage Blood Sugar',
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMediumFamily,
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            fontSize: 18.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.bold,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .bodyMediumIsCustom,
                                          ),
                                    ),
                                    Text(
                                      valueOrDefault<String>(
                                        functions.languagefuncation(
                                            textInfoItem.description,
                                            FFLocalizations.of(context)
                                                .languageCode,
                                            FFAppState().translationsCSV),
                                        'Precision glucose & insulin tracking.',
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMediumFamily,
                                            color: Color(0xFF8E8E93),
                                            letterSpacing: 0.0,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .bodyMediumIsCustom,
                                          ),
                                    ),
                                  ].divide(SizedBox(height: 4.0)),
                                ),
                              ),
                              Builder(
                                builder: (context) {
                                  if (_model.selectedKey
                                      .contains(textInfoItem.title)) {
                                    return FaIcon(
                                      FontAwesomeIcons.solidCheckCircle,
                                      color: Color(0xFFE31E24),
                                      size: 26.0,
                                    );
                                  } else {
                                    return Container(
                                      width: 26.0,
                                      height: 26.0,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Color(0xFFE5E7EB),
                                          width: 2.0,
                                        ),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ].divide(SizedBox(width: 20.0)),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              );
            },
          ),
        ],
      ),
    ).animateOnPageLoad(animationsMap['columnOnPageLoadAnimation']!);
  }
}
