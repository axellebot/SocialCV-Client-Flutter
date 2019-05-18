import 'package:equatable/equatable.dart';

/// [ConfigurationEvent] that must be dispatch to [ApplicationBloc]
abstract class ConfigurationEvent extends Equatable {
  ConfigurationEvent([List props = const []]) : super(props);

  @override
  String toString() => '$runtimeType{}';
}

class AppLaunched extends ConfigurationEvent {}
