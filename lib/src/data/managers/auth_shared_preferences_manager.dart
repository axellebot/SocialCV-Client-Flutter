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
  FutureOr<String?> getAccessToken() async {
    final prefs = await _prefs;
    return prefs.getString(_keyOAuthAccessToken);
  }

  @override
  FutureOr<bool> setAccessToken(String token) async {
    final prefs = await _prefs;
    return await prefs.setString(_keyOAuthAccessToken, token);
  }

  @override
  FutureOr<bool> deleteAccessToken() async {
    final prefs = await _prefs;
    return await prefs.remove(_keyOAuthAccessToken);
  }

  @override
  FutureOr<DateTime?> getAccessTokenExpiration() async {
    final prefs = await _prefs;
    final String? tmp = prefs.getString(_keyOAuthAccessTokenExpiration);
    return tmp != null ? DateTime.parse(tmp) : null;
  }

  @override
  FutureOr<bool> setAccessTokenExpiration(DateTime expiration) async {
    final prefs = await _prefs;
    return await prefs.setString(
      _keyOAuthAccessTokenExpiration,
      expiration.toIso8601String(),
    );
  }

  @override
  FutureOr<bool> deleteAccessTokenExpiration() async {
    final prefs = await _prefs;
    return await prefs.remove(_keyOAuthAccessTokenExpiration);
  }

  @override
  FutureOr<String?> getRefreshToken() async {
    final prefs = await _prefs;
    return prefs.getString(_keyOAuthRefreshToken);
  }

  @override
  FutureOr<bool> setRefreshToken(String? refreshToken) async {
    final prefs = await _prefs;
    return await prefs.setString(_keyOAuthRefreshToken, refreshToken!);
  }

  @override
  FutureOr<bool> deleteRefreshToken() async {
    final prefs = await _prefs;
    return prefs.remove(_keyOAuthRefreshToken);
  }

  @override
  FutureOr<DateTime?> getRefreshTokenExpiration() async {
    final prefs = await _prefs;
    final String? tmp = prefs.getString(_keyOAuthRefreshTokenExpiration);
    return tmp != null ? DateTime.parse(tmp) : null;
  }

  @override
  FutureOr<bool> setRefreshTokenExpiration(DateTime expiration) async {
    final prefs = await _prefs;
    return await prefs.setString(
      _keyOAuthRefreshTokenExpiration,
      expiration.toIso8601String(),
    );
  }

  @override
  FutureOr<bool> deleteRefreshTokenExpiration() async {
    final prefs = await _prefs;
    return await prefs.remove(_keyOAuthRefreshTokenExpiration);
  }

  /// ----------------------------------------------------------
  /// -------------------------- All ---------------------------
  /// ----------------------------------------------------------

  FutureOr<bool> deleteAll() async {
    return await deleteAccessToken() &
        await deleteAccessTokenExpiration() &
        await deleteRefreshToken() &
        await deleteRefreshTokenExpiration();
  }
}
