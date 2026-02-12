// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class BPMinfoStruct extends BaseStruct {
  BPMinfoStruct({
    int? id,
    int? pluse,
    int? hrv,
    String? userId,
    String? createdAt,

    /// Using for locally.
    ///
    /// in function retun status like good
    String? status,

    /// Using for locally.
    ///
    /// in function retun color
    Color? color,
  })  : _id = id,
        _pluse = pluse,
        _hrv = hrv,
        _userId = userId,
        _createdAt = createdAt,
        _status = status,
        _color = color;

  // "id" field.
  int? _id;
  int get id => _id ?? 0;
  set id(int? val) => _id = val;

  void incrementId(int amount) => id = id + amount;

  bool hasId() => _id != null;

  // "pluse" field.
  int? _pluse;
  int get pluse => _pluse ?? 0;
  set pluse(int? val) => _pluse = val;

  void incrementPluse(int amount) => pluse = pluse + amount;

  bool hasPluse() => _pluse != null;

  // "hrv" field.
  int? _hrv;
  int get hrv => _hrv ?? 0;
  set hrv(int? val) => _hrv = val;

  void incrementHrv(int amount) => hrv = hrv + amount;

  bool hasHrv() => _hrv != null;

  // "user_id" field.
  String? _userId;
  String get userId => _userId ?? '';
  set userId(String? val) => _userId = val;

  bool hasUserId() => _userId != null;

  // "created_at" field.
  String? _createdAt;
  String get createdAt => _createdAt ?? '';
  set createdAt(String? val) => _createdAt = val;

  bool hasCreatedAt() => _createdAt != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  set status(String? val) => _status = val;

  bool hasStatus() => _status != null;

  // "color" field.
  Color? _color;
  Color? get color => _color;
  set color(Color? val) => _color = val;

  bool hasColor() => _color != null;

  static BPMinfoStruct fromMap(Map<String, dynamic> data) => BPMinfoStruct(
        id: castToType<int>(data['id']),
        pluse: castToType<int>(data['pluse']),
        hrv: castToType<int>(data['hrv']),
        userId: data['user_id'] as String?,
        createdAt: data['created_at'] as String?,
        status: data['status'] as String?,
        color: getSchemaColor(data['color']),
      );

  static BPMinfoStruct? maybeFromMap(dynamic data) =>
      data is Map ? BPMinfoStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'pluse': _pluse,
        'hrv': _hrv,
        'user_id': _userId,
        'created_at': _createdAt,
        'status': _status,
        'color': _color,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.int,
        ),
        'pluse': serializeParam(
          _pluse,
          ParamType.int,
        ),
        'hrv': serializeParam(
          _hrv,
          ParamType.int,
        ),
        'user_id': serializeParam(
          _userId,
          ParamType.String,
        ),
        'created_at': serializeParam(
          _createdAt,
          ParamType.String,
        ),
        'status': serializeParam(
          _status,
          ParamType.String,
        ),
        'color': serializeParam(
          _color,
          ParamType.Color,
        ),
      }.withoutNulls;

  static BPMinfoStruct fromSerializableMap(Map<String, dynamic> data) =>
      BPMinfoStruct(
        id: deserializeParam(
          data['id'],
          ParamType.int,
          false,
        ),
        pluse: deserializeParam(
          data['pluse'],
          ParamType.int,
          false,
        ),
        hrv: deserializeParam(
          data['hrv'],
          ParamType.int,
          false,
        ),
        userId: deserializeParam(
          data['user_id'],
          ParamType.String,
          false,
        ),
        createdAt: deserializeParam(
          data['created_at'],
          ParamType.String,
          false,
        ),
        status: deserializeParam(
          data['status'],
          ParamType.String,
          false,
        ),
        color: deserializeParam(
          data['color'],
          ParamType.Color,
          false,
        ),
      );

  @override
  String toString() => 'BPMinfoStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is BPMinfoStruct &&
        id == other.id &&
        pluse == other.pluse &&
        hrv == other.hrv &&
        userId == other.userId &&
        createdAt == other.createdAt &&
        status == other.status &&
        color == other.color;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([id, pluse, hrv, userId, createdAt, status, color]);
}

BPMinfoStruct createBPMinfoStruct({
  int? id,
  int? pluse,
  int? hrv,
  String? userId,
  String? createdAt,
  String? status,
  Color? color,
}) =>
    BPMinfoStruct(
      id: id,
      pluse: pluse,
      hrv: hrv,
      userId: userId,
      createdAt: createdAt,
      status: status,
      color: color,
    );
