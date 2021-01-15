import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_cv_client_flutter/bloc.dart';
import 'package:social_cv_client_flutter/domain.dart';

/// Business Logic Component for Authentication
class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final String _tag = '$AuthenticationBloc';

  final CVAuthService cvAuthService;
  final AuthInfoRepository authInfoRepository;
  final LoginBloc loginBloc;
  final RegisterBloc registerBloc;

  StreamSubscription registerBlocSubscription;
  StreamSubscription loginBlocSubscription;

  AuthenticationBloc({
    @required this.cvAuthService,
    @required this.authInfoRepository,
    @required this.loginBloc,
    @required this.registerBloc,
  })  : assert(cvAuthService != null, 'No $CVAuthService given'),
        assert(authInfoRepository != null, 'No $AppPrefsRepository given'),
        assert(loginBloc != null, 'No $LoginBloc given'),
        assert(registerBloc != null, 'No $RegisterBloc given'),
        super() {
    loginBlocSubscription = loginBloc.state.listen((state) {
      if (state is LoginSucceed) {
        dispatch(LoggedIn(
          accessToken: state.accessToken,
          accessTokenExpiration: state.accessTokenExpiration,
          refreshToken: state.refreshToken,
        ));
      }
    });

    registerBlocSubscription = registerBloc.state.listen((state) {
      if (state is RegisterSucceed) {
        dispatch(LoggedIn(
          accessToken: state.accessToken,
          accessTokenExpiration: state.accessTokenExpiration,
          refreshToken: state.refreshToken,
        ));
      }
    });
  }

  @override
  void dispose() {
    loginBlocSubscription.cancel();
    registerBlocSubscription.cancel();
    super.dispose();
  }

  @override
  AuthenticationState get initialState => AuthenticationUninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    print('$_tag:mapEventToState($event)');
    if (event is AppStarted) {
      yield* _mapAppStartedToState(event);
    } else if (event is LoggedIn) {
      yield* _mapLoggedInToState(event);
    } else if (event is LoggedOut) {
      yield* _mapLoggedOutToState(event);
    }
  }

  /// -----------------------------------------------------------------------
  ///                       All Event map to State
  /// -----------------------------------------------------------------------

  /// Map [AppStarted] to [AuthenticationState]
  ///
  /// ```dart
  /// yield* _mapAppStartedToState(event);
  /// ```
  Stream<AuthenticationState> _mapAppStartedToState(AppStarted event) async* {
    try {
      final token = await authInfoRepository.getAccessToken();

      /// TODO: Check access token expiration and fetch new access token with refresh token
      /// TODO: Check refresh token expiration, if it's expired set state to Unauthenticated

      if (token != null && token?.length > 0) {
        yield AuthenticationAuthenticated();
      } else {
        yield AuthenticationUnauthenticated();
      }
    } catch (error) {
      yield AuthenticationFailed(error: error);
    }
  }

  /// Map [LoggedIn] to [AuthenticationState]
  ///
  /// ```dart
  /// yield* _mapLoggedInToState(event);
  /// ```
  Stream<AuthenticationState> _mapLoggedInToState(LoggedIn event) async* {
    yield AuthenticationLoading();
    await authInfoRepository.setAccessToken(event.accessToken);
    await authInfoRepository
        .setAccessTokenExpiration(event.accessTokenExpiration);
    await authInfoRepository.setRefreshToken(event.refreshToken);
    yield AuthenticationAuthenticated();
  }

  /// Map [LoggedIn] to [AuthenticationState]
  ///
  /// ```dart
  /// yield* _mapLoggedInToState(event);
  /// ```
  Stream<AuthenticationState> _mapLoggedOutToState(LoggedOut event) async* {
    yield AuthenticationLoading();
    await cvAuthService.logout();
    await authInfoRepository.deleteAccessToken();
    await authInfoRepository.deleteAccessTokenExpiration();
    await authInfoRepository.deleteRefreshToken();
    await authInfoRepository.deleteRefreshTokenExpiration();
    yield AuthenticationUnauthenticated();
  }
}
