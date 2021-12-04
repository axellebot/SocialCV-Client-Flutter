import 'package:equatable/equatable.dart';
import 'package:social_cv_client_flutter/bloc.dart';
import 'package:social_cv_client_flutter/domain.dart';

abstract class EntryState extends Equatable {
  const EntryState() : super();

  @override
  List<Object> get props => [];

  @override
  String toString() => '$runtimeType{}';
}

class EntryUninitialized extends EntryState
    with ElementUninitialized<EntryEntity> {}

class EntryLoading extends EntryState with ElementLoading<EntryEntity> {}

class EntryLoaded extends EntryState with ElementLoaded<EntryEntity> {
  EntryLoaded({
    required EntryEntity entry,
  }) : super() {
    element = entry;
  }

  @override
  List<Object> get props => super.props..addAll([element]);

  @override
  String toString() {
    return '$runtimeType{ '
        'entry: $element'
        ' }';
  }
}

class EntryFailure extends EntryState with ElementFailure<EntryEntity> {
  EntryFailure({required Object error}) : super() {
    this.error = error;
  }

  @override
  List<Object> get props => super.props..addAll([error]);

  @override
  String toString() => '$runtimeType{ '
      'error: $error'
      ' }';
}
