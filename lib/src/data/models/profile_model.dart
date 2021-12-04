import 'package:json_annotation/json_annotation.dart';
import 'package:social_cv_client_flutter/data.dart';
import 'package:social_cv_client_flutter/domain.dart';

part 'profile_model.g.dart';

@JsonSerializable()
class ProfileDataModel extends ElementDataModel implements ProfileEntity {
  @JsonKey(name: 'title')
  @override
  String? title;

  @JsonKey(name: 'subtitle')
  @override
  String? subtitle;

  @JsonKey(name: 'picture')
  @override
  Uri? picture;

  @JsonKey(name: 'cover')
  @override
  Uri? cover;

  @JsonKey(name: 'parts')
  @override
  List<String>? partIds;

  @JsonKey(name: 'type')
  @override
  String? type;

  ProfileDataModel({
    required String id,
    this.title,
    this.subtitle,
    this.picture,
    this.cover,
    this.partIds,
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

  factory ProfileDataModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileDataModelToJson(this);
}
