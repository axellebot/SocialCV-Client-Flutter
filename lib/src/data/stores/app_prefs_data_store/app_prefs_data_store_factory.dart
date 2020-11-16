import 'package:meta/meta.dart';
import 'package:social_cv_client_flutter/data.dart';

class AppPrefsDataStoreFactory {
  final String _tag = '$AppPrefsDataStoreFactory';

  final AppPrefsDataStore diskDataStore;

  AppPrefsDataStore get create => diskDataStore;

  AppPrefsDataStoreFactory({@required this.diskDataStore})
      : assert(diskDataStore != null, 'No disk $AppPrefsDataStore given');

  @override
  String toString() => '$runtimeType{ '
      'diskDataStore: $diskDataStore'
      ' }';
}
