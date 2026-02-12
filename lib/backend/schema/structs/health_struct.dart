// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class HealthStruct extends BaseStruct {
  HealthStruct({
    bool? energy,
    bool? glucose,
    bool? oxygen,
    bool? pressure,
    bool? temperature,
    bool? heartRate,
    bool? restingEnergy,
    bool? steps,
    bool? distance,
  })  : _energy = energy,
        _glucose = glucose,
        _oxygen = oxygen,
        _pressure = pressure,
        _temperature = temperature,
        _heartRate = heartRate,
        _restingEnergy = restingEnergy,
        _steps = steps,
        _distance = distance;

  // "energy" field.
  bool? _energy;
  bool get energy => _energy ?? false;
  set energy(bool? val) => _energy = val;

  bool hasEnergy() => _energy != null;

  // "glucose" field.
  bool? _glucose;
  bool get glucose => _glucose ?? false;
  set glucose(bool? val) => _glucose = val;

  bool hasGlucose() => _glucose != null;

  // "oxygen" field.
  bool? _oxygen;
  bool get oxygen => _oxygen ?? false;
  set oxygen(bool? val) => _oxygen = val;

  bool hasOxygen() => _oxygen != null;

  // "pressure" field.
  bool? _pressure;
  bool get pressure => _pressure ?? false;
  set pressure(bool? val) => _pressure = val;

  bool hasPressure() => _pressure != null;

  // "temperature" field.
  bool? _temperature;
  bool get temperature => _temperature ?? false;
  set temperature(bool? val) => _temperature = val;

  bool hasTemperature() => _temperature != null;

  // "heartRate" field.
  bool? _heartRate;
  bool get heartRate => _heartRate ?? false;
  set heartRate(bool? val) => _heartRate = val;

  bool hasHeartRate() => _heartRate != null;

  // "restingEnergy" field.
  bool? _restingEnergy;
  bool get restingEnergy => _restingEnergy ?? false;
  set restingEnergy(bool? val) => _restingEnergy = val;

  bool hasRestingEnergy() => _restingEnergy != null;

  // "steps" field.
  bool? _steps;
  bool get steps => _steps ?? false;
  set steps(bool? val) => _steps = val;

  bool hasSteps() => _steps != null;

  // "distance" field.
  bool? _distance;
  bool get distance => _distance ?? false;
  set distance(bool? val) => _distance = val;

  bool hasDistance() => _distance != null;

  static HealthStruct fromMap(Map<String, dynamic> data) => HealthStruct(
        energy: data['energy'] as bool?,
        glucose: data['glucose'] as bool?,
        oxygen: data['oxygen'] as bool?,
        pressure: data['pressure'] as bool?,
        temperature: data['temperature'] as bool?,
        heartRate: data['heartRate'] as bool?,
        restingEnergy: data['restingEnergy'] as bool?,
        steps: data['steps'] as bool?,
        distance: data['distance'] as bool?,
      );

  static HealthStruct? maybeFromMap(dynamic data) =>
      data is Map ? HealthStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'energy': _energy,
        'glucose': _glucose,
        'oxygen': _oxygen,
        'pressure': _pressure,
        'temperature': _temperature,
        'heartRate': _heartRate,
        'restingEnergy': _restingEnergy,
        'steps': _steps,
        'distance': _distance,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'energy': serializeParam(
          _energy,
          ParamType.bool,
        ),
        'glucose': serializeParam(
          _glucose,
          ParamType.bool,
        ),
        'oxygen': serializeParam(
          _oxygen,
          ParamType.bool,
        ),
        'pressure': serializeParam(
          _pressure,
          ParamType.bool,
        ),
        'temperature': serializeParam(
          _temperature,
          ParamType.bool,
        ),
        'heartRate': serializeParam(
          _heartRate,
          ParamType.bool,
        ),
        'restingEnergy': serializeParam(
          _restingEnergy,
          ParamType.bool,
        ),
        'steps': serializeParam(
          _steps,
          ParamType.bool,
        ),
        'distance': serializeParam(
          _distance,
          ParamType.bool,
        ),
      }.withoutNulls;

  static HealthStruct fromSerializableMap(Map<String, dynamic> data) =>
      HealthStruct(
        energy: deserializeParam(
          data['energy'],
          ParamType.bool,
          false,
        ),
        glucose: deserializeParam(
          data['glucose'],
          ParamType.bool,
          false,
        ),
        oxygen: deserializeParam(
          data['oxygen'],
          ParamType.bool,
          false,
        ),
        pressure: deserializeParam(
          data['pressure'],
          ParamType.bool,
          false,
        ),
        temperature: deserializeParam(
          data['temperature'],
          ParamType.bool,
          false,
        ),
        heartRate: deserializeParam(
          data['heartRate'],
          ParamType.bool,
          false,
        ),
        restingEnergy: deserializeParam(
          data['restingEnergy'],
          ParamType.bool,
          false,
        ),
        steps: deserializeParam(
          data['steps'],
          ParamType.bool,
          false,
        ),
        distance: deserializeParam(
          data['distance'],
          ParamType.bool,
          false,
        ),
      );

  @override
  String toString() => 'HealthStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is HealthStruct &&
        energy == other.energy &&
        glucose == other.glucose &&
        oxygen == other.oxygen &&
        pressure == other.pressure &&
        temperature == other.temperature &&
        heartRate == other.heartRate &&
        restingEnergy == other.restingEnergy &&
        steps == other.steps &&
        distance == other.distance;
  }

  @override
  int get hashCode => const ListEquality().hash([
        energy,
        glucose,
        oxygen,
        pressure,
        temperature,
        heartRate,
        restingEnergy,
        steps,
        distance
      ]);
}

HealthStruct createHealthStruct({
  bool? energy,
  bool? glucose,
  bool? oxygen,
  bool? pressure,
  bool? temperature,
  bool? heartRate,
  bool? restingEnergy,
  bool? steps,
  bool? distance,
}) =>
    HealthStruct(
      energy: energy,
      glucose: glucose,
      oxygen: oxygen,
      pressure: pressure,
      temperature: temperature,
      heartRate: heartRate,
      restingEnergy: restingEnergy,
      steps: steps,
      distance: distance,
    );
