// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class InfoStruct extends BaseStruct {
  InfoStruct({
    String? title,
    String? description,
    String? image,
  })  : _title = title,
        _description = description,
        _image = image;

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

  static InfoStruct fromMap(Map<String, dynamic> data) => InfoStruct(
        title: data['title'] as String?,
        description: data['description'] as String?,
        image: data['image'] as String?,
      );

  static InfoStruct? maybeFromMap(dynamic data) =>
      data is Map ? InfoStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'title': _title,
        'description': _description,
        'image': _image,
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
      );

  @override
  String toString() => 'InfoStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is InfoStruct &&
        title == other.title &&
        description == other.description &&
        image == other.image;
  }

  @override
  int get hashCode => const ListEquality().hash([title, description, image]);
}

InfoStruct createInfoStruct({
  String? title,
  String? description,
  String? image,
}) =>
    InfoStruct(
      title: title,
      description: description,
      image: image,
    );
