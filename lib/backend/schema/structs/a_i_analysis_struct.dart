// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

/// table
/// heart_heath also use
class AIAnalysisStruct extends BaseStruct {
  AIAnalysisStruct({
    int? id,
    String? name,
    String? photo,
    String? aboutMe,
    String? approach,
    double? review,
    List<String>? qualification,
    String? createdAt,
    int? plan,
    int? days,
    String? type,
    String? description,
    List<String>? images,
  })  : _id = id,
        _name = name,
        _photo = photo,
        _aboutMe = aboutMe,
        _approach = approach,
        _review = review,
        _qualification = qualification,
        _createdAt = createdAt,
        _plan = plan,
        _days = days,
        _type = type,
        _description = description,
        _images = images;

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

  // "photo" field.
  String? _photo;
  String get photo => _photo ?? '';
  set photo(String? val) => _photo = val;

  bool hasPhoto() => _photo != null;

  // "about_me" field.
  String? _aboutMe;
  String get aboutMe => _aboutMe ?? '';
  set aboutMe(String? val) => _aboutMe = val;

  bool hasAboutMe() => _aboutMe != null;

  // "approach" field.
  String? _approach;
  String get approach => _approach ?? '';
  set approach(String? val) => _approach = val;

  bool hasApproach() => _approach != null;

  // "review" field.
  double? _review;
  double get review => _review ?? 0.0;
  set review(double? val) => _review = val;

  void incrementReview(double amount) => review = review + amount;

  bool hasReview() => _review != null;

  // "qualification" field.
  List<String>? _qualification;
  List<String> get qualification => _qualification ?? const [];
  set qualification(List<String>? val) => _qualification = val;

  void updateQualification(Function(List<String>) updateFn) {
    updateFn(_qualification ??= []);
  }

  bool hasQualification() => _qualification != null;

  // "created_at" field.
  String? _createdAt;
  String get createdAt => _createdAt ?? '';
  set createdAt(String? val) => _createdAt = val;

  bool hasCreatedAt() => _createdAt != null;

  // "plan" field.
  int? _plan;
  int get plan => _plan ?? 0;
  set plan(int? val) => _plan = val;

  void incrementPlan(int amount) => plan = plan + amount;

  bool hasPlan() => _plan != null;

  // "days" field.
  int? _days;
  int get days => _days ?? 0;
  set days(int? val) => _days = val;

  void incrementDays(int amount) => days = days + amount;

  bool hasDays() => _days != null;

  // "type" field.
  String? _type;
  String get type => _type ?? '';
  set type(String? val) => _type = val;

  bool hasType() => _type != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  set description(String? val) => _description = val;

  bool hasDescription() => _description != null;

  // "images" field.
  List<String>? _images;
  List<String> get images => _images ?? const [];
  set images(List<String>? val) => _images = val;

  void updateImages(Function(List<String>) updateFn) {
    updateFn(_images ??= []);
  }

  bool hasImages() => _images != null;

  static AIAnalysisStruct fromMap(Map<String, dynamic> data) =>
      AIAnalysisStruct(
        id: castToType<int>(data['id']),
        name: data['name'] as String?,
        photo: data['photo'] as String?,
        aboutMe: data['about_me'] as String?,
        approach: data['approach'] as String?,
        review: castToType<double>(data['review']),
        qualification: getDataList(data['qualification']),
        createdAt: data['created_at'] as String?,
        plan: castToType<int>(data['plan']),
        days: castToType<int>(data['days']),
        type: data['type'] as String?,
        description: data['description'] as String?,
        images: getDataList(data['images']),
      );

  static AIAnalysisStruct? maybeFromMap(dynamic data) => data is Map
      ? AIAnalysisStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'name': _name,
        'photo': _photo,
        'about_me': _aboutMe,
        'approach': _approach,
        'review': _review,
        'qualification': _qualification,
        'created_at': _createdAt,
        'plan': _plan,
        'days': _days,
        'type': _type,
        'description': _description,
        'images': _images,
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
        'photo': serializeParam(
          _photo,
          ParamType.String,
        ),
        'about_me': serializeParam(
          _aboutMe,
          ParamType.String,
        ),
        'approach': serializeParam(
          _approach,
          ParamType.String,
        ),
        'review': serializeParam(
          _review,
          ParamType.double,
        ),
        'qualification': serializeParam(
          _qualification,
          ParamType.String,
          isList: true,
        ),
        'created_at': serializeParam(
          _createdAt,
          ParamType.String,
        ),
        'plan': serializeParam(
          _plan,
          ParamType.int,
        ),
        'days': serializeParam(
          _days,
          ParamType.int,
        ),
        'type': serializeParam(
          _type,
          ParamType.String,
        ),
        'description': serializeParam(
          _description,
          ParamType.String,
        ),
        'images': serializeParam(
          _images,
          ParamType.String,
          isList: true,
        ),
      }.withoutNulls;

  static AIAnalysisStruct fromSerializableMap(Map<String, dynamic> data) =>
      AIAnalysisStruct(
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
        photo: deserializeParam(
          data['photo'],
          ParamType.String,
          false,
        ),
        aboutMe: deserializeParam(
          data['about_me'],
          ParamType.String,
          false,
        ),
        approach: deserializeParam(
          data['approach'],
          ParamType.String,
          false,
        ),
        review: deserializeParam(
          data['review'],
          ParamType.double,
          false,
        ),
        qualification: deserializeParam<String>(
          data['qualification'],
          ParamType.String,
          true,
        ),
        createdAt: deserializeParam(
          data['created_at'],
          ParamType.String,
          false,
        ),
        plan: deserializeParam(
          data['plan'],
          ParamType.int,
          false,
        ),
        days: deserializeParam(
          data['days'],
          ParamType.int,
          false,
        ),
        type: deserializeParam(
          data['type'],
          ParamType.String,
          false,
        ),
        description: deserializeParam(
          data['description'],
          ParamType.String,
          false,
        ),
        images: deserializeParam<String>(
          data['images'],
          ParamType.String,
          true,
        ),
      );

  @override
  String toString() => 'AIAnalysisStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is AIAnalysisStruct &&
        id == other.id &&
        name == other.name &&
        photo == other.photo &&
        aboutMe == other.aboutMe &&
        approach == other.approach &&
        review == other.review &&
        listEquality.equals(qualification, other.qualification) &&
        createdAt == other.createdAt &&
        plan == other.plan &&
        days == other.days &&
        type == other.type &&
        description == other.description &&
        listEquality.equals(images, other.images);
  }

  @override
  int get hashCode => const ListEquality().hash([
        id,
        name,
        photo,
        aboutMe,
        approach,
        review,
        qualification,
        createdAt,
        plan,
        days,
        type,
        description,
        images
      ]);
}

AIAnalysisStruct createAIAnalysisStruct({
  int? id,
  String? name,
  String? photo,
  String? aboutMe,
  String? approach,
  double? review,
  String? createdAt,
  int? plan,
  int? days,
  String? type,
  String? description,
}) =>
    AIAnalysisStruct(
      id: id,
      name: name,
      photo: photo,
      aboutMe: aboutMe,
      approach: approach,
      review: review,
      createdAt: createdAt,
      plan: plan,
      days: days,
      type: type,
      description: description,
    );
