// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ActivityStruct extends BaseStruct {
  ActivityStruct({
    int? id,
    String? name,
    String? description,
    String? image,
    String? createdAt,
    int? connectId,
  })  : _id = id,
        _name = name,
        _description = description,
        _image = image,
        _createdAt = createdAt,
        _connectId = connectId;

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

  // "created_at" field.
  String? _createdAt;
  String get createdAt => _createdAt ?? '';
  set createdAt(String? val) => _createdAt = val;

  bool hasCreatedAt() => _createdAt != null;

  // "connect_id" field.
  int? _connectId;
  int get connectId => _connectId ?? 0;
  set connectId(int? val) => _connectId = val;

  void incrementConnectId(int amount) => connectId = connectId + amount;

  bool hasConnectId() => _connectId != null;

  static ActivityStruct fromMap(Map<String, dynamic> data) => ActivityStruct(
        id: castToType<int>(data['id']),
        name: data['name'] as String?,
        description: data['description'] as String?,
        image: data['image'] as String?,
        createdAt: data['created_at'] as String?,
        connectId: castToType<int>(data['connect_id']),
      );

  static ActivityStruct? maybeFromMap(dynamic data) =>
      data is Map ? ActivityStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'name': _name,
        'description': _description,
        'image': _image,
        'created_at': _createdAt,
        'connect_id': _connectId,
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
        'description': serializeParam(
          _description,
          ParamType.String,
        ),
        'image': serializeParam(
          _image,
          ParamType.String,
        ),
        'created_at': serializeParam(
          _createdAt,
          ParamType.String,
        ),
        'connect_id': serializeParam(
          _connectId,
          ParamType.int,
        ),
      }.withoutNulls;

  static ActivityStruct fromSerializableMap(Map<String, dynamic> data) =>
      ActivityStruct(
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
        createdAt: deserializeParam(
          data['created_at'],
          ParamType.String,
          false,
        ),
        connectId: deserializeParam(
          data['connect_id'],
          ParamType.int,
          false,
        ),
      );

  @override
  String toString() => 'ActivityStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ActivityStruct &&
        id == other.id &&
        name == other.name &&
        description == other.description &&
        image == other.image &&
        createdAt == other.createdAt &&
        connectId == other.connectId;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([id, name, description, image, createdAt, connectId]);
}

ActivityStruct createActivityStruct({
  int? id,
  String? name,
  String? description,
  String? image,
  String? createdAt,
  int? connectId,
}) =>
    ActivityStruct(
      id: id,
      name: name,
      description: description,
      image: image,
      createdAt: createdAt,
      connectId: connectId,
    );
