import 'dart:async';

import 'package:meta/meta.dart';
import 'package:social_cv_client_flutter/bloc.dart';
import 'package:social_cv_client_flutter/domain.dart';
import 'package:social_cv_client_flutter/presentation.dart';

/// Business Logic Component for Part list
class PartListBloc extends ElementListBloc<PartEntity, PartRepository,
    PartListEvent, PartListState> {
  final String _tag = '$PartListBloc';

  PartListBloc({@required PartRepository repository})
      : super(repository: repository);

  @override
  PartListState get initialState => PartListUninitialized();

  @override
  Stream<PartListState> mapEventToState(PartListEvent event) async* {
    print('$_tag:mapEventToState($event)');
    if (event is PartListInitialized) {
      yield* _mapPartListInitializedEventToState(event);
    } else if (event is PartListRefresh) {
      yield* _mapPartListRefreshEventToState(event);
    } else if (event is PartListLoadMore) {
      yield* _mapPartListLoadMoreEventToState(event);
    }
  }

  /// --------------------------------------------------------------------------
  ///                         All Event map to State
  /// --------------------------------------------------------------------------

  Stream<PartListState> _mapPartListInitializedEventToState(
      PartListInitialized event) async* {
    print('$_tag:_mapPartListInitializedEventToState($event)');
    try {
      /// TODO: Add refresh indicator stream

      parentId = event.parentId;
      ownerId = event.ownerId;
      cursor = event.cursor;

      elements = await _getParts(cursor: cursor);

      yield PartListLoaded(parts: elements);
    } catch (error) {
      yield PartListFailure(error: error);
    }
  }

  Stream<PartListState> _mapPartListRefreshEventToState(
      PartListRefresh event) async* {
    print('$_tag:_mapPartListRefreshEventToState($event)');
    try {
      /// TODO: Add refresh indicator stream
      elements = await _getParts(cursor: cursor);
      yield PartListLoaded(parts: elements);
    } catch (error) {
      yield PartListFailure(error: error);
    }
  }

  /// Map [PartListLoadMore] to [PartListState]
  ///
  /// ```dart
  /// yield* _mapPartListLoadMoreEventToState(event);
  /// ```
  Stream<PartListState> _mapPartListLoadMoreEventToState(
      PartListLoadMore event) async* {
    print('$_tag:_mapPartListLoadMoreEventToState($event)');
    try {
      /// TODO: Add load more indicator stream

      List<PartEntity> parts = await _getParts(
        cursor: event.cursor.copyWith(offset: elements.length),
      );

      /// Append to elements
      elements.addAll(parts);

      /// Save cursor limit if use list refreshed
      cursor = cursor.copyWith(limit: elements.length);

      yield PartListLoaded(parts: elements);
    } catch (error) {
      yield PartListFailure(error: error);
    }
  }

  FutureOr<List<PartEntity>> _getParts({@required Cursor cursor}) async {
    print('$_tag:_getParts({cursor: $cursor})');
    if (parentId != null) {
      return await repository.getPartsFromProfile(
        parentId,
        cursor: cursor,
      );
    } else if (ownerId != null) {
      return await repository.getPartsFromUser(
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
