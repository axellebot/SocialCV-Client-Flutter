import 'package:social_cv_client_flutter/presentation.dart';

class UserViewModel extends ElementViewModel {
  bool disabled;
  String email;
  String username;
  String picture;
  List<String> profileIds;
  dynamic permission;

  UserViewModel({
    String id,
    this.disabled,
    this.email,
    this.username,
    this.picture,
    this.profileIds,
    this.permission,
    DateTime createdAt,
    DateTime updatedAt,
    int version,
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
