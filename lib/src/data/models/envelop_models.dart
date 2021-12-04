import 'package:json_annotation/json_annotation.dart';
import 'package:social_cv_client_flutter/domain.dart';

part 'envelop_models.g.dart';

/// ----------------------------------------------------------------------------
///                            Envelop
/// ----------------------------------------------------------------------------

abstract class _Envelop extends Object {
  @JsonKey(name: 'error')
  final bool? error;

  @JsonKey(name: 'message')
  final String? message;

  _Envelop({
    this.error,
    this.message,
  });
}

/// Envelop containing [data] of type [T]
@JsonSerializable()
class DataEnvelop<T> extends _Envelop {
  @_GenericConverter()
  T data;

  DataEnvelop({
    bool? error,
    String? message,
    required this.data,
  }) : super(error: error, message: message);

  factory DataEnvelop.fromJson(Map<String, dynamic> json) =>
      _$DataEnvelopFromJson<T>(json);

  Map<String, dynamic> toJson() => _$DataEnvelopToJson<T>(this);
}

/// Envelop with containing [data] list of type [T]
@JsonSerializable()
class DataArrayEnvelop<T> extends _Envelop {
  @_GenericConverter()
  List<T> data;

  int? total;

  DataArrayEnvelop({
    bool? error,
    String? message,
    this.total,
    required this.data,
  }) : super(error: error, message: message);

  factory DataArrayEnvelop.fromJson(Map<String, dynamic> json) =>
      _$DataArrayEnvelopFromJson<T>(json);

  Map<String, dynamic> toJson() => _$DataArrayEnvelopToJson<T>(this);
}

/// Provide json serialization and deserialization methods
/// for generic/template field type
///
/// Working for generic type only
///
/// Based on
/// https://github.com/dart-lang/json_serializable/blob/ee2c5c788279af01860624303abe16811850b82c/example/lib/json_converter_example.dart
///
/// Example:
/// ```dart
/// @_GenericConverter
/// List<T> generics
///
/// @_GenericConverter
/// T generic
/// ```
///
class _GenericConverter<T> implements JsonConverter<T, dynamic> {
  const _GenericConverter();

  @override
  T fromJson(Object? json) {
    print('fromJson');
    final T? t = (T as dynamic)?.fromJson(json) as T?
        // This will only work if `json` is a native JSON type:
        //   num, String, bool, null, etc
        // *and* is assignable to `T`.
        ??
        json as T?;

    if (t == null) {
      throw Exception('Type $T no supported');
    }
    return t;
  }

  @override
  dynamic toJson(T object) {
    print('toJson');
    // This will only work if `object` is a native JSON type:
    //   num, String, bool, null, etc
    // Or if it has a `toJson()` function`.
    return (object as dynamic)?.toJson() ?? object as Object;
  }
}

@JsonSerializable()
class RequestAuthDataModel extends Object {
  @JsonKey(name: 'username')
  final String? username;
  @JsonKey(name: 'password')
  final String? password;

  RequestAuthDataModel({
    required this.username,
    required this.password,
  })  : assert(username != null && password != null),
        super();

  factory RequestAuthDataModel.fromJson(Map<String, dynamic> json) =>
      _$RequestAuthDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$RequestAuthDataModelToJson(this);

  @override
  String toString() => '$runtimeType{ '
      'username: $username, '
      'password: HIDDEN'
      ' }';
}

@JsonSerializable()
class ResponseAuthDataModel implements AuthEntity {
  @JsonKey(name: 'access_token')
  @override
  String? accessToken;

  @JsonKey(name: 'refresh_token')
  @override
  String? refreshToken;

  @JsonKey(name: 'expires_in')
  int accessTokenExpiresIn;

  @JsonKey(name: 'token_type')
  @override
  String? tokenType;

  @override
  DateTime? accessTokenExpiration;

  ResponseAuthDataModel({
    this.accessToken,
    this.refreshToken,
    required this.accessTokenExpiresIn,
    this.tokenType,
  }) : super() {
    accessTokenExpiration =
        DateTime.now().add(Duration(milliseconds: accessTokenExpiresIn));
  }

  factory ResponseAuthDataModel.fromJson(Map<String, dynamic> json) =>
      _$ResponseAuthDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseAuthDataModelToJson(this);

  @override
  String toString() => '$runtimeType{ '
      'accessToken: $accessToken, '
      'refreshToken: $refreshToken, '
      'accessTokenExpiresAt: $accessTokenExpiresIn, '
      'tokenType: $tokenType'
      ' }';
}
