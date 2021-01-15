import 'package:meta/meta.dart';
import 'package:social_cv_client_flutter/bloc.dart';
import 'package:social_cv_client_flutter/domain.dart';

/// Business Logic Component for User
class UserBloc
    extends ElementBloc<UserEntity, UserRepository, UserEvent, UserState> {
  final String _tag = '$UserBloc';

  UserBloc({@required UserRepository repository})
      : super(repository: repository);

  /// [_fallBackId] is used if [element] is never assigned and
  /// an [UserRefresh] is dispatched
  String _fallBackId;

  @override
  UserState get initialState => UserUninitialized();

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    print('$_tag:mapEventToState($event)');
    if (event is UserInitialized) {
      yield* _mapInitializedEventToState(event);
    } else if (event is UserRefresh) {
      yield* _mapRefreshEventToState(event);
    }
  }

  /// --------------------------------------------------------------------------
  ///                         All Event map to State
  /// --------------------------------------------------------------------------

  /// Map [UserInitialized] to [UserState]
  ///
  /// ```dart
  /// yield* _mapInitializedEventToState(event);
  /// ```
  Stream<UserState> _mapInitializedEventToState(UserInitialized event) async* {
    print('$_tag:_mapInitializedEventToState($event)');
    try {
      yield UserLoading();

      if (event.elementId != null) {
        _fallBackId = event.elementId;
        element = await await repository.getById(event.elementId);
      } else if (event.element != null) {
        _fallBackId = event.element.id;
        element = event.element;
      }

      yield UserLoaded(user: element);
    } catch (error) {
      yield UserFailure(error: error);
    }
  }

  /// Map [UserRefresh] to [UserState]
  ///
  /// ```dart
  /// yield* _mapRefreshEventToState(event);
  /// ```
  Stream<UserState> _mapRefreshEventToState(UserRefresh event) async* {
    print('$_tag:_mapRefreshEventToState($event)');
    try {
      yield UserLoading();

      element = await repository.getById(
        element?.id ?? _fallBackId,
        force: true,
      );

      _fallBackId = element.id;

      yield UserLoaded(user: element);
    } catch (error) {
      yield UserFailure(error: error);
    }
  }
}
