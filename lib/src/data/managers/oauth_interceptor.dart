import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';

class OAuthInterceptor extends Interceptor {
  String? _clientId;
  String? _clientSecret;
  String? _accessToken;
  String? _refreshToken;

  late final InterceptorsWrapper _interceptorWrapper;

  OAuthInterceptor({
    String? clientId,
    String? clientSecret,
    String? accessToken,
    String? refreshToken,
  }) {
    _clientId = clientId;
    _clientSecret = clientSecret;
    _accessToken = accessToken;
    _refreshToken = refreshToken;
  }

  @override
  FutureOr<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    // Adding client credentials
    if (_clientId != null && _clientSecret != null) {
      options.headers.addAll({
        'client_id': '$_clientId',
        'client_secret': '$_clientSecret',
        'grant_type': 'password',
      });
    }

    // Adding access token
    if (_accessToken != null) {
      options.headers
          .addAll({HttpHeaders.authorizationHeader: 'Bearer $_accessToken'});
    }

    // Adding refresh token
    if (_refreshToken != null) {
      options.headers.addAll({'refresh_token': '$_refreshToken'});
    }

    handler.next(options);
  }

  @override
  FutureOr<void> onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    /// Save access token
    final data = response.data;
    if (data is Map) {
      if (data.containsKey('access_token')) {
        _accessToken = data['access_token'] as String?;
      }

      /// Save refresh token
      if (data.containsKey('refresh_token')) {
        _refreshToken = response.data['refresh_token'] as String?;
      }
    }
    handler.next(response);
  }

  FutureOr<void> deleteAuthData() async {
    _accessToken = null;
  }

  @override
  String toString() => '$runtimeType{}';
}
