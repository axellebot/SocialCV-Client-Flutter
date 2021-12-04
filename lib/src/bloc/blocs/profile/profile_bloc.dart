import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:social_cv_client_flutter/bloc.dart';
import 'package:social_cv_client_flutter/domain.dart';

/// Business Logic Component for Profile
class ProfileBloc extends ElementBloc<ProfileEntity, ProfileRepository,
    ProfileEvent, ProfileState> {
  final String _tag = '$ProfileBloc';

  ProfileBloc({required ProfileRepository repository})
      : super(
          repository: repository,
          initialState: ProfileUninitialized(),
        ) {
    on<ProfileInitialized>(_onInitialize);
    on<ProfileRefresh>(_onRefresh);
  }

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
        element = await repository.getById(event.elementId!);
      } else if (event.element != null) {
        element = event.element;
      }

      emit(ProfileLoaded(profile: element!));
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
        element!.id,
        force: true,
      );

      emit(ProfileLoaded(profile: element!));
    } catch (error) {
      emit(ProfileFailure(error: error));
    }
  }
}
