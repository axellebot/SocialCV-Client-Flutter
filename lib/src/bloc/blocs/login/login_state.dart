import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class LoginState extends Equatable {
  LoginState([List props = const []]) : super(props);

  @override
  String toString() => '$runtimeType{}';
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginFailure extends LoginState {
  final dynamic error;

  LoginFailure({@required this.error})
      : assert(error != null, 'No error given'),
        super([error]);

  @override
  String toString() => '$runtimeType{ '
      'error: $error'
      ' }';
}

class LoginSucceed extends LoginState {
  final String accessToken;
  final DateTime accessTokenExpiration;
  final String refreshToken;

  LoginSucceed({
    @required this.accessToken,
    @required this.accessTokenExpiration,
    @required this.refreshToken,
  }) : super([accessToken, accessTokenExpiration, refreshToken]);

  @override
  String toString() => '$runtimeType{ '
      'accessToken: $accessToken, '
      'accessToken: $accessTokenExpiration, '
      'refreshToken: $refreshToken '
      ' }';
}
