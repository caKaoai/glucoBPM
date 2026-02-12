import '../database.dart';

class PlanFaqTable extends SupabaseTable<PlanFaqRow> {
  @override
  String get tableName => 'plan_faq';

  @override
  PlanFaqRow createRow(Map<String, dynamic> data) => PlanFaqRow(data);
}

class PlanFaqRow extends SupabaseDataRow {
  PlanFaqRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => PlanFaqTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  String? get name => getField<String>('name');
  set name(String? value) => setField<String>('name', value);

  String? get photo => getField<String>('photo');
  set photo(String? value) => setField<String>('photo', value);

  String? get type => getField<String>('type');
  set type(String? value) => setField<String>('type', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);
}
