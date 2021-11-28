import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_cv_client_flutter/bloc.dart';
import 'package:social_cv_client_flutter/domain.dart';

/// Business Logic Component for Profile
class ProfileBloc extends ElementBloc<ProfileEntity, ProfileRepository,
    ProfileEvent, ProfileState> {
  final String _tag = '$ProfileBloc';

  ProfileBloc({@required ProfileRepository repository})
      : super(
          repository: repository,
          initialState: ProfileUninitialized(),
        ) {
    on<ProfileInitialized>(_onInitialize);
    on<ProfileRefresh>(_onRefresh);
  }

  /// [_fallBackId] is used if [element] is never assigned and
  /// an [ProfileRefresh] is dispatched
  String _fallBackId;

  /// --------------------------------------------------------------------------
  ///                         All Event map to State
  /// --------------------------------------------------------------------------

  /// Map [ProfileInitialized] to [ProfileState]
  FutureOr<void> _onInitialize(
    ProfileInitialized event,
    Emitter<ProfileState> emit,
  ) async {
    print('$_tag:_onInitialize($event,$emit)');
    try {
      emit(ProfileLoading());

      if (event.elementId != null) {
        _fallBackId = event.elementId;
        element = await await repository.getById(event.elementId);
      } else if (event.element != null) {
        _fallBackId = event.element.id;
        element = event.element;
      }

      emit(ProfileLoaded(profile: element));
    } catch (error) {
      emit(ProfileFailure(error: error));
    }
  }

  /// Map [ProfileRefresh] to [ProfileState]
  FutureOr<void> _onRefresh(
    ProfileRefresh event,
    Emitter<ProfileState> emit,
  ) async {
    print('$_tag:_onRefresh($event,$emit)');
    try {
      emit(ProfileLoading());

      element = await repository.getById(
        element?.id ?? _fallBackId,
        force: true,
      );

      _fallBackId = element.id;

      emit(ProfileLoaded(profile: element));
    } catch (error) {
      emit(ProfileFailure(error: error));
    }
  }
}
