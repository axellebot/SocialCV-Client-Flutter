import 'package:equatable/equatable.dart';

/// [IdentityEvent] that must be dispatch to [AccountBloc]
abstract class IdentityEvent extends Equatable {
  IdentityEvent([List props = const []]) : super(props);

  @override
  String toString() => '$runtimeType{}';
}

class IdentityRefresh extends IdentityEvent {}
