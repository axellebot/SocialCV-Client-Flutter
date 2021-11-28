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
        super(AuthenticationUninitialized()) {
    loginBlocSubscription = loginBloc.stream.listen((state) {
      on<AppStarted>(_onAppStart);
      on<Login>(_onLogin);
      on<Logout>(_onLogout);

      if (state is LoginSucceed) {
        add(Login(
          accessToken: state.accessToken,
          accessTokenExpiration: state.accessTokenExpiration,
          refreshToken: state.refreshToken,
        ));
      }
    });

    registerBlocSubscription = registerBloc.stream.listen((state) {
      if (state is RegisterSucceed) {
        add(Login(
          accessToken: state.accessToken,
          accessTokenExpiration: state.accessTokenExpiration,
          refreshToken: state.refreshToken,
        ));
      }
    });
  }

  @override
  Future<void> close() async {
    await loginBlocSubscription.cancel();
    await registerBlocSubscription.cancel();
    await super.close();
  }

  /// -----------------------------------------------------------------------
  ///                       All Event map to State
  /// -----------------------------------------------------------------------

  /// Map [AppStarted] to [AuthenticationState]
  FutureOr<void> _onAppStart(
    AppStarted event,
    Emitter<AuthenticationState> emit,
  ) async {
    try {
      final token = await authInfoRepository.getAccessToken();

      /// TODO: Check access token expiration and fetch new access token with refresh token
      /// TODO: Check refresh token expiration, if it's expired set state to Unauthenticated

      if (token != null && token?.length > 0) {
        emit(AuthenticationAuthenticated());
      } else {
        emit(AuthenticationUnauthenticated());
      }
    } catch (error) {
      emit(AuthenticationFailed(error: error));
    }
  }

  /// Map [Login] to [AuthenticationState]
  FutureOr<void> _onLogin(
    Login event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(AuthenticationLoading());
    await authInfoRepository.setAccessToken(event.accessToken);
    await authInfoRepository
        .setAccessTokenExpiration(event.accessTokenExpiration);
    await authInfoRepository.setRefreshToken(event.refreshToken);
    emit(AuthenticationAuthenticated());
  }

  /// Map [Logout] to [AuthenticationState]
  FutureOr<void> _onLogout(
    Logout event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(AuthenticationLoading());
    await cvAuthService.logout();
    await authInfoRepository.deleteAccessToken();
    await authInfoRepository.deleteAccessTokenExpiration();
    await authInfoRepository.deleteRefreshToken();
    await authInfoRepository.deleteRefreshTokenExpiration();
    emit(AuthenticationUnauthenticated());
  }
}
