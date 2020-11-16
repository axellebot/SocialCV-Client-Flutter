import 'package:meta/meta.dart';
import 'package:social_cv_client_flutter/data.dart';

class EntryDataStoreFactory {
  final String _tag = '$EntryDataStoreFactory';

  final EntryDataStore cloudDataStore;
  final EntryDataStore memoryDataStore;

  EntryDataStore get create => cloudDataStore;

  EntryDataStoreFactory({
    @required this.cloudDataStore,
    @required this.memoryDataStore,
  })  : assert(cloudDataStore != null, 'No cloud $EntryDataStore given'),
        assert(memoryDataStore != null, 'No memory $EntryDataStore given');

  @override
  String toString() => '$runtimeType{ '
      'memoryDataStore: $memoryDataStore, '
      'cloudDataStore: $cloudDataStore'
      ' }';
}
