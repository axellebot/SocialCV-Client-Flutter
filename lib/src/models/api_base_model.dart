import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'api_base_model.g.dart';

@JsonSerializable()
class BaseModel {
  BaseModel({Key key, this.id});

  @JsonKey(name: '_id')
  String id;

  factory BaseModel.fromJson(Map<String, dynamic> json) =>
      _$BaseModelFromJson(json);

  Map<String, dynamic> toJson() => _$BaseModelToJson(this);
}

@JsonSerializable()
class ResponseModel {
  ResponseModel({Key key, this.error, this.message});

  bool error;
  String message;
  String data;

  factory ResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseModelToJson(this);
}
