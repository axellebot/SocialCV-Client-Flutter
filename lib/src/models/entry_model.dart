import 'package:cv/src/models/api_models.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'entry_model.g.dart';

@JsonSerializable()
class EntryModel extends BaseModel {
  EntryModel(
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

  factory EntryModel.fromJson(Map<String, dynamic> json) =>
      _$EntryModelFromJson(json);

  Map<String, dynamic> toJson() => _$EntryModelToJson(this);
}
