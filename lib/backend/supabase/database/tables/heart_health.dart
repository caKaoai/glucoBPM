import '../database.dart';

class HeartHealthTable extends SupabaseTable<HeartHealthRow> {
  @override
  String get tableName => 'heart_health';

  @override
  HeartHealthRow createRow(Map<String, dynamic> data) => HeartHealthRow(data);
}

class HeartHealthRow extends SupabaseDataRow {
  HeartHealthRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => HeartHealthTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  String? get photo => getField<String>('photo');
  set photo(String? value) => setField<String>('photo', value);

  String? get name => getField<String>('name');
  set name(String? value) => setField<String>('name', value);

  String? get description => getField<String>('description');
  set description(String? value) => setField<String>('description', value);

  int? get plan => getField<int>('plan');
  set plan(int? value) => setField<int>('plan', value);

  int? get days => getField<int>('days');
  set days(int? value) => setField<int>('days', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String? get type => getField<String>('type');
  set type(String? value) => setField<String>('type', value);

  List<String> get images => getListField<String>('images');
  set images(List<String>? value) => setListField<String>('images', value);
}
