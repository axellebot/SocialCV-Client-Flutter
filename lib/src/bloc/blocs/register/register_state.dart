import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class RegisterState extends Equatable {
  RegisterState([List props = const []]) : super(props);

  @override
  String toString() => '$runtimeType{}';
}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterFailure extends RegisterState {
  final dynamic error;

  RegisterFailure({@required this.error})
      : assert(error != null, 'No error given'),
        super([error]);

  @override
  String toString() => '$runtimeType{ '
      'error: $error'
      ' }';
}

class RegisterSucceed extends RegisterState {
  final String accessToken;
  final DateTime accessTokenExpiration;
  final String refreshToken;

  RegisterSucceed({
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
