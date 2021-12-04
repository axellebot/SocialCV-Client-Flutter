import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:social_cv_client_flutter/bloc.dart';
import 'package:social_cv_client_flutter/domain.dart';

/// Business Logic Component for User
class UserBloc
    extends ElementBloc<UserEntity, UserRepository, UserEvent, UserState> {
  final String _tag = '$UserBloc';

  UserBloc({required UserRepository repository})
      : super(
          repository: repository,
          initialState: UserUninitialized(),
        ) {
    on<UserInitialize>(_onInitialize);
    on<UserRefresh>(_onRefresh);
  }

  /// --------------------------------------------------------------------------
  ///                         All Event map to State
  /// --------------------------------------------------------------------------

  /// Map [UserInitialize] to [UserState]
  FutureOr<void> _onInitialize(
    UserInitialize event,
    Emitter<UserState> emit,
  ) async {
    print('$_tag:_onInitialize($event,$emit)');
    try {
      emit(UserLoading());

      if (event.elementId != null) {
        element = await repository.getById(event.elementId!);
      } else if (event.element != null) {
        element = event.element;
      }

      emit(UserLoaded(user: element!));
    } catch (error) {
      emit(UserFailure(error: error));
    }
  }

  /// Map [UserRefresh] to [UserState]
  FutureOr<void> _onRefresh(
    UserRefresh event,
    Emitter<UserState> emit,
  ) async {
    print('$_tag:_onRefresh($event,$emit)');
    try {
      emit(UserLoading());

      element = await repository.getById(
        element!.id,
        force: true,
      );

      emit(UserLoaded(user: element!));
    } catch (error) {
      emit(UserFailure(error: error));
    }
  }
}
