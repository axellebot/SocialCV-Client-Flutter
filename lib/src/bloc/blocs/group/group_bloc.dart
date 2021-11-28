import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_cv_client_flutter/bloc.dart';
import 'package:social_cv_client_flutter/domain.dart';

/// Business Logic Component for Group
class GroupBloc
    extends ElementBloc<GroupEntity, GroupRepository, GroupEvent, GroupState> {
  final String _tag = '$GroupBloc';

  GroupBloc({@required GroupRepository repository})
      : super(
          repository: repository,
          initialState: GroupUninitialized(),
        ) {
    on<GroupInitialize>(_onInitialize);
    on<GroupRefresh>(_onRefresh);
  }

  /// [_fallBackId] is used if [element] is never assigned and
  /// an [GroupRefresh] is dispatched
  String _fallBackId;

  /// --------------------------------------------------------------------------
  ///                         All Event map to State
  /// --------------------------------------------------------------------------

  FutureOr<void> _onInitialize(
    GroupInitialize event,
    Emitter<GroupState> emit,
  ) async {
    print('$_tag:_onInitialize($event,$emit)');
    try {
      emit(GroupLoading());

      if (event.elementId != null) {
        _fallBackId = event.elementId;
        element = await repository.getById(event.elementId);
      } else if (event.element != null) {
        _fallBackId = event.element.id;
        element = event.element;
      }

      emit(GroupLoaded(group: element));
    } catch (error) {
      emit(GroupFailure(error: error));
    }
  }

  /// Map [GroupRefresh] to [GroupState]
  FutureOr<void> _onRefresh(
    GroupRefresh event,
    Emitter<GroupState> emit,
  ) async {
    print('$_tag:_onRefresh($event,$emit)');
    try {
      emit(GroupLoading());

      element = await repository.getById(
        element?.id ?? _fallBackId,
        force: true,
      );

      _fallBackId = element.id;

      emit(GroupLoaded(group: element));
    } catch (error) {
      emit(GroupFailure(error: error));
    }
  }

  @override
  String toString() {
    return '$runtimeType{ '
        'repository: $repository'
        ' }';
  }
}
