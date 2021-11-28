import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_cv_client_flutter/bloc.dart';
import 'package:social_cv_client_flutter/domain.dart';
import 'package:social_cv_client_flutter/presentation.dart';

/// Business Logic Component for Entry list
class EntryListBloc extends ElementListBloc<EntryEntity, EntryRepository,
    EntryListEvent, EntryListState> {
  final String _tag = '$EntryListBloc';

  EntryListBloc({@required EntryRepository repository})
      : super(
          repository: repository,
          initialState: EntryListUninitialized(),
        ) {
    on<EntryListInitialize>(_onInitialize);
    on<EntryListRefresh>(_onListRefresh);
    on<EntryListLoadMore>(_onLoadMore);
  }

  /// --------------------------------------------------------------------------
  ///                         All Event map to State
  /// --------------------------------------------------------------------------

  /// Map [EntryListInitialize] to [EntryListState]
  FutureOr<void> _onInitialize(
    EntryListInitialize event,
    Emitter<EntryListState> emit,
  ) async {
    print('$_tag:_onInitialize($event,$emit)');
    try {
      /// TODO: Add refresh indicator stream

      parentId = event.parentId;
      ownerId = event.ownerId;
      cursor = event.cursor;

      elements = await _getEntries(cursor: event.cursor);

      emit(EntryListLoaded(entries: elements));
    } catch (error) {
      emit(EntryListFailure(error: error));
    }
  }

  /// Map [EntryListRefresh] to [EntryListState]
  FutureOr<void> _onListRefresh(
    EntryListRefresh event,
    Emitter<EntryListState> emit,
  ) async {
    print('$_tag:_onListRefresh($event,$emit)');
    try {
      /// TODO: Add refresh indicator stream
      elements = await _getEntries(cursor: cursor);
      emit(EntryListLoaded(entries: elements));
    } catch (error) {
      emit(EntryListFailure(error: error));
    }
  }

  /// Map [EntryListLoadMore] to [EntryListState]
  FutureOr<void> _onLoadMore(
    EntryListLoadMore event,
    Emitter<EntryListState> emit,
  ) async {
    print('$_tag:_onLoadMore($event,$emit)');
    try {
      /// TODO: Add load more indicator stream

      final List<EntryEntity> entries = await _getEntries(
        cursor: event.cursor.copyWith(offset: elements.length),
      );

      /// Append to elements
      elements.addAll(entries);

      /// Save cursor limit if use list refreshed
      cursor = cursor.copyWith(limit: elements.length);

      emit(EntryListLoaded(entries: elements));
    } catch (error) {
      emit(EntryListFailure(error: error));
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
