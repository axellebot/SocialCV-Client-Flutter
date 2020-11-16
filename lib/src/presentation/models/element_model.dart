import 'package:meta/meta.dart';

abstract class ElementViewModel {
  String id;
  DateTime createdAt;
  DateTime updatedAt;
  int version;

  ElementViewModel({
    @required this.id,
    this.createdAt,
    this.updatedAt,
    this.version,
  }) : super();

  @override
  String toString() => '$runtimeType{ '
      'id: $id, '
      'createdAt: $createdAt, '
      'updatedAt: $updatedAt, '
      'version: $version'
      ' }';
}
