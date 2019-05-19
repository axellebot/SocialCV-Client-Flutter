import 'package:shared_preferences/shared_preferences.dart';

/// One of the possible Implementation of PreferencesService Interface
class AppSharedPreferencesManager {
  final String _keyUserId = 'USER_ID';
  final String _keyUserEmail = 'USER_EMAIL';
  final String _keyAppTheme = 'APP_THEME';

  Future<SharedPreferences> get _prefs => SharedPreferences.getInstance();

  AppSharedPreferencesManager();

  /// ----------------------------------------------------------
  /// ------------------------- User ---------------------------
  /// ----------------------------------------------------------

  Future<bool> setUserId(String userId) async {
    final prefs = await _prefs;
    return prefs.setString(_keyUserId, userId);
  }

  Future<String> getUserId() async {
    final prefs = await _prefs;
    return prefs.getString(_keyUserId);
  }

  Future<bool> deleteUserId() async {
    final prefs = await _prefs;
    return prefs.remove(_keyUserId);
  }

  Future<void> setUserEmail(String userEmail) async {
    final prefs = await _prefs;
    return prefs.setString(_keyUserEmail, userEmail);
  }

  Future<String> getUserEmail() async {
    final prefs = await _prefs;
    return prefs.getString(_keyUserEmail);
  }

  Future<void> deleteUserEmail() async {
    final prefs = await _prefs;
    return prefs.remove(_keyUserEmail);
  }

  /// ----------------------------------------------------------
  /// ------------------------- Theme --------------------------
  /// ----------------------------------------------------------

  Future<String> getAppTheme() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString(_keyAppTheme);
  }

  Future<bool> setAppTheme(String theme) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.setString(_keyAppTheme, theme);
  }

  Future<bool> deleteAppTheme() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.remove(_keyAppTheme);
  }

  /// ----------------------------------------------------------
  /// -------------------------- All ---------------------------
  /// ----------------------------------------------------------

  Future deleteAll() async {
    await this.deleteUserId();
    await this.deleteUserEmail();
    await this.deleteAppTheme();
  }
}
