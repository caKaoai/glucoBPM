import '../database.dart';

class UsersTable extends SupabaseTable<UsersRow> {
  @override
  String get tableName => 'users';

  @override
  UsersRow createRow(Map<String, dynamic> data) => UsersRow(data);
}

class UsersRow extends SupabaseDataRow {
  UsersRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => UsersTable();

  String? get name => getField<String>('name');
  set name(String? value) => setField<String>('name', value);

  String? get gender => getField<String>('gender');
  set gender(String? value) => setField<String>('gender', value);

  int? get age => getField<int>('age');
  set age(int? value) => setField<int>('age', value);

  int? get height => getField<int>('height');
  set height(int? value) => setField<int>('height', value);

  int? get weight => getField<int>('weight');
  set weight(int? value) => setField<int>('weight', value);

  double? get bmi => getField<double>('bmi');
  set bmi(double? value) => setField<double>('bmi', value);

  String? get heightUnit => getField<String>('heightUnit');
  set heightUnit(String? value) => setField<String>('heightUnit', value);

  String? get weightUnit => getField<String>('weightUnit');
  set weightUnit(String? value) => setField<String>('weightUnit', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);

  String get userId => getField<String>('user_id')!;
  set userId(String value) => setField<String>('user_id', value);

  String? get email => getField<String>('email');
  set email(String? value) => setField<String>('email', value);

  String? get authProvider => getField<String>('auth_provider');
  set authProvider(String? value) => setField<String>('auth_provider', value);

  String? get profileUrl => getField<String>('profile_url');
  set profileUrl(String? value) => setField<String>('profile_url', value);

  String? get emi => getField<String>('emi');
  set emi(String? value) => setField<String>('emi', value);

  int? get goalSteps => getField<int>('goalSteps');
  set goalSteps(int? value) => setField<int>('goalSteps', value);

  String? get ipAddress => getField<String>('ipAddress');
  set ipAddress(String? value) => setField<String>('ipAddress', value);

  String? get country => getField<String>('country');
  set country(String? value) => setField<String>('country', value);

  List<String> get goal => getListField<String>('goal');
  set goal(List<String>? value) => setListField<String>('goal', value);

  String? get daibType => getField<String>('daibType');
  set daibType(String? value) => setField<String>('daibType', value);
}
