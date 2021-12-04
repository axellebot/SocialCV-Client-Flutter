import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:social_cv_client_flutter/domain.dart';
import 'package:social_cv_client_flutter/src/data/models/config_model.dart';

/// From https://medium.com/@sokrato/storing-your-secret-keys-in-flutter-c0b9af1c0f69
class ConfigAssetsManager implements FoundationConfigService {
  static const _configPath = 'config.json';
  ConfigDataModel? _config;

  ConfigAssetsManager();

  FutureOr<void> _load() async {
    final jsonMap = await rootBundle.loadStructuredData<Map<String, dynamic>>(
      _configPath,
      (jsonStr) {
        return Future.value(json.decode(jsonStr) as Map<String, dynamic>?);
      },
    );
    _config = ConfigDataModel.fromJson(jsonMap);
  }

  @override
  FutureOr<String> getApiServerUrl() async {
    if (_config == null) await _load();
    return Future.value(_config!.apiServerUrl);
  }

  @override
  FutureOr<String> getClientId() async {
    if (_config == null) await _load();
    return Future.value(_config!.clientId);
  }

  @override
  FutureOr<String> getClientSecret() async {
    if (_config == null) await _load();
    return Future.value(_config!.clientSecret);
  }
}
