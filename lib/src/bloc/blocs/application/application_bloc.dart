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
        super(AppUninitialized()) {
    on<AppConfigure>(_onConfigure);
    on<AppThemeChange>(_onAppThemeChange);
  }

  /// -----------------------------------------------------------------------
  ///                       All Event map to State
  /// -----------------------------------------------------------------------

  /// Map [AppConfigure] to [AppState]
  FutureOr<void> _onConfigure(
    AppConfigure event,
    Emitter<AppState> emit,
  ) async {
    try {
      emit(AppLoading());
      final darkMode = await appPreferencesRepository.getDarkMode() ?? false;
      emit(AppInitialized(darkMode: darkMode));
    } catch (error) {
      emit(AppFailure(error: error));
    }
  }

  /// Map [AppThemeChange] to [AppState]
  FutureOr<void> _onAppThemeChange(
    AppThemeChange event,
    Emitter<AppState> emit,
  ) async {
    try {
      emit(AppLoading());
      await appPreferencesRepository.toggleDarkMode(event.darkMode);
      emit(AppInitialized(darkMode: event.darkMode));
    } catch (error) {
      emit(AppFailure(error: error));
    }
  }
}
