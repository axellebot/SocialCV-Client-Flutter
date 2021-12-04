import 'dart:async';

import 'package:social_cv_client_flutter/data.dart';
import 'package:social_cv_client_flutter/domain.dart';
import 'package:social_cv_client_flutter/presentation.dart';

/// Memory implementation of [EntryDataStore]
class MemoryEntryDataStore implements EntryDataStore {
  final String _tag = '$MemoryEntryDataStore';

  MemoryEntryDataStore();

  final Map<String, CacheModel<EntryDataModel>> _entries =
      <String, CacheModel<EntryDataModel>>{};

  @override
  FutureOr<EntryDataModel?> getEntry(String entryId) async {
    print('$_tag:getEntry($entryId)');

    final CacheModel<EntryDataModel>? cacheModel = _entries[entryId];
    return (cacheModel != null && !cacheModel.isExpired())
        ? cacheModel.model
        : null;
  }

  @override
  FutureOr<EntryDataModel> setEntry(EntryDataModel entryModel) async {
    print('$_tag:setEntry($entryModel)');

    final DateTime expiration = defaultExpirationDateTime;
    final cacheModel = CacheModel<EntryDataModel>(
      model: entryModel,
      expiration: expiration,
    );
    _entries[entryModel.id] = cacheModel;

    return cacheModel.model;
  }

  @override
  FutureOr<List<EntryDataModel>> getEntries({
    Cursor cursor = const Cursor(),
  }) {
    return _entries.values.map((value) => value.model).toList();
  }

  @override
  FutureOr<List<EntryDataModel>> getEntriesFromGroup(
    String groupId, {
    Cursor cursor = const Cursor(),
  }) {
    // TODO: implement getEntriesFromGroup
    throw NotImplementedYetError();
  }

  @override
  FutureOr<List<EntryDataModel>> getEntriesFromUser(
    String userId, {
    Cursor cursor = const Cursor(),
  }) {
    return _entries.values
        .map((e) => e.model)
        .where((model) => model.ownerId == userId)
        .toList();
  }

  @override
  String toString() => '$runtimeType{}';
}
