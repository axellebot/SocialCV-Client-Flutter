import 'dart:async';

import 'package:meta/meta.dart';
import 'package:social_cv_client_flutter/data.dart';
import 'package:social_cv_client_flutter/domain.dart';

class ImplAuthInfoRepository implements AuthInfoRepository {
  final AuthInfoDataStoreFactory factory;

  ImplAuthInfoRepository({@required this.factory})
      : assert(factory != null, 'No $AuthInfoDataStoreFactory given');

  /// --------------------------------------------------------------------------
  ///                             Access Token
  /// --------------------------------------------------------------------------

  @override
  FutureOr<String> getAccessToken() {
    return factory.diskDataStore.getAccessToken();
  }

  @override
  FutureOr<void> setAccessToken(String token) {
    return factory.diskDataStore.setAccessToken(token);
  }

  @override
  FutureOr<void> deleteAccessToken() {
    return factory.diskDataStore.deleteAccessToken();
  }

  @override
  FutureOr<DateTime> getAccessTokenExpiration() {
    return factory.diskDataStore.getAccessTokenExpiration();
  }

  @override
  FutureOr<void> setAccessTokenExpiration(DateTime expiration) {
    return factory.diskDataStore.setAccessTokenExpiration(expiration);
  }

  @override
  FutureOr<void> deleteAccessTokenExpiration() {
    return factory.diskDataStore.deleteAccessTokenExpiration();
  }

  /// --------------------------------------------------------------------------
  ///                             Refresh Token
  /// --------------------------------------------------------------------------

  @override
  FutureOr<String> getRefreshToken() {
    return factory.diskDataStore.getRefreshToken();
  }

  @override
  FutureOr<void> setRefreshToken(String token) {
    return factory.diskDataStore.setRefreshToken(token);
  }

  @override
  FutureOr<void> deleteRefreshToken() {
    return factory.diskDataStore.deleteRefreshToken();
  }

  @override
  FutureOr<DateTime> getRefreshTokenExpiration() {
    return factory.diskDataStore.getRefreshTokenExpiration();
  }

  @override
  FutureOr<void> setRefreshTokenExpiration(DateTime expiration) {
    return factory.diskDataStore.setRefreshTokenExpiration(expiration);
  }

  @override
  FutureOr<void> deleteRefreshTokenExpiration() {
    return factory.diskDataStore.deleteRefreshTokenExpiration();
  }
}
