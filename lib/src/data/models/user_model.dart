import 'package:json_annotation/json_annotation.dart';
import 'package:social_cv_client_flutter/data.dart';
import 'package:social_cv_client_flutter/domain.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserDataModel extends ElementDataModel implements UserEntity {
  @JsonKey(name: 'disabled')
  @override
  bool? disabled;

  @JsonKey(name: 'email')
  @override
  String? email;

  @JsonKey(name: 'username')
  @override
  String? username;

  @JsonKey(name: 'picture')
  @override
  String? picture;

  @JsonKey(name: 'profiles')
  @override
  List<String>? profileIds;

  @JsonKey(name: 'permission')
  @override
  dynamic permission;

  UserDataModel({
    required String id,
    this.disabled,
    this.email,
    this.username,
    this.picture,
    this.profileIds,
    this.permission,
    String? ownerId,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? version,
  }) : super(
          id: id,
          ownerId: ownerId,
          createdAt: createdAt,
          updatedAt: updatedAt,
          version: version,
        );

  factory UserDataModel.fromJson(Map<String, dynamic> json) =>
      _$UserDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataModelToJson(this);

  @override
  String toString() => '$runtimeType{ '
      'id: $id, '
      'disabled: $disabled, '
      'email: $email, '
      'username: $username, '
      'picture: $picture, '
      'profileIds: $profileIds, '
      'permission: $permission'
      ' }';
}
