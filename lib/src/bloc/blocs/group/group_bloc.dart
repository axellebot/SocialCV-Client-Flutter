import 'package:meta/meta.dart';
import 'package:social_cv_client_flutter/bloc.dart';
import 'package:social_cv_client_flutter/domain.dart';

/// Business Logic Component for Group
class GroupBloc
    extends ElementBloc<GroupEntity, GroupRepository, GroupEvent, GroupState> {
  final String _tag = '$GroupBloc';

  GroupBloc({@required GroupRepository repository})
      : super(repository: repository);

  /// [_fallBackId] is used if [element] is never assigned and
  /// an [GroupRefresh] is dispatched
  String _fallBackId;

  @override
  GroupState get initialState => GroupUninitialized();

  @override
  Stream<GroupState> mapEventToState(GroupEvent event) async* {
    print('$_tag:mapEventToState($event)');
    if (event is GroupInitialized) {
      yield* _mapInitializedEventToState(event);
    } else if (event is GroupRefresh) {
      yield* _mapRefreshEventToState(event);
    }
  }

  /// --------------------------------------------------------------------------
  ///                         All Event map to State
  /// --------------------------------------------------------------------------

  Stream<GroupState> _mapInitializedEventToState(
      GroupInitialized event) async* {
    print('$_tag:_mapInitializedEventToState($event)');
    try {
      yield GroupLoading();

      if (event.elementId != null) {
        _fallBackId = event.elementId;
        element = await repository.getById(event.elementId);
      } else if (event.element != null) {
        _fallBackId = event.element.id;
        element = event.element;
      }

      yield GroupLoaded(group: element);
    } catch (error) {
      yield GroupFailure(error: error);
    }
  }

  /// Map [GroupRefresh] to [GroupState]
  ///
  /// ```dart
  /// yield* _mapRefreshEventToState(event);
  /// ```
  Stream<GroupState> _mapRefreshEventToState(GroupRefresh event) async* {
    print('$_tag:_mapRefreshEventToState($event)');
    try {
      yield GroupLoading();

      element = await repository.getById(
        element?.id ?? _fallBackId,
        force: true,
      );

      _fallBackId = element.id;

      yield GroupLoaded(group: element);
    } catch (error) {
      yield GroupFailure(error: error);
    }
  }

  @override
  String toString() {
    return '$runtimeType{ '
        'repository: $repository'
        ' }';
  }
}
