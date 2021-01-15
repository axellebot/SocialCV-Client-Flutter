import 'package:social_cv_client_flutter/domain.dart';

abstract class EntryEntity extends ElementEntity {
  String name;
  String type;
  dynamic content;
  String startDate;
  String endDate;
  String location;
  String ownerId;

  @override
  String toString() => '$runtimeType{ '
      'id: $id, '
      'name: $name, '
      'type: $type, '
      'content: $content, '
      'startDate: $startDate, '
      'endDate: $endDate, '
      'location: $location, '
      'owner: $ownerId, '
      'createdAt: $createdAt, '
      'updatedAt: $updatedAt, '
      'version: $version'
      ' }';
}
