import 'package:json_annotation/json_annotation.dart';
import 'package:social_cv_client_flutter/data.dart';
import 'package:social_cv_client_flutter/domain.dart';

part 'part_model.g.dart';

@JsonSerializable()
class PartDataModel extends ElementDataModel implements PartEntity {
  @JsonKey(name: 'name')
  @override
  String? name;

  @JsonKey(name: 'groups')
  @override
  List<String>? groupIds;

  @JsonKey(name: 'type')
  @override
  String? type;

  PartDataModel({
    required String id,
    this.name,
    this.groupIds,
    this.type,
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

  factory PartDataModel.fromJson(Map<String, dynamic> json) =>
      _$PartDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$PartDataModelToJson(this);
}
