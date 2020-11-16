import 'package:meta/meta.dart';
import 'package:social_cv_client_flutter/data.dart';

class PartDataStoreFactory {
  final PartDataStore cloudDataStore;
  final PartDataStore memoryDataStore;

  PartDataStoreFactory({
    @required this.cloudDataStore,
    @required this.memoryDataStore,
  })  : assert(cloudDataStore != null, 'No cloud $PartDataStore given'),
        assert(memoryDataStore != null, 'No memory $PartDataStore given');

  PartDataStore get create => cloudDataStore;

  @override
  String toString() => '$runtimeType{ '
      'memoryDataStore: $memoryDataStore, '
      'cloudDataStore: $cloudDataStore'
      ' }';
}
