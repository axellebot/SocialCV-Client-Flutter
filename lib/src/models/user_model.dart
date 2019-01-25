import 'package:cv/src/models/api_models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends ApiBaseModel {
  UserModel({
    String id,
    this.disabled,
    this.email,
    this.username,
    this.picture,
    this.profileIds,
    this.permission,
  }) : super(id: id);

  bool disabled;
  String email;
  String username;
  String picture;

  @JsonKey(name: 'profiles')
  List<String> profileIds;

  dynamic permission;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  @override
  String toString() {
    return 'UserModel{disabled: $disabled, email: $email, username: $username, picture: $picture, profileIds: $profileIds, permission: $permission}';
  }
}
