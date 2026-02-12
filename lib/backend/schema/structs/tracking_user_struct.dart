// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TrackingUserStruct extends BaseStruct {
  TrackingUserStruct({
    bool? planFirst,
    bool? bpmTrackToday,
    DateTime? date,
  })  : _planFirst = planFirst,
        _bpmTrackToday = bpmTrackToday,
        _date = date;

  // "PlanFirst" field.
  bool? _planFirst;
  bool get planFirst => _planFirst ?? false;
  set planFirst(bool? val) => _planFirst = val;

  bool hasPlanFirst() => _planFirst != null;

  // "bpmTrackToday" field.
  bool? _bpmTrackToday;
  bool get bpmTrackToday => _bpmTrackToday ?? false;
  set bpmTrackToday(bool? val) => _bpmTrackToday = val;

  bool hasBpmTrackToday() => _bpmTrackToday != null;

  // "date" field.
  DateTime? _date;
  DateTime? get date => _date;
  set date(DateTime? val) => _date = val;

  bool hasDate() => _date != null;

  static TrackingUserStruct fromMap(Map<String, dynamic> data) =>
      TrackingUserStruct(
        planFirst: data['PlanFirst'] as bool?,
        bpmTrackToday: data['bpmTrackToday'] as bool?,
        date: data['date'] as DateTime?,
      );

  static TrackingUserStruct? maybeFromMap(dynamic data) => data is Map
      ? TrackingUserStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'PlanFirst': _planFirst,
        'bpmTrackToday': _bpmTrackToday,
        'date': _date,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'PlanFirst': serializeParam(
          _planFirst,
          ParamType.bool,
        ),
        'bpmTrackToday': serializeParam(
          _bpmTrackToday,
          ParamType.bool,
        ),
        'date': serializeParam(
          _date,
          ParamType.DateTime,
        ),
      }.withoutNulls;

  static TrackingUserStruct fromSerializableMap(Map<String, dynamic> data) =>
      TrackingUserStruct(
        planFirst: deserializeParam(
          data['PlanFirst'],
          ParamType.bool,
          false,
        ),
        bpmTrackToday: deserializeParam(
          data['bpmTrackToday'],
          ParamType.bool,
          false,
        ),
        date: deserializeParam(
          data['date'],
          ParamType.DateTime,
          false,
        ),
      );

  @override
  String toString() => 'TrackingUserStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is TrackingUserStruct &&
        planFirst == other.planFirst &&
        bpmTrackToday == other.bpmTrackToday &&
        date == other.date;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([planFirst, bpmTrackToday, date]);
}

TrackingUserStruct createTrackingUserStruct({
  bool? planFirst,
  bool? bpmTrackToday,
  DateTime? date,
}) =>
    TrackingUserStruct(
      planFirst: planFirst,
      bpmTrackToday: bpmTrackToday,
      date: date,
    );
