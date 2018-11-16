import 'dart:async';
import 'dart:convert';

import 'package:cv/src/errors/api_errors.dart';
import 'package:cv/src/errors/http_errors.dart';
import 'package:cv/src/models/api_models.dart';
import 'package:cv/src/models/user_model.dart';
import 'package:http/http.dart';

class JsonClient extends BaseClient {
  final Client _client = Client();

  final Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  JsonClient({this.timeoutSecond = 5}) : super();

  int timeoutSecond;

  @override
  Future<StreamedResponse> send(BaseRequest request) {
    request.headers.addAll(headers);
    return _client
        .send(request)
        .timeout(Duration(seconds: this.timeoutSecond))
        .then(_filterStatusCode);
  }

  Future<StreamedResponse> _filterStatusCode(StreamedResponse response) async {
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
}

class ApiService {
  Client client = JsonClient();
  final String _baseUrl = "https://api.cv.lebot.me";

  Future<AuthLoginResponseModel> login(AuthLoginModel loginModel) async {
    return client
        .post(
      "$_baseUrl/auth/login",
      body: jsonEncode(loginModel),
    )
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
    )
        .then((Response response) {
      return ResponseModel<UserModel>.fromJson(json.decode(response.body));
    });
  }
}
