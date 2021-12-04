import 'package:equatable/equatable.dart';

/// [AuthenticationEvent] that must be dispatch to [AuthenticationBloc]
abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent() : super();

  @override
  List<Object> get props => [];
}

/// Use [AppStarted] to begin auth process on startup
class AppStarted extends AuthenticationEvent {}

/// Use [Login] to inform that user just logged in
class Login extends AuthenticationEvent {
  final String accessToken;
  final DateTime accessTokenExpiration;
  final String refreshToken;

  const Login({
    required this.accessToken,
    required this.accessTokenExpiration,
    required this.refreshToken,
  }) : super();

  @override
  List<Object> get props => super.props
    ..addAll([
      accessToken,
      accessTokenExpiration,
      refreshToken,
    ]);

  @override
  String toString() => '$runtimeType{ '
      'accessToken: $accessToken, '
      'accessTokenExpiration: $accessTokenExpiration, '
      'refreshToken: $refreshToken'
      ' }';
}

/// Use [Logout] to request logout
class Logout extends AuthenticationEvent {}
