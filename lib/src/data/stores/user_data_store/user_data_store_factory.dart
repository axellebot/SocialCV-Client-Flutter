import 'package:social_cv_client_flutter/data.dart';

class UserDataStoreFactory {
  final UserDataStore cloudDataStore;
  final UserDataStore memoryDataStore;

  UserDataStoreFactory({
    required this.cloudDataStore,
    required this.memoryDataStore,
  });

  UserDataStore get create => cloudDataStore;

  @override
  String toString() => '$runtimeType{ '
      'memoryDataStore: $memoryDataStore, '
      'cloudDataStore: $cloudDataStore'
      ' }';
}
