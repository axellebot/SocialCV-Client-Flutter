import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_cv_client_flutter/bloc.dart';
import 'package:social_cv_client_flutter/domain.dart';

/// Business Logic Component for User
class UserBloc
    extends ElementBloc<UserEntity, UserRepository, UserEvent, UserState> {
  final String _tag = '$UserBloc';

  UserBloc({@required UserRepository repository})
      : super(
          repository: repository,
          initialState: UserUninitialized(),
        ) {
    on<UserInitialize>(_onInitialize);
    on<UserRefresh>(_onRefresh);
  }

  /// [_fallBackId] is used if [element] is never assigned and
  /// an [UserRefresh] is dispatched
  String _fallBackId;

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
        _fallBackId = event.elementId;
        element = await repository.getById(event.elementId);
      } else if (event.element != null) {
        _fallBackId = event.element.id;
        element = event.element;
      }

      emit(UserLoaded(user: element));
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
        element?.id ?? _fallBackId,
        force: true,
      );

      _fallBackId = element.id;

      emit(UserLoaded(user: element));
    } catch (error) {
      emit(UserFailure(error: error));
    }
  }
}
