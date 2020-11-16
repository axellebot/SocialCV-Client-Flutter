import 'dart:async';

import 'package:social_cv_client_flutter/data.dart';
import 'package:social_cv_client_flutter/presentation.dart';

/// Memory implementation of [GroupDataStore]
class MemoryGroupDataStore implements GroupDataStore {
  final String _tag = '$MemoryGroupDataStore';

  MemoryGroupDataStore();

  final _groups = <String, CacheModel<GroupDataModel>>{};

  @override
  FutureOr<GroupDataModel> getGroup(String groupId) async {
    print('$_tag:getGroup($groupId)');

    final CacheModel<GroupDataModel> cacheModel = _groups[groupId];
    return (cacheModel != null && !cacheModel.isExpired())
        ? cacheModel.model
        : null;
  }

  @override
  FutureOr<GroupDataModel> setGroup(GroupDataModel groupModel) async {
    print('$_tag:setGroup($groupModel)');

    final DateTime expiration =
        generateExpirationDateTime(Duration(minutes: 1));
    final cacheModel =
        CacheModel<GroupDataModel>(model: groupModel, expiration: expiration);
    _groups[groupModel.id] = cacheModel;

    return cacheModel.model;
  }

  @override
  FutureOr<List<GroupDataModel>> getGroups({
    Cursor cursor = const Cursor(),
  }) {
    return _groups.values.map((value) => value.model).toList();
  }

  @override
  FutureOr<List<GroupDataModel>> getGroupsFromPart(
    String partId, {
    Cursor cursor = const Cursor(),
  }) {
    // TODO: implement getGroupsFromPart
    return null;
  }

  @override
  FutureOr<List<GroupDataModel>> getGroupsFromUser(
    String userId, {
    Cursor cursor = const Cursor(),
  }) {
    return _groups.values
        .map((e) => e.model)
        .where((model) => model.ownerId == userId)
        .toList();
  }

  @override
  String toString() => '$runtimeType{}';
}
