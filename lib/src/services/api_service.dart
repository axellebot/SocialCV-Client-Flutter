import 'dart:async';
import 'dart:convert';

import 'package:cv/src/errors/api_errors.dart';
import 'package:cv/src/errors/http_errors.dart';
import 'package:cv/src/models/api_models.dart';
import 'package:cv/src/models/user_model.dart';
import 'package:http/http.dart';

class ApiService {
  Client client = Client();
  final String _baseUrl = "https://api.cv.lebot.me";
  final int _timeoutSecond = 5;
  final Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  Future<Response> _filterStatusCode(Response response) async {
    switch (response.statusCode) {
      case 501:
        throw HttpServerErrorNotImplementedError();
      case 502:
        throw HttpServerErrorBadGatewayError();
      case 503:
        throw HttpServerErrorServiceUnavailableError();
      case 504:
        throw HttpServerErrorGatewayTimeoutError();
      case 505:
        throw HttpServerErrorHttpVersionNotSupportedError();
    }
    return response;
  }

  Future<AuthLoginResponseModel> login(AuthLoginModel loginModel) async {
    return client
        .post(
          "$_baseUrl/auth/login",
          headers: headers,
          body: jsonEncode(loginModel),
        )
        .timeout(Duration(seconds: _timeoutSecond))
        .then(_filterStatusCode)
        .then((Response response) {
      switch (response.statusCode) {
        case 400:
          throw ApiErrorWrongPasswordError();
        case 404:
          throw ApiErrorUserNotFoundError();
      }
      return AuthLoginResponseModel.fromJson(json.decode(response.body));
    });
  }

  Future<ResponseModel<UserModel>> fetchAccountDetails(String token) async {
    return client
        .get(
          "$_baseUrl/me?token=$token",
          headers: headers,
        )
        .timeout(Duration(seconds: _timeoutSecond))
        .then(_filterStatusCode)
        .then((Response response) {
      return ResponseModel<UserModel>.fromJson(json.decode(response.body));
    });
  }
}
