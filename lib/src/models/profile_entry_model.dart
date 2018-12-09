import 'package:cv/src/models/api_models.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile_entry_model.g.dart';

@JsonSerializable()
class ProfileEntryModel extends BaseModel {
  ProfileEntryModel(
      {Key key,
      this.name,
      this.startDate,
      this.endDate,
      this.location,
      this.owner,
      this.type})
      : super(key: key);

  String name;
  dynamic content;
  String startDate;
  String endDate;
  String location;
  String owner;
  String type;

  factory ProfileEntryModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileEntryModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileEntryModelToJson(this);
}
