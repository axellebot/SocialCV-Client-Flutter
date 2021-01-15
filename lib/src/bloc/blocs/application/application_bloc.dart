import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_cv_client_flutter/bloc.dart';
import 'package:social_cv_client_flutter/domain.dart';

/// Business Logic Component for Application behaviors
/// Can manage theme
class AppBloc extends Bloc<AppEvent, AppState> {
  final String _tag = '$AppBloc';

  final AppPrefsRepository appPreferencesRepository;

  AppBloc({
    @required this.appPreferencesRepository,
  })  : assert(
          appPreferencesRepository != null,
          'No $AppPrefsRepository given',
        ),
        super();

  @override
  AppState get initialState => AppUninitialized();

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    print('$_tag:mapEventToState($event)');
    if (event is AppConfigured) {
      yield* _mapAppConfiguredToState(event);
    } else if (event is AppThemeChanged) {
      yield* _mapAppThemeChangedToState(event);
    }
  }

  /// -----------------------------------------------------------------------
  ///                       All Event map to State
  /// -----------------------------------------------------------------------

  /// Map [AppThemeChanged] to [AppState]
  ///
  /// ```dart
  /// yield* _mapAppThemeChangedToState(event);
  /// ```
  Stream<AppState> _mapAppThemeChangedToState(AppThemeChanged event) async* {
    try {
      yield AppLoading();
      await appPreferencesRepository.toggleDarkMode(event.darkMode);
      yield AppInitialized(darkMode: event.darkMode);
    } catch (error) {
      yield AppFailure(error: error);
    }
  }

  /// Map [AppConfigured] to [AppState]
  ///
  /// ```dart
  /// yield* _mapAppConfiguredToState(event);
  /// ```
  Stream<AppState> _mapAppConfiguredToState(AppConfigured event) async* {
    try {
      yield AppLoading();
      final darkMode = await appPreferencesRepository.getDarkMode() ?? false;
      yield AppInitialized(darkMode: darkMode);
    } catch (error) {
      yield AppFailure(error: error);
    }
  }
}
