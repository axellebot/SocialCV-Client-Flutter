import 'dart:async' show Future;
import 'dart:convert' show json;

import 'package:flutter/services.dart';
import 'package:social_cv_client_dart_common/repositories.dart';

/// From https://medium.com/@sokrato/storing-your-secret-keys-in-flutter-c0b9af1c0f69

class LocalConfigManager implements ConfigRepository {
  static const secretPath = 'config.json';

  String _apiServerUrl;
  String _clientId;
  String _clientSecret;

  LocalConfigManager() {
    rootBundle.loadStructuredData<String>(
      secretPath,
      (jsonStr) {
        Map<String, dynamic> jsonMap = json.decode(jsonStr);
        _apiServerUrl = jsonMap["serverUrl"];
        _clientId = jsonMap["clientId"];
        _clientSecret = jsonMap["clientSecret"];
      },
    );
  }

  @override
  Future<String> getApiServerUrl() => Future.value(_apiServerUrl);

  @override
  Future<String> getClientId() => Future.value(_clientId);

  @override
  Future<String> getClientSecret() => Future.value(_clientSecret);
}
