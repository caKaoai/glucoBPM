// ignore_for_file: unnecessary_getters_setters


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

/// This is used in the food scan flow and language table
class MealStruct extends BaseStruct {
  MealStruct({
    int? id,
    String? name,
    String? langCode,
    String? createdAt,
    String? langName,
    String? countryCode,
    String? flag,
    String? mealDate,
    String? mealHour,
    String? imageUrl,
    String? language,
    int? calories,
    int? fat,
    List<String>? ingredients,
    DiabeticScoreStruct? diabeticScore,
    int? protein,
    int? carbs,
    int? sugar,
    List<InfoStruct>? diabeticInsights,
    double? portionSize,
  })  : _id = id,
        _name = name,
        _langCode = langCode,
        _createdAt = createdAt,
        _langName = langName,
        _countryCode = countryCode,
        _flag = flag,
        _mealDate = mealDate,
        _mealHour = mealHour,
        _imageUrl = imageUrl,
        _language = language,
        _calories = calories,
        _fat = fat,
        _ingredients = ingredients,
        _diabeticScore = diabeticScore,
        _protein = protein,
        _carbs = carbs,
        _sugar = sugar,
        _diabeticInsights = diabeticInsights,
        _portionSize = portionSize;

  // "id" field.
  int? _id;
  int get id => _id ?? 0;
  set id(int? val) => _id = val;

  void incrementId(int amount) => id = id + amount;

  bool hasId() => _id != null;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  // "lang_code" field.
  String? _langCode;
  String get langCode => _langCode ?? '';
  set langCode(String? val) => _langCode = val;

  bool hasLangCode() => _langCode != null;

  // "created_at" field.
  String? _createdAt;
  String get createdAt => _createdAt ?? '';
  set createdAt(String? val) => _createdAt = val;

  bool hasCreatedAt() => _createdAt != null;

  // "lang_name" field.
  String? _langName;
  String get langName => _langName ?? '';
  set langName(String? val) => _langName = val;

  bool hasLangName() => _langName != null;

  // "country_code" field.
  String? _countryCode;
  String get countryCode => _countryCode ?? '';
  set countryCode(String? val) => _countryCode = val;

  bool hasCountryCode() => _countryCode != null;

  // "flag" field.
  String? _flag;
  String get flag => _flag ?? '';
  set flag(String? val) => _flag = val;

  bool hasFlag() => _flag != null;

  // "meal_date" field.
  String? _mealDate;
  String get mealDate => _mealDate ?? '';
  set mealDate(String? val) => _mealDate = val;

  bool hasMealDate() => _mealDate != null;

  // "meal_hour" field.
  String? _mealHour;
  String get mealHour => _mealHour ?? '';
  set mealHour(String? val) => _mealHour = val;

  bool hasMealHour() => _mealHour != null;

  // "image_url" field.
  String? _imageUrl;
  String get imageUrl => _imageUrl ?? '';
  set imageUrl(String? val) => _imageUrl = val;

  bool hasImageUrl() => _imageUrl != null;

  // "language" field.
  String? _language;
  String get language => _language ?? '';
  set language(String? val) => _language = val;

  bool hasLanguage() => _language != null;

  // "calories" field.
  int? _calories;
  int get calories => _calories ?? 0;
  set calories(int? val) => _calories = val;

  void incrementCalories(int amount) => calories = calories + amount;

  bool hasCalories() => _calories != null;

  // "fat" field.
  int? _fat;
  int get fat => _fat ?? 0;
  set fat(int? val) => _fat = val;

  void incrementFat(int amount) => fat = fat + amount;

  bool hasFat() => _fat != null;

  // "ingredients" field.
  List<String>? _ingredients;
  List<String> get ingredients => _ingredients ?? const [];
  set ingredients(List<String>? val) => _ingredients = val;

  void updateIngredients(Function(List<String>) updateFn) {
    updateFn(_ingredients ??= []);
  }

  bool hasIngredients() => _ingredients != null;

  // "diabetic_score" field.
  DiabeticScoreStruct? _diabeticScore;
  DiabeticScoreStruct get diabeticScore =>
      _diabeticScore ?? DiabeticScoreStruct();
  set diabeticScore(DiabeticScoreStruct? val) => _diabeticScore = val;

  void updateDiabeticScore(Function(DiabeticScoreStruct) updateFn) {
    updateFn(_diabeticScore ??= DiabeticScoreStruct());
  }

  bool hasDiabeticScore() => _diabeticScore != null;

  // "protein" field.
  int? _protein;
  int get protein => _protein ?? 0;
  set protein(int? val) => _protein = val;

  void incrementProtein(int amount) => protein = protein + amount;

  bool hasProtein() => _protein != null;

  // "carbs" field.
  int? _carbs;
  int get carbs => _carbs ?? 0;
  set carbs(int? val) => _carbs = val;

  void incrementCarbs(int amount) => carbs = carbs + amount;

  bool hasCarbs() => _carbs != null;

  // "sugar" field.
  int? _sugar;
  int get sugar => _sugar ?? 0;
  set sugar(int? val) => _sugar = val;

  void incrementSugar(int amount) => sugar = sugar + amount;

  bool hasSugar() => _sugar != null;

  // "diabetic_insights" field.
  List<InfoStruct>? _diabeticInsights;
  List<InfoStruct> get diabeticInsights => _diabeticInsights ?? const [];
  set diabeticInsights(List<InfoStruct>? val) => _diabeticInsights = val;

  void updateDiabeticInsights(Function(List<InfoStruct>) updateFn) {
    updateFn(_diabeticInsights ??= []);
  }

  bool hasDiabeticInsights() => _diabeticInsights != null;

  // "portion_size" field.
  double? _portionSize;
  double get portionSize => _portionSize ?? 0.0;
  set portionSize(double? val) => _portionSize = val;

  void incrementPortionSize(double amount) =>
      portionSize = portionSize + amount;

  bool hasPortionSize() => _portionSize != null;

  static MealStruct fromMap(Map<String, dynamic> data) => MealStruct(
        id: castToType<int>(data['id']),
        name: data['name'] as String?,
        langCode: data['lang_code'] as String?,
        createdAt: data['created_at'] as String?,
        langName: data['lang_name'] as String?,
        countryCode: data['country_code'] as String?,
        flag: data['flag'] as String?,
        mealDate: data['meal_date'] as String?,
        mealHour: data['meal_hour'] as String?,
        imageUrl: data['image_url'] as String?,
        language: data['language'] as String?,
        calories: castToType<int>(data['calories']),
        fat: castToType<int>(data['fat']),
        ingredients: getDataList(data['ingredients']),
        diabeticScore: data['diabetic_score'] is DiabeticScoreStruct
            ? data['diabetic_score']
            : DiabeticScoreStruct.maybeFromMap(data['diabetic_score']),
        protein: castToType<int>(data['protein']),
        carbs: castToType<int>(data['carbs']),
        sugar: castToType<int>(data['sugar']),
        diabeticInsights: getStructList(
          data['diabetic_insights'],
          InfoStruct.fromMap,
        ),
        portionSize: castToType<double>(data['portion_size']),
      );

  static MealStruct? maybeFromMap(dynamic data) =>
      data is Map ? MealStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'name': _name,
        'lang_code': _langCode,
        'created_at': _createdAt,
        'lang_name': _langName,
        'country_code': _countryCode,
        'flag': _flag,
        'meal_date': _mealDate,
        'meal_hour': _mealHour,
        'image_url': _imageUrl,
        'language': _language,
        'calories': _calories,
        'fat': _fat,
        'ingredients': _ingredients,
        'diabetic_score': _diabeticScore?.toMap(),
        'protein': _protein,
        'carbs': _carbs,
        'sugar': _sugar,
        'diabetic_insights': _diabeticInsights?.map((e) => e.toMap()).toList(),
        'portion_size': _portionSize,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.int,
        ),
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'lang_code': serializeParam(
          _langCode,
          ParamType.String,
        ),
        'created_at': serializeParam(
          _createdAt,
          ParamType.String,
        ),
        'lang_name': serializeParam(
          _langName,
          ParamType.String,
        ),
        'country_code': serializeParam(
          _countryCode,
          ParamType.String,
        ),
        'flag': serializeParam(
          _flag,
          ParamType.String,
        ),
        'meal_date': serializeParam(
          _mealDate,
          ParamType.String,
        ),
        'meal_hour': serializeParam(
          _mealHour,
          ParamType.String,
        ),
        'image_url': serializeParam(
          _imageUrl,
          ParamType.String,
        ),
        'language': serializeParam(
          _language,
          ParamType.String,
        ),
        'calories': serializeParam(
          _calories,
          ParamType.int,
        ),
        'fat': serializeParam(
          _fat,
          ParamType.int,
        ),
        'ingredients': serializeParam(
          _ingredients,
          ParamType.String,
          isList: true,
        ),
        'diabetic_score': serializeParam(
          _diabeticScore,
          ParamType.DataStruct,
        ),
        'protein': serializeParam(
          _protein,
          ParamType.int,
        ),
        'carbs': serializeParam(
          _carbs,
          ParamType.int,
        ),
        'sugar': serializeParam(
          _sugar,
          ParamType.int,
        ),
        'diabetic_insights': serializeParam(
          _diabeticInsights,
          ParamType.DataStruct,
          isList: true,
        ),
        'portion_size': serializeParam(
          _portionSize,
          ParamType.double,
        ),
      }.withoutNulls;

  static MealStruct fromSerializableMap(Map<String, dynamic> data) =>
      MealStruct(
        id: deserializeParam(
          data['id'],
          ParamType.int,
          false,
        ),
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        langCode: deserializeParam(
          data['lang_code'],
          ParamType.String,
          false,
        ),
        createdAt: deserializeParam(
          data['created_at'],
          ParamType.String,
          false,
        ),
        langName: deserializeParam(
          data['lang_name'],
          ParamType.String,
          false,
        ),
        countryCode: deserializeParam(
          data['country_code'],
          ParamType.String,
          false,
        ),
        flag: deserializeParam(
          data['flag'],
          ParamType.String,
          false,
        ),
        mealDate: deserializeParam(
          data['meal_date'],
          ParamType.String,
          false,
        ),
        mealHour: deserializeParam(
          data['meal_hour'],
          ParamType.String,
          false,
        ),
        imageUrl: deserializeParam(
          data['image_url'],
          ParamType.String,
          false,
        ),
        language: deserializeParam(
          data['language'],
          ParamType.String,
          false,
        ),
        calories: deserializeParam(
          data['calories'],
          ParamType.int,
          false,
        ),
        fat: deserializeParam(
          data['fat'],
          ParamType.int,
          false,
        ),
        ingredients: deserializeParam<String>(
          data['ingredients'],
          ParamType.String,
          true,
        ),
        diabeticScore: deserializeStructParam(
          data['diabetic_score'],
          ParamType.DataStruct,
          false,
          structBuilder: DiabeticScoreStruct.fromSerializableMap,
        ),
        protein: deserializeParam(
          data['protein'],
          ParamType.int,
          false,
        ),
        carbs: deserializeParam(
          data['carbs'],
          ParamType.int,
          false,
        ),
        sugar: deserializeParam(
          data['sugar'],
          ParamType.int,
          false,
        ),
        diabeticInsights: deserializeStructParam<InfoStruct>(
          data['diabetic_insights'],
          ParamType.DataStruct,
          true,
          structBuilder: InfoStruct.fromSerializableMap,
        ),
        portionSize: deserializeParam(
          data['portion_size'],
          ParamType.double,
          false,
        ),
      );

  @override
  String toString() => 'MealStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is MealStruct &&
        id == other.id &&
        name == other.name &&
        langCode == other.langCode &&
        createdAt == other.createdAt &&
        langName == other.langName &&
        countryCode == other.countryCode &&
        flag == other.flag &&
        mealDate == other.mealDate &&
        mealHour == other.mealHour &&
        imageUrl == other.imageUrl &&
        language == other.language &&
        calories == other.calories &&
        fat == other.fat &&
        listEquality.equals(ingredients, other.ingredients) &&
        diabeticScore == other.diabeticScore &&
        protein == other.protein &&
        carbs == other.carbs &&
        sugar == other.sugar &&
        listEquality.equals(diabeticInsights, other.diabeticInsights) &&
        portionSize == other.portionSize;
  }

  @override
  int get hashCode => const ListEquality().hash([
        id,
        name,
        langCode,
        createdAt,
        langName,
        countryCode,
        flag,
        mealDate,
        mealHour,
        imageUrl,
        language,
        calories,
        fat,
        ingredients,
        diabeticScore,
        protein,
        carbs,
        sugar,
        diabeticInsights,
        portionSize
      ]);
}

MealStruct createMealStruct({
  int? id,
  String? name,
  String? langCode,
  String? createdAt,
  String? langName,
  String? countryCode,
  String? flag,
  String? mealDate,
  String? mealHour,
  String? imageUrl,
  String? language,
  int? calories,
  int? fat,
  DiabeticScoreStruct? diabeticScore,
  int? protein,
  int? carbs,
  int? sugar,
  double? portionSize,
}) =>
    MealStruct(
      id: id,
      name: name,
      langCode: langCode,
      createdAt: createdAt,
      langName: langName,
      countryCode: countryCode,
      flag: flag,
      mealDate: mealDate,
      mealHour: mealHour,
      imageUrl: imageUrl,
      language: language,
      calories: calories,
      fat: fat,
      diabeticScore: diabeticScore ?? DiabeticScoreStruct(),
      protein: protein,
      carbs: carbs,
      sugar: sugar,
      portionSize: portionSize,
    );
