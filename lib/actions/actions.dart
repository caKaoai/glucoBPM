import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/actions/actions.dart' as action_blocks;
import '/index.dart';
import 'package:flutter/material.dart';

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

Future config(BuildContext context) async {
  ApiCallResponse? configInfo;

  configInfo = await AllCommandTableGroup.configCall.call();

  if ((configInfo.succeeded ?? true)) {
    FFAppState().config = ((configInfo.jsonBody ?? '')
            .toList()
            .map<ConfigStruct?>(ConfigStruct.maybeFromMap)
            .toList() as Iterable<ConfigStruct?>)
        .withoutNulls
        .firstOrNull!;
    FFAppState().update(() {});
  }
}

Future auth(BuildContext context) async {
  await Future.delayed(
    Duration(
      milliseconds: 3000,
    ),
  );
  await UsersTable().update(
    data: {
      'gender': FFAppState().userData.gender,
      'age': FFAppState().userData.age,
      'height': FFAppState().userData.height,
      'weight': FFAppState().userData.weight,
      'heightUnit': FFAppState().userData.heightUnit,
      'weightUnit': FFAppState().userData.weightUnit,
      'emi': FFAppState().userData.emi,
      'ipAddress': FFAppState().userData.ipAddress,
      'country': FFAppState().userData.country,
      'goal': FFAppState().userData.goal,
      'daibType': FFAppState().userData.daibType,
    },
    matchingRows: (rows) => rows.eqOrNull(
      'user_id',
      currentUserUid,
    ),
  );
  await Future.delayed(
    Duration(
      milliseconds: 3000,
    ),
  );
  await action_blocks.userInfo(context);

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
}

Future mealGet(BuildContext context) async {
  ApiCallResponse? getMealInfo;

  getMealInfo = await MealGroup.getMealInfoCall.call(
    id: currentUserUid,
  );

  if ((getMealInfo.succeeded ?? true)) {
    FFAppState().MealInfo = ((getMealInfo.jsonBody ?? '')
            .toList()
            .map<MealStruct?>(MealStruct.maybeFromMap)
            .toList() as Iterable<MealStruct?>)
        .withoutNulls
        .toList()
        .cast<MealStruct>();
    FFAppState().update(() {});
  }
}

Future getActivity(BuildContext context) async {
  ApiCallResponse? activity;

  activity = await AllCommandTableGroup.activityCall.call();

  if ((activity.succeeded ?? true)) {
    FFAppState().activityName = ((activity.jsonBody ?? '')
            .toList()
            .map<ActivityStruct?>(ActivityStruct.maybeFromMap)
            .toList() as Iterable<ActivityStruct?>)
        .withoutNulls
        .toList()
        .cast<ActivityStruct>();
  }
}
