import 'package:social_cv_client_flutter/presentation.dart';

class PartViewModel extends ElementViewModel {
  String? name;
  List<String>? groupIds;
  String? type;
  String? ownerId;

  PartViewModel({
    String? id,
    this.name,
    this.groupIds,
    this.type,
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

  PartViewModel copyWith({
    String? id,
    String? name,
    List<String>? groupIds,
    String? type,
    String? ownerId,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? version,
  }) {
    return PartViewModel(
      id: id ?? this.id,
      name: name ?? this.name,
      groupIds: groupIds ?? this.groupIds,
      type: type ?? this.type,
      ownerId: ownerId ?? this.ownerId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      version: version ?? this.version,
    );
  }

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
