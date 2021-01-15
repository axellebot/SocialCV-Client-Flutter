import 'dart:async';

import 'package:social_cv_client_flutter/data.dart';
import 'package:social_cv_client_flutter/presentation.dart';

abstract class EntryDataStore {
  FutureOr<EntryDataModel> getEntry(String entryId);

  FutureOr<EntryDataModel> setEntry(EntryDataModel entryModel);

  FutureOr<List<EntryDataModel>> getEntries({
    /// TODO: Add filters
    /// TODO: Add sort
    Cursor cursor = const Cursor(),
  });

  FutureOr<List<EntryDataModel>> getEntriesFromGroup(
    String groupId, {

    /// TODO: Add filters
    /// TODO: Add sort
    Cursor cursor = const Cursor(),
  });

  FutureOr<List<EntryDataModel>> getEntriesFromUser(
    String userId, {

    /// TODO: Add filters
    /// TODO: Add sort
    Cursor cursor = const Cursor(),
  });
}
