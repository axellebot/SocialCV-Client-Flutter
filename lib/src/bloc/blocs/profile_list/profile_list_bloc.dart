import 'dart:async';

import 'package:meta/meta.dart';
import 'package:social_cv_client_flutter/bloc.dart';
import 'package:social_cv_client_flutter/domain.dart';
import 'package:social_cv_client_flutter/presentation.dart';

/// Business Logic Component for Profile list
class ProfileListBloc extends ElementListBloc<ProfileEntity, ProfileRepository,
    ProfileListEvent, ProfileListState> {
  final String _tag = '$ProfileListBloc';

  ProfileListBloc({@required ProfileRepository repository})
      : super(repository: repository);

  @override
  ProfileListState get initialState => ProfileListUninitialized();

  @override
  Stream<ProfileListState> mapEventToState(ProfileListEvent event) async* {
    print('$_tag:mapEventToState($event)');
    if (event is ProfileListInitialized) {
      yield* _mapProfileListInitializedEventToState(event);
    } else if (event is ProfileListRefresh) {
      yield* _mapProfileListRefreshEventToState(event);
    } else if (event is ProfileListLoadMore) {
      yield* _mapProfileListLoadMoreEventToState(event);
    }
  }

  /// --------------------------------------------------------------------------
  ///                         All Event map to State
  /// --------------------------------------------------------------------------

  /// Map [ProfileListInitialized] to [ProfileListState]
  ///
  /// ```dart
  /// yield* _mapProfileListInitializedEventToState(event);
  /// ```
  Stream<ProfileListState> _mapProfileListInitializedEventToState(
      ProfileListInitialized event) async* {
    print('$_tag:_mapProfileListInitializedEventToState($event)');
    try {
      /// TODO: Add refresh indicator stream

      parentId = event.parentId;
      ownerId = event.ownerId;
      cursor = event.cursor;

      elements = await _getProfiles(cursor: cursor);

      yield ProfileListLoaded(profiles: elements);
    } catch (error) {
      yield ProfileListFailure(error: error);
    }
  }

  /// Map [ProfileListRefresh] to [ProfileListState]
  ///
  /// ```dart
  /// yield* _mapProfileListRefreshEventToState(event);
  /// ```
  Stream<ProfileListState> _mapProfileListRefreshEventToState(
      ProfileListRefresh event) async* {
    print('$_tag:_mapProfileListRefreshEventToState($event)');
    try {
      /// TODO: Add refresh indicator stream
      elements = await _getProfiles(cursor: cursor);
      yield ProfileListLoaded(profiles: elements);
    } catch (error) {
      yield ProfileListFailure(error: error);
    }
  }

  /// Map [ProfileListLoadMore] to [ProfileListState]
  ///
  /// ```dart
  /// yield* _mapProfileListLoadMoreEventToState(event);
  /// ```
  Stream<ProfileListState> _mapProfileListLoadMoreEventToState(
      ProfileListLoadMore event) async* {
    print('$_tag:_mapProfileListLoadMoreEventToState($event)');
    try {
      /// TODO: Add load more indicator stream

      final List<ProfileEntity> profiles = await _getProfiles(
        cursor: event.cursor.copyWith(offset: elements.length),
      );

      /// Append to elements
      elements.addAll(profiles);

      /// Save cursor limit if use list refreshed
      cursor = cursor.copyWith(limit: elements.length);

      yield ProfileListLoaded(profiles: elements);
    } catch (error) {
      yield ProfileListFailure(error: error);
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
