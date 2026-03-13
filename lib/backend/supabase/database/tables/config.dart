import '../database.dart';

class ConfigTable extends SupabaseTable<ConfigRow> {
  @override
  String get tableName => 'config';

  @override
  ConfigRow createRow(Map<String, dynamic> data) => ConfigRow(data);
}

class ConfigRow extends SupabaseDataRow {
  ConfigRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => ConfigTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  dynamic get onboardingGoalText => getField<dynamic>('onboarding_goal_text');
  set onboardingGoalText(dynamic value) =>
      setField<dynamic>('onboarding_goal_text', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String? get policy => getField<String>('policy');
  set policy(String? value) => setField<String>('policy', value);

  int? get translationTableVersion =>
      getField<int>('translation_table_version');
  set translationTableVersion(int? value) =>
      setField<int>('translation_table_version', value);

  dynamic get scanTypeImages => getField<dynamic>('scanTypeImages');
  set scanTypeImages(dynamic value) =>
      setField<dynamic>('scanTypeImages', value);
}
