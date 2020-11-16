import 'dart:async';

import 'package:meta/meta.dart';
import 'package:social_cv_client_flutter/data.dart';
import 'package:social_cv_client_flutter/domain.dart';
import 'package:social_cv_client_flutter/presentation.dart';

class ImplUserRepository extends UserRepository {
  final String _tag = '$ImplUserRepository';

  final UserDataStoreFactory factory;

  ImplUserRepository({@required this.factory}) : assert(factory != null);

  @override
  FutureOr<UserEntity> getById(
    String id, {
    bool force = false,
  }) async {
    assert(id != null);
    print('$_tag:getUser($id)');

    UserDataModel dataModel;

    if (!force) dataModel = await factory.memoryDataStore.getUser(id);

    if (dataModel == null) {
      dataModel = await factory.cloudDataStore.getUser(id);
      factory.memoryDataStore.setUser(dataModel);
    }

    return dataModel;
  }

  @override
  FutureOr<List<UserEntity>> getList({
    /// TODO: Add filters
    /// TODO: Add sort
    Cursor cursor = const Cursor(),
  }) async {
    print('$_tag:getUsers');

    final dataModels = await factory.cloudDataStore.getUsers(
      cursor: cursor,
    );

    // Store in RAM
    dataModels.map(factory.memoryDataStore.setUser);

    return dataModels;
  }

  @override
  String toString() => '$runtimeType{ '
      'factory: $factory'
      ' }';
}
