import 'dart:async';

import 'package:social_cv_client_flutter/data.dart';
import 'package:social_cv_client_flutter/domain.dart';
import 'package:social_cv_client_flutter/presentation.dart';

/// Memory implementation of [PartDataStore]
class MemoryPartDataStore implements PartDataStore {
  final String _tag = '$MemoryPartDataStore';

  MemoryPartDataStore();

  final Map<String?, CacheModel<PartDataModel>> _parts =
      <String, CacheModel<PartDataModel>>{};

  @override
  FutureOr<PartDataModel?> getPart(String partId) async {
    print('$_tag:getPart($partId)');

    final CacheModel<PartDataModel>? cacheModel = _parts[partId];

    return cacheModel?.model;
  }

  @override
  FutureOr<PartDataModel> setPart(PartDataModel partModel) async {
    print('$_tag:setPart($partModel)');

    final DateTime expiration = defaultExpirationDateTime;
    final cacheModel =
        CacheModel<PartDataModel>(model: partModel, expiration: expiration);
    _parts[partModel.id] = cacheModel;

    return cacheModel.model;
  }

  @override
  FutureOr<List<PartDataModel>> getParts({
    Cursor cursor = const Cursor(),
  }) {
    return _parts.values.map((value) => value.model).toList();
  }

  @override
  FutureOr<List<PartDataModel>> getPartsFromProfile(
    String? profileId, {
    Cursor cursor = const Cursor(),
  }) {
    // TODO: implement getPartsFromProfile
    throw NotImplementedYetError();
  }

  @override
  FutureOr<List<PartDataModel>> getPartsFromUser(
    String? userId, {
    Cursor cursor = const Cursor(),
  }) {
    return _parts.values
        .map((e) => e.model)
        .where((model) => model.ownerId == userId)
        .toList();
  }

  @override
  String toString() => '$runtimeType{}';
}
