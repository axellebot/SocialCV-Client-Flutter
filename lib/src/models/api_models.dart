import 'package:cv/src/models/entry_model.dart';
import 'package:cv/src/models/group_model.dart';
import 'package:cv/src/models/part_model.dart';
import 'package:cv/src/models/profile_model.dart';
import 'package:cv/src/models/user_model.dart';
import 'package:cv/src/utils/logger.dart';
import 'package:json_annotation/json_annotation.dart';

part 'api_models.g.dart';

@JsonSerializable()
class ApiBaseModel extends Object {
  ApiBaseModel({this.id}) : super();

  @JsonKey(name: '_id')
  String id;

  DateTime createdAt;
  DateTime updatedAt;

  @JsonKey(name: '__v')
  int v;

  factory ApiBaseModel.fromJson(Map<String, dynamic> json) =>
      _$ApiBaseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ApiBaseModelToJson(this);
}

@JsonSerializable()
class ResponseModel<T> extends Object {
  ResponseModel({
    this.error,
    this.message,
    this.data,
  });

  bool error;
  String message;

  @JsonKey(fromJson: _dataFromJson, toJson: _dataToJson)
  T data;

  factory ResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ResponseModelFromJson<T>(json);

  Map<String, dynamic> toJson() => _$ResponseModelToJson<T>(this);
}

// TODO : Add model if needed
T _dataFromJson<T>(Map<String, dynamic> input) {
  logger.info("_dataFromJson $T");

  if (T == UserModel)
    return UserModel.fromJson(input) as T;
  else if (T == ProfileModel)
    return ProfileModel.fromJson(input) as T;
  else if (T == PartModel)
    return PartModel.fromJson(input) as T;
  else if (T == GroupModel)
    return GroupModel.fromJson(input) as T;
  else if (T == EntryModel)
    return EntryModel.fromJson(input) as T;
  else
    throw Exception("Unknown type $T in ._dataFromJson");
}

// TODO : Add model if needed
Map<String, dynamic> _dataToJson<T>(Object json) {
  logger.info("_dataToJson $T");
  return json;
}

/// Model with GenericCollection https://github.com/dart-lang/json_serializable/blob/ee2c5c788279af01860624303abe16811850b82c/example/lib/json_converter_example.dart
@JsonSerializable()
class ResponseModelWithArray<T> extends Object {
  ResponseModelWithArray({
    this.error,
    this.message,
    this.data,
  });

  bool error;
  String message;

  @_ResponseDataConverter()
  List<T> data;

  int total;

  factory ResponseModelWithArray.fromJson(Map<String, dynamic> json) =>
      _$ResponseModelWithArrayFromJson<T>(json);

  Map<String, dynamic> toJson() => _$ResponseModelWithArrayToJson<T>(this);
}

class _ResponseDataConverter<T> implements JsonConverter<T, Object> {
  const _ResponseDataConverter();

  @override
  T fromJson(Object json) {
    if (json is Map<String, dynamic>) {
      if (T == UserModel)
        return UserModel.fromJson(json) as T;
      else if (T == ProfileModel)
        return ProfileModel.fromJson(json) as T;
      else if (T == PartModel)
        return PartModel.fromJson(json) as T;
      else if (T == GroupModel)
        return GroupModel.fromJson(json) as T;
      else if (T == EntryModel) return EntryModel.fromJson(json) as T;
    }
    // This will only work if `json` is a native JSON type:
    //   num, String, bool, null, etc
    // *and* is assignable to `T`.
    return json as T;
  }

  @override
  Object toJson(T object) {
    // This will only work if `object` is a native JSON type:
    //   num, String, bool, null, etc
    // Or if it has a `toJson()` function`.
    return object;
  }
}

@JsonSerializable()
class OAuthTokenModel extends Object {
  const OAuthTokenModel({
    this.username,
    this.password,
    this.refreshToken,
    this.clientId,
    this.clientSecret,
    this.grantType = "password",
  })  : assert((username != null && password != null) || refreshToken != null),
        assert(clientId != null),
        assert(clientSecret != null),
        assert(grantType != null),
        super();

  @JsonKey(name: 'username')
  final String username;
  @JsonKey(name: 'password')
  final String password;
  @JsonKey(name: 'refresh_token')
  final String refreshToken;
  @JsonKey(name: 'client_id')
  final String clientId;
  @JsonKey(name: 'client_secret')
  final String clientSecret;
  @JsonKey(name: 'grant_type')
  final String grantType;

  factory OAuthTokenModel.fromJson(Map<String, dynamic> json) =>
      _$OAuthTokenModelFromJson(json);

  Map<String, dynamic> toJson() => _$OAuthTokenModelToJson(this);
}

@JsonSerializable()
class OAuthAccessTokenResponseModel extends Object {
  OAuthAccessTokenResponseModel({
    this.accessToken,
    this.refreshToken,
    this.accessTokenExpiresAt,
    this.tokenType,
  }) : super();

  @JsonKey(name: 'access_token')
  String accessToken;
  @JsonKey(name: 'refresh_token')
  String refreshToken;
  @JsonKey(name: 'expires_in')
  int accessTokenExpiresAt;
  @JsonKey(name: 'token_type')
  String tokenType;

  factory OAuthAccessTokenResponseModel.fromJson(Map<String, dynamic> json) =>
      _$OAuthAccessTokenResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$OAuthAccessTokenResponseModelToJson(this);
}
