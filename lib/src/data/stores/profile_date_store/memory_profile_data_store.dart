import 'dart:async';

import 'package:social_cv_client_flutter/data.dart';
import 'package:social_cv_client_flutter/presentation.dart';

/// Memory implementation of [ProfileDataStore]
class MemoryProfileDataStore implements ProfileDataStore {
  final String _tag = '$MemoryProfileDataStore';

  MemoryProfileDataStore();

  final _profiles = <String, CacheModel<ProfileDataModel>>{};

  @override
  FutureOr<ProfileDataModel> getProfile(String profileId) async {
    print('$_tag:getProfile($profileId)');

    final CacheModel<ProfileDataModel> cacheModel = _profiles[profileId];
    return (cacheModel != null && !cacheModel.isExpired())
        ? cacheModel.model
        : null;
  }

  @override
  FutureOr<ProfileDataModel> setProfile(ProfileDataModel profileModel) async {
    print('$_tag:setProfile($profileModel)');

    final DateTime expiration =
        generateExpirationDateTime(Duration(minutes: 1));
    final cacheModel = CacheModel<ProfileDataModel>(
        model: profileModel, expiration: expiration);
    _profiles[profileModel.id] = cacheModel;

    return cacheModel.model;
  }

  @override
  FutureOr<List<ProfileDataModel>> getProfiles({
    Cursor cursor = const Cursor(),
  }) {
    return _profiles.values.map((value) => value.model).toList();
  }

  @override
  FutureOr<List<ProfileDataModel>> getProfilesFromUser(
    String userId, {
    Cursor cursor = const Cursor(),
  }) {
    return _profiles.values
        .map((value) => value.model)
        .where((model) => model.ownerId == userId)
        .toList();
  }

  @override
  String toString() => '$runtimeType{}';
}
