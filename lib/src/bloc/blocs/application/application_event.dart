import 'package:equatable/equatable.dart';

/// [AppEvent] that must be dispatch to [AppBloc]
abstract class AppEvent extends Equatable {
  const AppEvent() : super();

  @override
  List<Object> get props => [];

  @override
  String toString() => '$runtimeType{}';
}

class AppConfigure extends AppEvent {}

class AppThemeChange extends AppEvent {
  final bool darkMode;

  const AppThemeChange({
    required this.darkMode,
  }) : super();

  @override
  List<Object> get props => super.props..addAll([darkMode]);

  @override
  String toString() => '$runtimeType{ '
      'darkMode: $darkMode'
      ' }';
}
