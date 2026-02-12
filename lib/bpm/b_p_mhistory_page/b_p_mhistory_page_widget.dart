import '/backend/supabase/supabase.dart';
import '/bpm/bpm_history_block/bpm_history_block_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'b_p_mhistory_page_model.dart';
export 'b_p_mhistory_page_model.dart';

class BPMhistoryPageWidget extends StatefulWidget {
  const BPMhistoryPageWidget({super.key});

  static String routeName = 'BPMhistoryPage';
  static String routePath = '/bPMhistoryPage';

  @override
  State<BPMhistoryPageWidget> createState() => _BPMhistoryPageWidgetState();
}

class _BPMhistoryPageWidgetState extends State<BPMhistoryPageWidget> {
  late BPMhistoryPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BPMhistoryPageModel());
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
              context.pop();
            },
          ),
          title: Text(
            'History',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: FlutterFlowTheme.of(context).headlineMediumFamily,
                  color: FlutterFlowTheme.of(context).primaryText,
                  fontSize: 22.0,
                  letterSpacing: 0.0,
                  useGoogleFonts:
                      !FlutterFlowTheme.of(context).headlineMediumIsCustom,
                ),
          ),
          actions: [],
          centerTitle: true,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Builder(
            builder: (context) {
              final bpmData = functions
                      .filterBPMinfoDatewise(FFAppState().bpmInfos.toList())
                      ?.sortedList(keyOf: (e) => e.date, desc: true)
                      .toList() ??
                  [];

              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: List.generate(bpmData.length, (bpmDataIndex) {
                    final bpmDataItem = bpmData[bpmDataIndex];
                    return Padding(
                      padding: EdgeInsets.all(14.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            bpmDataItem.date,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .bodyMediumFamily,
                                  fontSize: 16.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w500,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .bodyMediumIsCustom,
                                ),
                          ),
                          Builder(
                            builder: (context) {
                              final bpmInfos = bpmDataItem.bpmInfo.toList();

                              return Column(
                                mainAxisSize: MainAxisSize.max,
                                children: List.generate(bpmInfos.length,
                                    (bpmInfosIndex) {
                                  final bpmInfosItem = bpmInfos[bpmInfosIndex];
                                  return InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      _model.storeIndex = bpmInfosIndex;
                                      safeSetState(() {});
                                    },
                                    child: custom_widgets.SwipeToDelete(
                                      width: double.infinity,
                                      height: 100.0,
                                      index: bpmInfosIndex,
                                      storedIndex: _model.storeIndex,
                                      ondelete: () async {
                                        await UserBPMTable().delete(
                                          matchingRows: (rows) => rows.eqOrNull(
                                            'id',
                                            bpmInfosItem.id,
                                          ),
                                        );
                                        if (functions
                                                .filterBPMinfoDatewise(
                                                    FFAppState()
                                                        .bpmInfos
                                                        .toList())
                                                ?.where(
                                                    (e) => e.date == 'Today')
                                                .toList()
                                                .length ==
                                            1) {
                                          await Future.wait([
                                            Future(() async {
                                              FFAppState()
                                                  .updateUserTrackingStruct(
                                                (e) => e..bpmTrackToday = false,
                                              );
                                              safeSetState(() {});
                                            }),
                                            Future(() async {
                                              context.goNamed(
                                                  HomePageWidget.routeName);
                                            }),
                                          ]);
                                        }
                                        await action_blocks.bpmInfo(context);
                                      },
                                      onSwipeOpen: (index) async {
                                        _model.storeIndex = index;
                                        safeSetState(() {});
                                      },
                                      uiComponent: () => BpmHistoryBlockWidget(
                                        bpmInfo: bpmInfosItem,
                                      ),
                                    ),
                                  );
                                }).divide(SizedBox(height: 14.0)),
                              );
                            },
                          ),
                        ].divide(SizedBox(height: 10.0)),
                      ),
                    );
                  }),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
