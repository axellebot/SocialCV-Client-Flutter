import 'package:meta/meta.dart';
import 'package:social_cv_client_flutter/bloc.dart';
import 'package:social_cv_client_flutter/domain.dart';

/// Business Logic Component for Part
class PartBloc
    extends ElementBloc<PartEntity, PartRepository, PartEvent, PartState> {
  final String _tag = '$PartBloc';

  PartBloc({@required PartRepository repository})
      : super(repository: repository);

  /// [_fallBackId] is used if [element] is never assigned and
  /// an [PartRefresh] is dispatched
  String _fallBackId;

  @override
  PartState get initialState => PartUninitialized();

  @override
  Stream<PartState> mapEventToState(PartEvent event) async* {
    print('$_tag:mapEventToState($event)');
    if (event is PartInitialized) {
      yield* _mapInitializedEventToState(event);
    } else if (event is PartRefresh) {
      yield* _mapRefreshEventToState(event);
    }
  }

  /// --------------------------------------------------------------------------
  ///                         All Event map to State
  /// --------------------------------------------------------------------------

  /// Map [PartInitialized] to [PartState]
  ///
  /// ```dart
  /// yield* _mapInitializedEventToState(event);
  /// ```
  Stream<PartState> _mapInitializedEventToState(PartInitialized event) async* {
    print('$_tag:_mapInitializedEventToState($event)');
    try {
      yield PartLoading();

      if (event.elementId != null) {
        _fallBackId = event.elementId;
        element = await repository.getById(event.elementId);
      } else if (event.element != null) {
        _fallBackId = event.element.id;
        element = event.element;
      }

      yield PartLoaded(part: element);
    } catch (error) {
      yield PartFailure(error: error);
    }
  }

  /// Map [PartRefresh] to [PartState]
  ///
  /// ```dart
  /// yield* _mapRefreshEventToState(event);
  /// ```
  Stream<PartState> _mapRefreshEventToState(PartRefresh event) async* {
    print('$_tag:_mapRefreshEventToState($event)');
    try {
      yield PartLoading();

      element = await repository.getById(
        element?.id ?? _fallBackId,
        force: true,
      );

      _fallBackId = element.id;

      yield PartLoaded(part: element);
    } catch (error) {
      yield PartFailure(error: error);
    }
  }
}
