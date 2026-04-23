import 'dart:convert';
import '../schema/structs/index.dart';

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
  static LanguageCall languageCall = LanguageCall();
  static ConfigCall configCall = ConfigCall();
  static ActivityCall activityCall = ActivityCall();
}

class LanguageCall {
  Future<ApiCallResponse> call({
    String? countryCode = '',
    String? token =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRteXBnY29panJrZXpjc211b2d5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Njg3OTgzMDcsImV4cCI6MjA4NDM3NDMwN30.6X7i6W_-qReXpcQghKn8oRv1QaPOYD3MvUETstEksak',
  }) async {
    final baseUrl = AllCommandTableGroup.getBaseUrl(
      token: token,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'Language',
      apiUrl: '${baseUrl}/language?country_code=eq.${countryCode}',
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

class ConfigCall {
  Future<ApiCallResponse> call({
    String? token =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRteXBnY29panJrZXpjc211b2d5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Njg3OTgzMDcsImV4cCI6MjA4NDM3NDMwN30.6X7i6W_-qReXpcQghKn8oRv1QaPOYD3MvUETstEksak',
  }) async {
    final baseUrl = AllCommandTableGroup.getBaseUrl(
      token: token,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'Config',
      apiUrl: '${baseUrl}/config',
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

class ActivityCall {
  Future<ApiCallResponse> call({
    String? token =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRteXBnY29panJrZXpjc211b2d5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Njg3OTgzMDcsImV4cCI6MjA4NDM3NDMwN30.6X7i6W_-qReXpcQghKn8oRv1QaPOYD3MvUETstEksak',
  }) async {
    final baseUrl = AllCommandTableGroup.getBaseUrl(
      token: token,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'activity',
      apiUrl: '${baseUrl}/activity',
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

/// End User Group Code

/// Start Edge Function Group Code

class EdgeFunctionGroup {
  static String getBaseUrl({
    String? token =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRteXBnY29panJrZXpjc211b2d5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Njg3OTgzMDcsImV4cCI6MjA4NDM3NDMwN30.6X7i6W_-qReXpcQghKn8oRv1QaPOYD3MvUETstEksak',
  }) =>
      'https://tmypgcoijrkezcsmuogy.supabase.co/functions/v1';
  static Map<String, String> headers = {
    'Content-type': 'application/json',
    'Authorization': 'Bearer [token]',
    'apikey': '[token]',
  };
  static AnalyzeFoodMultiLanguageCall analyzeFoodMultiLanguageCall =
      AnalyzeFoodMultiLanguageCall();
  static MoveActiveScoreCall moveActiveScoreCall = MoveActiveScoreCall();
}

class AnalyzeFoodMultiLanguageCall {
  Future<ApiCallResponse> call({
    String? imageUrl = '',
    String? language = '',
    String? token =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRteXBnY29panJrZXpjc211b2d5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Njg3OTgzMDcsImV4cCI6MjA4NDM3NDMwN30.6X7i6W_-qReXpcQghKn8oRv1QaPOYD3MvUETstEksak',
  }) async {
    final baseUrl = EdgeFunctionGroup.getBaseUrl(
      token: token,
    );

    final ffApiRequestBody = '''
{
  "image_url": "${escapeStringForJson(imageUrl)}",
  "Language": "${escapeStringForJson(language)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'analyzeFoodMultiLanguage',
      apiUrl: '${baseUrl}/analyze_food_multi_language',
      callType: ApiCallType.POST,
      headers: {
        'Content-type': 'application/json',
        'Authorization': 'Bearer ${token}',
        'apikey': '${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  MealStruct? mealInfo(dynamic response) =>
      MealStruct.maybeFromMap(getJsonField(
        response,
        r'''$.meal''',
      ));
}

class MoveActiveScoreCall {
  Future<ApiCallResponse> call({
    String? activity = '',
    int? durationMinutes,
    String? gender = '',
    int? age,
    int? weightKg,
    int? heightCm,
    String? language = '',
    int? level,
    String? token =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRteXBnY29panJrZXpjc211b2d5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Njg3OTgzMDcsImV4cCI6MjA4NDM3NDMwN30.6X7i6W_-qReXpcQghKn8oRv1QaPOYD3MvUETstEksak',
  }) async {
    final baseUrl = EdgeFunctionGroup.getBaseUrl(
      token: token,
    );

    final ffApiRequestBody = '''
{
  "activity": "${escapeStringForJson(activity)}",
  "duration_minutes": ${durationMinutes},
  "intensity": {
    "level": ${level},
    "scale": {
      "min": 1,
      "max": 10
    }
  },
  "person": {
    "gender": "${escapeStringForJson(gender)}",
    "age": ${age},
    "weight_kg": ${weightKg},
    "height_cm": ${heightCm},
    "language": "${escapeStringForJson(language)}"
  }
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Move Active Score',
      apiUrl: '${baseUrl}/move_active_score',
      callType: ApiCallType.POST,
      headers: {
        'Content-type': 'application/json',
        'Authorization': 'Bearer ${token}',
        'apikey': '${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  int? caloriesBurned(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.estimated_calories_burned''',
      ));
  String? summary(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.summary''',
      ));
  int? healthScore(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.health_score''',
      ));
}

/// End Edge Function Group Code

/// Start Meal Group Code

class MealGroup {
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
  static GetMealInfoCall getMealInfoCall = GetMealInfoCall();
  static InsertMealCall insertMealCall = InsertMealCall();
  static UpdateMealCall updateMealCall = UpdateMealCall();
}

class GetMealInfoCall {
  Future<ApiCallResponse> call({
    String? id = '',
    String? token =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRteXBnY29panJrZXpjc211b2d5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Njg3OTgzMDcsImV4cCI6MjA4NDM3NDMwN30.6X7i6W_-qReXpcQghKn8oRv1QaPOYD3MvUETstEksak',
  }) async {
    final baseUrl = MealGroup.getBaseUrl(
      token: token,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'Get Meal Info',
      apiUrl: '${baseUrl}/meal?user_id=eq.${id}',
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

class InsertMealCall {
  Future<ApiCallResponse> call({
    String? mealDate = '',
    String? mealHour = '',
    String? imageUrl = '',
    String? language = '',
    String? name = '',
    int? calories,
    int? fat,
    List<String>? ingredientsList,
    dynamic diabeticScoreJson,
    int? protein,
    int? carbs,
    int? sugar,
    dynamic diabeticInsightsJson,
    String? createdAt = '',
    String? userId = '',
    double? portionSize,
    String? token =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRteXBnY29panJrZXpjc211b2d5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Njg3OTgzMDcsImV4cCI6MjA4NDM3NDMwN30.6X7i6W_-qReXpcQghKn8oRv1QaPOYD3MvUETstEksak',
  }) async {
    final baseUrl = MealGroup.getBaseUrl(
      token: token,
    );
    final ingredients = _serializeList(ingredientsList);
    final diabeticScore = _serializeJson(diabeticScoreJson);
    final diabeticInsights = _serializeJson(diabeticInsightsJson, true);
    final ffApiRequestBody = '''
{
  "user_id": "${escapeStringForJson(userId)}",
  "meal_date": "${escapeStringForJson(mealDate)}",
  "meal_hour": "${escapeStringForJson(mealHour)}",
  "image_url": "${escapeStringForJson(imageUrl)}",
  "language": "${escapeStringForJson(language)}",
  "name": "${escapeStringForJson(name)}",
  "calories": ${calories},
  "fat": ${fat},
  "ingredients": ${ingredients},
  "diabetic_score": ${diabeticScore},
  "protein": ${protein},
  "carbs": ${carbs},
  "sugar": ${sugar},
  "diabetic_insights": ${diabeticInsights},
  "created_at": "${escapeStringForJson(createdAt)}",
  "portion_size": ${portionSize}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Insert Meal',
      apiUrl: '${baseUrl}/meal',
      callType: ApiCallType.POST,
      headers: {
        'Content-type': 'application/json',
        'Authorization': 'Bearer ${token}',
        'apikey': '${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class UpdateMealCall {
  Future<ApiCallResponse> call({
    int? calories,
    int? fat,
    List<String>? ingredientsList,
    dynamic diabeticScoreJson,
    int? protein,
    int? carbs,
    int? sugar,
    dynamic diabeticInsightsJson,
    double? portionSize,
    int? id,
    String? mealDate = '',
    String? mealHour = '',
    String? token =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRteXBnY29panJrZXpjc211b2d5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Njg3OTgzMDcsImV4cCI6MjA4NDM3NDMwN30.6X7i6W_-qReXpcQghKn8oRv1QaPOYD3MvUETstEksak',
  }) async {
    final baseUrl = MealGroup.getBaseUrl(
      token: token,
    );
    final ingredients = _serializeList(ingredientsList);
    final diabeticScore = _serializeJson(diabeticScoreJson);
    final diabeticInsights = _serializeJson(diabeticInsightsJson, true);
    final ffApiRequestBody = '''
{
  "meal_date": "${escapeStringForJson(mealDate)}",
  "meal_hour": "${escapeStringForJson(mealHour)}",
  "calories": ${calories},
  "fat": ${fat},
  "ingredients": ${ingredients},
  "diabetic_score": ${diabeticScore},
  "protein": ${protein},
  "carbs": ${carbs},
  "sugar": ${sugar},
  "diabetic_insights": ${diabeticInsights},
  "portion_size": ${portionSize}

}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Update Meal',
      apiUrl: '${baseUrl}/meal?id =eq.${id}',
      callType: ApiCallType.PATCH,
      headers: {
        'Content-type': 'application/json',
        'Authorization': 'Bearer ${token}',
        'apikey': '${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

/// End Meal Group Code

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

String? escapeStringForJson(String? input) {
  if (input == null) {
    return null;
  }
  return input
      .replaceAll('\\', '\\\\')
      .replaceAll('"', '\\"')
      .replaceAll('\n', '\\n')
      .replaceAll('\t', '\\t');
}
