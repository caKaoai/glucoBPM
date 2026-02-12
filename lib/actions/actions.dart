import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

Future aiAnalysisInfo(BuildContext context) async {
  ApiCallResponse? info;

  info = await AllCommandTableGroup.aIAnalysisCall.call();

  if ((info.succeeded ?? true)) {
    FFAppState().aiAnalysisInfo = ((info.jsonBody ?? '')
            .toList()
            .map<AIAnalysisStruct?>(AIAnalysisStruct.maybeFromMap)
            .toList() as Iterable<AIAnalysisStruct?>)
        .withoutNulls
        .toList()
        .cast<AIAnalysisStruct>();
    FFAppState().update(() {});
  }
}

Future heartHealth(BuildContext context) async {
  ApiCallResponse? healthInfo;

  healthInfo = await AllCommandTableGroup.heartHealthCall.call();

  if ((healthInfo.succeeded ?? true)) {
    FFAppState().hearthHealth = ((healthInfo.jsonBody ?? '')
            .toList()
            .map<AIAnalysisStruct?>(AIAnalysisStruct.maybeFromMap)
            .toList() as Iterable<AIAnalysisStruct?>)
        .withoutNulls
        .toList()
        .cast<AIAnalysisStruct>();
    FFAppState().update(() {});
  }
}

Future planFAQ(BuildContext context) async {
  ApiCallResponse? planINfo;

  planINfo = await AllCommandTableGroup.planFAQCall.call();

  if ((planINfo.succeeded ?? true)) {
    FFAppState().PlanFAQ = ((planINfo.jsonBody ?? '')
            .toList()
            .map<AIAnalysisStruct?>(AIAnalysisStruct.maybeFromMap)
            .toList() as Iterable<AIAnalysisStruct?>)
        .withoutNulls
        .toList()
        .cast<AIAnalysisStruct>();
    FFAppState().update(() {});
  }
}

Future userInfo(BuildContext context) async {
  ApiCallResponse? userInfo;

  userInfo = await UserGroup.userInfoCall.call(
    id: currentUserUid,
  );

  if ((userInfo.succeeded ?? true)) {
    FFAppState().updateUserDataStruct(
      (e) => e
        ..name = UserGroup.userInfoCall.name(
          (userInfo?.jsonBody ?? ''),
        )
        ..email = UserGroup.userInfoCall.email(
          (userInfo?.jsonBody ?? ''),
        )
        ..profileUrl = UserGroup.userInfoCall.profileUrl(
          (userInfo?.jsonBody ?? ''),
        )
        ..emi = UserGroup.userInfoCall.emi(
          (userInfo?.jsonBody ?? ''),
        )
        ..gender = UserGroup.userInfoCall.gender(
          (userInfo?.jsonBody ?? ''),
        )
        ..age = UserGroup.userInfoCall.age(
          (userInfo?.jsonBody ?? ''),
        )
        ..height = UserGroup.userInfoCall.height(
          (userInfo?.jsonBody ?? ''),
        )
        ..weight = UserGroup.userInfoCall.weight(
          (userInfo?.jsonBody ?? ''),
        )
        ..bmi = UserGroup.userInfoCall.bmi(
          (userInfo?.jsonBody ?? ''),
        )
        ..heightUnit = UserGroup.userInfoCall.heightunit(
          (userInfo?.jsonBody ?? ''),
        )
        ..weightUnit = UserGroup.userInfoCall.weightUnit(
          (userInfo?.jsonBody ?? ''),
        )
        ..authProvider = UserGroup.userInfoCall.authProvider(
          (userInfo?.jsonBody ?? ''),
        ),
    );
    FFAppState().update(() {});
  }
}

Future bloodInfo(BuildContext context) async {
  ApiCallResponse? bloodInfo;

  bloodInfo = await AllCommandTableGroup.bloodInfoCall.call(
    id: currentUserUid,
  );

  if ((bloodInfo.succeeded ?? true)) {
    FFAppState().bloodInfo = ((bloodInfo.jsonBody ?? '')
            .toList()
            .map<BloodInfoStruct?>(BloodInfoStruct.maybeFromMap)
            .toList() as Iterable<BloodInfoStruct?>)
        .withoutNulls
        .toList()
        .cast<BloodInfoStruct>();
  }
}

Future bpmInfo(BuildContext context) async {
  ApiCallResponse? bpmData;

  bpmData = await UserGroup.bPMInfoCall.call(
    id: currentUserUid,
  );

  if ((bpmData.succeeded ?? true)) {
    FFAppState().bpmInfos = ((bpmData.jsonBody ?? '')
            .toList()
            .map<BPMinfoStruct?>(BPMinfoStruct.maybeFromMap)
            .toList() as Iterable<BPMinfoStruct?>)
        .withoutNulls
        .toList()
        .cast<BPMinfoStruct>();
    FFAppState().update(() {});
  }
}
