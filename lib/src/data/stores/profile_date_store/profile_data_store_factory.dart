import 'package:meta/meta.dart';
import 'package:social_cv_client_flutter/data.dart';

class ProfileDataStoreFactory {
  final ProfileDataStore cloudDataStore;
  final ProfileDataStore memoryDataStore;

  ProfileDataStoreFactory({
    @required this.cloudDataStore,
    @required this.memoryDataStore,
  })  : assert(cloudDataStore != null, 'No cloud $ProfileDataStore given'),
        assert(memoryDataStore != null, 'No memory $ProfileDataStore given');

  ProfileDataStore get create => cloudDataStore;

  @override
  String toString() => '$runtimeType{ '
      'memoryDataStore: $memoryDataStore, '
      'cloudDataStore: $cloudDataStore'
      ' }';
}
