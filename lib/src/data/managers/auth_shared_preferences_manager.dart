import 'package:shared_preferences/shared_preferences.dart';

/// One of the possible Implementation of PreferencesService Interface
class AuthSharedPreferencesManager {
  final String _keyOAuthAccessToken = 'OAUTH_ACCESS_TOKEN';
  final String _keyOAuthAccessTokenExpiration = 'OAUTH_ACCESS_TOKEN_EXPIRATION';
  final String _keyOAuthRefreshToken = 'OAUTH_REFRESH_TOKEN';
  final String _keyOAuthRefreshTokenExpiration =
      'OAUTH_REFRESH_TOKEN_EXPIRATION';
  final String _keyAuthConnected = 'AUTH_CONNECTED';

  Future<SharedPreferences> get _prefs => SharedPreferences.getInstance();

  AuthSharedPreferencesManager();

  /// ----------------------------------------------------------
  /// ------------------------- Tokens -------------------------
  /// ----------------------------------------------------------

  Future<String> getAccessToken() async {
    final prefs = await _prefs;
    return prefs.getString(_keyOAuthAccessToken) ?? '';
  }

  Future<bool> setAccessToken(String accessToken) async {
    final prefs = await _prefs;
    return prefs.setString(_keyOAuthAccessToken, accessToken);
  }

  Future<bool> deleteAccessToken() async {
    final prefs = await _prefs;
    return prefs.remove(_keyOAuthAccessToken);
  }

  Future<int> getAccessTokenExpiration() async {
    final prefs = await _prefs;
    return prefs.getInt(_keyOAuthAccessTokenExpiration) ?? '';
  }

  Future<bool> setAccessTokenExpiration(int accessTokenExpiration) async {
    final prefs = await _prefs;
    return prefs.setInt(_keyOAuthAccessTokenExpiration, accessTokenExpiration);
  }

  Future<bool> deleteAccessTokenExpiration() async {
    final prefs = await _prefs;
    return prefs.remove(_keyOAuthAccessTokenExpiration);
  }

  Future<String> getRefreshToken() async {
    final prefs = await _prefs;
    return prefs.getString(_keyOAuthRefreshToken) ?? '';
  }

  Future<bool> setRefreshToken(String refreshToken) async {
    final prefs = await _prefs;
    return prefs.setString(_keyOAuthRefreshToken, refreshToken);
  }

  Future<bool> deleteRefreshToken() async {
    final prefs = await _prefs;
    return prefs.remove(_keyOAuthRefreshToken);
  }

  Future<String> getRefreshTokenExpiration() async {
    final prefs = await _prefs;
    return prefs.getString(_keyOAuthRefreshTokenExpiration) ?? '';
  }

  Future<bool> setRefreshTokenExpiration(int refreshTokenExpiration) async {
    final prefs = await _prefs;
    return prefs.setInt(
        _keyOAuthRefreshTokenExpiration, refreshTokenExpiration);
  }

  Future<bool> deleteRefreshTokenExpiration() async {
    final prefs = await _prefs;
    return prefs.remove(_keyOAuthRefreshTokenExpiration);
  }

  /// ----------------------------------------------------------
  /// -------------------------- All ---------------------------
  /// ----------------------------------------------------------

  Future deleteAll() async {
    await this.deleteAccessToken();
    await this.deleteAccessTokenExpiration();
    await this.deleteRefreshToken();
    await this.deleteRefreshTokenExpiration();
  }
}
