import 'package:social_cv_client_flutter/data.dart';

class GroupEntity extends ElementDataModel {
  String name;
  List<String> entryIds;
  String type;
  String ownerId;

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
