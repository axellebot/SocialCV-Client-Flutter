import 'dart:async';

abstract class FoundationConfigService {
  /// Get Api server url ([String])
  FutureOr<String> getApiServerUrl();

  /// Get client id ([String])
  FutureOr<String> getClientId();

  /// Get client secret ([String])
  FutureOr<String> getClientSecret();
}
