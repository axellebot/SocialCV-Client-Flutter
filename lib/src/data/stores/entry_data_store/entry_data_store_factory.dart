import 'package:social_cv_client_flutter/data.dart';

class EntryDataStoreFactory {
  final String _tag = '$EntryDataStoreFactory';

  final EntryDataStore cloudDataStore;
  final EntryDataStore memoryDataStore;

  EntryDataStore get create => cloudDataStore;

  EntryDataStoreFactory({
    required this.cloudDataStore,
    required this.memoryDataStore,
  });

  @override
  String toString() => '$runtimeType{ '
      'memoryDataStore: $memoryDataStore, '
      'cloudDataStore: $cloudDataStore'
      ' }';
}
