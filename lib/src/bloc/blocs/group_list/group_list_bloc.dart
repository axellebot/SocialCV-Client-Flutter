import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:social_cv_client_flutter/bloc.dart';
import 'package:social_cv_client_flutter/domain.dart';
import 'package:social_cv_client_flutter/presentation.dart';

/// Business Logic Component for Group list
class GroupListBloc extends ElementListBloc<GroupEntity, GroupRepository,
    GroupListEvent, GroupListState> {
  final String _tag = '$GroupListBloc';

  GroupListBloc({required GroupRepository repository})
      : super(
          repository: repository,
          initialState: GroupListUninitialized(),
        ) {
    on<GroupListInitialize>(_onInitialize);
    on<GroupListRefresh>(_onRefresh);
    on<GroupListLoadMore>(_onLoadMore);
  }

  /// --------------------------------------------------------------------------
  ///                         All Event map to State
  /// --------------------------------------------------------------------------

  /// Map [GroupListInitialize] to [GroupListState]
  FutureOr<void> _onInitialize(
    GroupListInitialize event,
    Emitter<GroupListState> emit,
  ) async {
    print('$_tag:_onInitialize($event,$emit)');
    try {
      /// TODO: Add refresh indicator stream

      parentId = event.parentId;
      ownerId = event.ownerId;
      cursor = event.cursor;

      elements = await _getGroups(cursor: cursor);

      emit(GroupListLoaded(groups: elements));
    } catch (error) {
      emit(GroupListFailure(error: error));
    }
  }

  /// Map [GroupListRefresh] to [GroupListState]
  FutureOr<void> _onRefresh(
    GroupListRefresh event,
    Emitter<GroupListState> emit,
  ) async {
    print('$_tag:_onRefresh($event,$emit)');
    try {
      /// TODO: Add refresh indicator stream
      elements = await _getGroups(cursor: cursor);
      emit(GroupListLoaded(groups: elements));
    } catch (error) {
      emit(GroupListFailure(error: error));
    }
  }

  /// Map [GroupListLoadMore] to [GroupListState]
  FutureOr<void> _onLoadMore(
    GroupListLoadMore event,
    Emitter<GroupListState> emit,
  ) async {
    print('$_tag:_onLoadMore($event,$emit)');
    try {
      /// TODO: Add load more indicator stream

      final List<GroupEntity> groups = await _getGroups(
        cursor: event.cursor.copyWith(offset: elements.length),
      );

      /// Append to elements
      elements.addAll(groups);

      /// Save cursor limit if use list refreshed
      cursor = cursor.copyWith(limit: elements.length);

      emit(GroupListLoaded(groups: elements));
    } catch (error) {
      emit(GroupListFailure(error: error));
    }
  }

  FutureOr<List<GroupEntity>> _getGroups({required Cursor cursor}) async {
    print('$_tag:_getGroups({cursor: $cursor})');
    if (parentId != null) {
      return await repository.getGroupsFromPart(
        parentId!,
        cursor: cursor,
      );
    } else if (ownerId != null) {
      return await repository.getGroupsFromUser(
        ownerId!,
        cursor: cursor,
      );
    } else {
      return await repository.getList(
        cursor: cursor,
      );
    }
  }
}
