// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class BloodInfoStruct extends BaseStruct {
  BloodInfoStruct({
    int? id,
    int? type,
    int? systolic,
    int? diastolic,
    int? spo2,
    String? sugarState,
    int? mgDl,
    double? mmoiL,
    String? date,
    String? time,
    String? createdAt,

    /// local use to return color code
    Color? color,
  })  : _id = id,
        _type = type,
        _systolic = systolic,
        _diastolic = diastolic,
        _spo2 = spo2,
        _sugarState = sugarState,
        _mgDl = mgDl,
        _mmoiL = mmoiL,
        _date = date,
        _time = time,
        _createdAt = createdAt,
        _color = color;

  // "id" field.
  int? _id;
  int get id => _id ?? 0;
  set id(int? val) => _id = val;

  void incrementId(int amount) => id = id + amount;

  bool hasId() => _id != null;

  // "type" field.
  int? _type;
  int get type => _type ?? 0;
  set type(int? val) => _type = val;

  void incrementType(int amount) => type = type + amount;

  bool hasType() => _type != null;

  // "systolic" field.
  int? _systolic;
  int get systolic => _systolic ?? 0;
  set systolic(int? val) => _systolic = val;

  void incrementSystolic(int amount) => systolic = systolic + amount;

  bool hasSystolic() => _systolic != null;

  // "diastolic" field.
  int? _diastolic;
  int get diastolic => _diastolic ?? 0;
  set diastolic(int? val) => _diastolic = val;

  void incrementDiastolic(int amount) => diastolic = diastolic + amount;

  bool hasDiastolic() => _diastolic != null;

  // "spo2" field.
  int? _spo2;
  int get spo2 => _spo2 ?? 0;
  set spo2(int? val) => _spo2 = val;

  void incrementSpo2(int amount) => spo2 = spo2 + amount;

  bool hasSpo2() => _spo2 != null;

  // "sugar_state" field.
  String? _sugarState;
  String get sugarState => _sugarState ?? '';
  set sugarState(String? val) => _sugarState = val;

  bool hasSugarState() => _sugarState != null;

  // "mg_dl" field.
  int? _mgDl;
  int get mgDl => _mgDl ?? 0;
  set mgDl(int? val) => _mgDl = val;

  void incrementMgDl(int amount) => mgDl = mgDl + amount;

  bool hasMgDl() => _mgDl != null;

  // "mmoi_l" field.
  double? _mmoiL;
  double get mmoiL => _mmoiL ?? 0.0;
  set mmoiL(double? val) => _mmoiL = val;

  void incrementMmoiL(double amount) => mmoiL = mmoiL + amount;

  bool hasMmoiL() => _mmoiL != null;

  // "date" field.
  String? _date;
  String get date => _date ?? '';
  set date(String? val) => _date = val;

  bool hasDate() => _date != null;

  // "time" field.
  String? _time;
  String get time => _time ?? '';
  set time(String? val) => _time = val;

  bool hasTime() => _time != null;

  // "created_at" field.
  String? _createdAt;
  String get createdAt => _createdAt ?? '';
  set createdAt(String? val) => _createdAt = val;

  bool hasCreatedAt() => _createdAt != null;

  // "color" field.
  Color? _color;
  Color? get color => _color;
  set color(Color? val) => _color = val;

  bool hasColor() => _color != null;

  static BloodInfoStruct fromMap(Map<String, dynamic> data) => BloodInfoStruct(
        id: castToType<int>(data['id']),
        type: castToType<int>(data['type']),
        systolic: castToType<int>(data['systolic']),
        diastolic: castToType<int>(data['diastolic']),
        spo2: castToType<int>(data['spo2']),
        sugarState: data['sugar_state'] as String?,
        mgDl: castToType<int>(data['mg_dl']),
        mmoiL: castToType<double>(data['mmoi_l']),
        date: data['date'] as String?,
        time: data['time'] as String?,
        createdAt: data['created_at'] as String?,
        color: getSchemaColor(data['color']),
      );

  static BloodInfoStruct? maybeFromMap(dynamic data) => data is Map
      ? BloodInfoStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'type': _type,
        'systolic': _systolic,
        'diastolic': _diastolic,
        'spo2': _spo2,
        'sugar_state': _sugarState,
        'mg_dl': _mgDl,
        'mmoi_l': _mmoiL,
        'date': _date,
        'time': _time,
        'created_at': _createdAt,
        'color': _color,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.int,
        ),
        'type': serializeParam(
          _type,
          ParamType.int,
        ),
        'systolic': serializeParam(
          _systolic,
          ParamType.int,
        ),
        'diastolic': serializeParam(
          _diastolic,
          ParamType.int,
        ),
        'spo2': serializeParam(
          _spo2,
          ParamType.int,
        ),
        'sugar_state': serializeParam(
          _sugarState,
          ParamType.String,
        ),
        'mg_dl': serializeParam(
          _mgDl,
          ParamType.int,
        ),
        'mmoi_l': serializeParam(
          _mmoiL,
          ParamType.double,
        ),
        'date': serializeParam(
          _date,
          ParamType.String,
        ),
        'time': serializeParam(
          _time,
          ParamType.String,
        ),
        'created_at': serializeParam(
          _createdAt,
          ParamType.String,
        ),
        'color': serializeParam(
          _color,
          ParamType.Color,
        ),
      }.withoutNulls;

  static BloodInfoStruct fromSerializableMap(Map<String, dynamic> data) =>
      BloodInfoStruct(
        id: deserializeParam(
          data['id'],
          ParamType.int,
          false,
        ),
        type: deserializeParam(
          data['type'],
          ParamType.int,
          false,
        ),
        systolic: deserializeParam(
          data['systolic'],
          ParamType.int,
          false,
        ),
        diastolic: deserializeParam(
          data['diastolic'],
          ParamType.int,
          false,
        ),
        spo2: deserializeParam(
          data['spo2'],
          ParamType.int,
          false,
        ),
        sugarState: deserializeParam(
          data['sugar_state'],
          ParamType.String,
          false,
        ),
        mgDl: deserializeParam(
          data['mg_dl'],
          ParamType.int,
          false,
        ),
        mmoiL: deserializeParam(
          data['mmoi_l'],
          ParamType.double,
          false,
        ),
        date: deserializeParam(
          data['date'],
          ParamType.String,
          false,
        ),
        time: deserializeParam(
          data['time'],
          ParamType.String,
          false,
        ),
        createdAt: deserializeParam(
          data['created_at'],
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
  String toString() => 'BloodInfoStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is BloodInfoStruct &&
        id == other.id &&
        type == other.type &&
        systolic == other.systolic &&
        diastolic == other.diastolic &&
        spo2 == other.spo2 &&
        sugarState == other.sugarState &&
        mgDl == other.mgDl &&
        mmoiL == other.mmoiL &&
        date == other.date &&
        time == other.time &&
        createdAt == other.createdAt &&
        color == other.color;
  }

  @override
  int get hashCode => const ListEquality().hash([
        id,
        type,
        systolic,
        diastolic,
        spo2,
        sugarState,
        mgDl,
        mmoiL,
        date,
        time,
        createdAt,
        color
      ]);
}

BloodInfoStruct createBloodInfoStruct({
  int? id,
  int? type,
  int? systolic,
  int? diastolic,
  int? spo2,
  String? sugarState,
  int? mgDl,
  double? mmoiL,
  String? date,
  String? time,
  String? createdAt,
  Color? color,
}) =>
    BloodInfoStruct(
      id: id,
      type: type,
      systolic: systolic,
      diastolic: diastolic,
      spo2: spo2,
      sugarState: sugarState,
      mgDl: mgDl,
      mmoiL: mmoiL,
      date: date,
      time: time,
      createdAt: createdAt,
      color: color,
    );
