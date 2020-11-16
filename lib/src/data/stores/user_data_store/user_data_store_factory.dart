import 'package:meta/meta.dart';
import 'package:social_cv_client_flutter/data.dart';

class UserDataStoreFactory {
  final UserDataStore cloudDataStore;
  final UserDataStore memoryDataStore;

  UserDataStoreFactory({
    @required this.cloudDataStore,
    @required this.memoryDataStore,
  })  : assert(cloudDataStore != null, 'No cloud $UserDataStore given'),
        assert(memoryDataStore != null, 'No memory $UserDataStore given');

  UserDataStore get create => cloudDataStore;

  @override
  String toString() => '$runtimeType{ '
      'memoryDataStore: $memoryDataStore, '
      'cloudDataStore: $cloudDataStore'
      ' }';
}
