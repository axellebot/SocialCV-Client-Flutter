import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:social_cv_client_flutter/bloc.dart';
import 'package:social_cv_client_flutter/domain.dart';

abstract class EntryListState extends Equatable {
  EntryListState([List props = const []]) : super(props);

  @override
  String toString() => '$runtimeType{}';
}

class EntryListUninitialized extends EntryListState
    with ElementListUninitialized<EntryEntity> {}

class EntryListLoading extends EntryListState
    with ElementListLoading<EntryEntity> {
  EntryListLoading({int count = 0}) : super([count]) {
    this.count = count;
  }

  @override
  String toString() => '$runtimeType{ '
      'count: $count'
      ' }';
}

class EntryListLoaded extends EntryListState
    with ElementListLoaded<EntryEntity> {
  EntryListLoaded({@required List<EntryEntity> entries}) : super([entries]) {
    elements = entries;
  }

  @override
  String toString() => '$runtimeType{ '
      'entries: $elements'
      ' }';
}

class EntryListFailure extends EntryListState
    with ElementListFailure<EntryEntity> {
  EntryListFailure({@required dynamic error})
      : assert(error != null, 'No error given'),
        super([error]) {
    this.error = error;
  }

  @override
  String toString() => '$runtimeType{ '
      'error: $error'
      ' }';
}
