import '/backend/supabase/supabase.dart';
import '/components/history_block_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'history_page_model.dart';
export 'history_page_model.dart';

class HistoryPageWidget extends StatefulWidget {
  const HistoryPageWidget({
    super.key,
    required this.calltype,
  });

  /// 0=pressure
  /// 1=oxygen
  /// 2=sugar
  final int? calltype;

  static String routeName = 'HistoryPage';
  static String routePath = '/historyPage';

  @override
  State<HistoryPageWidget> createState() => _HistoryPageWidgetState();
}

class _HistoryPageWidgetState extends State<HistoryPageWidget> {
  late HistoryPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HistoryPageModel());
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
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: Builder(
              builder: (context) {
                final bloodInfo = functions
                        .filterDatebyBloodInfo(FFAppState()
                            .bloodInfo
                            .where((e) => e.type == widget.calltype)
                            .toList())
                        ?.sortedList(keyOf: (e) => e.date, desc: true)
                        .toList() ??
                    [];

                return SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(bloodInfo.length, (bloodInfoIndex) {
                      final bloodInfoItem = bloodInfo[bloodInfoIndex];
                      return Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            bloodInfoItem.date,
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
                              final bloood = bloodInfoItem.bloodInfo.toList();

                              return Column(
                                mainAxisSize: MainAxisSize.max,
                                children:
                                    List.generate(bloood.length, (blooodIndex) {
                                  final blooodItem = bloood[blooodIndex];
                                  return InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      _model.storeIndex = blooodIndex;
                                      safeSetState(() {});
                                    },
                                    child: custom_widgets.SwipeToDelete(
                                      width: double.infinity,
                                      height: 100.0,
                                      index: blooodIndex,
                                      storedIndex: _model.storeIndex,
                                      ondelete: () async {
                                        await UserBloodTrackTable().delete(
                                          matchingRows: (rows) => rows.eqOrNull(
                                            'id',
                                            blooodItem.id,
                                          ),
                                        );
                                        if (bloodInfoItem.bloodInfo.length ==
                                            1) {
                                          await Future.wait([
                                            Future(() async {
                                              context.goNamed(
                                                  HomePageWidget.routeName);
                                            }),
                                            Future(() async {
                                              FFAppState().removeFromBloodInfo(
                                                  blooodItem);
                                              safeSetState(() {});
                                            }),
                                          ]);
                                        }
                                        await action_blocks.bloodInfo(context);
                                      },
                                      onSwipeOpen: (index) async {
                                        _model.storeIndex = index;
                                        safeSetState(() {});
                                      },
                                      uiComponent: () => HistoryBlockWidget(
                                        callType: widget.calltype!,
                                        infoOfBlood: blooodItem,
                                      ),
                                    ),
                                  );
                                }).divide(SizedBox(height: 16.0)),
                              );
                            },
                          ),
                        ].divide(SizedBox(height: 18.0)),
                      );
                    }).divide(SizedBox(height: 16.0)),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
