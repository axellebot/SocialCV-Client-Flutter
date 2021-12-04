import 'package:equatable/equatable.dart';

abstract class RegisterState extends Equatable {
  const RegisterState() : super();

  @override
  List<Object> get props => [];

  @override
  String toString() => '$runtimeType{}';
}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterFailure extends RegisterState {
  final Object error;

  const RegisterFailure({required this.error}) : super();

  @override
  List<Object> get props => super.props..addAll([error]);

  @override
  String toString() => '$runtimeType{ '
      'error: $error'
      ' }';
}

class RegisterSucceed extends RegisterState {
  final String accessToken;
  final DateTime accessTokenExpiration;
  final String refreshToken;

  const RegisterSucceed({
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
      'refreshToken: $refreshToken'
      ' }';
}
