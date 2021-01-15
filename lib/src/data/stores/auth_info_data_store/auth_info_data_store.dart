import 'dart:async';

abstract class AuthInfoDataStore {
  /// --------------------------------------------------------------------------
  ///                             Access Token
  /// --------------------------------------------------------------------------

  /// Set access token ([String])
  FutureOr<String> setAccessToken(String accessToken);

  /// Get access token
  ///
  /// Must return a access token ([String]) or [null] otherwise
  FutureOr<String> getAccessToken();

  /// Delete access token
  FutureOr<String> deleteAccessToken();

  /// Set access token expiration datetime as([DateTime])
  FutureOr<DateTime> setAccessTokenExpiration(DateTime expiration);

  /// Get access token expiration time
  ///
  /// Must return the access token expiration datetime ([DateTime])
  /// or [null] otherwise
  FutureOr<DateTime> getAccessTokenExpiration();

  /// Delete access token expiration datetime
  FutureOr<DateTime> deleteAccessTokenExpiration();

  /// --------------------------------------------------------------------------
  ///                             Refresh Token
  /// --------------------------------------------------------------------------

  /// Set refresh token ([String])
  FutureOr<String> setRefreshToken(String token);

  /// Get refresh token
  ///
  /// Must return a refresh token ([String]) or [null] otherwise
  FutureOr<String> getRefreshToken();

  /// Delete refresh token
  FutureOr<String> deleteRefreshToken();

  /// Set refresh token expiration datetime as timestamp ([int])
  FutureOr<DateTime> setRefreshTokenExpiration(DateTime expiration);

  /// Get refresh token expiration datetime
  ///
  /// Must return the access token expiration datetime ([DateTime])
  /// or [null] otherwise
  FutureOr<DateTime> getRefreshTokenExpiration();

  /// Delete refresh token expiration date
  FutureOr<DateTime> deleteRefreshTokenExpiration();

  /// --------------------------------------------------------------------------
  ///                                Misc
  /// --------------------------------------------------------------------------

  @override
  String toString() => '$runtimeType{}';
}
