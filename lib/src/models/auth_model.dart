import 'package:cv/src/models/api_base_model.dart';
import 'package:cv/src/models/user_model.dart';
import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_model.g.dart';

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
