import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_cv_client_flutter/bloc.dart';
import 'package:social_cv_client_flutter/domain.dart';

/// Business Logic Component for Part
class PartBloc
    extends ElementBloc<PartEntity, PartRepository, PartEvent, PartState> {
  final String _tag = '$PartBloc';

  PartBloc({@required PartRepository repository})
      : super(
          repository: repository,
          initialState: PartUninitialized(),
        ) {
    on<PartInitialize>(_onInitialize);
    on<PartRefresh>(_onRefresh);
  }

  /// [_fallBackId] is used if [element] is never assigned and
  /// an [PartRefresh] is dispatched
  String _fallBackId;

  /// --------------------------------------------------------------------------
  ///                         All Event map to State
  /// --------------------------------------------------------------------------

  /// Map [PartInitialize] to [PartState]
  FutureOr<void> _onInitialize(
    PartInitialize event,
    Emitter<PartState> emit,
  ) async {
    print('$_tag:_onInitialize($event,$emit)');
    try {
      emit(PartLoading());

      if (event.elementId != null) {
        _fallBackId = event.elementId;
        element = await repository.getById(event.elementId);
      } else if (event.element != null) {
        _fallBackId = event.element.id;
        element = event.element;
      }

      emit(PartLoaded(part: element));
    } catch (error) {
      emit(PartFailure(error: error));
    }
  }

  /// Map [PartRefresh] to [PartState]
  FutureOr<void> _onRefresh(
    PartRefresh event,
    Emitter<PartState> emit,
  ) async {
    print('$_tag:_onRefresh($event,$emit)');
    try {
      emit(PartLoading());

      element = await repository.getById(
        element?.id ?? _fallBackId,
        force: true,
      );

      _fallBackId = element.id;

      emit(PartLoaded(part: element));
    } catch (error) {
      emit(PartFailure(error: error));
    }
  }
}
