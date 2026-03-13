// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class DiabeticScoreStruct extends BaseStruct {
  DiabeticScoreStruct({
    int? value,
    String? unit,
    String? scoreLabel,
    String? glycemicLevel,
    String? glucoseImpactText,
  })  : _value = value,
        _unit = unit,
        _scoreLabel = scoreLabel,
        _glycemicLevel = glycemicLevel,
        _glucoseImpactText = glucoseImpactText;

  // "value" field.
  int? _value;
  int get value => _value ?? 0;
  set value(int? val) => _value = val;

  void incrementValue(int amount) => value = value + amount;

  bool hasValue() => _value != null;

  // "unit" field.
  String? _unit;
  String get unit => _unit ?? '';
  set unit(String? val) => _unit = val;

  bool hasUnit() => _unit != null;

  // "score_label" field.
  String? _scoreLabel;
  String get scoreLabel => _scoreLabel ?? '';
  set scoreLabel(String? val) => _scoreLabel = val;

  bool hasScoreLabel() => _scoreLabel != null;

  // "glycemic_level" field.
  String? _glycemicLevel;
  String get glycemicLevel => _glycemicLevel ?? '';
  set glycemicLevel(String? val) => _glycemicLevel = val;

  bool hasGlycemicLevel() => _glycemicLevel != null;

  // "glucose_impact_text" field.
  String? _glucoseImpactText;
  String get glucoseImpactText => _glucoseImpactText ?? '';
  set glucoseImpactText(String? val) => _glucoseImpactText = val;

  bool hasGlucoseImpactText() => _glucoseImpactText != null;

  static DiabeticScoreStruct fromMap(Map<String, dynamic> data) =>
      DiabeticScoreStruct(
        value: castToType<int>(data['value']),
        unit: data['unit'] as String?,
        scoreLabel: data['score_label'] as String?,
        glycemicLevel: data['glycemic_level'] as String?,
        glucoseImpactText: data['glucose_impact_text'] as String?,
      );

  static DiabeticScoreStruct? maybeFromMap(dynamic data) => data is Map
      ? DiabeticScoreStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'value': _value,
        'unit': _unit,
        'score_label': _scoreLabel,
        'glycemic_level': _glycemicLevel,
        'glucose_impact_text': _glucoseImpactText,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'value': serializeParam(
          _value,
          ParamType.int,
        ),
        'unit': serializeParam(
          _unit,
          ParamType.String,
        ),
        'score_label': serializeParam(
          _scoreLabel,
          ParamType.String,
        ),
        'glycemic_level': serializeParam(
          _glycemicLevel,
          ParamType.String,
        ),
        'glucose_impact_text': serializeParam(
          _glucoseImpactText,
          ParamType.String,
        ),
      }.withoutNulls;

  static DiabeticScoreStruct fromSerializableMap(Map<String, dynamic> data) =>
      DiabeticScoreStruct(
        value: deserializeParam(
          data['value'],
          ParamType.int,
          false,
        ),
        unit: deserializeParam(
          data['unit'],
          ParamType.String,
          false,
        ),
        scoreLabel: deserializeParam(
          data['score_label'],
          ParamType.String,
          false,
        ),
        glycemicLevel: deserializeParam(
          data['glycemic_level'],
          ParamType.String,
          false,
        ),
        glucoseImpactText: deserializeParam(
          data['glucose_impact_text'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'DiabeticScoreStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is DiabeticScoreStruct &&
        value == other.value &&
        unit == other.unit &&
        scoreLabel == other.scoreLabel &&
        glycemicLevel == other.glycemicLevel &&
        glucoseImpactText == other.glucoseImpactText;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([value, unit, scoreLabel, glycemicLevel, glucoseImpactText]);
}

DiabeticScoreStruct createDiabeticScoreStruct({
  int? value,
  String? unit,
  String? scoreLabel,
  String? glycemicLevel,
  String? glucoseImpactText,
}) =>
    DiabeticScoreStruct(
      value: value,
      unit: unit,
      scoreLabel: scoreLabel,
      glycemicLevel: glycemicLevel,
      glucoseImpactText: glucoseImpactText,
    );
