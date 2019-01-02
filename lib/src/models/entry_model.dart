import 'package:cv/src/models/api_models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'entry_model.g.dart';

@JsonSerializable()
class EntryModel extends ApiBaseModel {
  EntryModel({
    String id,
    this.name,
    this.startDate,
    this.endDate,
    this.location,
    this.owner,
    this.type,
  }) : super(id: id);

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

  @override
  String toString() {
    return 'EntryModel{name: $name, content: $content, startDate: $startDate, endDate: $endDate, location: $location, owner: $owner, type: $type}';
  }
}
