import 'package:meta/meta.dart';
import 'package:social_cv_client_flutter/data.dart';

class AuthInfoDataStoreFactory {
  final String _tag = '$AuthInfoDataStoreFactory';

  final AuthInfoDataStore diskDataStore;

  AuthInfoDataStore get create => diskDataStore;

  AuthInfoDataStoreFactory({@required this.diskDataStore})
      : assert(diskDataStore != null, 'No disk $AuthInfoDataStore given');

  @override
  String toString() => '$runtimeType{ '
      'diskDataStore: $diskDataStore'
      ' }';
}
