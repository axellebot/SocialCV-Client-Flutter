import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:social_cv_client_flutter/data.dart';
import 'package:social_cv_client_flutter/domain.dart' as domain;

class ApiInterceptor extends Interceptor {
  String _clientId;
  String _clientSecret;
  String _accessToken;
  String _refreshToken;

  InterceptorsWrapper _interceptorWrapper;

  ApiInterceptor({
    String clientId,
    String clientSecret,
    String accessToken,
    String refreshToken,
  }) {
    _clientId = clientId;
    _clientSecret = clientSecret;
    _accessToken = accessToken;
    _refreshToken = refreshToken;

    _interceptorWrapper =
        InterceptorsWrapper(onRequest: _onRequest, onResponse: _onResponse);
  }

  InterceptorsWrapper get interceptorsWrapper => _interceptorWrapper;

  RequestOptions _onRequest(RequestOptions options) {
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

    return options;
  }

  Response<dynamic> _onResponse(Response<dynamic> response) {
    /// Save access token
    final data = response.data;
    if (data is Map) {
      if (data.containsKey('access_token')) {
        _accessToken = data['access_token'] as String;
      }

      /// Save refresh token
      if (data.containsKey('refresh_token')) {
        _refreshToken = response.data['refresh_token'] as String;
      }
    }
    return response;
  }

  FutureOr<void> deleteAuthData() async {
    _accessToken = null;
  }

  @override
  String toString() => '$runtimeType{}';
}

/// Parse response to check if there is any error
dynamic checkApiResponse(Response response, {StackTrace stackTrace}) {
  // TODO: use Envelop type for Response body
  final Map<String, dynamic> body = response.data as Map<String, dynamic>;
  final String apiErrorCode = body['error'] as String;
  final String apiMessage = body['message'] as String;

  if (apiErrorCode != null) {
    throw ApiException.fromDioRequest(
      errorCode: apiErrorCode,
      message: apiMessage,
      stackTrace: stackTrace ?? StackTrace.current,
    );
  }
  return response;
}

dynamic apiErrorCatcher(dynamic err) {
  if (err is DioError && err.response != null) {
    final Response response = err.response;
    final StackTrace stackTrace =
        (err?.error as dynamic).stackTrace as StackTrace;

    checkApiResponse(response, stackTrace: stackTrace);

    final statusCode = err?.response?.statusCode;
    final statusMessage = err?.response?.statusMessage;

    if (statusCode != null) {
      throw domain.HttpException(
        statusCode: statusCode,
        statusMessage: statusMessage,
        stackTrace: stackTrace ?? StackTrace.current,
      );
    }
  }
  return err;
}
