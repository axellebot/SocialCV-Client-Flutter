import 'package:equatable/equatable.dart';
import 'package:social_cv_client_flutter/bloc.dart';
import 'package:social_cv_client_flutter/domain.dart';

/// [EntryEvent] that must be dispatch to [EntryBloc]
abstract class EntryEvent extends Equatable {
  EntryEvent([List props = const []]) : super(props);

  @override
  String toString() => '$runtimeType{}';
}

class EntryInitialize extends EntryEvent with ElementInitialize<EntryEntity> {
  EntryInitialize({String entryId, EntryEntity entry})
      : assert(
          entryId != null && entry == null,
          '$EntryInitialize must be created with an $EntryEntity or its ID',
        ),
        assert(
          entryId == null && entry != null,
          '$EntryInitialize must be created with an $EntryEntity or its ID',
        ),
        super([entryId, entry]) {
    elementId = entryId;
    element = entry;
  }

  @override
  String toString() => '$runtimeType{ '
      'entryId: $elementId, '
      'element: $element'
      ' }';
}

class EntryRefresh extends EntryEvent with ElementRefresh<EntryEntity> {}
