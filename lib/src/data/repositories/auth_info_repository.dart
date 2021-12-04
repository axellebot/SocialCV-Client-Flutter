import 'dart:async';

import 'package:social_cv_client_flutter/data.dart';
import 'package:social_cv_client_flutter/domain.dart';

class ImplAuthInfoRepository implements AuthInfoRepository {
  final AuthInfoDataStoreFactory factory;

  ImplAuthInfoRepository({required this.factory});

  /// --------------------------------------------------------------------------
  ///                             Access Token
  /// --------------------------------------------------------------------------

  @override
  FutureOr<bool> setAccessToken(String token) async {
    return await factory.diskDataStore.setAccessToken(token);
  }

  @override
  FutureOr<String?> getAccessToken() async {
    return await factory.diskDataStore.getAccessToken();
  }

  @override
  FutureOr<bool> deleteAccessToken() async {
    return await factory.diskDataStore.deleteAccessToken();
  }

  @override
  FutureOr<bool> setAccessTokenExpiration(DateTime expiration) async {
    return await factory.diskDataStore.setAccessTokenExpiration(expiration);
  }

  @override
  FutureOr<DateTime?> getAccessTokenExpiration() async {
    return await factory.diskDataStore.getAccessTokenExpiration();
  }

  @override
  FutureOr<bool> deleteAccessTokenExpiration() async {
    return await factory.diskDataStore.deleteAccessTokenExpiration();
  }

  /// --------------------------------------------------------------------------
  ///                             Refresh Token
  /// --------------------------------------------------------------------------

  @override
  FutureOr<bool> setRefreshToken(String token) async {
    return await factory.diskDataStore.setRefreshToken(token);
  }

  @override
  FutureOr<String?> getRefreshToken() async {
    return await factory.diskDataStore.getRefreshToken();
  }

  @override
  FutureOr<bool> deleteRefreshToken() async {
    return await factory.diskDataStore.deleteRefreshToken();
  }

  @override
  FutureOr<DateTime?> getRefreshTokenExpiration() async {
    return await factory.diskDataStore.getRefreshTokenExpiration();
  }

  @override
  FutureOr<bool> setRefreshTokenExpiration(DateTime expiration) async {
    return await factory.diskDataStore.setRefreshTokenExpiration(expiration);
  }

  @override
  FutureOr<bool> deleteRefreshTokenExpiration() async {
    return await factory.diskDataStore.deleteRefreshTokenExpiration();
  }
}
