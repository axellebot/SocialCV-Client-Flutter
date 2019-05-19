import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:social_cv_client_flutter/src/data/models/config_model.dart';

/// From https://medium.com/@sokrato/storing-your-secret-keys-in-flutter-c0b9af1c0f69
class ConfigAssetsManager {
  static const _configPath = 'config.json';
  ConfigDataModel _config;

  ConfigAssetsManager();

  Future<void> _load() async {
    await rootBundle.loadStructuredData<String>(
      _configPath,
      (jsonStr) {
        Map<String, dynamic> jsonMap = json.decode(jsonStr);
        _config = ConfigDataModel.fromJson(jsonMap);
      },
    );
  }

  Future<String> getApiServerUrl() async {
    if (_config == null) await _load();
    return Future.value(_config.apiServerUrl);
  }

  Future<String> getClientId() async {
    if (_config == null) await _load();
    return Future.value(_config.clientId);
  }

  Future<String> getClientSecret() async {
    if (_config == null) await _load();
    return Future.value(_config.clientSecret);
  }
}
