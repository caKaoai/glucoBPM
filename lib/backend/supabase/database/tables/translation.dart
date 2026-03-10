import '../database.dart';

class TranslationTable extends SupabaseTable<TranslationRow> {
  @override
  String get tableName => 'translation';

  @override
  TranslationRow createRow(Map<String, dynamic> data) => TranslationRow(data);
}

class TranslationRow extends SupabaseDataRow {
  TranslationRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => TranslationTable();

  String? get en => getField<String>('en');
  set en(String? value) => setField<String>('en', value);

  String? get vi => getField<String>('vi');
  set vi(String? value) => setField<String>('vi', value);

  String? get ja => getField<String>('ja');
  set ja(String? value) => setField<String>('ja', value);

  String? get ar => getField<String>('ar');
  set ar(String? value) => setField<String>('ar', value);

  String? get hi => getField<String>('hi');
  set hi(String? value) => setField<String>('hi', value);

  String? get th => getField<String>('th');
  set th(String? value) => setField<String>('th', value);

  String? get es => getField<String>('es');
  set es(String? value) => setField<String>('es', value);

  String? get ko => getField<String>('ko');
  set ko(String? value) => setField<String>('ko', value);

  String? get zhHans => getField<String>('zh_Hans');
  set zhHans(String? value) => setField<String>('zh_Hans', value);

  String? get fr => getField<String>('fr');
  set fr(String? value) => setField<String>('fr', value);

  String? get tr => getField<String>('tr');
  set tr(String? value) => setField<String>('tr', value);

  String? get ru => getField<String>('ru');
  set ru(String? value) => setField<String>('ru', value);

  String? get de => getField<String>('de');
  set de(String? value) => setField<String>('de', value);

  String? get pt => getField<String>('pt');
  set pt(String? value) => setField<String>('pt', value);

  String? get it => getField<String>('it');
  set it(String? value) => setField<String>('it', value);

  int get tranId => getField<int>('tran_id')!;
  set tranId(int value) => setField<int>('tran_id', value);

  String? get id => getField<String>('id');
  set id(String? value) => setField<String>('id', value);

  String? get key => getField<String>('key');
  set key(String? value) => setField<String>('key', value);
}
