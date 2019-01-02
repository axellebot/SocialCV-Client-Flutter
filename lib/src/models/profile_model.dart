import 'package:cv/src/models/api_models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile_model.g.dart';

@JsonSerializable()
class ProfileModel extends ApiBaseModel {
  ProfileModel({
    String id,
    this.title,
    this.subtitle,
    this.picture,
    this.cover,
    this.type,
    this.parts,
    this.owner,
  }) : super(id: id);

  String title;
  String subtitle;
  String picture;
  String cover;
  String type;

  @JsonKey(name: 'parts')
  dynamic parts;

  String owner;

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);

  @override
  String toString() {
    return 'ProfileModel{title: $title, subtitle: $subtitle, picture: '
        '$picture, cover: $cover, type: $type, parts: $parts, owner: $owner}';
  }
}
