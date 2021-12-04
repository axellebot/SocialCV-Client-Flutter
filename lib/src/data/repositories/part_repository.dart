import 'dart:async';

import 'package:social_cv_client_flutter/data.dart';
import 'package:social_cv_client_flutter/domain.dart';
import 'package:social_cv_client_flutter/presentation.dart';

class ImplPartRepository extends PartRepository {
  final String _tag = '$ImplPartRepository';

  final PartDataStoreFactory factory;

  ImplPartRepository({
    required this.factory,
  });

  @override
  FutureOr<PartEntity> getById(
    String id, {
    bool force = false,
  }) async {
    print('$_tag:getById($id)');

    PartDataModel? dataModel;

    if (!force) dataModel = await factory.memoryDataStore.getPart(id);

    if (dataModel == null) {
      dataModel = await factory.cloudDataStore.getPart(id);
      factory.memoryDataStore.setPart(dataModel!);
    }

    return dataModel;
  }

  @override
  FutureOr<List<PartEntity>> getList({
    /// TODO: Add filters
    /// TODO: Add sort
    Cursor cursor = const Cursor(),
  }) async {
    print('$_tag:getList');

    final dataModels = await factory.cloudDataStore.getParts(
      cursor: cursor,
    );

    // Store in RAM
    dataModels.map(factory.memoryDataStore.setPart);

    return dataModels;
  }

  @override
  FutureOr<List<PartEntity>> getPartsFromProfile(
    String profileId, {

    /// TODO: Add filters
    /// TODO: Add sort
    Cursor cursor = const Cursor(),
  }) async {
    print('$_tag:getPartsFromProfile');

    final dataModels = await factory.cloudDataStore.getPartsFromProfile(
      profileId,
      cursor: cursor,
    );

    // Store in RAM
    dataModels.map(factory.memoryDataStore.setPart);

    return dataModels;
  }

  @override
  FutureOr<List<PartEntity>> getPartsFromUser(
    String userId, {
    Cursor cursor = const Cursor(),
  }) async {
    print('$_tag:getPartsFromUser');

    final dataModels = await factory.cloudDataStore.getPartsFromUser(
      userId,
      cursor: cursor,
    );

    // Store in RAM
    dataModels.map(factory.memoryDataStore.setPart);

    return dataModels;
  }

  @override
  String toString() => '$runtimeType{ '
      'factory: $factory'
      ' }';
}
