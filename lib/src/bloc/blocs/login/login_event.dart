import 'package:equatable/equatable.dart';

/// [LoginEvent] that must be dispatch to [LoginBloc]
abstract class LoginEvent extends Equatable {
  const LoginEvent() : super();

  @override
  List<Object> get props => [];

  @override
  String toString() => '$runtimeType{}';
}

class LoginButtonPressed extends LoginEvent {
  final String email;
  final String password;

  const LoginButtonPressed({
    required this.email,
    required this.password,
  }) : super();

  @override
  List<Object> get props => super.props..addAll([email, password]);

  @override
  String toString() => '$runtimeType{ '
      'username: $email, '
      'password: HIDDEN'
      ' }';
}
