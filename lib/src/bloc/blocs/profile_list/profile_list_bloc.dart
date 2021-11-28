import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_cv_client_flutter/bloc.dart';
import 'package:social_cv_client_flutter/domain.dart';
import 'package:social_cv_client_flutter/presentation.dart';

/// Business Logic Component for Profile list
class ProfileListBloc extends ElementListBloc<ProfileEntity, ProfileRepository,
    ProfileListEvent, ProfileListState> {
  final String _tag = '$ProfileListBloc';

  ProfileListBloc({@required ProfileRepository repository})
      : super(
          repository: repository,
          initialState: ProfileListUninitialized(),
        ) {
    on<ProfileListInitialize>(_onInitialize);
    on<ProfileListRefresh>(_onRefresh);
    on<ProfileListLoadMore>(_onLoadMore);
  }

  /// --------------------------------------------------------------------------
  ///                         All Event map to State
  /// --------------------------------------------------------------------------

  /// Map [ProfileListInitialize] to [ProfileListState]
  FutureOr<void> _onInitialize(
    ProfileListInitialize event,
    Emitter<ProfileListState> emit,
  ) async {
    print('$_tag:_onInitialize($event,$emit)');
    try {
      /// TODO: Add refresh indicator stream

      parentId = event.parentId;
      ownerId = event.ownerId;
      cursor = event.cursor;

      elements = await _getProfiles(cursor: cursor);

      emit(ProfileListLoaded(profiles: elements));
    } catch (error) {
      emit(ProfileListFailure(error: error));
    }
  }

  /// Map [ProfileListRefresh] to [ProfileListState]
  FutureOr<void> _onRefresh(
    ProfileListRefresh event,
    Emitter<ProfileListState> emit,
  ) async {
    print('$_tag:_onRefresh($event,$emit)');
    try {
      /// TODO: Add refresh indicator stream
      elements = await _getProfiles(cursor: cursor);
      emit(ProfileListLoaded(profiles: elements));
    } catch (error) {
      emit(ProfileListFailure(error: error));
    }
  }

  /// Map [ProfileListLoadMore] to [ProfileListState]
  FutureOr<void> _onLoadMore(
    ProfileListLoadMore event,
    Emitter<ProfileListState> emit,
  ) async {
    print('$_tag:_onLoadMore($event,$emit)');
    try {
      /// TODO: Add load more indicator stream

      final List<ProfileEntity> profiles = await _getProfiles(
        cursor: event.cursor.copyWith(offset: elements.length),
      );

      /// Append to elements
      elements.addAll(profiles);

      /// Save cursor limit if use list refreshed
      cursor = cursor.copyWith(limit: elements.length);

      emit(ProfileListLoaded(profiles: elements));
    } catch (error) {
      emit(ProfileListFailure(error: error));
    }
  }

  FutureOr<List<ProfileEntity>> _getProfiles({@required Cursor cursor}) async {
    print('$_tag:_getProfiles({cursor: $cursor})');
    if (parentId != null) {
      return await repository.getProfilesFromUser(
        parentId,
        cursor: cursor,
      );
    } else if (ownerId != null) {
      return await repository.getProfilesFromUser(
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
