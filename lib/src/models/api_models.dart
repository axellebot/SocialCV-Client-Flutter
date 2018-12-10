import 'package:cv/src/commons/logger.dart';
import 'package:cv/src/models/entry_model.dart';
import 'package:cv/src/models/group_model.dart';
import 'package:cv/src/models/part_model.dart';
import 'package:cv/src/models/profile_model.dart';
import 'package:cv/src/models/user_model.dart';
import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'api_models.g.dart';

@JsonSerializable()
class BaseModel extends Object {
  BaseModel({Key key, this.id});

  @JsonKey(name: '_id')
  String id;

  factory BaseModel.fromJson(Map<String, dynamic> json) =>
      _$BaseModelFromJson(json);

  Map<String, dynamic> toJson() => _$BaseModelToJson(this);
}

@JsonSerializable()
class ResponseModel<T> {
  ResponseModel({Key key, this.error, this.message, this.data});

  bool error;
  String message;

  @JsonKey(fromJson: _dataFromJson, toJson: _dataToJson)
  T data;

  factory ResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ResponseModelFromJson<T>(json);

  Map<String, dynamic> toJson() => _$ResponseModelToJson<T>(this);
}

// Model with GenericCollection https://github
// .com/dart-lang/json_serializable/blob
// /ee2c5c788279af01860624303abe16811850b82c/example/lib/json_converter_example.dart
@JsonSerializable()
class ResponseModelWithArray<T> {
  ResponseModelWithArray({Key key, this.error, this.message, this.data});

  bool error;
  String message;

  @_Converter()
  List<T> data;

  int total;

  factory ResponseModelWithArray.fromJson(Map<String, dynamic> json) =>
      _$ResponseModelWithArrayFromJson<T>(json);

  Map<String, dynamic> toJson() => _$ResponseModelWithArrayToJson<T>(this);
}

class _Converter<T> implements JsonConverter<T, Object> {
  const _Converter();

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

// TODO : Add models if needed
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

// TODO : Add models if needed
Map<String, dynamic> _dataToJson<T>(Object json) {
  logger.info("_dataToJson $T");
  return json;
}

@JsonSerializable()
class AuthLoginModel {
  AuthLoginModel({this.login, this.password});

  String login;
  String password;

  factory AuthLoginModel.fromJson(Map<String, dynamic> json) =>
      _$AuthLoginModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthLoginModelToJson(this);
}

@JsonSerializable()
class AuthLoginResponseModel extends ResponseModel {
  AuthLoginResponseModel({Key key, this.token, this.user}) : super(key: key);

  String token;
  UserModel user;

  factory AuthLoginResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AuthLoginResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthLoginResponseModelToJson(this);
}
