import 'package:social_cv_client_flutter/presentation.dart';

class GroupViewModel extends ElementViewModel {
  String name;
  List<String> entryIds;
  String type;
  String ownerId;

  GroupViewModel({
    String id,
    this.name,
    this.entryIds,
    this.type,
    this.ownerId,
    DateTime createdAt,
    DateTime updatedAt,
    int version,
  }) : super(
          id: id,
          createdAt: createdAt,
          updatedAt: updatedAt,
          version: version,
        );

  GroupViewModel copyWith({
    String id,
    String name,
    List<String> entryIds,
    String type,
    String ownerId,
    DateTime createdAt,
    DateTime updatedAt,
    int version,
  }) {
    return GroupViewModel(
      id: id ?? this.id,
      name: name ?? this.name,
      entryIds: entryIds ?? this.entryIds,
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
      'type: $type, '
      'entryIds: $entryIds, '
      'owner: $ownerId, '
      'createdAt: $createdAt, '
      'updatedAt: $updatedAt, '
      'version: $version'
      ' }';
}
