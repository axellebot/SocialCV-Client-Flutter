import 'package:social_cv_client_flutter/domain.dart';
import 'package:social_cv_client_flutter/presentation.dart';

mixin ElementListInitialize<T extends ElementEntity> {
  String parentId;
  String ownerId;
  Cursor cursor;

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
  Cursor cursor;

  @override
  String toString() => '$runtimeType{ '
      'cursor: $cursor'
      ' }';
}
