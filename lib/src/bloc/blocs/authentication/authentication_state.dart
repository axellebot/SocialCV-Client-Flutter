import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState() : super();

  @override
  List<Object> get props => [];

  @override
  String toString() => '$runtimeType{}';
}

class AuthenticationUninitialized extends AuthenticationState {}

class AuthenticationAuthenticated extends AuthenticationState {}

class AuthenticationUnauthenticated extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}

class AuthenticationFailed extends AuthenticationState {
  final Object error;

  const AuthenticationFailed({
    required this.error,
  }) : super();

  @override
  List<Object> get props => super.props..addAll([error]);

  @override
  String toString() => '$runtimeType{ '
      'error: $error'
      ' }';
}
