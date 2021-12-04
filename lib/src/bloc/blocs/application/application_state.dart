import 'package:equatable/equatable.dart';

abstract class AppState extends Equatable {
  const AppState() : super();

  @override
  List<Object> get props => [];

  @override
  String toString() => '$runtimeType{}';
}

class AppUninitialized extends AppState {}

class AppInitialized extends AppState {
  final bool darkMode;

  const AppInitialized({
    this.darkMode = false,
  }) : super();

  @override
  List<Object> get props => super.props..addAll([darkMode]);

  @override
  String toString() => '$runtimeType{ '
      'darkMode: $darkMode'
      ' }';
}

class AppFailure extends AppState {
  final Object error;

  const AppFailure({
    required this.error,
  }) : super();

  @override
  List<Object> get props => super.props..addAll([error]);

  @override
  String toString() => '$runtimeType{ '
      'error: $error'
      ' }';
}

class AppLoading extends AppState {}
