// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class HealthInfoStruct extends BaseStruct {
  HealthInfoStruct({
    int? steps,
    int? activeEnergy,
    int? restingEnergy,
    String? date,
    double? distance,
  })  : _steps = steps,
        _activeEnergy = activeEnergy,
        _restingEnergy = restingEnergy,
        _date = date,
        _distance = distance;

  // "steps" field.
  int? _steps;
  int get steps => _steps ?? 0;
  set steps(int? val) => _steps = val;

  void incrementSteps(int amount) => steps = steps + amount;

  bool hasSteps() => _steps != null;

  // "activeEnergy" field.
  int? _activeEnergy;
  int get activeEnergy => _activeEnergy ?? 0;
  set activeEnergy(int? val) => _activeEnergy = val;

  void incrementActiveEnergy(int amount) =>
      activeEnergy = activeEnergy + amount;

  bool hasActiveEnergy() => _activeEnergy != null;

  // "restingEnergy" field.
  int? _restingEnergy;
  int get restingEnergy => _restingEnergy ?? 0;
  set restingEnergy(int? val) => _restingEnergy = val;

  void incrementRestingEnergy(int amount) =>
      restingEnergy = restingEnergy + amount;

  bool hasRestingEnergy() => _restingEnergy != null;

  // "date" field.
  String? _date;
  String get date => _date ?? '';
  set date(String? val) => _date = val;

  bool hasDate() => _date != null;

  // "distance" field.
  double? _distance;
  double get distance => _distance ?? 0.0;
  set distance(double? val) => _distance = val;

  void incrementDistance(double amount) => distance = distance + amount;

  bool hasDistance() => _distance != null;

  static HealthInfoStruct fromMap(Map<String, dynamic> data) =>
      HealthInfoStruct(
        steps: castToType<int>(data['steps']),
        activeEnergy: castToType<int>(data['activeEnergy']),
        restingEnergy: castToType<int>(data['restingEnergy']),
        date: data['date'] as String?,
        distance: castToType<double>(data['distance']),
      );

  static HealthInfoStruct? maybeFromMap(dynamic data) => data is Map
      ? HealthInfoStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'steps': _steps,
        'activeEnergy': _activeEnergy,
        'restingEnergy': _restingEnergy,
        'date': _date,
        'distance': _distance,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'steps': serializeParam(
          _steps,
          ParamType.int,
        ),
        'activeEnergy': serializeParam(
          _activeEnergy,
          ParamType.int,
        ),
        'restingEnergy': serializeParam(
          _restingEnergy,
          ParamType.int,
        ),
        'date': serializeParam(
          _date,
          ParamType.String,
        ),
        'distance': serializeParam(
          _distance,
          ParamType.double,
        ),
      }.withoutNulls;

  static HealthInfoStruct fromSerializableMap(Map<String, dynamic> data) =>
      HealthInfoStruct(
        steps: deserializeParam(
          data['steps'],
          ParamType.int,
          false,
        ),
        activeEnergy: deserializeParam(
          data['activeEnergy'],
          ParamType.int,
          false,
        ),
        restingEnergy: deserializeParam(
          data['restingEnergy'],
          ParamType.int,
          false,
        ),
        date: deserializeParam(
          data['date'],
          ParamType.String,
          false,
        ),
        distance: deserializeParam(
          data['distance'],
          ParamType.double,
          false,
        ),
      );

  @override
  String toString() => 'HealthInfoStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is HealthInfoStruct &&
        steps == other.steps &&
        activeEnergy == other.activeEnergy &&
        restingEnergy == other.restingEnergy &&
        date == other.date &&
        distance == other.distance;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([steps, activeEnergy, restingEnergy, date, distance]);
}

HealthInfoStruct createHealthInfoStruct({
  int? steps,
  int? activeEnergy,
  int? restingEnergy,
  String? date,
  double? distance,
}) =>
    HealthInfoStruct(
      steps: steps,
      activeEnergy: activeEnergy,
      restingEnergy: restingEnergy,
      date: date,
      distance: distance,
    );
