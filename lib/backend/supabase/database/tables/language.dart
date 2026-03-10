import '../database.dart';

class LanguageTable extends SupabaseTable<LanguageRow> {
  @override
  String get tableName => 'language';

  @override
  LanguageRow createRow(Map<String, dynamic> data) => LanguageRow(data);
}

class LanguageRow extends SupabaseDataRow {
  LanguageRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => LanguageTable();

  int? get id => getField<int>('id');
  set id(int? value) => setField<int>('id', value);

  String? get name => getField<String>('name');
  set name(String? value) => setField<String>('name', value);

  String? get langCode => getField<String>('lang_code');
  set langCode(String? value) => setField<String>('lang_code', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);

  String? get langName => getField<String>('lang_name');
  set langName(String? value) => setField<String>('lang_name', value);

  String? get countryCode => getField<String>('country_code');
  set countryCode(String? value) => setField<String>('country_code', value);

  String? get flag => getField<String>('flag');
  set flag(String? value) => setField<String>('flag', value);
}
