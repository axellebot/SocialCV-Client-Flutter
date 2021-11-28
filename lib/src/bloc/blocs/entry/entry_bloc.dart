import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_cv_client_flutter/bloc.dart';
import 'package:social_cv_client_flutter/domain.dart';

/// Business Logic Component for Entry
class EntryBloc
    extends ElementBloc<EntryEntity, EntryRepository, EntryEvent, EntryState> {
  final String _tag = '$EntryBloc';

  EntryBloc({@required EntryRepository repository})
      : super(
          repository: repository,
          initialState: EntryUninitialized(),
        ) {
    on<EntryInitialize>(_onInitialize);
    on<EntryRefresh>(_onRefresh);
  }

  /// [_fallBackId] is used if [element] is never assigned and
  /// an [EntryRefresh] is dispatched
  String _fallBackId;

  /// --------------------------------------------------------------------------
  ///                         All Event map to State
  /// --------------------------------------------------------------------------

  /// Map [EntryInitialize] to [EntryState]
  FutureOr<void> _onInitialize(
    EntryInitialize event,
    Emitter<EntryState> emit,
  ) async* {
    print('$_tag:_onInitialize($event,$emit)');
    try {
      yield EntryLoading();

      if (event.elementId != null) {
        _fallBackId = event.elementId;
        element = await repository.getById(event.elementId);
      } else if (event.element != null) {
        _fallBackId = event.element.id;
        element = event.element;
      }

      yield EntryLoaded(entry: element);
    } catch (error) {
      yield EntryFailure(error: error);
    }
  }

  /// Map [EntryRefresh] to [EntryState]
  FutureOr<void> _onRefresh(
    EntryRefresh event,
    Emitter<EntryState> emit,
  ) async {
    print('$_tag:_onRefresh($event,$emit)');
    try {
      emit(EntryLoading());

      element = await repository.getById(
        element?.id ?? _fallBackId,
        force: true,
      );

      _fallBackId = element.id;

      emit(EntryLoaded(entry: element));
    } catch (error) {
      emit(EntryFailure(error: error));
    }
  }
}
