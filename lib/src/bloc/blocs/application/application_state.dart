import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class AppState extends Equatable {
  AppState([List props = const []]) : super(props);

  @override
  String toString() => '$runtimeType{}';
}

class AppUninitialized extends AppState {}

class AppInitialized extends AppState {
  final bool darkMode;

  AppInitialized({this.darkMode = false}) : super([darkMode]);

  @override
  String toString() => '$runtimeType{ '
      'darkMode: $darkMode'
      ' }';
}

class AppFailure extends AppState {
  final dynamic error;

  AppFailure({@required this.error})
      : assert(error != null, 'No error given'),
        super([error]);

  @override
  String toString() => '$runtimeType{ '
      'error: $error'
      ' }';
}

class AppLoading extends AppState {}
