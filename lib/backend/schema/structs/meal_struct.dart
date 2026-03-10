// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class MealStruct extends BaseStruct {
  MealStruct({
    int? id,
    String? name,
    String? image,
    String? langCode,
    String? createdAt,
    int? sessionId,
    String? langName,
    String? countryCode,
    int? connectId,
    String? flag,
  })  : _id = id,
        _name = name,
        _image = image,
        _langCode = langCode,
        _createdAt = createdAt,
        _sessionId = sessionId,
        _langName = langName,
        _countryCode = countryCode,
        _connectId = connectId,
        _flag = flag;

  // "id" field.
  int? _id;
  int get id => _id ?? 0;
  set id(int? val) => _id = val;

  void incrementId(int amount) => id = id + amount;

  bool hasId() => _id != null;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  // "image" field.
  String? _image;
  String get image => _image ?? '';
  set image(String? val) => _image = val;

  bool hasImage() => _image != null;

  // "lang_code" field.
  String? _langCode;
  String get langCode => _langCode ?? '';
  set langCode(String? val) => _langCode = val;

  bool hasLangCode() => _langCode != null;

  // "created_at" field.
  String? _createdAt;
  String get createdAt => _createdAt ?? '';
  set createdAt(String? val) => _createdAt = val;

  bool hasCreatedAt() => _createdAt != null;

  // "session_id" field.
  int? _sessionId;
  int get sessionId => _sessionId ?? 0;
  set sessionId(int? val) => _sessionId = val;

  void incrementSessionId(int amount) => sessionId = sessionId + amount;

  bool hasSessionId() => _sessionId != null;

  // "lang_name" field.
  String? _langName;
  String get langName => _langName ?? '';
  set langName(String? val) => _langName = val;

  bool hasLangName() => _langName != null;

  // "country_code" field.
  String? _countryCode;
  String get countryCode => _countryCode ?? '';
  set countryCode(String? val) => _countryCode = val;

  bool hasCountryCode() => _countryCode != null;

  // "connect_id" field.
  int? _connectId;
  int get connectId => _connectId ?? 0;
  set connectId(int? val) => _connectId = val;

  void incrementConnectId(int amount) => connectId = connectId + amount;

  bool hasConnectId() => _connectId != null;

  // "flag" field.
  String? _flag;
  String get flag => _flag ?? '';
  set flag(String? val) => _flag = val;

  bool hasFlag() => _flag != null;

  static MealStruct fromMap(Map<String, dynamic> data) => MealStruct(
        id: castToType<int>(data['id']),
        name: data['name'] as String?,
        image: data['image'] as String?,
        langCode: data['lang_code'] as String?,
        createdAt: data['created_at'] as String?,
        sessionId: castToType<int>(data['session_id']),
        langName: data['lang_name'] as String?,
        countryCode: data['country_code'] as String?,
        connectId: castToType<int>(data['connect_id']),
        flag: data['flag'] as String?,
      );

  static MealStruct? maybeFromMap(dynamic data) =>
      data is Map ? MealStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'name': _name,
        'image': _image,
        'lang_code': _langCode,
        'created_at': _createdAt,
        'session_id': _sessionId,
        'lang_name': _langName,
        'country_code': _countryCode,
        'connect_id': _connectId,
        'flag': _flag,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.int,
        ),
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'image': serializeParam(
          _image,
          ParamType.String,
        ),
        'lang_code': serializeParam(
          _langCode,
          ParamType.String,
        ),
        'created_at': serializeParam(
          _createdAt,
          ParamType.String,
        ),
        'session_id': serializeParam(
          _sessionId,
          ParamType.int,
        ),
        'lang_name': serializeParam(
          _langName,
          ParamType.String,
        ),
        'country_code': serializeParam(
          _countryCode,
          ParamType.String,
        ),
        'connect_id': serializeParam(
          _connectId,
          ParamType.int,
        ),
        'flag': serializeParam(
          _flag,
          ParamType.String,
        ),
      }.withoutNulls;

  static MealStruct fromSerializableMap(Map<String, dynamic> data) =>
      MealStruct(
        id: deserializeParam(
          data['id'],
          ParamType.int,
          false,
        ),
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        image: deserializeParam(
          data['image'],
          ParamType.String,
          false,
        ),
        langCode: deserializeParam(
          data['lang_code'],
          ParamType.String,
          false,
        ),
        createdAt: deserializeParam(
          data['created_at'],
          ParamType.String,
          false,
        ),
        sessionId: deserializeParam(
          data['session_id'],
          ParamType.int,
          false,
        ),
        langName: deserializeParam(
          data['lang_name'],
          ParamType.String,
          false,
        ),
        countryCode: deserializeParam(
          data['country_code'],
          ParamType.String,
          false,
        ),
        connectId: deserializeParam(
          data['connect_id'],
          ParamType.int,
          false,
        ),
        flag: deserializeParam(
          data['flag'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'MealStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is MealStruct &&
        id == other.id &&
        name == other.name &&
        image == other.image &&
        langCode == other.langCode &&
        createdAt == other.createdAt &&
        sessionId == other.sessionId &&
        langName == other.langName &&
        countryCode == other.countryCode &&
        connectId == other.connectId &&
        flag == other.flag;
  }

  @override
  int get hashCode => const ListEquality().hash([
        id,
        name,
        image,
        langCode,
        createdAt,
        sessionId,
        langName,
        countryCode,
        connectId,
        flag
      ]);
}

MealStruct createMealStruct({
  int? id,
  String? name,
  String? image,
  String? langCode,
  String? createdAt,
  int? sessionId,
  String? langName,
  String? countryCode,
  int? connectId,
  String? flag,
}) =>
    MealStruct(
      id: id,
      name: name,
      image: image,
      langCode: langCode,
      createdAt: createdAt,
      sessionId: sessionId,
      langName: langName,
      countryCode: countryCode,
      connectId: connectId,
      flag: flag,
    );
