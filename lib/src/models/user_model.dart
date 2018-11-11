import 'package:cv/src/models/api_models.dart';
import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends BaseModel {
  UserModel(
      {Key key,
      this.disabled,
      this.email,
      this.username,
      this.picture,
      this.profileIds,
      this.permission})
      : super(key: key);

  bool disabled;
  String email;
  String username;
  String picture;

  @JsonKey(name: 'profiles')
  List<String> profileIds;

  String permission;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
