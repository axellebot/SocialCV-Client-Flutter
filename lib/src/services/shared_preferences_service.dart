import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static final String KEY_AUTH_TOKEN = "AUTH_TOKEN";

  static Future<SharedPreferences> get _prefs =>
      SharedPreferences.getInstance();

  /// ----------------------------------------------------------
  /// Method that returns the token from Shared Preferences
  /// ----------------------------------------------------------
  Future<String> getAuthToken() async {
    final SharedPreferences prefs = await _prefs;

    return prefs.getString(KEY_AUTH_TOKEN) ?? '';
  }

  /// ----------------------------------------------------------
  /// Method that saves the token in Shared Preferences
  /// ----------------------------------------------------------
  static Future<bool> setAuthToken(String token) async {
    final SharedPreferences prefs = await _prefs;

    return prefs.setString(KEY_AUTH_TOKEN, token);
  }

  /// ----------------------------------------------------------
  /// Method that delete the token in Shared Preferences
  /// ----------------------------------------------------------
  static Future<bool> deleteAuthToken() async {
    final SharedPreferences prefs = await _prefs;

    return prefs.remove(KEY_AUTH_TOKEN);
  }
}
