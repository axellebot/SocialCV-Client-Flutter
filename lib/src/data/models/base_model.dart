import 'package:json_annotation/json_annotation.dart';
import 'package:social_cv_client_flutter/domain.dart';

abstract class BaseDataModel implements BaseEntity {
  @JsonKey(name: '_id')
  @override
  String id;

  @JsonKey(name: 'createdAt')
  @override
  DateTime? createdAt;

  @JsonKey(name: 'updatedAt')
  @override
  DateTime? updatedAt;

  @JsonKey(name: '__v')
  @override
  int? version;

  BaseDataModel({
    required this.id,
    this.createdAt,
    this.updatedAt,
    this.version,
  }) : super();
}
