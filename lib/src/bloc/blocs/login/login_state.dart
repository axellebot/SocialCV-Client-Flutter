import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  const LoginState() : super();

  @override
  List<Object> get props => [];

  @override
  String toString() => '$runtimeType{}';
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginFailure extends LoginState {
  final Object error;

  const LoginFailure({
    required this.error,
  }) : super();

  @override
  List<Object> get props => super.props..addAll([error]);

  @override
  String toString() => '$runtimeType{ '
      'error: $error'
      ' }';
}

class LoginSucceed extends LoginState {
  final String accessToken;
  final DateTime accessTokenExpiration;
  final String refreshToken;

  const LoginSucceed({
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
      'accessToken: $accessTokenExpiration, '
      'refreshToken: $refreshToken '
      ' }';
}
