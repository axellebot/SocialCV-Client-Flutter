import 'package:equatable/equatable.dart';

abstract class ConfigurationEvent extends Equatable {
  ConfigurationEvent([List props = const []]) : super(props);
}

class AppLaunched extends ConfigurationEvent {}
