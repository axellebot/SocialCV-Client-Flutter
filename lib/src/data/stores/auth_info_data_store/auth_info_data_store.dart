import 'dart:async';

abstract class AuthInfoDataStore {
  /// --------------------------------------------------------------------------
  ///                             Access Token
  /// --------------------------------------------------------------------------

  /// Set access token ([String])
  FutureOr<bool> setAccessToken(String accessToken);

  /// Get access token
  ///
  /// Must return a access token ([String]) or [null] otherwise
  FutureOr<String?> getAccessToken();

  /// Delete access token
  FutureOr<bool> deleteAccessToken();

  /// Set access token expiration datetime as([DateTime])
  FutureOr<bool> setAccessTokenExpiration(DateTime expiration);

  /// Get access token expiration time
  ///
  /// Must return the access token expiration datetime ([DateTime])
  /// or [null] otherwise
  FutureOr<DateTime?> getAccessTokenExpiration();

  /// Delete access token expiration datetime
  FutureOr<bool> deleteAccessTokenExpiration();

  /// --------------------------------------------------------------------------
  ///                             Refresh Token
  /// --------------------------------------------------------------------------

  /// Set refresh token ([String])
  FutureOr<bool> setRefreshToken(String? token);

  /// Get refresh token
  ///
  /// Must return a refresh token ([String]) or [null] otherwise
  FutureOr<String?> getRefreshToken();

  /// Delete refresh token
  FutureOr<bool> deleteRefreshToken();

  /// Set refresh token expiration datetime as timestamp ([int])
  FutureOr<bool> setRefreshTokenExpiration(DateTime expiration);

  /// Get refresh token expiration datetime
  ///
  /// Must return the access token expiration datetime ([DateTime])
  /// or [null] otherwise
  FutureOr<DateTime?> getRefreshTokenExpiration();

  /// Delete refresh token expiration date
  FutureOr<bool> deleteRefreshTokenExpiration();

  /// --------------------------------------------------------------------------
  ///                                Misc
  /// --------------------------------------------------------------------------

  @override
  String toString() => '$runtimeType{}';
}
