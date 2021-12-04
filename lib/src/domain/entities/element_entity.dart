import 'package:social_cv_client_flutter/domain.dart';

abstract class ElementEntity extends BaseEntity {
  String? ownerId;

  ElementEntity({
    required String id,
    this.ownerId,
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
      'ownerId: $ownerId, '
      'createdAt: $createdAt, '
      'updatedAt: $updatedAt, '
      'version: $version'
      ' }';
}
