import 'dart:async';

import 'package:meta/meta.dart';
import 'package:social_cv_client_flutter/bloc.dart';
import 'package:social_cv_client_flutter/domain.dart';
import 'package:social_cv_client_flutter/presentation.dart';

/// Business Logic Component for Group list
class GroupListBloc extends ElementListBloc<GroupEntity, GroupRepository,
    GroupListEvent, GroupListState> {
  final String _tag = '$GroupListBloc';

  GroupListBloc({@required GroupRepository repository})
      : super(repository: repository);

  @override
  GroupListState get initialState => GroupListUninitialized();

  @override
  Stream<GroupListState> mapEventToState(GroupListEvent event) async* {
    print('$_tag:mapEventToState($event)');
    if (event is GroupListInitialized) {
      yield* _mapGroupListInitializedEventToState(event);
    } else if (event is GroupListRefresh) {
      yield* _mapGroupListRefreshEventToState(event);
    } else if (event is GroupListLoadMore) {
      yield* _mapGroupListLoadMoreEventToState(event);
    }
  }

  /// --------------------------------------------------------------------------
  ///                         All Event map to State
  /// --------------------------------------------------------------------------

  /// Map [GroupListInitialized] to [GroupListState]
  ///
  /// ```dart
  /// yield* _mapGroupListInitializedEventToState(event);
  /// ```
  Stream<GroupListState> _mapGroupListInitializedEventToState(
      GroupListInitialized event) async* {
    print('$_tag:_mapGroupListInitializedEventToState($event)');
    try {
      /// TODO: Add refresh indicator stream

      parentId = event.parentId;
      ownerId = event.ownerId;
      cursor = event.cursor;

      elements = await _getGroups(cursor: cursor);

      yield GroupListLoaded(groups: elements);
    } catch (error) {
      yield GroupListFailure(error: error);
    }
  }

  /// Map [GroupListRefresh] to [GroupListState]
  ///
  /// ```dart
  /// yield* _mapGroupListRefreshEventToState(event);
  /// ```
  Stream<GroupListState> _mapGroupListRefreshEventToState(
      GroupListRefresh event) async* {
    print('$_tag:_mapGroupListRefreshEventToState($event)');
    try {
      /// TODO: Add refresh indicator stream
      elements = await _getGroups(cursor: cursor);
      yield GroupListLoaded(groups: elements);
    } catch (error) {
      yield GroupListFailure(error: error);
    }
  }

  /// Map [GroupListLoadMore] to [GroupListState]
  ///
  /// ```dart
  /// yield* _mapGroupListLoadMoreEventToState(event);
  /// ```
  Stream<GroupListState> _mapGroupListLoadMoreEventToState(
      GroupListLoadMore event) async* {
    print('$_tag:_mapGroupListLoadMoreEventToState($event)');
    try {
      /// TODO: Add load more indicator stream

      final List<GroupEntity> groups = await _getGroups(
        cursor: event.cursor.copyWith(offset: elements.length),
      );

      /// Append to elements
      elements.addAll(groups);

      /// Save cursor limit if use list refreshed
      cursor = cursor.copyWith(limit: elements.length);

      yield GroupListLoaded(groups: elements);
    } catch (error) {
      yield GroupListFailure(error: error);
    }
  }

  FutureOr<List<GroupEntity>> _getGroups({@required Cursor cursor}) async {
    print('$_tag:_getGroups({cursor: $cursor})');
    if (parentId != null) {
      return await repository.getGroupsFromPart(
        parentId,
        cursor: cursor,
      );
    } else if (ownerId != null) {
      return await repository.getGroupsFromUser(
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
