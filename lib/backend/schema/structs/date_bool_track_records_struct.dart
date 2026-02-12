// ignore_for_file: unnecessary_getters_setters


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class DateBoolTrackRecordsStruct extends BaseStruct {
  DateBoolTrackRecordsStruct({
    String? date,
    List<BloodInfoStruct>? bloodInfo,
    List<BPMinfoStruct>? bpmInfo,
  })  : _date = date,
        _bloodInfo = bloodInfo,
        _bpmInfo = bpmInfo;

  // "date" field.
  String? _date;
  String get date => _date ?? '';
  set date(String? val) => _date = val;

  bool hasDate() => _date != null;

  // "BloodInfo" field.
  List<BloodInfoStruct>? _bloodInfo;
  List<BloodInfoStruct> get bloodInfo => _bloodInfo ?? const [];
  set bloodInfo(List<BloodInfoStruct>? val) => _bloodInfo = val;

  void updateBloodInfo(Function(List<BloodInfoStruct>) updateFn) {
    updateFn(_bloodInfo ??= []);
  }

  bool hasBloodInfo() => _bloodInfo != null;

  // "bpmInfo" field.
  List<BPMinfoStruct>? _bpmInfo;
  List<BPMinfoStruct> get bpmInfo => _bpmInfo ?? const [];
  set bpmInfo(List<BPMinfoStruct>? val) => _bpmInfo = val;

  void updateBpmInfo(Function(List<BPMinfoStruct>) updateFn) {
    updateFn(_bpmInfo ??= []);
  }

  bool hasBpmInfo() => _bpmInfo != null;

  static DateBoolTrackRecordsStruct fromMap(Map<String, dynamic> data) =>
      DateBoolTrackRecordsStruct(
        date: data['date'] as String?,
        bloodInfo: getStructList(
          data['BloodInfo'],
          BloodInfoStruct.fromMap,
        ),
        bpmInfo: getStructList(
          data['bpmInfo'],
          BPMinfoStruct.fromMap,
        ),
      );

  static DateBoolTrackRecordsStruct? maybeFromMap(dynamic data) => data is Map
      ? DateBoolTrackRecordsStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'date': _date,
        'BloodInfo': _bloodInfo?.map((e) => e.toMap()).toList(),
        'bpmInfo': _bpmInfo?.map((e) => e.toMap()).toList(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'date': serializeParam(
          _date,
          ParamType.String,
        ),
        'BloodInfo': serializeParam(
          _bloodInfo,
          ParamType.DataStruct,
          isList: true,
        ),
        'bpmInfo': serializeParam(
          _bpmInfo,
          ParamType.DataStruct,
          isList: true,
        ),
      }.withoutNulls;

  static DateBoolTrackRecordsStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      DateBoolTrackRecordsStruct(
        date: deserializeParam(
          data['date'],
          ParamType.String,
          false,
        ),
        bloodInfo: deserializeStructParam<BloodInfoStruct>(
          data['BloodInfo'],
          ParamType.DataStruct,
          true,
          structBuilder: BloodInfoStruct.fromSerializableMap,
        ),
        bpmInfo: deserializeStructParam<BPMinfoStruct>(
          data['bpmInfo'],
          ParamType.DataStruct,
          true,
          structBuilder: BPMinfoStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'DateBoolTrackRecordsStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is DateBoolTrackRecordsStruct &&
        date == other.date &&
        listEquality.equals(bloodInfo, other.bloodInfo) &&
        listEquality.equals(bpmInfo, other.bpmInfo);
  }

  @override
  int get hashCode => const ListEquality().hash([date, bloodInfo, bpmInfo]);
}

DateBoolTrackRecordsStruct createDateBoolTrackRecordsStruct({
  String? date,
}) =>
    DateBoolTrackRecordsStruct(
      date: date,
    );
