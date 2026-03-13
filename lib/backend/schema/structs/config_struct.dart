// ignore_for_file: unnecessary_getters_setters


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ConfigStruct extends BaseStruct {
  ConfigStruct({
    int? id,
    List<InfoStruct>? onboardingGoalText,
    String? policy,
    int? translationTableVersion,
    List<InfoStruct>? scanTypeImages,

    /// only 2 field use color and name
    List<InfoStruct>? diabeticInsightColor,
    int? recentMealCount,
    List<String>? mealTime,
  })  : _id = id,
        _onboardingGoalText = onboardingGoalText,
        _policy = policy,
        _translationTableVersion = translationTableVersion,
        _scanTypeImages = scanTypeImages,
        _diabeticInsightColor = diabeticInsightColor,
        _recentMealCount = recentMealCount,
        _mealTime = mealTime;

  // "id" field.
  int? _id;
  int get id => _id ?? 0;
  set id(int? val) => _id = val;

  void incrementId(int amount) => id = id + amount;

  bool hasId() => _id != null;

  // "onboarding_goal_text" field.
  List<InfoStruct>? _onboardingGoalText;
  List<InfoStruct> get onboardingGoalText => _onboardingGoalText ?? const [];
  set onboardingGoalText(List<InfoStruct>? val) => _onboardingGoalText = val;

  void updateOnboardingGoalText(Function(List<InfoStruct>) updateFn) {
    updateFn(_onboardingGoalText ??= []);
  }

  bool hasOnboardingGoalText() => _onboardingGoalText != null;

  // "policy" field.
  String? _policy;
  String get policy => _policy ?? '';
  set policy(String? val) => _policy = val;

  bool hasPolicy() => _policy != null;

  // "translation_table_version" field.
  int? _translationTableVersion;
  int get translationTableVersion => _translationTableVersion ?? 0;
  set translationTableVersion(int? val) => _translationTableVersion = val;

  void incrementTranslationTableVersion(int amount) =>
      translationTableVersion = translationTableVersion + amount;

  bool hasTranslationTableVersion() => _translationTableVersion != null;

  // "scanTypeImages" field.
  List<InfoStruct>? _scanTypeImages;
  List<InfoStruct> get scanTypeImages => _scanTypeImages ?? const [];
  set scanTypeImages(List<InfoStruct>? val) => _scanTypeImages = val;

  void updateScanTypeImages(Function(List<InfoStruct>) updateFn) {
    updateFn(_scanTypeImages ??= []);
  }

  bool hasScanTypeImages() => _scanTypeImages != null;

  // "diabetic_insight_color" field.
  List<InfoStruct>? _diabeticInsightColor;
  List<InfoStruct> get diabeticInsightColor =>
      _diabeticInsightColor ?? const [];
  set diabeticInsightColor(List<InfoStruct>? val) =>
      _diabeticInsightColor = val;

  void updateDiabeticInsightColor(Function(List<InfoStruct>) updateFn) {
    updateFn(_diabeticInsightColor ??= []);
  }

  bool hasDiabeticInsightColor() => _diabeticInsightColor != null;

  // "recent_meal_count" field.
  int? _recentMealCount;
  int get recentMealCount => _recentMealCount ?? 0;
  set recentMealCount(int? val) => _recentMealCount = val;

  void incrementRecentMealCount(int amount) =>
      recentMealCount = recentMealCount + amount;

  bool hasRecentMealCount() => _recentMealCount != null;

  // "meal_time" field.
  List<String>? _mealTime;
  List<String> get mealTime => _mealTime ?? const [];
  set mealTime(List<String>? val) => _mealTime = val;

  void updateMealTime(Function(List<String>) updateFn) {
    updateFn(_mealTime ??= []);
  }

  bool hasMealTime() => _mealTime != null;

  static ConfigStruct fromMap(Map<String, dynamic> data) => ConfigStruct(
        id: castToType<int>(data['id']),
        onboardingGoalText: getStructList(
          data['onboarding_goal_text'],
          InfoStruct.fromMap,
        ),
        policy: data['policy'] as String?,
        translationTableVersion:
            castToType<int>(data['translation_table_version']),
        scanTypeImages: getStructList(
          data['scanTypeImages'],
          InfoStruct.fromMap,
        ),
        diabeticInsightColor: getStructList(
          data['diabetic_insight_color'],
          InfoStruct.fromMap,
        ),
        recentMealCount: castToType<int>(data['recent_meal_count']),
        mealTime: getDataList(data['meal_time']),
      );

  static ConfigStruct? maybeFromMap(dynamic data) =>
      data is Map ? ConfigStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'onboarding_goal_text':
            _onboardingGoalText?.map((e) => e.toMap()).toList(),
        'policy': _policy,
        'translation_table_version': _translationTableVersion,
        'scanTypeImages': _scanTypeImages?.map((e) => e.toMap()).toList(),
        'diabetic_insight_color':
            _diabeticInsightColor?.map((e) => e.toMap()).toList(),
        'recent_meal_count': _recentMealCount,
        'meal_time': _mealTime,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.int,
        ),
        'onboarding_goal_text': serializeParam(
          _onboardingGoalText,
          ParamType.DataStruct,
          isList: true,
        ),
        'policy': serializeParam(
          _policy,
          ParamType.String,
        ),
        'translation_table_version': serializeParam(
          _translationTableVersion,
          ParamType.int,
        ),
        'scanTypeImages': serializeParam(
          _scanTypeImages,
          ParamType.DataStruct,
          isList: true,
        ),
        'diabetic_insight_color': serializeParam(
          _diabeticInsightColor,
          ParamType.DataStruct,
          isList: true,
        ),
        'recent_meal_count': serializeParam(
          _recentMealCount,
          ParamType.int,
        ),
        'meal_time': serializeParam(
          _mealTime,
          ParamType.String,
          isList: true,
        ),
      }.withoutNulls;

  static ConfigStruct fromSerializableMap(Map<String, dynamic> data) =>
      ConfigStruct(
        id: deserializeParam(
          data['id'],
          ParamType.int,
          false,
        ),
        onboardingGoalText: deserializeStructParam<InfoStruct>(
          data['onboarding_goal_text'],
          ParamType.DataStruct,
          true,
          structBuilder: InfoStruct.fromSerializableMap,
        ),
        policy: deserializeParam(
          data['policy'],
          ParamType.String,
          false,
        ),
        translationTableVersion: deserializeParam(
          data['translation_table_version'],
          ParamType.int,
          false,
        ),
        scanTypeImages: deserializeStructParam<InfoStruct>(
          data['scanTypeImages'],
          ParamType.DataStruct,
          true,
          structBuilder: InfoStruct.fromSerializableMap,
        ),
        diabeticInsightColor: deserializeStructParam<InfoStruct>(
          data['diabetic_insight_color'],
          ParamType.DataStruct,
          true,
          structBuilder: InfoStruct.fromSerializableMap,
        ),
        recentMealCount: deserializeParam(
          data['recent_meal_count'],
          ParamType.int,
          false,
        ),
        mealTime: deserializeParam<String>(
          data['meal_time'],
          ParamType.String,
          true,
        ),
      );

  @override
  String toString() => 'ConfigStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is ConfigStruct &&
        id == other.id &&
        listEquality.equals(onboardingGoalText, other.onboardingGoalText) &&
        policy == other.policy &&
        translationTableVersion == other.translationTableVersion &&
        listEquality.equals(scanTypeImages, other.scanTypeImages) &&
        listEquality.equals(diabeticInsightColor, other.diabeticInsightColor) &&
        recentMealCount == other.recentMealCount &&
        listEquality.equals(mealTime, other.mealTime);
  }

  @override
  int get hashCode => const ListEquality().hash([
        id,
        onboardingGoalText,
        policy,
        translationTableVersion,
        scanTypeImages,
        diabeticInsightColor,
        recentMealCount,
        mealTime
      ]);
}

ConfigStruct createConfigStruct({
  int? id,
  String? policy,
  int? translationTableVersion,
  int? recentMealCount,
}) =>
    ConfigStruct(
      id: id,
      policy: policy,
      translationTableVersion: translationTableVersion,
      recentMealCount: recentMealCount,
    );
