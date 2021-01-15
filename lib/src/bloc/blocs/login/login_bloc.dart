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
        super();

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    print('$_tag:mapEventToState($event)');
    if (event is LoginButtonPressed) {
      yield* _mapLoginButtonPressedToState(event);
    }
  }

  /// --------------------------------------------------------------------------
  ///                         All Event map to State
  /// --------------------------------------------------------------------------

  /// Map [LoginButtonPressed] to [LoginState]
  ///
  /// ```dart
  /// yield* _mapLoginButtonPressedToState(event);
  /// ```
  Stream<LoginState> _mapLoginButtonPressedToState(
      LoginButtonPressed event) async* {
    try {
      if (event is LoginButtonPressed) {
        yield LoginLoading();

        final auth = await cvAuthService.authenticate(
          email: event.email,
          password: event.password,
        );

        yield LoginSucceed(
          accessToken: auth.accessToken,
          accessTokenExpiration: auth.accessTokenExpiration,
          refreshToken: auth.refreshToken,
        );
      }
    } catch (error) {
      yield LoginFailure(error: error);
    }
  }
}
