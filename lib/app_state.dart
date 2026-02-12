import 'package:flutter/material.dart';
import '/backend/schema/structs/index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      if (prefs.containsKey('ff_userData')) {
        try {
          final serializedData = prefs.getString('ff_userData') ?? '{}';
          _userData =
              UserStruct.fromSerializableMap(jsonDecode(serializedData));
        } catch (e) {
          print("Can't decode persisted data type. Error: $e.");
        }
      }
    });
    _safeInit(() {
      _aiAnalysisInfo = prefs
              .getStringList('ff_aiAnalysisInfo')
              ?.map((x) {
                try {
                  return AIAnalysisStruct.fromSerializableMap(jsonDecode(x));
                } catch (e) {
                  print("Can't decode persisted data type. Error: $e.");
                  return null;
                }
              })
              .withoutNulls
              .toList() ??
          _aiAnalysisInfo;
    });
    _safeInit(() {
      _hearthHealth = prefs
              .getStringList('ff_hearthHealth')
              ?.map((x) {
                try {
                  return AIAnalysisStruct.fromSerializableMap(jsonDecode(x));
                } catch (e) {
                  print("Can't decode persisted data type. Error: $e.");
                  return null;
                }
              })
              .withoutNulls
              .toList() ??
          _hearthHealth;
    });
    _safeInit(() {
      if (prefs.containsKey('ff_UserTracking')) {
        try {
          final serializedData = prefs.getString('ff_UserTracking') ?? '{}';
          _UserTracking = TrackingUserStruct.fromSerializableMap(
              jsonDecode(serializedData));
        } catch (e) {
          print("Can't decode persisted data type. Error: $e.");
        }
      }
    });
    _safeInit(() {
      _PlanFAQ = prefs
              .getStringList('ff_PlanFAQ')
              ?.map((x) {
                try {
                  return AIAnalysisStruct.fromSerializableMap(jsonDecode(x));
                } catch (e) {
                  print("Can't decode persisted data type. Error: $e.");
                  return null;
                }
              })
              .withoutNulls
              .toList() ??
          _PlanFAQ;
    });
    _safeInit(() {
      _bloodInfo = prefs
              .getStringList('ff_bloodInfo')
              ?.map((x) {
                try {
                  return BloodInfoStruct.fromSerializableMap(jsonDecode(x));
                } catch (e) {
                  print("Can't decode persisted data type. Error: $e.");
                  return null;
                }
              })
              .withoutNulls
              .toList() ??
          _bloodInfo;
    });
    _safeInit(() {
      if (prefs.containsKey('ff_HealthPermission')) {
        try {
          final serializedData = prefs.getString('ff_HealthPermission') ?? '{}';
          _HealthPermission =
              HealthStruct.fromSerializableMap(jsonDecode(serializedData));
        } catch (e) {
          print("Can't decode persisted data type. Error: $e.");
        }
      }
    });
    _safeInit(() {
      _bpmInfos = prefs
              .getStringList('ff_bpmInfos')
              ?.map((x) {
                try {
                  return BPMinfoStruct.fromSerializableMap(jsonDecode(x));
                } catch (e) {
                  print("Can't decode persisted data type. Error: $e.");
                  return null;
                }
              })
              .withoutNulls
              .toList() ??
          _bpmInfos;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  UserStruct _userData = UserStruct();
  UserStruct get userData => _userData;
  set userData(UserStruct value) {
    _userData = value;
    prefs.setString('ff_userData', value.serialize());
  }

  void updateUserDataStruct(Function(UserStruct) updateFn) {
    updateFn(_userData);
    prefs.setString('ff_userData', _userData.serialize());
  }

  List<AIAnalysisStruct> _aiAnalysisInfo = [];
  List<AIAnalysisStruct> get aiAnalysisInfo => _aiAnalysisInfo;
  set aiAnalysisInfo(List<AIAnalysisStruct> value) {
    _aiAnalysisInfo = value;
    prefs.setStringList(
        'ff_aiAnalysisInfo', value.map((x) => x.serialize()).toList());
  }

  void addToAiAnalysisInfo(AIAnalysisStruct value) {
    aiAnalysisInfo.add(value);
    prefs.setStringList('ff_aiAnalysisInfo',
        _aiAnalysisInfo.map((x) => x.serialize()).toList());
  }

  void removeFromAiAnalysisInfo(AIAnalysisStruct value) {
    aiAnalysisInfo.remove(value);
    prefs.setStringList('ff_aiAnalysisInfo',
        _aiAnalysisInfo.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromAiAnalysisInfo(int index) {
    aiAnalysisInfo.removeAt(index);
    prefs.setStringList('ff_aiAnalysisInfo',
        _aiAnalysisInfo.map((x) => x.serialize()).toList());
  }

  void updateAiAnalysisInfoAtIndex(
    int index,
    AIAnalysisStruct Function(AIAnalysisStruct) updateFn,
  ) {
    aiAnalysisInfo[index] = updateFn(_aiAnalysisInfo[index]);
    prefs.setStringList('ff_aiAnalysisInfo',
        _aiAnalysisInfo.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInAiAnalysisInfo(int index, AIAnalysisStruct value) {
    aiAnalysisInfo.insert(index, value);
    prefs.setStringList('ff_aiAnalysisInfo',
        _aiAnalysisInfo.map((x) => x.serialize()).toList());
  }

  List<AIAnalysisStruct> _hearthHealth = [];
  List<AIAnalysisStruct> get hearthHealth => _hearthHealth;
  set hearthHealth(List<AIAnalysisStruct> value) {
    _hearthHealth = value;
    prefs.setStringList(
        'ff_hearthHealth', value.map((x) => x.serialize()).toList());
  }

  void addToHearthHealth(AIAnalysisStruct value) {
    hearthHealth.add(value);
    prefs.setStringList(
        'ff_hearthHealth', _hearthHealth.map((x) => x.serialize()).toList());
  }

  void removeFromHearthHealth(AIAnalysisStruct value) {
    hearthHealth.remove(value);
    prefs.setStringList(
        'ff_hearthHealth', _hearthHealth.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromHearthHealth(int index) {
    hearthHealth.removeAt(index);
    prefs.setStringList(
        'ff_hearthHealth', _hearthHealth.map((x) => x.serialize()).toList());
  }

  void updateHearthHealthAtIndex(
    int index,
    AIAnalysisStruct Function(AIAnalysisStruct) updateFn,
  ) {
    hearthHealth[index] = updateFn(_hearthHealth[index]);
    prefs.setStringList(
        'ff_hearthHealth', _hearthHealth.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInHearthHealth(int index, AIAnalysisStruct value) {
    hearthHealth.insert(index, value);
    prefs.setStringList(
        'ff_hearthHealth', _hearthHealth.map((x) => x.serialize()).toList());
  }

  TrackingUserStruct _UserTracking = TrackingUserStruct();
  TrackingUserStruct get UserTracking => _UserTracking;
  set UserTracking(TrackingUserStruct value) {
    _UserTracking = value;
    prefs.setString('ff_UserTracking', value.serialize());
  }

  void updateUserTrackingStruct(Function(TrackingUserStruct) updateFn) {
    updateFn(_UserTracking);
    prefs.setString('ff_UserTracking', _UserTracking.serialize());
  }

  List<AIAnalysisStruct> _PlanFAQ = [];
  List<AIAnalysisStruct> get PlanFAQ => _PlanFAQ;
  set PlanFAQ(List<AIAnalysisStruct> value) {
    _PlanFAQ = value;
    prefs.setStringList('ff_PlanFAQ', value.map((x) => x.serialize()).toList());
  }

  void addToPlanFAQ(AIAnalysisStruct value) {
    PlanFAQ.add(value);
    prefs.setStringList(
        'ff_PlanFAQ', _PlanFAQ.map((x) => x.serialize()).toList());
  }

  void removeFromPlanFAQ(AIAnalysisStruct value) {
    PlanFAQ.remove(value);
    prefs.setStringList(
        'ff_PlanFAQ', _PlanFAQ.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromPlanFAQ(int index) {
    PlanFAQ.removeAt(index);
    prefs.setStringList(
        'ff_PlanFAQ', _PlanFAQ.map((x) => x.serialize()).toList());
  }

  void updatePlanFAQAtIndex(
    int index,
    AIAnalysisStruct Function(AIAnalysisStruct) updateFn,
  ) {
    PlanFAQ[index] = updateFn(_PlanFAQ[index]);
    prefs.setStringList(
        'ff_PlanFAQ', _PlanFAQ.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInPlanFAQ(int index, AIAnalysisStruct value) {
    PlanFAQ.insert(index, value);
    prefs.setStringList(
        'ff_PlanFAQ', _PlanFAQ.map((x) => x.serialize()).toList());
  }

  List<BloodInfoStruct> _bloodInfo = [];
  List<BloodInfoStruct> get bloodInfo => _bloodInfo;
  set bloodInfo(List<BloodInfoStruct> value) {
    _bloodInfo = value;
    prefs.setStringList(
        'ff_bloodInfo', value.map((x) => x.serialize()).toList());
  }

  void addToBloodInfo(BloodInfoStruct value) {
    bloodInfo.add(value);
    prefs.setStringList(
        'ff_bloodInfo', _bloodInfo.map((x) => x.serialize()).toList());
  }

  void removeFromBloodInfo(BloodInfoStruct value) {
    bloodInfo.remove(value);
    prefs.setStringList(
        'ff_bloodInfo', _bloodInfo.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromBloodInfo(int index) {
    bloodInfo.removeAt(index);
    prefs.setStringList(
        'ff_bloodInfo', _bloodInfo.map((x) => x.serialize()).toList());
  }

  void updateBloodInfoAtIndex(
    int index,
    BloodInfoStruct Function(BloodInfoStruct) updateFn,
  ) {
    bloodInfo[index] = updateFn(_bloodInfo[index]);
    prefs.setStringList(
        'ff_bloodInfo', _bloodInfo.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInBloodInfo(int index, BloodInfoStruct value) {
    bloodInfo.insert(index, value);
    prefs.setStringList(
        'ff_bloodInfo', _bloodInfo.map((x) => x.serialize()).toList());
  }

  HealthStruct _HealthPermission = HealthStruct();
  HealthStruct get HealthPermission => _HealthPermission;
  set HealthPermission(HealthStruct value) {
    _HealthPermission = value;
    prefs.setString('ff_HealthPermission', value.serialize());
  }

  void updateHealthPermissionStruct(Function(HealthStruct) updateFn) {
    updateFn(_HealthPermission);
    prefs.setString('ff_HealthPermission', _HealthPermission.serialize());
  }

  List<HealthInfoStruct> _healthInfo = [];
  List<HealthInfoStruct> get healthInfo => _healthInfo;
  set healthInfo(List<HealthInfoStruct> value) {
    _healthInfo = value;
  }

  void addToHealthInfo(HealthInfoStruct value) {
    healthInfo.add(value);
  }

  void removeFromHealthInfo(HealthInfoStruct value) {
    healthInfo.remove(value);
  }

  void removeAtIndexFromHealthInfo(int index) {
    healthInfo.removeAt(index);
  }

  void updateHealthInfoAtIndex(
    int index,
    HealthInfoStruct Function(HealthInfoStruct) updateFn,
  ) {
    healthInfo[index] = updateFn(_healthInfo[index]);
  }

  void insertAtIndexInHealthInfo(int index, HealthInfoStruct value) {
    healthInfo.insert(index, value);
  }

  List<BPMinfoStruct> _bpmInfos = [];
  List<BPMinfoStruct> get bpmInfos => _bpmInfos;
  set bpmInfos(List<BPMinfoStruct> value) {
    _bpmInfos = value;
    prefs.setStringList(
        'ff_bpmInfos', value.map((x) => x.serialize()).toList());
  }

  void addToBpmInfos(BPMinfoStruct value) {
    bpmInfos.add(value);
    prefs.setStringList(
        'ff_bpmInfos', _bpmInfos.map((x) => x.serialize()).toList());
  }

  void removeFromBpmInfos(BPMinfoStruct value) {
    bpmInfos.remove(value);
    prefs.setStringList(
        'ff_bpmInfos', _bpmInfos.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromBpmInfos(int index) {
    bpmInfos.removeAt(index);
    prefs.setStringList(
        'ff_bpmInfos', _bpmInfos.map((x) => x.serialize()).toList());
  }

  void updateBpmInfosAtIndex(
    int index,
    BPMinfoStruct Function(BPMinfoStruct) updateFn,
  ) {
    bpmInfos[index] = updateFn(_bpmInfos[index]);
    prefs.setStringList(
        'ff_bpmInfos', _bpmInfos.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInBpmInfos(int index, BPMinfoStruct value) {
    bpmInfos.insert(index, value);
    prefs.setStringList(
        'ff_bpmInfos', _bpmInfos.map((x) => x.serialize()).toList());
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
