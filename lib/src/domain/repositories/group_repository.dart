import 'dart:async';

import 'package:social_cv_client_flutter/domain.dart';
import 'package:social_cv_client_flutter/presentation.dart';
import 'package:social_cv_client_flutter/src/domain/repositories/entity_repository.dart';

/// Repository interface for group element purpose
abstract class GroupRepository extends EntityRepository<GroupEntity> {
  /// Fetch groups from the parent part identified by [partId]
  ///
  /// [Cursor] can be used to choose the offset and the limit
  ///
  /// Must return a [List] of [GroupEntity]
  FutureOr<List<GroupEntity>> getGroupsFromPart(
    String partId, {

    /// TODO: Add filters
    /// TODO: Add sort
    Cursor cursor = const Cursor(),
  });

  /// Fetch groups from the user identified by [userId]
  ///
  /// [Cursor] can be used to choose the offset and the limit
  ///
  /// Must return a [List] of [GroupEntity]
  FutureOr<List<GroupEntity>> getGroupsFromUser(
    String userId, {

    /// TODO: Add filters
    /// TODO: Add sort
    Cursor cursor = const Cursor(),
  });
}
