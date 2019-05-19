import 'package:meta/meta.dart';
import 'package:social_cv_client_dart_common/repositories.dart';
import 'package:social_cv_client_flutter/src/data/managers/config_assets_manager.dart';

class LocalConfigRepository implements ConfigRepository {
  final ConfigAssetsManager configAssetsManager;

  LocalConfigRepository({@required this.configAssetsManager})
      : assert(
          configAssetsManager != null,
          'No $LocalConfigRepository given',
        );

  @override
  Future<String> getApiServerUrl() async {
    return await configAssetsManager.getApiServerUrl();
  }

  @override
  Future<String> getClientId() async {
    return await configAssetsManager.getClientId();
  }

  @override
  Future<String> getClientSecret() async {
    return await configAssetsManager.getClientSecret();
  }
}
