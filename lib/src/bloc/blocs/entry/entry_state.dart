import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:social_cv_client_flutter/bloc.dart';
import 'package:social_cv_client_flutter/domain.dart';

abstract class EntryState extends Equatable {
  EntryState([List props = const []]) : super(props);

  @override
  String toString() => '$runtimeType{}';
}

class EntryUninitialized extends EntryState
    with ElementUninitialized<EntryEntity> {}

class EntryLoading extends EntryState with ElementLoading<EntryEntity> {}

class EntryLoaded extends EntryState with ElementLoaded<EntryEntity> {
  EntryLoaded({EntryEntity entry}) : super([entry]) {
    element = entry;
  }

  @override
  String toString() {
    return '$runtimeType{ '
        'entry: $element'
        ' }';
  }
}

class EntryFailure extends EntryState with ElementFailure<EntryEntity> {
  EntryFailure({@required dynamic error})
      : assert(error != null, 'No error given'),
        super([error]) {
    this.error = error;
  }

  @override
  String toString() => '$runtimeType{ '
      'error: $error'
      ' }';
}
