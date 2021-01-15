import 'dart:async';

import 'package:meta/meta.dart';
import 'package:social_cv_client_flutter/bloc.dart';
import 'package:social_cv_client_flutter/domain.dart';
import 'package:social_cv_client_flutter/presentation.dart';

/// Business Logic Component for Entry list
class EntryListBloc extends ElementListBloc<EntryEntity, EntryRepository,
    EntryListEvent, EntryListState> {
  final String _tag = '$EntryListBloc';

  EntryListBloc({@required EntryRepository repository})
      : super(repository: repository);

  @override
  EntryListState get initialState => EntryListUninitialized();

  @override
  Stream<EntryListState> mapEventToState(EntryListEvent event) async* {
    print('$_tag:mapEventToState($event)');
    if (event is EntryListInitialized) {
      yield* _mapEntryListInitializedEventToState(event);
    } else if (event is EntryListRefresh) {
      yield* _mapEntryListRefreshEventToState(event);
    } else if (event is EntryListLoadMore) {
      yield* _mapEntryListLoadMoreEventToState(event);
    }
  }

  /// --------------------------------------------------------------------------
  ///                         All Event map to State
  /// --------------------------------------------------------------------------

  /// Map [EntryListInitialized] to [EntryListState]
  ///
  /// ```dart
  /// yield* _mapEntryListInitializedEventToState(event);
  /// ```
  Stream<EntryListState> _mapEntryListInitializedEventToState(
      EntryListInitialized event) async* {
    print('$_tag:_mapEntryListInitializedEventToState($event)');
    try {
      /// TODO: Add refresh indicator stream

      parentId = event.parentId;
      ownerId = event.ownerId;
      cursor = event.cursor;

      elements = await _getEntries(cursor: event.cursor);

      yield EntryListLoaded(entries: elements);
    } catch (error) {
      yield EntryListFailure(error: error);
    }
  }

  /// Map [EntryListRefresh] to [EntryListState]
  ///
  /// ```dart
  /// yield* _mapEntryListRefreshEventToState(event);
  /// ```
  Stream<EntryListState> _mapEntryListRefreshEventToState(
      EntryListRefresh event) async* {
    print('$_tag:_mapEntryListRefreshEventToState($event)');
    try {
      /// TODO: Add refresh indicator stream
      elements = await _getEntries(cursor: cursor);
      yield EntryListLoaded(entries: elements);
    } catch (error) {
      yield EntryListFailure(error: error);
    }
  }

  /// Map [EntryListLoadMore] to [EntryListState]
  ///
  /// ```dart
  /// yield* _mapEntryListRefreshEventToState(event);
  /// ```
  Stream<EntryListState> _mapEntryListLoadMoreEventToState(
      EntryListLoadMore event) async* {
    print('$_tag:_mapEntryListLoadMoreEventToState($event)');
    try {
      /// TODO: Add load more indicator stream

      final List<EntryEntity> entries = await _getEntries(
        cursor: event.cursor.copyWith(offset: elements.length),
      );

      /// Append to elements
      elements.addAll(entries);

      /// Save cursor limit if use list refreshed
      cursor = cursor.copyWith(limit: elements.length);

      yield EntryListLoaded(entries: elements);
    } catch (error) {
      yield EntryListFailure(error: error);
    }
  }

  FutureOr<List<EntryEntity>> _getEntries({@required Cursor cursor}) async {
    print('$_tag:_getEntries({cursor: $cursor})');
    if (parentId != null) {
      return await repository.getEntriesFromGroup(
        parentId,
        cursor: cursor,
      );
    } else if (ownerId != null) {
      return await repository.getEntriesFromUser(
        ownerId,
        cursor: cursor,
      );
    } else {
      return await repository.getList(
        cursor: cursor,
      );
    }
  }
}
