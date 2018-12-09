import 'package:cv/src/models/api_models.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile_part_model.g.dart';

@JsonSerializable()
class ProfilePartModel extends BaseModel {
  ProfilePartModel({Key key, this.name, this.groupIds, this.owner})
      : super(key: key);

  String name;
  @JsonKey(name: 'groups')
  List<String> groupIds;
  String owner;
  @JsonKey(name: 'profile')
  String profileId;
  String type;

  factory ProfilePartModel.fromJson(Map<String, dynamic> json) =>
      _$ProfilePartModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProfilePartModelToJson(this);

  @override
  String toString() {
    return 'ProfilePartModel{name: $name, groupIds: $groupIds, owner: $owner, profileId: $profileId, type: $type}';
  }
}
