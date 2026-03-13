import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'analyze_food_model.dart';
export 'analyze_food_model.dart';

class AnalyzeFoodWidget extends StatefulWidget {
  const AnalyzeFoodWidget({
    super.key,
    required this.image,
  });

  final String? image;

  static String routeName = 'AnalyzeFood';
  static String routePath = '/analyzeFood';

  @override
  State<AnalyzeFoodWidget> createState() => _AnalyzeFoodWidgetState();
}

class _AnalyzeFoodWidgetState extends State<AnalyzeFoodWidget> {
  late AnalyzeFoodModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AnalyzeFoodModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.mealInfo =
          await EdgeFunctionGroup.analyzeFoodMultiLanguageCall.call(
        imageUrl: functions.convertImage((String localImage) {
          return localImage.split('~').last;
        }(widget.image!)),
        language: FFAppState().userData.country ==
                FFAppState().currentUserLang.countryCode
            ? FFAppState().currentUserLang.langName
            : 'English',
      );

      if ((_model.mealInfo?.succeeded ?? true)) {
        _model.foodInfo =
            EdgeFunctionGroup.analyzeFoodMultiLanguageCall.mealInfo(
          (_model.mealInfo?.jsonBody ?? ''),
        );
        safeSetState(() {});
        if (_model.foodInfo?.name != null && _model.foodInfo?.name != '') {
          await Future.delayed(
            Duration(
              milliseconds: 2500,
            ),
          );
          context.safePop();

          context.pushNamed(
            DetailsAnlyzeScreenWidget.routeName,
            queryParameters: {
              'mealInfo': serializeParam(
                _model.foodInfo,
                ParamType.DataStruct,
              ),
            }.withoutNulls,
          );
        } else {
          context.safePop();
        }
      } else {
        context.safePop();

        context.pushNamed(AnalyzedFailedWidget.routeName);

        return;
      }
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
        body: Stack(
          children: [
            Builder(
              builder: (context) {
                if (((String localImage) {
                          return localImage.split('~').first;
                        }(widget.image!)) !=
                        '') {
                  return Container(
                    width: double.infinity,
                    height: MediaQuery.sizeOf(context).height * 0.7,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    child: custom_widgets.CustomImage(
                      width: double.infinity,
                      height: 200.0,
                      localImage: (String localImage) {
                        return localImage.split('~').first;
                      }(widget.image!),
                    ),
                  );
                } else {
                  return Container(
                    width: double.infinity,
                    height: MediaQuery.sizeOf(context).height * 0.7,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: CachedNetworkImageProvider(
                          valueOrDefault<String>(
                            functions.convertImage((String localImage) {
                              return localImage.split('~').last;
                            }(widget.image!)),
                            'https://images.unsplash.com/photo-1615719413546-198b25453f85?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwyNHx8cGl6emF8ZW58MHx8fHwxNzczMzIzNzI1fDA&ixlib=rb-4.1.0&q=80&w=1080',
                          ),
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Lottie.asset(
                  'assets/jsons/loading_barline.json',
                  width: MediaQuery.sizeOf(context).width * 1.0,
                  height: 20.0,
                  fit: BoxFit.contain,
                  animate: true,
                ),
                Container(
                  width: double.infinity,
                  height: MediaQuery.sizeOf(context).height * 0.35,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(0.0),
                      bottomRight: Radius.circular(0.0),
                      topLeft: Radius.circular(40.0),
                      topRight: Radius.circular(40.0),
                    ),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(40.0, 0.0, 40.0, 0.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 12.0),
                              child: Text(
                                valueOrDefault<String>(
                                  functions.languagefuncation(
                                      'analyzing_your_meal',
                                      FFLocalizations.of(context).languageCode,
                                      FFAppState().translationsCSV),
                                  'Analyzing your meal...',
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .bodyMediumFamily,
                                      fontSize: 24.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w800,
                                      useGoogleFonts:
                                          !FlutterFlowTheme.of(context)
                                              .bodyMediumIsCustom,
                                    ),
                              ),
                            ),
                            Text(
                              valueOrDefault<String>(
                                functions.languagefuncation(
                                    'calculating_macros_and_safety_scores',
                                    FFLocalizations.of(context).languageCode,
                                    FFAppState().translationsCSV),
                                'Calculating macros and safety scores...',
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .bodyMediumFamily,
                                    color: Color(0xFF64748B),
                                    fontSize: 16.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
                                            .bodyMediumIsCustom,
                                  ),
                            ),
                            if (_model.foodInfo?.name != null &&
                                _model.foodInfo?.name != '')
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 32.0, 0.0, 50.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: FFButtonWidget(
                                        onPressed: () {
                                          print('Button pressed ...');
                                        },
                                        text: _model.foodInfo!.name,
                                        icon: Icon(
                                          FFIcons.k27,
                                          size: 15.0,
                                        ),
                                        options: FFButtonOptions(
                                          width: 160.0,
                                          height: 38.0,
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  16.0, 0.0, 16.0, 0.0),
                                          iconPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 0.0),
                                          iconColor:
                                              FlutterFlowTheme.of(context)
                                                  .primary,
                                          color: Color(0xFFF8FAFC),
                                          textStyle: FlutterFlowTheme.of(
                                                  context)
                                              .titleSmall
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .titleSmallFamily,
                                                color: Color(0xFF334155),
                                                fontSize: 14.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.bold,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .titleSmallIsCustom,
                                              ),
                                          elevation: 0.0,
                                          borderSide: BorderSide(
                                            color: Color(0xFFF1F5F9),
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(100.0),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: FFButtonWidget(
                                        onPressed: () {
                                          print('Button pressed ...');
                                        },
                                        text: valueOrDefault<String>(
                                          functions.languagefuncation(
                                              _model.foodInfo?.diabeticScore
                                                  .glycemicLevel,
                                              FFLocalizations.of(context)
                                                  .languageCode,
                                              FFAppState().translationsCSV),
                                          'MEDIUM GLYCEMIC',
                                        ),
                                        icon: Icon(
                                          FFIcons.kicon2,
                                          size: 15.0,
                                        ),
                                        options: FFButtonOptions(
                                          width: 160.0,
                                          height: 38.0,
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  16.0, 0.0, 16.0, 0.0),
                                          iconPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 0.0),
                                          iconColor:
                                              FlutterFlowTheme.of(context)
                                                  .primary,
                                          color: Color(0xFFF8FAFC),
                                          textStyle: FlutterFlowTheme.of(
                                                  context)
                                              .titleSmall
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .titleSmallFamily,
                                                color: Color(0xFF334155),
                                                fontSize: 14.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.bold,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .titleSmallIsCustom,
                                              ),
                                          elevation: 0.0,
                                          borderSide: BorderSide(
                                            color: Color(0xFFF1F5F9),
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(100.0),
                                        ),
                                      ),
                                    ),
                                  ].divide(SizedBox(width: 12.0)),
                                ),
                              ),
                          ].addToStart(SizedBox(height: 27.0)),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 20.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.cached_sharp,
                                    color: FlutterFlowTheme.of(context).primary,
                                    size: 24.0,
                                  ),
                                  Text(
                                    FFLocalizations.of(context).getText(
                                      '50iwpym5' /* GlucoPal AI Vision v2.4 */,
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMediumFamily,
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.bold,
                                          useGoogleFonts:
                                              !FlutterFlowTheme.of(context)
                                                  .bodyMediumIsCustom,
                                        ),
                                  ),
                                ].divide(SizedBox(width: 4.0)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 1.0,
                  height: MediaQuery.sizeOf(context).height * 0.01,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(
                        functions.convertImage((String localImage) {
                          return localImage.split('~').last;
                        }(widget.image!))!,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
