// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UserStruct extends BaseStruct {
  UserStruct({
    String? name,
    String? email,
    String? profileUrl,
    String? emi,
    String? gender,
    int? age,
    int? height,
    int? weight,
    double? bmi,
    String? heightUnit,
    String? weightUnit,
    String? authProvider,
    String? ipAddress,
    String? country,
    List<String>? goal,
    String? daibType,
  })  : _name = name,
        _email = email,
        _profileUrl = profileUrl,
        _emi = emi,
        _gender = gender,
        _age = age,
        _height = height,
        _weight = weight,
        _bmi = bmi,
        _heightUnit = heightUnit,
        _weightUnit = weightUnit,
        _authProvider = authProvider,
        _ipAddress = ipAddress,
        _country = country,
        _goal = goal,
        _daibType = daibType;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  set email(String? val) => _email = val;

  bool hasEmail() => _email != null;

  // "profile_url" field.
  String? _profileUrl;
  String get profileUrl => _profileUrl ?? '';
  set profileUrl(String? val) => _profileUrl = val;

  bool hasProfileUrl() => _profileUrl != null;

  // "emi" field.
  String? _emi;
  String get emi => _emi ?? '';
  set emi(String? val) => _emi = val;

  bool hasEmi() => _emi != null;

  // "gender" field.
  String? _gender;
  String get gender => _gender ?? '';
  set gender(String? val) => _gender = val;

  bool hasGender() => _gender != null;

  // "age" field.
  int? _age;
  int get age => _age ?? 0;
  set age(int? val) => _age = val;

  void incrementAge(int amount) => age = age + amount;

  bool hasAge() => _age != null;

  // "height" field.
  int? _height;
  int get height => _height ?? 0;
  set height(int? val) => _height = val;

  void incrementHeight(int amount) => height = height + amount;

  bool hasHeight() => _height != null;

  // "weight" field.
  int? _weight;
  int get weight => _weight ?? 0;
  set weight(int? val) => _weight = val;

  void incrementWeight(int amount) => weight = weight + amount;

  bool hasWeight() => _weight != null;

  // "bmi" field.
  double? _bmi;
  double get bmi => _bmi ?? 0.0;
  set bmi(double? val) => _bmi = val;

  void incrementBmi(double amount) => bmi = bmi + amount;

  bool hasBmi() => _bmi != null;

  // "heightUnit" field.
  String? _heightUnit;
  String get heightUnit => _heightUnit ?? '';
  set heightUnit(String? val) => _heightUnit = val;

  bool hasHeightUnit() => _heightUnit != null;

  // "weightUnit" field.
  String? _weightUnit;
  String get weightUnit => _weightUnit ?? '';
  set weightUnit(String? val) => _weightUnit = val;

  bool hasWeightUnit() => _weightUnit != null;

  // "auth_provider" field.
  String? _authProvider;
  String get authProvider => _authProvider ?? '';
  set authProvider(String? val) => _authProvider = val;

  bool hasAuthProvider() => _authProvider != null;

  // "ipAddress" field.
  String? _ipAddress;
  String get ipAddress => _ipAddress ?? '';
  set ipAddress(String? val) => _ipAddress = val;

  bool hasIpAddress() => _ipAddress != null;

  // "country" field.
  String? _country;
  String get country => _country ?? '';
  set country(String? val) => _country = val;

  bool hasCountry() => _country != null;

  // "goal" field.
  List<String>? _goal;
  List<String> get goal => _goal ?? const [];
  set goal(List<String>? val) => _goal = val;

  void updateGoal(Function(List<String>) updateFn) {
    updateFn(_goal ??= []);
  }

  bool hasGoal() => _goal != null;

  // "daibType" field.
  String? _daibType;
  String get daibType => _daibType ?? '';
  set daibType(String? val) => _daibType = val;

  bool hasDaibType() => _daibType != null;

  static UserStruct fromMap(Map<String, dynamic> data) => UserStruct(
        name: data['name'] as String?,
        email: data['email'] as String?,
        profileUrl: data['profile_url'] as String?,
        emi: data['emi'] as String?,
        gender: data['gender'] as String?,
        age: castToType<int>(data['age']),
        height: castToType<int>(data['height']),
        weight: castToType<int>(data['weight']),
        bmi: castToType<double>(data['bmi']),
        heightUnit: data['heightUnit'] as String?,
        weightUnit: data['weightUnit'] as String?,
        authProvider: data['auth_provider'] as String?,
        ipAddress: data['ipAddress'] as String?,
        country: data['country'] as String?,
        goal: getDataList(data['goal']),
        daibType: data['daibType'] as String?,
      );

  static UserStruct? maybeFromMap(dynamic data) =>
      data is Map ? UserStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'name': _name,
        'email': _email,
        'profile_url': _profileUrl,
        'emi': _emi,
        'gender': _gender,
        'age': _age,
        'height': _height,
        'weight': _weight,
        'bmi': _bmi,
        'heightUnit': _heightUnit,
        'weightUnit': _weightUnit,
        'auth_provider': _authProvider,
        'ipAddress': _ipAddress,
        'country': _country,
        'goal': _goal,
        'daibType': _daibType,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'email': serializeParam(
          _email,
          ParamType.String,
        ),
        'profile_url': serializeParam(
          _profileUrl,
          ParamType.String,
        ),
        'emi': serializeParam(
          _emi,
          ParamType.String,
        ),
        'gender': serializeParam(
          _gender,
          ParamType.String,
        ),
        'age': serializeParam(
          _age,
          ParamType.int,
        ),
        'height': serializeParam(
          _height,
          ParamType.int,
        ),
        'weight': serializeParam(
          _weight,
          ParamType.int,
        ),
        'bmi': serializeParam(
          _bmi,
          ParamType.double,
        ),
        'heightUnit': serializeParam(
          _heightUnit,
          ParamType.String,
        ),
        'weightUnit': serializeParam(
          _weightUnit,
          ParamType.String,
        ),
        'auth_provider': serializeParam(
          _authProvider,
          ParamType.String,
        ),
        'ipAddress': serializeParam(
          _ipAddress,
          ParamType.String,
        ),
        'country': serializeParam(
          _country,
          ParamType.String,
        ),
        'goal': serializeParam(
          _goal,
          ParamType.String,
          isList: true,
        ),
        'daibType': serializeParam(
          _daibType,
          ParamType.String,
        ),
      }.withoutNulls;

  static UserStruct fromSerializableMap(Map<String, dynamic> data) =>
      UserStruct(
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        email: deserializeParam(
          data['email'],
          ParamType.String,
          false,
        ),
        profileUrl: deserializeParam(
          data['profile_url'],
          ParamType.String,
          false,
        ),
        emi: deserializeParam(
          data['emi'],
          ParamType.String,
          false,
        ),
        gender: deserializeParam(
          data['gender'],
          ParamType.String,
          false,
        ),
        age: deserializeParam(
          data['age'],
          ParamType.int,
          false,
        ),
        height: deserializeParam(
          data['height'],
          ParamType.int,
          false,
        ),
        weight: deserializeParam(
          data['weight'],
          ParamType.int,
          false,
        ),
        bmi: deserializeParam(
          data['bmi'],
          ParamType.double,
          false,
        ),
        heightUnit: deserializeParam(
          data['heightUnit'],
          ParamType.String,
          false,
        ),
        weightUnit: deserializeParam(
          data['weightUnit'],
          ParamType.String,
          false,
        ),
        authProvider: deserializeParam(
          data['auth_provider'],
          ParamType.String,
          false,
        ),
        ipAddress: deserializeParam(
          data['ipAddress'],
          ParamType.String,
          false,
        ),
        country: deserializeParam(
          data['country'],
          ParamType.String,
          false,
        ),
        goal: deserializeParam<String>(
          data['goal'],
          ParamType.String,
          true,
        ),
        daibType: deserializeParam(
          data['daibType'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'UserStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is UserStruct &&
        name == other.name &&
        email == other.email &&
        profileUrl == other.profileUrl &&
        emi == other.emi &&
        gender == other.gender &&
        age == other.age &&
        height == other.height &&
        weight == other.weight &&
        bmi == other.bmi &&
        heightUnit == other.heightUnit &&
        weightUnit == other.weightUnit &&
        authProvider == other.authProvider &&
        ipAddress == other.ipAddress &&
        country == other.country &&
        listEquality.equals(goal, other.goal) &&
        daibType == other.daibType;
  }

  @override
  int get hashCode => const ListEquality().hash([
        name,
        email,
        profileUrl,
        emi,
        gender,
        age,
        height,
        weight,
        bmi,
        heightUnit,
        weightUnit,
        authProvider,
        ipAddress,
        country,
        goal,
        daibType
      ]);
}

UserStruct createUserStruct({
  String? name,
  String? email,
  String? profileUrl,
  String? emi,
  String? gender,
  int? age,
  int? height,
  int? weight,
  double? bmi,
  String? heightUnit,
  String? weightUnit,
  String? authProvider,
  String? ipAddress,
  String? country,
  String? daibType,
}) =>
    UserStruct(
      name: name,
      email: email,
      profileUrl: profileUrl,
      emi: emi,
      gender: gender,
      age: age,
      height: height,
      weight: weight,
      bmi: bmi,
      heightUnit: heightUnit,
      weightUnit: weightUnit,
      authProvider: authProvider,
      ipAddress: ipAddress,
      country: country,
      daibType: daibType,
    );
