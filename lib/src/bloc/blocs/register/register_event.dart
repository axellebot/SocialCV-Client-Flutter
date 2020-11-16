import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

/// [RegisterEvent] that must be dispatch to [RegisterBloc]
abstract class RegisterEvent extends Equatable {
  RegisterEvent([List props = const []]) : super(props);
}

class RegistrationEvent extends RegisterEvent {
  final String fName;
  final String lName;
  final String email;
  final String password;

  RegistrationEvent({
    @required this.fName,
    @required this.lName,
    @required this.email,
    @required this.password,
  }) : super([fName, lName, email, password]);

  @override
  String toString() => '$runtimeType{ '
      'fName: $fName, '
      'lName: $lName, '
      'email: $email, '
      'password: HIDDEN'
      ' }';
}
