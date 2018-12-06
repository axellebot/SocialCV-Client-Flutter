import 'package:cv/src/models/api_models.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile_group_model.g.dart';

@JsonSerializable()
class ProfileGroupModel extends BaseModel {
  ProfileGroupModel({Key key, this.name, this.entryIds, this.owner})
      : super(key: key);

  String name;
  @JsonKey(name: 'entries')
  List<String> entryIds;
  String owner;
  @JsonKey(name: 'profile')
  factory ProfileGroupModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileGroupModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileGroupModelToJson(this);

  @override
  String toString() {
    return 'ProfileGroupModel{name: $name, entryIds: $entryIds, owner: $owner}';
  }
}
