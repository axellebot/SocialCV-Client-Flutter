import 'dart:async';

/// Repository interface for authentication info purpose
abstract class AuthInfoRepository {
  /// --------------------------------------------------------------------------
  ///                             Access Token
  /// --------------------------------------------------------------------------

  /// Set access token ([String])
  FutureOr<bool> setAccessToken(String token);

  /// Get access token
  ///
  /// Must return a access token ([String]) or [null] otherwise
  FutureOr<String?> getAccessToken();

  /// Delete access token
  FutureOr<bool> deleteAccessToken();

  /// Set access token expiration datetime as timestamp ([DateTime])
  FutureOr<bool> setAccessTokenExpiration(DateTime expiration);

  /// Get access token expiration time
  ///
  /// Must return the access token expiration datetime as timestamp ([int])
  /// or [null] otherwise
  FutureOr<DateTime?> getAccessTokenExpiration();

  /// Delete access token expiration datetime
  FutureOr<bool> deleteAccessTokenExpiration();

  /// --------------------------------------------------------------------------
  ///                             Refresh Token
  /// --------------------------------------------------------------------------

  /// Set refresh token ([String])
  FutureOr<bool> setRefreshToken(String token);

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
}
