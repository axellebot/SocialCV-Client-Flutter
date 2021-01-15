import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

/// [AuthenticationEvent] that must be dispatch to [AuthenticationBloc]
abstract class AuthenticationEvent extends Equatable {
  AuthenticationEvent([List props = const []]) : super(props);
}

/// Use [AppStarted] to begin auth process on startup
class AppStarted extends AuthenticationEvent {}

/// Use [LoggedIn] to inform that user just logged in
class LoggedIn extends AuthenticationEvent {
  final String accessToken;
  final DateTime accessTokenExpiration;
  final String refreshToken;

  LoggedIn({
    @required this.accessToken,
    @required this.accessTokenExpiration,
    @required this.refreshToken,
  }) : super([
          accessToken,
          accessTokenExpiration,
          refreshToken,
        ]);

  @override
  String toString() => '$runtimeType{ '
      'accessToken: $accessToken, '
      'accessTokenExpiration: $accessTokenExpiration, '
      'refreshToken: $refreshToken, '
      ' }';
}

/// Use [LoggedOut] to request logout
class LoggedOut extends AuthenticationEvent {}
