import 'package:equatable/equatable.dart';

/// [IdentityEvent] that must be dispatch to [AccountBloc]
abstract class IdentityEvent extends Equatable {
  const IdentityEvent() : super();

  @override
  List<Object> get props => [];

  @override
  String toString() => '$runtimeType{}';
}

class IdentityRefresh extends IdentityEvent {}
