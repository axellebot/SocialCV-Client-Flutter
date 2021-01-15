import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_cv_client_flutter/data.dart';

/// Application preferences manager implementation
/// providing [AppPrefsDataStore]
class AppPrefsManager implements AppPrefsDataStore {
  final String _keyAppDarkMode = 'APP_DARK_MODE';

  FutureOr<SharedPreferences> get _prefs => SharedPreferences.getInstance();

  AppPrefsManager();

  /// --------------------------------------------------------------------------
  ///                                Dark Mode
  /// --------------------------------------------------------------------------

  @override
  FutureOr<bool> getDarkMode() async {
    final storage = await _prefs;
    return storage.getBool(_keyAppDarkMode);
  }

  @override
  FutureOr<bool> toggleDarkMode(bool darkMode) async {
    final storage = await _prefs;
    return await storage.setBool(
      _keyAppDarkMode,
      darkMode,
    );
  }

  @override
  FutureOr<bool> deleteDarkMode() async {
    final storage = await _prefs;
    await storage.remove(_keyAppDarkMode);
    return null;
  }

  /// --------------------------------------------------------------------------
  ///                                    All
  /// --------------------------------------------------------------------------

  @override
  Future<void> deleteAll() async {
    final storage = await _prefs;
    await storage.remove(_keyAppDarkMode);
  }
}
