import 'package:meta/meta.dart';
import 'package:social_cv_client_dart_common/repositories.dart';
import 'package:social_cv_client_flutter/src/data/managers/auth_shared_preferences_manager.dart';

class LocalAuthPreferencesRepository implements AuthPreferencesRepository {
  final AuthSharedPreferencesManager authSharedPreferencesManager;

  LocalAuthPreferencesRepository({@required this.authSharedPreferencesManager})
      : assert(
          authSharedPreferencesManager != null,
          'No $AuthSharedPreferencesManager given',
        );

  @override
  Future<void> deleteAccessToken() async {
    return await authSharedPreferencesManager.deleteAccessToken();
  }

  @override
  Future<void> deleteAccessTokenExpiration() async {
    return await authSharedPreferencesManager.deleteAccessTokenExpiration();
  }

  @override
  Future<void> deleteRefreshToken() async {
    return await authSharedPreferencesManager.deleteRefreshToken();
  }

  @override
  Future<void> deleteRefreshTokenExpiration() async {
    return await authSharedPreferencesManager.deleteRefreshTokenExpiration();
  }

  @override
  Future<String> getAccessToken() async {
    return await authSharedPreferencesManager.getAccessToken();
  }

  @override
  Future<int> getAccessTokenExpiration() async {
    return await authSharedPreferencesManager.getAccessTokenExpiration();
  }

  @override
  Future<String> getRefreshToken() async {
    return await authSharedPreferencesManager.getRefreshToken();
  }

  @override
  Future<String> getRefreshTokenExpiration() async {
    return await authSharedPreferencesManager.getRefreshTokenExpiration();
  }

  @override
  Future<void> setAccessToken(String accessToken) async {
    return await authSharedPreferencesManager.setAccessToken(accessToken);
  }

  @override
  Future<void> setAccessTokenExpiration(int accessTokenExpiration) async {
    return await authSharedPreferencesManager
        .setAccessTokenExpiration(accessTokenExpiration);
  }

  @override
  Future<void> setRefreshToken(String refreshToken) async {
    return await authSharedPreferencesManager.setRefreshToken(refreshToken);
  }

  @override
  Future<void> setRefreshTokenExpiration(int refreshTokenExpiration) async {
    return await authSharedPreferencesManager
        .setRefreshTokenExpiration(refreshTokenExpiration);
  }

  @override
  Future deleteAll() async {
    return await authSharedPreferencesManager.deleteAll();
  }
}
