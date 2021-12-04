import 'package:json_annotation/json_annotation.dart';
import 'package:social_cv_client_flutter/domain.dart';
import 'package:social_cv_client_flutter/src/data/models/base_model.dart';

abstract class ElementDataModel extends BaseDataModel implements ElementEntity {
  @JsonKey(name: 'ownerId')
  @override
  String? ownerId;

  ElementDataModel({
    required String id,
    this.ownerId,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? version,
  }) : super(
          id: id,
          createdAt: createdAt,
          updatedAt: updatedAt,
          version: version,
        );
}
