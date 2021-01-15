import 'dart:async';

import 'package:social_cv_client_flutter/domain.dart';
import 'package:social_cv_client_flutter/presentation.dart';
import 'package:social_cv_client_flutter/src/domain/repositories/entity_repository.dart';

/// Repository interface for part element purpose
abstract class PartRepository extends EntityRepository<PartEntity> {
  /// Fetch parts from the parent profile identified by [profileId]
  ///
  /// [Cursor] can be used to choose the offset and the limit
  ///
  /// Must return a [List] of [PartEntity]
  FutureOr<List<PartEntity>> getPartsFromProfile(
    String profileId, {

    /// TODO: Add filters
    /// TODO: Add sort
    Cursor cursor = const Cursor(),
  });

  /// Fetch parts from the user identified by [userId]
  ///
  /// [Cursor] can be used to choose the offset and the limit
  ///
  /// Must return a [List] of [PartEntity]
  FutureOr<List<PartEntity>> getPartsFromUser(
    String userId, {

    /// TODO: Add filters
    /// TODO: Add sort
    Cursor cursor = const Cursor(),
  });
}
