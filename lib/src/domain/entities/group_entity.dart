import 'package:social_cv_client_flutter/domain.dart';

abstract class GroupEntity extends ElementEntity {
  String? name;
  List<String>? entryIds;
  String? type;

  GroupEntity({
    required String id,
    this.name,
    this.entryIds,
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
      'name: $name, '
      'type: $type, '
      'entryIds: $entryIds, '
      'owner: $ownerId, '
      'createdAt: $createdAt, '
      'updatedAt: $updatedAt, '
      'version: $version'
      ' }';
}
