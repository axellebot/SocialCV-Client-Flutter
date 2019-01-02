import 'package:cv/src/models/api_models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'part_model.g.dart';

@JsonSerializable()
class PartModel extends ApiBaseModel {
  PartModel({
    String id,
    this.name,
    this.groupIds,
    this.owner,
  }) : super(id: id);

  String name;
  @JsonKey(name: 'groups')
  List<String> groupIds;
  String owner;
  @JsonKey(name: 'profile')
  String profileId;
  String type;

  factory PartModel.fromJson(Map<String, dynamic> json) =>
      _$PartModelFromJson(json);

  Map<String, dynamic> toJson() => _$PartModelToJson(this);

  @override
  String toString() {
    return 'PartModel{name: $name, groupIds: $groupIds, owner: $owner, profileId: $profileId, type: $type}';
  }
}
