import 'package:cv/src/models/profile_group_model.dart';
import 'package:cv/src/models/profile_model.dart';
import 'package:cv/src/models/profile_part_model.dart';
import 'package:cv/src/models/user_model.dart';
import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'api_models.g.dart';

@JsonSerializable()
class BaseModel {
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

// TODO : Add models if needed
T _dataFromJson<T>(Map<String, dynamic> input) {
  if (T == UserModel) return UserModel.fromJson(input) as T;
  if (T == ProfileModel) return ProfileModel.fromJson(input) as T;
  if (T == ProfilePartModel) return ProfilePartModel.fromJson(input) as T;
  if (T == ProfileGroupModel)
    return ProfileGroupModel.fromJson(input) as T;
  else
    throw Exception("Unknown type $T in RepsonseModel._dataFromJson");
}

Map<String, dynamic> _dataToJson<T>(T input) => {'data': input};

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
