import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static const String KEY_OAUTH_ACCESS_TOKEN = "OAUTH_ACCESS_TOKEN";
  static const String KEY_OAUTH_ACCESS_TOKEN_EXPIRATION =
      "OAUTH_ACCESS_TOKEN_EXPIRATION";
  static const String KEY_OAUTH_REFRESH_TOKEN = "OAUTH_REFRESH_TOKEN";
  static const String KEY_OAUTH_REFRESH_TOKEN_EXPIRATION =
      "OAUTH_REFRESH_TOKEN_EXPIRATION";
  static const String KEY_AUTH_CONNECTED = "AUTH_CONNECTED";
  static const String KEY_USER_ID = "USER_ID";
  static const String KEY_APP_THEME = "APP_THEME";

  static Future<SharedPreferences> get _prefs =>
      SharedPreferences.getInstance();

  /// ----------------------------------------------------------
  /// ------------------------- Tokens -------------------------
  /// ----------------------------------------------------------

  static Future<String> getAccessToken() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString(KEY_OAUTH_ACCESS_TOKEN) ?? '';
  }

  static Future<bool> setAccessToken(String accessToken) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.setString(KEY_OAUTH_ACCESS_TOKEN, accessToken);
  }

  static Future<bool> deleteAccessToken() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.remove(KEY_OAUTH_ACCESS_TOKEN);
  }

  static Future<int> getAccessTokenExpiration() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getInt(KEY_OAUTH_ACCESS_TOKEN_EXPIRATION) ?? '';
  }

  static Future<bool> setAccessTokenExpiration(
      int accessTokenExpiration) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.setInt(
        KEY_OAUTH_ACCESS_TOKEN_EXPIRATION, accessTokenExpiration);
  }

  static Future<bool> deleteAccessTokenExpiration() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.remove(KEY_OAUTH_ACCESS_TOKEN_EXPIRATION);
  }

  static Future<String> getRefreshToken() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString(KEY_OAUTH_REFRESH_TOKEN) ?? '';
  }

  static Future<bool> setRefreshToken(String refreshToken) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.setString(KEY_OAUTH_REFRESH_TOKEN, refreshToken);
  }

  static Future<bool> deleteRefreshToken() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.remove(KEY_OAUTH_REFRESH_TOKEN);
  }

  static Future<String> getRefreshTokenExpiration() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString(KEY_OAUTH_REFRESH_TOKEN_EXPIRATION) ?? '';
  }

  static Future<bool> setRefreshTokenExpiration(
      String refreshTokenExpiration) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.setString(
        KEY_OAUTH_REFRESH_TOKEN_EXPIRATION, refreshTokenExpiration);
  }

  static Future<bool> deleteRefreshTokenExpiration() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.remove(KEY_OAUTH_REFRESH_TOKEN_EXPIRATION);
  }

  /// ----------------------------------------------------------
  /// ----------------------- Connected ------------------------
  /// ----------------------------------------------------------

  static Future<bool> isAuthConnected() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getBool(KEY_AUTH_CONNECTED);
  }

  static Future<bool> setAuthConnected(bool connected) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.setBool(KEY_AUTH_CONNECTED, connected);
  }

  static Future<bool> deleteAuthConnected() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.remove(KEY_AUTH_CONNECTED);
  }

  /// ----------------------------------------------------------
  /// ------------------------- User ---------------------------
  /// ----------------------------------------------------------

  static Future<bool> setUserId(String userId) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.setString(KEY_USER_ID, userId);
  }

  static Future<String> getUserId() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString(KEY_USER_ID);
  }

  static Future<bool> deleteUserId() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.remove(KEY_USER_ID);
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

  /// ----------------------------------------------------------
  /// -------------------------- All ---------------------------
  /// ----------------------------------------------------------

  static Future deleteAll() async {
    await SharedPreferencesService.deleteAccessToken();
    await SharedPreferencesService.deleteAccessTokenExpiration();
    await SharedPreferencesService.deleteRefreshToken();
    await SharedPreferencesService.deleteRefreshTokenExpiration();
    await SharedPreferencesService.deleteAuthConnected();
    await SharedPreferencesService.deleteUserId();
    await SharedPreferencesService.deleteAppTheme();
  }
}
