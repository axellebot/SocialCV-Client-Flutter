import 'package:json_annotation/json_annotation.dart';
import 'package:social_cv_client_flutter/data.dart';
import 'package:social_cv_client_flutter/domain.dart';

part 'entry_model.g.dart';

@JsonSerializable()
class EntryDataModel extends ElementDataModel implements EntryEntity {
  @JsonKey(name: 'name')
  @override
  String? name;

  @JsonKey(name: 'type')
  @override
  String? type;

  @JsonKey(name: 'content')
  @override
  dynamic content;

  @JsonKey(name: 'startDate')
  @override
  String? startDate;

  @JsonKey(name: 'endDate')
  @override
  String? endDate;

  @JsonKey(name: 'location')
  @override
  String? location;

  EntryDataModel({
    required String id,
    this.name,
    this.type,
    this.content,
    this.startDate,
    this.endDate,
    this.location,
    String? ownerId,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? version,
  }) : super(
          id: id,
          ownerId: ownerId,
          createdAt: createdAt,
          updatedAt: updatedAt,
          version: version,
        );

  factory EntryDataModel.fromJson(Map<String, dynamic> json) =>
      _$EntryDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$EntryDataModelToJson(this);
}
