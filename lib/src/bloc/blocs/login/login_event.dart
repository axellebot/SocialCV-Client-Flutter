import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

/// [LoginEvent] that must be dispatch to [LoginBloc]
abstract class LoginEvent extends Equatable {
  LoginEvent([List props = const []]) : super(props);

  @override
  String toString() => '$runtimeType{}';
}

class LoginButtonPressed extends LoginEvent {
  final String email;
  final String password;

  LoginButtonPressed({
    @required this.email,
    @required this.password,
  }) : super([email, password]);

  @override
  String toString() => '$runtimeType{ '
      'username: $email, '
      'password: HIDDEN'
      ' }';
}
