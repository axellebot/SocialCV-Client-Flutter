abstract class BaseEntity {
  String id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? version;

  BaseEntity({
    required this.id,
    this.createdAt,
    this.updatedAt,
    this.version,
  });

  @override
  String toString() => '$runtimeType{ '
      'id: $id, '
      'createdAt: $createdAt, '
      'updatedAt: $updatedAt, '
      'version: $version'
      ' }';
}
