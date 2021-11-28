import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_cv_client_flutter/bloc.dart';
import 'package:social_cv_client_flutter/domain.dart';

/// Business Logic Component for Login
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final String _tag = '$LoginBloc';

  final CVAuthService cvAuthService;

  LoginBloc({
    @required this.cvAuthService,
  })  : assert(cvAuthService != null, 'No $CVAuthService given'),
        super(LoginInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
  }

  /// --------------------------------------------------------------------------
  ///                         All Event map to State
  /// --------------------------------------------------------------------------

  /// Map [LoginButtonPressed] to [LoginState]
  FutureOr<void> _onLoginButtonPressed(
      LoginButtonPressed event, Emitter<LoginState> emit) async {
    try {
      if (event is LoginButtonPressed) {
        emit(LoginLoading());

        final auth = await cvAuthService.authenticate(
          email: event.email,
          password: event.password,
        );

        emit(LoginSucceed(
          accessToken: auth.accessToken,
          accessTokenExpiration: auth.accessTokenExpiration,
          refreshToken: auth.refreshToken,
        ));
      }
    } catch (error) {
      emit(LoginFailure(error: error));
    }
  }
}
