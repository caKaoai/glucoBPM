import '../database.dart';

class UserBPMTable extends SupabaseTable<UserBPMRow> {
  @override
  String get tableName => 'user_BPM';

  @override
  UserBPMRow createRow(Map<String, dynamic> data) => UserBPMRow(data);
}

class UserBPMRow extends SupabaseDataRow {
  UserBPMRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => UserBPMTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  int? get pluse => getField<int>('pluse');
  set pluse(int? value) => setField<int>('pluse', value);

  int? get hrv => getField<int>('hrv');
  set hrv(int? value) => setField<int>('hrv', value);

  String? get userId => getField<String>('user_id');
  set userId(String? value) => setField<String>('user_id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);
}
