import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class AuthenticationState extends Equatable {
  AuthenticationState([List props = const []]) : super(props);

  @override
  String toString() => '$runtimeType{}';
}

class AuthenticationUninitialized extends AuthenticationState {}

class AuthenticationAuthenticated extends AuthenticationState {}

class AuthenticationUnauthenticated extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}

class AuthenticationFailed extends AuthenticationState {
  final dynamic error;

  AuthenticationFailed({@required this.error})
      : assert(error != null, 'No error given'),
        super([error]);

  @override
  String toString() => '$runtimeType{ '
      'error: $error'
      ' }';
}
