import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:social_cv_client_dart_common/models.dart';
import 'package:social_cv_client_dart_common/repositories.dart';

/// From https://medium.com/@sokrato/storing-your-secret-keys-in-flutter-c0b9af1c0f69
class AssetConfigManager implements ConfigRepository {
  static const _configPath = 'config.json';

  ConfigDataModel _config;

  Future<void> _load() async {
    await rootBundle.loadStructuredData<String>(
      _configPath,
      (jsonStr) {
        Map<String, dynamic> jsonMap = json.decode(jsonStr);
        _config = ConfigDataModel.fromJson(jsonMap);
      },
    );
  }

  @override
  Future<String> getApiServerUrl() async {
    if (_config == null) await _load();
    return Future.value(_config.apiServerUrl);
  }

  @override
  Future<String> getClientId() async {
    if (_config == null) await _load();
    return Future.value(_config.clientId);
  }

  @override
  Future<String> getClientSecret() async {
    if (_config == null) await _load();
    return Future.value(_config.clientSecret);
  }
}
