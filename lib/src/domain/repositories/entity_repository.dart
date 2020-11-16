import 'dart:async';

import 'package:social_cv_client_flutter/presentation.dart';
import 'package:social_cv_client_flutter/src/domain/entities/base_entity.dart';

abstract class EntityRepository<T extends BaseEntity> {
  /// Fetch the [T] identified by [id]
  ///
  /// [force] can be used to avoid cache use ([$false] by default)
  ///
  /// Must return an [T]
  FutureOr<T> getById(
    String id, {
    bool force = false,
  });

  /// Fetch [T] list
  ///
  /// [Cursor] can be used to choose the offset and the limit
  ///
  /// Must return a [List] of [T]
  FutureOr<List<T>> getList({
    /// TODO: Add filters
    /// TODO: Add sort
    Cursor cursor = const Cursor(),
  });

// TODO: Add delete
// TODO: Add create
}
