import 'package:social_cv_client_flutter/domain.dart';

abstract class PartEntity extends ElementEntity {
  String name;
  List<String> groupIds;
  String type;
  String ownerId;

  @override
  String toString() => '$runtimeType{ '
      'id: $id, '
      'name: $name, '
      'groupIds: $groupIds, '
      'type: $type, '
      'owner: $ownerId'
      ' }';
}
