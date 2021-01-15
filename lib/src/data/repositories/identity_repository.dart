import 'dart:async';

import 'package:meta/meta.dart';
import 'package:social_cv_client_flutter/data.dart';
import 'package:social_cv_client_flutter/domain.dart';

class ImplIdentityRepository extends IdentityRepository {
  final String _tag = '$ImplIdentityRepository';

  final IdentityDataStoreFactory factory;

  ImplIdentityRepository({@required this.factory}) : assert(factory != null);

  @override
  FutureOr<UserEntity> getIdentity() async {
    print('$_tag:getAccount');

    final dataModel = await factory.memoryDataStore.getIdentity();

    if (dataModel == null) {
      final dataModel = await factory.cloudDataStore.getIdentity();
      factory.memoryDataStore.setIdentity(dataModel);
    }

    return dataModel;
  }

//  @override
//  FutureOr<List<ProfileEntity>> getProfilesFromIdentity({
//    /// TODO: Add filters
//    /// TODO: Add sort
//    Cursor cursor = const Cursor(),
//  }) async {
//    print('$_tag:getProfilesFromIdentity');
//
//    final dataModels = await factory.cloudDataStore.getProfilesFromIdentity(
//      cursor: cursor,
//    );
//
//    return dataModels;
//  }

  @override
  String toString() => '$runtimeType{ '
      'factory: $factory'
      ' }';
}
