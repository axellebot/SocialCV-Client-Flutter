import 'package:social_cv_client_flutter/data.dart';

class GroupDataStoreFactory {
  final GroupDataStore cloudDataStore;
  final GroupDataStore memoryDataStore;

  GroupDataStoreFactory({
    required this.cloudDataStore,
    required this.memoryDataStore,
  });

  GroupDataStore get create => cloudDataStore;

  @override
  String toString() => '$runtimeType{ '
      'memoryDataStore: $memoryDataStore, '
      'cloudDataStore: $cloudDataStore'
      ' }';
}
