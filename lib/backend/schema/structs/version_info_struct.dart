// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class VersionInfoStruct extends BaseStruct {
  VersionInfoStruct({
    String? ios,
    String? android,
    bool? iosContinue,
    bool? androidContinue,
    String? iosUrl,
    String? androidUrl,
  })  : _ios = ios,
        _android = android,
        _iosContinue = iosContinue,
        _androidContinue = androidContinue,
        _iosUrl = iosUrl,
        _androidUrl = androidUrl;

  // "ios" field.
  String? _ios;
  String get ios => _ios ?? '';
  set ios(String? val) => _ios = val;

  bool hasIos() => _ios != null;

  // "android" field.
  String? _android;
  String get android => _android ?? '';
  set android(String? val) => _android = val;

  bool hasAndroid() => _android != null;

  // "ios_continue" field.
  bool? _iosContinue;
  bool get iosContinue => _iosContinue ?? false;
  set iosContinue(bool? val) => _iosContinue = val;

  bool hasIosContinue() => _iosContinue != null;

  // "android_continue" field.
  bool? _androidContinue;
  bool get androidContinue => _androidContinue ?? false;
  set androidContinue(bool? val) => _androidContinue = val;

  bool hasAndroidContinue() => _androidContinue != null;

  // "ios_url" field.
  String? _iosUrl;
  String get iosUrl => _iosUrl ?? '';
  set iosUrl(String? val) => _iosUrl = val;

  bool hasIosUrl() => _iosUrl != null;

  // "android_url" field.
  String? _androidUrl;
  String get androidUrl => _androidUrl ?? '';
  set androidUrl(String? val) => _androidUrl = val;

  bool hasAndroidUrl() => _androidUrl != null;

  static VersionInfoStruct fromMap(Map<String, dynamic> data) =>
      VersionInfoStruct(
        ios: data['ios'] as String?,
        android: data['android'] as String?,
        iosContinue: data['ios_continue'] as bool?,
        androidContinue: data['android_continue'] as bool?,
        iosUrl: data['ios_url'] as String?,
        androidUrl: data['android_url'] as String?,
      );

  static VersionInfoStruct? maybeFromMap(dynamic data) => data is Map
      ? VersionInfoStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'ios': _ios,
        'android': _android,
        'ios_continue': _iosContinue,
        'android_continue': _androidContinue,
        'ios_url': _iosUrl,
        'android_url': _androidUrl,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'ios': serializeParam(
          _ios,
          ParamType.String,
        ),
        'android': serializeParam(
          _android,
          ParamType.String,
        ),
        'ios_continue': serializeParam(
          _iosContinue,
          ParamType.bool,
        ),
        'android_continue': serializeParam(
          _androidContinue,
          ParamType.bool,
        ),
        'ios_url': serializeParam(
          _iosUrl,
          ParamType.String,
        ),
        'android_url': serializeParam(
          _androidUrl,
          ParamType.String,
        ),
      }.withoutNulls;

  static VersionInfoStruct fromSerializableMap(Map<String, dynamic> data) =>
      VersionInfoStruct(
        ios: deserializeParam(
          data['ios'],
          ParamType.String,
          false,
        ),
        android: deserializeParam(
          data['android'],
          ParamType.String,
          false,
        ),
        iosContinue: deserializeParam(
          data['ios_continue'],
          ParamType.bool,
          false,
        ),
        androidContinue: deserializeParam(
          data['android_continue'],
          ParamType.bool,
          false,
        ),
        iosUrl: deserializeParam(
          data['ios_url'],
          ParamType.String,
          false,
        ),
        androidUrl: deserializeParam(
          data['android_url'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'VersionInfoStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is VersionInfoStruct &&
        ios == other.ios &&
        android == other.android &&
        iosContinue == other.iosContinue &&
        androidContinue == other.androidContinue &&
        iosUrl == other.iosUrl &&
        androidUrl == other.androidUrl;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([ios, android, iosContinue, androidContinue, iosUrl, androidUrl]);
}

VersionInfoStruct createVersionInfoStruct({
  String? ios,
  String? android,
  bool? iosContinue,
  bool? androidContinue,
  String? iosUrl,
  String? androidUrl,
}) =>
    VersionInfoStruct(
      ios: ios,
      android: android,
      iosContinue: iosContinue,
      androidContinue: androidContinue,
      iosUrl: iosUrl,
      androidUrl: androidUrl,
    );
