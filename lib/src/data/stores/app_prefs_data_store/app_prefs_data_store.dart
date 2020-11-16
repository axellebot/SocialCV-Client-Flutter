import 'dart:async';

abstract class AppPrefsDataStore {
  /// Get App dark mode
  ///
  /// Must return the application dark mode [bool] or [null] if not found
  FutureOr<bool> getDarkMode();

  /// Set Application dark mode([bool])
  FutureOr<bool> toggleDarkMode(bool darkMode);

  /// Delete Application dark mode
  FutureOr<bool> deleteDarkMode();

  /// Delete all application preferences
  FutureOr deleteAll();
}
