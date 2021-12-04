import 'dart:async';

import 'package:social_cv_client_flutter/data.dart';
import 'package:social_cv_client_flutter/presentation.dart';

abstract class GroupDataStore {
  FutureOr<GroupDataModel?> getGroup(String groupId);

  FutureOr<GroupDataModel> setGroup(GroupDataModel groupModel);

  FutureOr<List<GroupDataModel>> getGroups({
    /// TODO: Add filters
    /// TODO: Add sort
    Cursor cursor = const Cursor(),
  });

  FutureOr<List<GroupDataModel>> getGroupsFromPart(
    String partId, {

    /// TODO: Add filters
    /// TODO: Add sort
    Cursor cursor = const Cursor(),
  });

  FutureOr<List<GroupDataModel>> getGroupsFromUser(
    String userId, {

    /// TODO: Add filters
    /// TODO: Add sort
    Cursor cursor = const Cursor(),
  });
}
