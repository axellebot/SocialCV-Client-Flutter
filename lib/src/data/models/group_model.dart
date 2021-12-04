import 'package:json_annotation/json_annotation.dart';
import 'package:social_cv_client_flutter/data.dart';
import 'package:social_cv_client_flutter/domain.dart';

part 'group_model.g.dart';

@JsonSerializable()
class GroupDataModel extends ElementDataModel implements GroupEntity {
  @JsonKey(name: 'name')
  @override
  String? name;

  @JsonKey(name: 'entries')
  @override
  List<String>? entryIds;

  @JsonKey(name: 'type')
  @override
  String? type;

  GroupDataModel({
    required String id,
    this.name,
    this.type,
    this.entryIds,
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

  factory GroupDataModel.fromJson(Map<String, dynamic> json) =>
      _$GroupDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$GroupDataModelToJson(this);
}
