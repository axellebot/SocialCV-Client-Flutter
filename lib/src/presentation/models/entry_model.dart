import 'package:social_cv_client_flutter/presentation.dart';

class EntryViewModel extends ElementViewModel {
  String name;
  String type;
  dynamic content;
  String startDate;
  String endDate;
  String location;
  String ownerId;

  EntryViewModel({
    String id,
    this.name,
    this.type,
    this.content,
    this.startDate,
    this.endDate,
    this.location,
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

  EntryViewModel copyWith({
    String id,
    String name,
    String type,
    String content,
    String startDate,
    String endDate,
    String location,
    String groupId,
    String ownerId,
    DateTime createdAt,
    DateTime updatedAt,
    int version,
  }) {
    return EntryViewModel(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      content: content ?? this.content,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      location: location ?? this.location,
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
