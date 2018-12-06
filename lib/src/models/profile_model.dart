import 'package:cv/src/models/api_models.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile_model.g.dart';

@JsonSerializable()
class ProfileModel extends BaseModel {
  ProfileModel(
      {Key key,
      this.title,
      this.subtitle,
      this.picture,
      this.cover,
      this.partIds,
      this.owner})
      : super(key: key);

  String title;
  String subtitle;
  String picture;
  String cover;
  @JsonKey(name: 'parts')
  List<String> partIds;
  String owner;

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);

  @override
  String toString() {
    return 'ProfileModel{title: $title, subtitle: $subtitle, picture: $picture, cover: $cover, partIds: $partIds, owner: $owner}';
  }
}
