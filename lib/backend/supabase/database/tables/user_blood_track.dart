import '../database.dart';

class UserBloodTrackTable extends SupabaseTable<UserBloodTrackRow> {
  @override
  String get tableName => 'user_bloodTrack';

  @override
  UserBloodTrackRow createRow(Map<String, dynamic> data) =>
      UserBloodTrackRow(data);
}

class UserBloodTrackRow extends SupabaseDataRow {
  UserBloodTrackRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => UserBloodTrackTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  int? get systolic => getField<int>('systolic');
  set systolic(int? value) => setField<int>('systolic', value);

  int? get diastolic => getField<int>('diastolic');
  set diastolic(int? value) => setField<int>('diastolic', value);

  int? get spo2 => getField<int>('spo2');
  set spo2(int? value) => setField<int>('spo2', value);

  String? get sugarState => getField<String>('sugar_state');
  set sugarState(String? value) => setField<String>('sugar_state', value);

  int? get mgDl => getField<int>('mg_dl');
  set mgDl(int? value) => setField<int>('mg_dl', value);

  double? get mmoiL => getField<double>('mmoi_l');
  set mmoiL(double? value) => setField<double>('mmoi_l', value);

  String? get date => getField<String>('date');
  set date(String? value) => setField<String>('date', value);

  String? get time => getField<String>('time');
  set time(String? value) => setField<String>('time', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String? get userId => getField<String>('user_id');
  set userId(String? value) => setField<String>('user_id', value);

  int? get type => getField<int>('type');
  set type(int? value) => setField<int>('type', value);
}
