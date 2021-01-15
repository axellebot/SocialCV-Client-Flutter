import 'dart:async';

import 'package:social_cv_client_flutter/domain.dart';
import 'package:social_cv_client_flutter/presentation.dart';
import 'package:social_cv_client_flutter/src/domain/repositories/entity_repository.dart';

/// Repository interface for entry element purpose
abstract class EntryRepository extends EntityRepository<EntryEntity> {
  /// Fetch groups from the parent group identified by [groupId]
  ///
  /// [Cursor] can be used to choose the offset and the limit
  ///
  /// Must return a [List] of [EntryEntity]
  FutureOr<List<EntryEntity>> getEntriesFromGroup(
    String groupId, {

    /// TODO: Add filters
    /// TODO: Add sort
    Cursor cursor = const Cursor(),
  });

  /// Fetch entries from the user identified by [userId]
  ///
  /// [Cursor] can be used to choose the offset and the limit
  ///
  /// Must return a [List] of [EntryEntity]
  FutureOr<List<EntryEntity>> getEntriesFromUser(
    String userId, {

    /// TODO: Add filters
    /// TODO: Add sort
    Cursor cursor = const Cursor(),
  });
}
