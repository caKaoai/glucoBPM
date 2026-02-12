import 'dart:convert';

import 'package:flutter/foundation.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

/// Start All Command Table Group Code

class AllCommandTableGroup {
  static String getBaseUrl({
    String? token =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRteXBnY29panJrZXpjc211b2d5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Njg3OTgzMDcsImV4cCI6MjA4NDM3NDMwN30.6X7i6W_-qReXpcQghKn8oRv1QaPOYD3MvUETstEksak',
  }) =>
      'https://tmypgcoijrkezcsmuogy.supabase.co/rest/v1';
  static Map<String, String> headers = {
    'Content-type': 'application/json',
    'Authorization': 'Bearer [token]',
    'apikey': '[token]',
  };
  static AIAnalysisCall aIAnalysisCall = AIAnalysisCall();
  static HeartHealthCall heartHealthCall = HeartHealthCall();
  static PlanFAQCall planFAQCall = PlanFAQCall();
  static BloodInfoCall bloodInfoCall = BloodInfoCall();
}

class AIAnalysisCall {
  Future<ApiCallResponse> call({
    String? token =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRteXBnY29panJrZXpjc211b2d5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Njg3OTgzMDcsImV4cCI6MjA4NDM3NDMwN30.6X7i6W_-qReXpcQghKn8oRv1QaPOYD3MvUETstEksak',
  }) async {
    final baseUrl = AllCommandTableGroup.getBaseUrl(
      token: token,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'AI Analysis',
      apiUrl: '${baseUrl}/al_analysisInfo',
      callType: ApiCallType.GET,
      headers: {
        'Content-type': 'application/json',
        'Authorization': 'Bearer ${token}',
        'apikey': '${token}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class HeartHealthCall {
  Future<ApiCallResponse> call({
    String? token =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRteXBnY29panJrZXpjc211b2d5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Njg3OTgzMDcsImV4cCI6MjA4NDM3NDMwN30.6X7i6W_-qReXpcQghKn8oRv1QaPOYD3MvUETstEksak',
  }) async {
    final baseUrl = AllCommandTableGroup.getBaseUrl(
      token: token,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'Heart Health',
      apiUrl: '${baseUrl}/heart_health',
      callType: ApiCallType.GET,
      headers: {
        'Content-type': 'application/json',
        'Authorization': 'Bearer ${token}',
        'apikey': '${token}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class PlanFAQCall {
  Future<ApiCallResponse> call({
    String? token =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRteXBnY29panJrZXpjc211b2d5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Njg3OTgzMDcsImV4cCI6MjA4NDM3NDMwN30.6X7i6W_-qReXpcQghKn8oRv1QaPOYD3MvUETstEksak',
  }) async {
    final baseUrl = AllCommandTableGroup.getBaseUrl(
      token: token,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'Plan FAQ',
      apiUrl: '${baseUrl}/plan_faq',
      callType: ApiCallType.GET,
      headers: {
        'Content-type': 'application/json',
        'Authorization': 'Bearer ${token}',
        'apikey': '${token}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class BloodInfoCall {
  Future<ApiCallResponse> call({
    String? id = '',
    String? token =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRteXBnY29panJrZXpjc211b2d5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Njg3OTgzMDcsImV4cCI6MjA4NDM3NDMwN30.6X7i6W_-qReXpcQghKn8oRv1QaPOYD3MvUETstEksak',
  }) async {
    final baseUrl = AllCommandTableGroup.getBaseUrl(
      token: token,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'Blood Info',
      apiUrl: '${baseUrl}/user_bloodTrack?user_id=eq.${id}',
      callType: ApiCallType.GET,
      headers: {
        'Content-type': 'application/json',
        'Authorization': 'Bearer ${token}',
        'apikey': '${token}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

/// End All Command Table Group Code

/// Start User Group Code

class UserGroup {
  static String getBaseUrl({
    String? token =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRteXBnY29panJrZXpjc211b2d5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Njg3OTgzMDcsImV4cCI6MjA4NDM3NDMwN30.6X7i6W_-qReXpcQghKn8oRv1QaPOYD3MvUETstEksak',
  }) =>
      'https://tmypgcoijrkezcsmuogy.supabase.co/rest/v1';
  static Map<String, String> headers = {
    'Content-type': 'application/json',
    'Authorization': 'Bearer [token]',
    'apikey': '[token]',
  };
  static UserInfoCall userInfoCall = UserInfoCall();
  static BPMInfoCall bPMInfoCall = BPMInfoCall();
}

class UserInfoCall {
  Future<ApiCallResponse> call({
    String? id = '',
    String? token =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRteXBnY29panJrZXpjc211b2d5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Njg3OTgzMDcsImV4cCI6MjA4NDM3NDMwN30.6X7i6W_-qReXpcQghKn8oRv1QaPOYD3MvUETstEksak',
  }) async {
    final baseUrl = UserGroup.getBaseUrl(
      token: token,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'UserInfo',
      apiUrl: '${baseUrl}/users?user_id=eq.${id}',
      callType: ApiCallType.GET,
      headers: {
        'Content-type': 'application/json',
        'Authorization': 'Bearer ${token}',
        'apikey': '${token}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  String? name(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].name''',
      ));
  String? gender(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].gender''',
      ));
  int? age(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$[:].age''',
      ));
  int? height(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$[:].height''',
      ));
  int? weight(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$[:].weight''',
      ));
  double? bmi(dynamic response) => castToType<double>(getJsonField(
        response,
        r'''$[:].bmi''',
      ));
  String? heightunit(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].heightUnit''',
      ));
  String? weightUnit(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].weightUnit''',
      ));
  String? userId(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].user_id''',
      ));
  String? email(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].email''',
      ));
  String? authProvider(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].auth_provider''',
      ));
  String? profileUrl(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].profile_url''',
      ));
  String? emi(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].emi''',
      ));
}

class BPMInfoCall {
  Future<ApiCallResponse> call({
    String? id = '',
    String? token =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRteXBnY29panJrZXpjc211b2d5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Njg3OTgzMDcsImV4cCI6MjA4NDM3NDMwN30.6X7i6W_-qReXpcQghKn8oRv1QaPOYD3MvUETstEksak',
  }) async {
    final baseUrl = UserGroup.getBaseUrl(
      token: token,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'BPMInfo',
      apiUrl: '${baseUrl}/user_BPM?user_id=eq.${id}',
      callType: ApiCallType.GET,
      headers: {
        'Content-type': 'application/json',
        'Authorization': 'Bearer ${token}',
        'apikey': '${token}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

/// End User Group Code

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _toEncodable(dynamic item) {
  return item;
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("List serialization failed. Returning empty list.");
    }
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}
