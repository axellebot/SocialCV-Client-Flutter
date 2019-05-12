import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_cv_client_dart_common/repositories.dart';

class SharedPreferencesManager implements PreferencesRepository {
  static const String KEY_OAUTH_ACCESS_TOKEN = 'OAUTH_ACCESS_TOKEN';
  static const String KEY_OAUTH_ACCESS_TOKEN_EXPIRATION =
      'OAUTH_ACCESS_TOKEN_EXPIRATION';
  static const String KEY_OAUTH_REFRESH_TOKEN = 'OAUTH_REFRESH_TOKEN';
  static const String KEY_OAUTH_REFRESH_TOKEN_EXPIRATION =
      'OAUTH_REFRESH_TOKEN_EXPIRATION';
  static const String KEY_AUTH_CONNECTED = 'AUTH_CONNECTED';
  static const String KEY_USER_ID = 'USER_ID';
  static const String KEY_APP_THEME = 'APP_THEME';

  static Future<SharedPreferences> get _prefs =>
      SharedPreferences.getInstance();

  /// ----------------------------------------------------------
  /// ------------------------- Tokens -------------------------
  /// ----------------------------------------------------------

  Future<String> getAccessToken() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString(KEY_OAUTH_ACCESS_TOKEN) ?? '';
  }

  Future<bool> setAccessToken(String accessToken) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.setString(KEY_OAUTH_ACCESS_TOKEN, accessToken);
  }

  Future<bool> deleteAccessToken() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.remove(KEY_OAUTH_ACCESS_TOKEN);
  }

  Future<int> getAccessTokenExpiration() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getInt(KEY_OAUTH_ACCESS_TOKEN_EXPIRATION) ?? '';
  }

  Future<bool> setAccessTokenExpiration(int accessTokenExpiration) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.setInt(
        KEY_OAUTH_ACCESS_TOKEN_EXPIRATION, accessTokenExpiration);
  }

  Future<bool> deleteAccessTokenExpiration() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.remove(KEY_OAUTH_ACCESS_TOKEN_EXPIRATION);
  }

  Future<String> getRefreshToken() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString(KEY_OAUTH_REFRESH_TOKEN) ?? '';
  }

  Future<bool> setRefreshToken(String refreshToken) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.setString(KEY_OAUTH_REFRESH_TOKEN, refreshToken);
  }

  Future<bool> deleteRefreshToken() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.remove(KEY_OAUTH_REFRESH_TOKEN);
  }

  Future<String> getRefreshTokenExpiration() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString(KEY_OAUTH_REFRESH_TOKEN_EXPIRATION) ?? '';
  }

  Future<bool> setRefreshTokenExpiration(int refreshTokenExpiration) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.setInt(
        KEY_OAUTH_REFRESH_TOKEN_EXPIRATION, refreshTokenExpiration);
  }

  Future<bool> deleteRefreshTokenExpiration() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.remove(KEY_OAUTH_REFRESH_TOKEN_EXPIRATION);
  }

  /// ----------------------------------------------------------
  /// ----------------------- Connected ------------------------
  /// ----------------------------------------------------------

  Future<bool> isAuthConnected() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getBool(KEY_AUTH_CONNECTED);
  }

  Future<bool> setAuthConnected(bool connected) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.setBool(KEY_AUTH_CONNECTED, connected);
  }

  Future<bool> deleteAuthConnected() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.remove(KEY_AUTH_CONNECTED);
  }

  /// ----------------------------------------------------------
  /// ------------------------- User ---------------------------
  /// ----------------------------------------------------------

  Future<bool> setUserId(String userId) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.setString(KEY_USER_ID, userId);
  }

  Future<String> getUserId() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString(KEY_USER_ID);
  }

  Future<bool> deleteUserId() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.remove(KEY_USER_ID);
  }

  /// ----------------------------------------------------------
  /// ------------------------- Theme --------------------------
  /// ----------------------------------------------------------

  Future<String> getAppTheme() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString(KEY_APP_THEME);
  }

  Future<bool> setAppTheme(String theme) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.setString(KEY_APP_THEME, theme);
  }

  Future<bool> deleteAppTheme() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.remove(KEY_APP_THEME);
  }

  /// ----------------------------------------------------------
  /// -------------------------- All ---------------------------
  /// ----------------------------------------------------------

  Future deleteAll() async {
    await this.deleteAccessToken();
    await this.deleteAccessTokenExpiration();
    await this.deleteRefreshToken();
    await this.deleteRefreshTokenExpiration();
    await this.deleteAuthConnected();
    await this.deleteUserId();
    await this.deleteAppTheme();
  }
}
