import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_cv_client_flutter/data.dart';

/// One of the possible Implementation of PreferencesService Interface
class AuthSharedPreferencesManager implements AuthInfoDataStore {
  final String _keyOAuthAccessToken = 'OAUTH_ACCESS_TOKEN';
  final String _keyOAuthAccessTokenExpiration = 'OAUTH_ACCESS_TOKEN_EXPIRATION';
  final String _keyOAuthRefreshToken = 'OAUTH_REFRESH_TOKEN';
  final String _keyOAuthRefreshTokenExpiration =
      'OAUTH_REFRESH_TOKEN_EXPIRATION';

  FutureOr<SharedPreferences> get _prefs => SharedPreferences.getInstance();

  AuthSharedPreferencesManager();

  /// ----------------------------------------------------------
  /// ------------------------- Tokens -------------------------
  /// ----------------------------------------------------------

  @override
  FutureOr<String> getAccessToken() async {
    final prefs = await _prefs;
    return prefs.getString(_keyOAuthAccessToken);
  }

  @override
  FutureOr<String> setAccessToken(String token) async {
    final prefs = await _prefs;
    return (await prefs.setString(_keyOAuthAccessToken, token)) ? token : null;
  }

  @override
  FutureOr<String> deleteAccessToken() async {
    final prefs = await _prefs;
    await prefs.remove(_keyOAuthAccessToken);
    return null;
  }

  @override
  FutureOr<DateTime> getAccessTokenExpiration() async {
    final prefs = await _prefs;
    return DateTime.parse(prefs.getString(_keyOAuthAccessTokenExpiration));
  }

  @override
  FutureOr<DateTime> setAccessTokenExpiration(DateTime expiration) async {
    final prefs = await _prefs;
    return (await prefs.setString(
            _keyOAuthAccessTokenExpiration, expiration.toIso8601String()))
        ? expiration
        : null;
  }

  @override
  FutureOr<DateTime> deleteAccessTokenExpiration() async {
    final prefs = await _prefs;
    await prefs.remove(_keyOAuthAccessTokenExpiration);
    return null;
  }

  @override
  FutureOr<String> getRefreshToken() async {
    final prefs = await _prefs;
    return prefs.getString(_keyOAuthRefreshToken);
  }

  @override
  FutureOr<String> setRefreshToken(String refreshToken) async {
    final prefs = await _prefs;
    return (await prefs.setString(_keyOAuthRefreshToken, refreshToken))
        ? refreshToken
        : null;
  }

  @override
  FutureOr<String> deleteRefreshToken() async {
    final prefs = await _prefs;
    await prefs.remove(_keyOAuthRefreshToken);
    return null;
  }

  @override
  FutureOr<DateTime> getRefreshTokenExpiration() async {
    final prefs = await _prefs;
    return DateTime.parse(prefs.getString(_keyOAuthRefreshTokenExpiration));
  }

  @override
  FutureOr<DateTime> setRefreshTokenExpiration(DateTime expiration) async {
    final prefs = await _prefs;
    return (await prefs.setString(
            _keyOAuthRefreshTokenExpiration, expiration.toIso8601String()))
        ? expiration
        : null;
  }

  @override
  FutureOr<DateTime> deleteRefreshTokenExpiration() async {
    final prefs = await _prefs;
    await prefs.remove(_keyOAuthRefreshTokenExpiration);
    return null;
  }

  /// ----------------------------------------------------------
  /// -------------------------- All ---------------------------
  /// ----------------------------------------------------------

  Future deleteAll() async {
    await deleteAccessToken();
    await deleteAccessTokenExpiration();
    await deleteRefreshToken();
    await deleteRefreshTokenExpiration();
  }
}
