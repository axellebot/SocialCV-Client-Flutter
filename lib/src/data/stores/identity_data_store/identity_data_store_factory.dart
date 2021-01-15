import 'package:meta/meta.dart';
import 'package:social_cv_client_flutter/data.dart';

class IdentityDataStoreFactory {
  final String _tag = '$IdentityDataStoreFactory';

  final IdentityDataStore memoryDataStore;
  final IdentityDataStore cloudDataStore;

  IdentityDataStoreFactory(
      {@required this.memoryDataStore, @required this.cloudDataStore})
      : assert(memoryDataStore != null, ' No memory $IdentityDataStore given'),
        assert(cloudDataStore != null, ' No cloud $IdentityDataStore given');

  IdentityDataStore get create => memoryDataStore;

  @override
  String toString() => '$runtimeType{ '
      'memoryDataStore: $memoryDataStore, '
      'cloudDataStore: $cloudDataStore'
      ' }';
}
