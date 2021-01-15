import 'package:meta/meta.dart';
import 'package:social_cv_client_flutter/bloc.dart';
import 'package:social_cv_client_flutter/domain.dart';

/// Business Logic Component for Profile
class ProfileBloc extends ElementBloc<ProfileEntity, ProfileRepository,
    ProfileEvent, ProfileState> {
  final String _tag = '$ProfileBloc';

  ProfileBloc({@required ProfileRepository repository})
      : super(repository: repository);

  /// [_fallBackId] is used if [element] is never assigned and
  /// an [ProfileRefresh] is dispatched
  String _fallBackId;

  @override
  ProfileState get initialState => ProfileUninitialized();

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    print('$_tag:mapEventToState($event)');
    if (event is ProfileInitialized) {
      yield* _mapInitializedEventToState(event);
    } else if (event is ProfileRefresh) {
      yield* _mapRefreshEventToState(event);
    }
  }

  /// --------------------------------------------------------------------------
  ///                         All Event map to State
  /// --------------------------------------------------------------------------

  /// Map [ProfileInitialized] to [ProfileState]
  ///
  /// ```dart
  /// yield* _mapInitializedEventToState(event);
  /// ```
  Stream<ProfileState> _mapInitializedEventToState(
      ProfileInitialized event) async* {
    print('$_tag:_mapInitializedEventToState($event)');
    try {
      yield ProfileLoading();

      if (event.elementId != null) {
        _fallBackId = event.elementId;
        element = await await repository.getById(event.elementId);
      } else if (event.element != null) {
        _fallBackId = event.element.id;
        element = event.element;
      }

      yield ProfileLoaded(profile: element);
    } catch (error) {
      yield ProfileFailure(error: error);
    }
  }

  /// Map [ProfileRefresh] to [ProfileState]
  ///
  /// ```dart
  /// yield* _mapRefreshEventToState(event);
  /// ```
  Stream<ProfileState> _mapRefreshEventToState(ProfileRefresh event) async* {
    print('$_tag:_mapRefreshEventToState($event)');
    try {
      yield ProfileLoading();

      element = await repository.getById(
        element?.id ?? _fallBackId,
        force: true,
      );

      _fallBackId = element.id;

      yield ProfileLoaded(profile: element);
    } catch (error) {
      yield ProfileFailure(error: error);
    }
  }
}
