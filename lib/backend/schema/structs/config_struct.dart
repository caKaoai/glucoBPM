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
  })  : _id = id,
        _onboardingGoalText = onboardingGoalText,
        _policy = policy,
        _translationTableVersion = translationTableVersion,
        _scanTypeImages = scanTypeImages;

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
        listEquality.equals(scanTypeImages, other.scanTypeImages);
  }

  @override
  int get hashCode => const ListEquality().hash([
        id,
        onboardingGoalText,
        policy,
        translationTableVersion,
        scanTypeImages
      ]);
}

ConfigStruct createConfigStruct({
  int? id,
  String? policy,
  int? translationTableVersion,
}) =>
    ConfigStruct(
      id: id,
      policy: policy,
      translationTableVersion: translationTableVersion,
    );
