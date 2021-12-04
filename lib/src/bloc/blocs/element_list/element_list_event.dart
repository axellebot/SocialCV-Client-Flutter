import 'package:social_cv_client_flutter/domain.dart';
import 'package:social_cv_client_flutter/presentation.dart';

mixin ElementListInitialize<T extends ElementEntity> {
  String? parentId;
  String? ownerId;
  late Cursor cursor;

  @override
  String toString() => '$runtimeType{ '
      'parentId: $parentId, '
      'ownerId: $ownerId, '
      'cursor: $cursor'
      ' }';
}

mixin ElementListRefresh<T extends ElementEntity> {
  @override
  String toString() => '$runtimeType{}';
}

mixin ElementListLoadMore<T extends ElementEntity> {
  late Cursor cursor;

  @override
  String toString() => '$runtimeType{ '
      'cursor: $cursor'
      ' }';
}
