import 'package:cv/src/models/api_models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'group_model.g.dart';

@JsonSerializable()
class GroupModel extends ApiBaseModel {
  GroupModel({
    String id,
    this.name,
    this.type,
    this.entryIds,
    this.owner,
  }) : super(id: id);

  String name;
  String type;
  @JsonKey(name: 'entries')
  List<String> entryIds;
  String owner;

  @JsonKey(name: 'profile')
  factory GroupModel.fromJson(Map<String, dynamic> json) =>
      _$GroupModelFromJson(json);

  Map<String, dynamic> toJson() => _$GroupModelToJson(this);

  @override
  String toString() {
    return 'GroupModel{name: $name, type: $type, entryIds: $entryIds, owner: $owner}';
  }
}
