import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static final String KEY_AUTH_TOKEN = "AUTH_TOKEN";
  static final String KEY_AUTH_CONNECTED = "AUTH_CONNECTED";
  static final String KEY_APP_THEME = "APP_THEME";

  static Future<SharedPreferences> get _prefs =>
      SharedPreferences.getInstance();

  /// ----------------------------------------------------------
  /// ------------------------- Token --------------------------
  /// ----------------------------------------------------------

  /// ----------------------------------------------------------
  /// Method that returns the token from Shared Preferences
  /// ----------------------------------------------------------
  static Future<String> getAuthToken() async {
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

  /// ----------------------------------------------------------
  /// ----------------------- Connected ------------------------
  /// ----------------------------------------------------------

  static Future<bool> isAuthConnected() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getBool(KEY_AUTH_CONNECTED) ?? false;
  }

  static Future<bool> setAuthConnected(bool connected) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.setBool(KEY_AUTH_CONNECTED, connected) ?? false;
  }

  static Future<bool> deleteAuthConnected() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.remove(KEY_AUTH_CONNECTED);
  }

  /// ----------------------------------------------------------
  /// ------------------------- Theme --------------------------
  /// ----------------------------------------------------------

  static Future<String> getAppTheme() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString(KEY_APP_THEME);
  }

  static Future<bool> setAppTheme(String theme) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.setString(KEY_APP_THEME, theme);
  }

  static Future<bool> deleteAppTheme() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.remove(KEY_APP_THEME);
  }
}
