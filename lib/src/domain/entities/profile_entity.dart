import 'package:social_cv_client_flutter/domain.dart';

abstract class ProfileEntity extends ElementEntity {
  String? title;
  String? subtitle;
  Uri? picture;
  Uri? cover;
  List<String>? partIds;
  String? type;

  ProfileEntity({
    required String id,
    this.title,
    this.subtitle,
    this.picture,
    this.cover,
    this.partIds,
    this.type,
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

  @override
  String toString() => '$runtimeType{ '
      'id: $id, '
      'title: $title, '
      'subtitle: $subtitle, '
      'picture: $picture, '
      'cover: $cover, '
      'partIds: $partIds, '
      'type: $type, '
      'ownerId: $ownerId, '
      'createdAt: $createdAt, '
      'updatedAt: $updatedAt, '
      'version: $version'
      ' }';
}
