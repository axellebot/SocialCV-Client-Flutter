import 'package:meta/meta.dart';
import 'package:social_cv_client_flutter/bloc.dart';
import 'package:social_cv_client_flutter/domain.dart';

/// Business Logic Component for Entry
class EntryBloc
    extends ElementBloc<EntryEntity, EntryRepository, EntryEvent, EntryState> {
  final String _tag = '$EntryBloc';

  EntryBloc({@required EntryRepository repository})
      : super(repository: repository);

  /// [_fallBackId] is used if [element] is never assigned and
  /// an [EntryRefresh] is dispatched
  String _fallBackId;

  @override
  EntryState get initialState => EntryUninitialized();

  @override
  Stream<EntryState> mapEventToState(EntryEvent event) async* {
    print('$_tag:mapEventToState($event)');
    if (event is EntryInitialized) {
      yield* _mapInitializedEventToState(event);
    } else if (event is EntryRefresh) {
      yield* _mapRefreshEventToState(event);
    }
  }

  /// --------------------------------------------------------------------------
  ///                         All Event map to State
  /// --------------------------------------------------------------------------

  /// Map [EntryInitialized] to [EntryState]
  ///
  /// ```dart
  /// yield* _mapInitializedEventToState(event);
  /// ```
  Stream<EntryState> _mapInitializedEventToState(
      EntryInitialized event) async* {
    print('$_tag:_mapInitializedEventToState($event)');
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
  ///
  /// ```dart
  /// yield* _mapRefreshEventToState(event);
  /// ```
  Stream<EntryState> _mapRefreshEventToState(EntryRefresh event) async* {
    print('$_tag:_mapRefreshEventToState($event)');
    try {
      yield EntryLoading();

      element = await repository.getById(
        element?.id ?? _fallBackId,
        force: true,
      );

      _fallBackId = element.id;

      yield EntryLoaded(entry: element);
    } catch (error) {
      yield EntryFailure(error: error);
    }
  }
}
