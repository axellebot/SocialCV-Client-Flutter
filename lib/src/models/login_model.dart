import 'package:json_annotation/json_annotation.dart';
import 'package:cv/src/models/api_base_model.dart';

part 'login_model.g.dart';

@JsonSerializable()
class LoginModel {
  LoginModel(this.login, this.password);

  String login;
  String password;

  factory LoginModel.fromJson(Map<String, dynamic> json) =>
      _$LoginModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginModelToJson(this);
}

@JsonSerializable()
class LoginResponseModel extends ResponseModel {
  LoginResponseModel(bool error, String message, this.token, this.user)
      : super(error, message);

  String token;
  UserModel user;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseModelToJson(this);
}

@JsonSerializable()
class UserModel extends BaseModel {
  UserModel(String id, this.disabled, this.username, this.email,
      this.profileIds, this.permission)
      : super(id);

  bool disabled;
  String email;
  String username;

  @JsonKey(name: 'profiles')
  List<String> profileIds;
  String permission;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
