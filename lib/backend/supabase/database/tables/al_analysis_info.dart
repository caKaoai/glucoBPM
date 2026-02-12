import '../database.dart';

class AlAnalysisInfoTable extends SupabaseTable<AlAnalysisInfoRow> {
  @override
  String get tableName => 'al_analysisInfo';

  @override
  AlAnalysisInfoRow createRow(Map<String, dynamic> data) =>
      AlAnalysisInfoRow(data);
}

class AlAnalysisInfoRow extends SupabaseDataRow {
  AlAnalysisInfoRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => AlAnalysisInfoTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  String? get name => getField<String>('name');
  set name(String? value) => setField<String>('name', value);

  String? get photo => getField<String>('photo');
  set photo(String? value) => setField<String>('photo', value);

  String? get aboutMe => getField<String>('about_me');
  set aboutMe(String? value) => setField<String>('about_me', value);

  String? get approach => getField<String>('approach');
  set approach(String? value) => setField<String>('approach', value);

  double? get review => getField<double>('review');
  set review(double? value) => setField<double>('review', value);

  List<String> get qualification => getListField<String>('qualification');
  set qualification(List<String>? value) =>
      setListField<String>('qualification', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);
}
