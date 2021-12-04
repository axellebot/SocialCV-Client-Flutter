import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:social_cv_client_flutter/bloc.dart';
import 'package:social_cv_client_flutter/domain.dart';

/// Business Logic Component for Entry
class EntryBloc
    extends ElementBloc<EntryEntity, EntryRepository, EntryEvent, EntryState> {
  final String _tag = '$EntryBloc';

  EntryBloc({required EntryRepository repository})
      : super(
          repository: repository,
          initialState: EntryUninitialized(),
        ) {
    on<EntryInitialize>(_onInitialize);
    on<EntryRefresh>(_onRefresh);
  }

  /// --------------------------------------------------------------------------
  ///                         All Event map to State
  /// --------------------------------------------------------------------------

  /// Map [EntryInitialize] to [EntryState]
  FutureOr<void> _onInitialize(
    EntryInitialize event,
    Emitter<EntryState> emit,
  ) async {
    print('$_tag:_onInitialize($event,$emit)');
    try {
      emit(EntryLoading());

      if (event.elementId != null) {
        element = await repository.getById(event.elementId!);
      } else if (event.element != null) {
        element = event.element;
      }

      emit(EntryLoaded(entry: element!));
    } catch (error) {
      emit(EntryFailure(error: error));
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
        element!.id,
        force: true,
      );

      emit(EntryLoaded(entry: element!));
    } catch (error) {
      emit(EntryFailure(error: error));
    }
  }
}
