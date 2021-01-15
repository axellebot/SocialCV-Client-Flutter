abstract class BaseEntity {
  String id;
  DateTime createdAt;
  DateTime updatedAt;
  int version;

  @override
  String toString() => '$runtimeType{ '
      'id: $id, '
      'createdAt: $createdAt, '
      'updatedAt: $updatedAt, '
      'version: $version'
      ' }';
}
