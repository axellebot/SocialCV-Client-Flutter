import 'package:equatable/equatable.dart';

/// [ConfigurationEvent] that must be dispatch to [AppBloc]
abstract class ConfigurationEvent extends Equatable {
  const ConfigurationEvent() : super();

  @override
  List<Object> get props => [];

  @override
  String toString() => '$runtimeType{}';
}

class AppLaunched extends ConfigurationEvent {}
