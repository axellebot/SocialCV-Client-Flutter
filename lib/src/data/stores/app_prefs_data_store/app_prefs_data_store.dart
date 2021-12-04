import 'dart:async';

abstract class AppPrefsDataStore {
  /// Set Application dark mode with [darkMode]
  FutureOr<bool> setDarkMode(bool darkMode);

  /// Get App dark mode
  ///
  /// Must return the application dark mode [bool] or [null] if not found
  FutureOr<bool?> getDarkMode();

  /// Delete Application dark mode
  FutureOr<bool> deleteDarkMode();

  /// Delete all application preferences
  FutureOr<bool> deleteAllPrefs();
}
