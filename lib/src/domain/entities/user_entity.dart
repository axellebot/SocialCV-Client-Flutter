import 'package:social_cv_client_flutter/domain.dart';

abstract class UserEntity extends ElementEntity {
  String? email;
  String? username;
  bool? disabled;
  String? picture;
  List<String>? profileIds;
  dynamic permission;

  UserEntity({
    required String id,
    this.email,
    this.username,
    this.disabled,
    this.picture,
    this.profileIds,
    this.permission,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? version,
  }) : super(
          id: id,
          createdAt: createdAt,
          updatedAt: updatedAt,
          version: version,
        );

  @override
  String toString() => '$runtimeType{ '
      'id: $id, '
      'disabled: $disabled, '
      'email: $email, '
      'username: $username, '
      'picture: $picture, '
      'profileIds: $profileIds, '
      'permission: $permission, '
      'createdAt: $createdAt, '
      'updatedAt: $updatedAt, '
      'version: $version'
      ' }';
}
