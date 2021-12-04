import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:social_cv_client_flutter/bloc.dart';
import 'package:social_cv_client_flutter/domain.dart';
import 'package:social_cv_client_flutter/presentation.dart';

/// Business Logic Component for Part list
class PartListBloc extends ElementListBloc<PartEntity, PartRepository,
    PartListEvent, PartListState> {
  final String _tag = '$PartListBloc';

  PartListBloc({required PartRepository repository})
      : super(
          repository: repository,
          initialState: PartListUninitialized(),
        ) {
    on<PartListInitialize>(_onInitialize);
    on<PartListRefresh>(_onRefresh);
    on<PartListLoadMore>(_onLoadMore);
  }

  /// --------------------------------------------------------------------------
  ///                         All Event map to State
  /// --------------------------------------------------------------------------

  /// Map [PartListInitialize] to [PartListState]
  FutureOr<void> _onInitialize(
    PartListInitialize event,
    Emitter<PartListState> emit,
  ) async {
    print('$_tag:_onInitialize($event,$emit)');
    try {
      /// TODO: Add refresh indicator stream

      parentId = event.parentId;
      ownerId = event.ownerId;
      cursor = event.cursor;

      elements = await _getParts(cursor: cursor);

      emit(PartListLoaded(parts: elements));
    } catch (error) {
      emit(PartListFailure(error: error));
    }
  }

  /// Map [PartListRefresh] to [PartListState]
  FutureOr<void> _onRefresh(
    PartListRefresh event,
    Emitter<PartListState> emit,
  ) async {
    print('$_tag:_onRefresh($event,$emit)');
    try {
      /// TODO: Add refresh indicator stream
      elements = await _getParts(cursor: cursor);
      emit(PartListLoaded(parts: elements));
    } catch (error) {
      emit(PartListFailure(error: error));
    }
  }

  /// Map [PartListLoadMore] to [PartListState]
  FutureOr<void> _onLoadMore(
    PartListLoadMore event,
    Emitter<PartListState> emit,
  ) async {
    print('$_tag:_onLoadMore($event,$emit)');
    try {
      /// TODO: Add load more indicator stream

      final List<PartEntity> parts = await _getParts(
        cursor: event.cursor.copyWith(offset: elements.length),
      );

      /// Append to elements
      elements.addAll(parts);

      /// Save cursor limit if use list refreshed
      cursor = cursor.copyWith(limit: elements.length);

      emit(PartListLoaded(parts: elements));
    } catch (error) {
      emit(PartListFailure(error: error));
    }
  }

  FutureOr<List<PartEntity>> _getParts({required Cursor cursor}) async {
    print('$_tag:_getParts({cursor: $cursor})');
    if (parentId != null) {
      return await repository.getPartsFromProfile(
        parentId!,
        cursor: cursor,
      );
    } else if (ownerId != null) {
      return await repository.getPartsFromUser(
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
