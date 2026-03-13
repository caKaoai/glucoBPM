// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class InfoStruct extends BaseStruct {
  InfoStruct({
    String? title,
    String? description,
    String? image,
    String? ranking,
    String? color,
  })  : _title = title,
        _description = description,
        _image = image,
        _ranking = ranking,
        _color = color;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  set title(String? val) => _title = val;

  bool hasTitle() => _title != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  set description(String? val) => _description = val;

  bool hasDescription() => _description != null;

  // "image" field.
  String? _image;
  String get image => _image ?? '';
  set image(String? val) => _image = val;

  bool hasImage() => _image != null;

  // "ranking" field.
  String? _ranking;
  String get ranking => _ranking ?? '';
  set ranking(String? val) => _ranking = val;

  bool hasRanking() => _ranking != null;

  // "color" field.
  String? _color;
  String get color => _color ?? '';
  set color(String? val) => _color = val;

  bool hasColor() => _color != null;

  static InfoStruct fromMap(Map<String, dynamic> data) => InfoStruct(
        title: data['title'] as String?,
        description: data['description'] as String?,
        image: data['image'] as String?,
        ranking: data['ranking'] as String?,
        color: data['color'] as String?,
      );

  static InfoStruct? maybeFromMap(dynamic data) =>
      data is Map ? InfoStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'title': _title,
        'description': _description,
        'image': _image,
        'ranking': _ranking,
        'color': _color,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'title': serializeParam(
          _title,
          ParamType.String,
        ),
        'description': serializeParam(
          _description,
          ParamType.String,
        ),
        'image': serializeParam(
          _image,
          ParamType.String,
        ),
        'ranking': serializeParam(
          _ranking,
          ParamType.String,
        ),
        'color': serializeParam(
          _color,
          ParamType.String,
        ),
      }.withoutNulls;

  static InfoStruct fromSerializableMap(Map<String, dynamic> data) =>
      InfoStruct(
        title: deserializeParam(
          data['title'],
          ParamType.String,
          false,
        ),
        description: deserializeParam(
          data['description'],
          ParamType.String,
          false,
        ),
        image: deserializeParam(
          data['image'],
          ParamType.String,
          false,
        ),
        ranking: deserializeParam(
          data['ranking'],
          ParamType.String,
          false,
        ),
        color: deserializeParam(
          data['color'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'InfoStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is InfoStruct &&
        title == other.title &&
        description == other.description &&
        image == other.image &&
        ranking == other.ranking &&
        color == other.color;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([title, description, image, ranking, color]);
}

InfoStruct createInfoStruct({
  String? title,
  String? description,
  String? image,
  String? ranking,
  String? color,
}) =>
    InfoStruct(
      title: title,
      description: description,
      image: image,
      ranking: ranking,
      color: color,
    );
