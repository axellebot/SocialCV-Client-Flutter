import 'dart:async';

import 'package:social_cv_client_flutter/data.dart';

/// Memory implementation of [IdentityDataStore]
class MemoryIdentityDataStore implements IdentityDataStore {
  final String _tag = '$MemoryIdentityDataStore';

  MemoryIdentityDataStore();

  CacheModel<UserDataModel> _accountCache;

  @override
  FutureOr<UserDataModel> getIdentity() async {
    print('$_tag:getAccount()');

    return (_accountCache != null && !_accountCache.isExpired())
        ? _accountCache.model
        : null;
  }

  @override
  FutureOr<UserDataModel> setIdentity(UserDataModel userModel) async {
    print('$_tag:setAccount($userModel)');

    final DateTime expiration =
        generateExpirationDateTime(Duration(minutes: 1));
    _accountCache =
        CacheModel<UserDataModel>(model: userModel, expiration: expiration);

    return _accountCache.model;
  }

  @override
  String toString() => '$runtimeType{}';
}
