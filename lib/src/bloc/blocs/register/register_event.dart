import 'package:equatable/equatable.dart';

/// [RegisterEvent] that must be dispatch to [RegisterBloc]
abstract class RegisterEvent extends Equatable {
  const RegisterEvent() : super();

  @override
  List<Object> get props => [];
}

class RegistrationEvent extends RegisterEvent {
  final String fName;
  final String lName;
  final String email;
  final String password;

  const RegistrationEvent({
    required this.fName,
    required this.lName,
    required this.email,
    required this.password,
  }) : super();

  @override
  List<Object> get props =>
      super.props..addAll([fName, lName, email, password]);

  @override
  String toString() => '$runtimeType{ '
      'fName: $fName, '
      'lName: $lName, '
      'email: $email, '
      'password: HIDDEN'
      ' }';
}
