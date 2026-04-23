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
      _countryCode = prefs.getString('ff_countryCode') ?? _countryCode;
    });
    _safeInit(() {
      if (prefs.containsKey('ff_currentUserLang')) {
        try {
          final serializedData = prefs.getString('ff_currentUserLang') ?? '{}';
          _currentUserLang =
              MealStruct.fromSerializableMap(jsonDecode(serializedData));
        } catch (e) {
          print("Can't decode persisted data type. Error: $e.");
        }
      }
    });
    _safeInit(() {
      if (prefs.containsKey('ff_translationsCSV')) {
        try {
          _translationsCSV =
              jsonDecode(prefs.getString('ff_translationsCSV') ?? '');
        } catch (e) {
          print("Can't decode persisted json. Error: $e.");
        }
      }
    });
    _safeInit(() {
      if (prefs.containsKey('ff_config')) {
        try {
          final serializedData = prefs.getString('ff_config') ?? '{}';
          _config =
              ConfigStruct.fromSerializableMap(jsonDecode(serializedData));
        } catch (e) {
          print("Can't decode persisted data type. Error: $e.");
        }
      }
    });
    _safeInit(() {
      _MealInfo = prefs
              .getStringList('ff_MealInfo')
              ?.map((x) {
                try {
                  return MealStruct.fromSerializableMap(jsonDecode(x));
                } catch (e) {
                  print("Can't decode persisted data type. Error: $e.");
                  return null;
                }
              })
              .withoutNulls
              .toList() ??
          _MealInfo;
    });
    _safeInit(() {
      _activityName = prefs
              .getStringList('ff_activityName')
              ?.map((x) {
                try {
                  return ActivityStruct.fromSerializableMap(jsonDecode(x));
                } catch (e) {
                  print("Can't decode persisted data type. Error: $e.");
                  return null;
                }
              })
              .withoutNulls
              .toList() ??
          _activityName;
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

  /// this is used for app.
  ///
  /// does not store to the backend. this used in the profile page
  String _countryCode = '';
  String get countryCode => _countryCode;
  set countryCode(String value) {
    _countryCode = value;
    prefs.setString('ff_countryCode', value);
  }

  MealStruct _currentUserLang = MealStruct();
  MealStruct get currentUserLang => _currentUserLang;
  set currentUserLang(MealStruct value) {
    _currentUserLang = value;
    prefs.setString('ff_currentUserLang', value.serialize());
  }

  void updateCurrentUserLangStruct(Function(MealStruct) updateFn) {
    updateFn(_currentUserLang);
    prefs.setString('ff_currentUserLang', _currentUserLang.serialize());
  }

  dynamic _translationsCSV;
  dynamic get translationsCSV => _translationsCSV;
  set translationsCSV(dynamic value) {
    _translationsCSV = value;
    prefs.setString('ff_translationsCSV', jsonEncode(value));
  }

  ConfigStruct _config = ConfigStruct();
  ConfigStruct get config => _config;
  set config(ConfigStruct value) {
    _config = value;
    prefs.setString('ff_config', value.serialize());
  }

  void updateConfigStruct(Function(ConfigStruct) updateFn) {
    updateFn(_config);
    prefs.setString('ff_config', _config.serialize());
  }

  List<MealStruct> _MealInfo = [];
  List<MealStruct> get MealInfo => _MealInfo;
  set MealInfo(List<MealStruct> value) {
    _MealInfo = value;
    prefs.setStringList(
        'ff_MealInfo', value.map((x) => x.serialize()).toList());
  }

  void addToMealInfo(MealStruct value) {
    MealInfo.add(value);
    prefs.setStringList(
        'ff_MealInfo', _MealInfo.map((x) => x.serialize()).toList());
  }

  void removeFromMealInfo(MealStruct value) {
    MealInfo.remove(value);
    prefs.setStringList(
        'ff_MealInfo', _MealInfo.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromMealInfo(int index) {
    MealInfo.removeAt(index);
    prefs.setStringList(
        'ff_MealInfo', _MealInfo.map((x) => x.serialize()).toList());
  }

  void updateMealInfoAtIndex(
    int index,
    MealStruct Function(MealStruct) updateFn,
  ) {
    MealInfo[index] = updateFn(_MealInfo[index]);
    prefs.setStringList(
        'ff_MealInfo', _MealInfo.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInMealInfo(int index, MealStruct value) {
    MealInfo.insert(index, value);
    prefs.setStringList(
        'ff_MealInfo', _MealInfo.map((x) => x.serialize()).toList());
  }

  List<ActivityStruct> _activityName = [];
  List<ActivityStruct> get activityName => _activityName;
  set activityName(List<ActivityStruct> value) {
    _activityName = value;
    prefs.setStringList(
        'ff_activityName', value.map((x) => x.serialize()).toList());
  }

  void addToActivityName(ActivityStruct value) {
    activityName.add(value);
    prefs.setStringList(
        'ff_activityName', _activityName.map((x) => x.serialize()).toList());
  }

  void removeFromActivityName(ActivityStruct value) {
    activityName.remove(value);
    prefs.setStringList(
        'ff_activityName', _activityName.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromActivityName(int index) {
    activityName.removeAt(index);
    prefs.setStringList(
        'ff_activityName', _activityName.map((x) => x.serialize()).toList());
  }

  void updateActivityNameAtIndex(
    int index,
    ActivityStruct Function(ActivityStruct) updateFn,
  ) {
    activityName[index] = updateFn(_activityName[index]);
    prefs.setStringList(
        'ff_activityName', _activityName.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInActivityName(int index, ActivityStruct value) {
    activityName.insert(index, value);
    prefs.setStringList(
        'ff_activityName', _activityName.map((x) => x.serialize()).toList());
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
