import 'package:json_annotation/json_annotation.dart';

part 'api_base_model.g.dart';

@JsonSerializable()
class BaseModel {
  BaseModel(this.id);

  @JsonKey(name: '_id')
  String id;

  factory BaseModel.fromJson(Map<String, dynamic> json) =>
      _$BaseModelFromJson(json);

  Map<String, dynamic> toJson() => _$BaseModelToJson(this);
}

@JsonSerializable()
class ResponseModel {
  ResponseModel(this.error, this.message);

  bool error;
  String message;
  String data;
}
