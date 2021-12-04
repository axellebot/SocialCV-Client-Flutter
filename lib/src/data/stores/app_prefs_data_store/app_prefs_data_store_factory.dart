import 'package:social_cv_client_flutter/data.dart';

class AppPrefsDataStoreFactory {
  final String _tag = '$AppPrefsDataStoreFactory';

  final AppPrefsDataStore diskDataStore;

  /// TODO: Add real factory when needed
  AppPrefsDataStore get create => diskDataStore;

  AppPrefsDataStoreFactory({
    required this.diskDataStore,
  });

  @override
  String toString() => '$runtimeType{ '
      'diskDataStore: $diskDataStore'
      ' }';
}
