import 'package:social_cv_client_flutter/data.dart';

class AuthInfoDataStoreFactory {
  final String _tag = '$AuthInfoDataStoreFactory';

  final AuthInfoDataStore diskDataStore;

  AuthInfoDataStore get create => diskDataStore;

  AuthInfoDataStoreFactory({required this.diskDataStore});

  @override
  String toString() => '$runtimeType{ '
      'diskDataStore: $diskDataStore'
      ' }';
}
