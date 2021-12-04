import 'package:social_cv_client_flutter/domain.dart';

abstract class PartEntity extends ElementEntity {
  String? name;
  List<String>? groupIds;
  String? type;

  PartEntity({
    required String id,
    this.name,
    this.groupIds,
    this.type,
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
      'name: $name, '
      'groupIds: $groupIds, '
      'type: $type, '
      'owner: $ownerId, '
      'createdAt: $createdAt, '
      'updatedAt: $updatedAt, '
      'version: $version'
      ' }';
}
