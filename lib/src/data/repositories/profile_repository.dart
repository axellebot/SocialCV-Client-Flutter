import 'dart:async';

import 'package:social_cv_client_flutter/data.dart';
import 'package:social_cv_client_flutter/domain.dart';
import 'package:social_cv_client_flutter/presentation.dart';

class ImplProfileRepository extends ProfileRepository {
  final String _tag = '$ImplProfileRepository';

  final ProfileDataStoreFactory factory;

  ImplProfileRepository({
    required this.factory,
  });

  @override
  FutureOr<ProfileEntity> getById(
    String id, {
    bool force = false,
  }) async {
    print('$_tag:getById($id)');

    ProfileDataModel? dataModel;

    if (!force) dataModel = await factory.memoryDataStore.getProfile(id);

    if (dataModel == null) {
      dataModel = await factory.cloudDataStore.getProfile(id);
      factory.memoryDataStore.setProfile(dataModel!);
    }

    return dataModel;
  }

  @override
  FutureOr<List<ProfileEntity>> getList({
    /// TODO: Add filters
    /// TODO: Add sort
    Cursor cursor = const Cursor(),
  }) async {
    print('$_tag:getList');

    final dataModels = await factory.cloudDataStore.getProfiles(
      cursor: cursor,
    );

    // Store in RAM
    dataModels.map(factory.memoryDataStore.setProfile);

    return dataModels;
  }

  @override
  FutureOr<List<ProfileEntity>> getProfilesFromUser(
    String userId, {
    Cursor cursor = const Cursor(),
  }) async {
    print('$_tag:getProfilesFromUser($userId)');

    final dataModels = await factory.cloudDataStore.getProfilesFromUser(
      userId,
      cursor: cursor,
    );

    // Store in RAM
    dataModels.map(factory.memoryDataStore.setProfile);

    return dataModels;
  }

  @override
  String toString() => '$runtimeType{ '
      'factory: $factory'
      ' }';
}
