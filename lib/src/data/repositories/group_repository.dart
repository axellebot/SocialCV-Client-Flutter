import 'dart:async';

import 'package:social_cv_client_flutter/data.dart';
import 'package:social_cv_client_flutter/domain.dart';
import 'package:social_cv_client_flutter/presentation.dart';

class ImplGroupRepository extends GroupRepository {
  final String _tag = '$ImplGroupRepository';

  final GroupDataStoreFactory factory;

  ImplGroupRepository({required this.factory});

  @override
  FutureOr<GroupEntity> getById(
    String id, {
    bool force = false,
  }) async {
    print('$_tag:getById($id)');

    GroupDataModel? dataModel;

    if (!force) dataModel = await factory.memoryDataStore.getGroup(id);

    if (dataModel == null) {
      dataModel = await factory.cloudDataStore.getGroup(id);
      await factory.memoryDataStore.setGroup(dataModel!);
    }

    return dataModel;
  }

  @override
  FutureOr<List<GroupEntity>> getList({
    /// TODO: Add filters
    /// TODO: Add sort
    Cursor cursor = const Cursor(),
  }) async {
    print('$_tag:getList');

    final dataModels = await factory.cloudDataStore.getGroups(
      cursor: cursor,
    );

    // Store in RAM
    dataModels.map(factory.memoryDataStore.setGroup);

    return dataModels;
  }

  @override
  FutureOr<List<GroupEntity>> getGroupsFromPart(
    String partId, {

    /// TODO: Add filters
    /// TODO: Add sort
    Cursor cursor = const Cursor(),
  }) async {
    print('$_tag:getGroupsFromPart($partId)');

    final dataModels = await factory.cloudDataStore.getGroupsFromPart(
      partId,
      cursor: cursor,
    );

    // Store in RAM
    dataModels.map(factory.memoryDataStore.setGroup);

    return dataModels;
  }

  @override
  FutureOr<List<GroupEntity>> getGroupsFromUser(
    String userId, {

    /// TODO: Add filters
    /// TODO: Add sort
    Cursor cursor = const Cursor(),
  }) async {
    print('$_tag:getGroupsFromUser($userId)');

    final dataModels = await factory.cloudDataStore.getGroupsFromUser(
      userId,
      cursor: cursor,
    );

    // Store in RAM
    dataModels.map(factory.memoryDataStore.setGroup);

    return dataModels;
  }

  @override
  String toString() => '$runtimeType{ '
      'factory: $factory'
      ' }';
}
