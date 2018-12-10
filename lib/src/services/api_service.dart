import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cv/src/errors/api_errors.dart';
import 'package:cv/src/errors/base_errors.dart';
import 'package:cv/src/errors/http_errors.dart';
import 'package:cv/src/models/api_models.dart';
import 'package:cv/src/models/profile_entry_model.dart';
import 'package:cv/src/models/profile_group_model.dart';
import 'package:cv/src/models/profile_model.dart';
import 'package:cv/src/models/profile_part_model.dart';
import 'package:cv/src/models/user_model.dart';
import 'package:http/http.dart';

// TODO : Inject ApiService
class ApiService {
  Client client = ApiClient();
  final String _baseUrl = "api.cv.lebot.me";

  ///
  /// Auth
  ///

  Future<AuthLoginResponseModel> login(AuthLoginModel loginModel) async {
    Uri uri = Uri.https(_baseUrl, "/auth/login");

    return client
        .post(
      uri,
      body: jsonEncode(loginModel),
    )
        .then((Response response) {
      switch (response.statusCode) {
        case HttpStatus.badRequest:
          throw ApiErrorWrongPasswordError();
        case HttpStatus.notFound:
          throw ApiErrorUserNotFoundError();
      }
      return AuthLoginResponseModel.fromJson(json.decode(response.body));
    });
  }

  ///
  /// Account
  ///

  Future<ResponseModel<UserModel>> fetchAccountDetails(String token) async {
    Uri uri = Uri.https(_baseUrl, "/me", {
      "token": token,
    });

    return client.get(uri).then((Response response) {
      return ResponseModel<UserModel>.fromJson(json.decode(response.body));
    });
  }

  Future<ResponseModelWithArray<ProfileModel>> fetchAccountProfiles(
    String token, {
    int offset = 0,
    int limit = 10,
  }) async {
    Uri uri = Uri.https(_baseUrl, "/me/profiles", {
      "token": token,
      "offset": offset.toString(),
      "limit": limit.toString(),
    });

    return client.get(uri).then((Response response) {
      switch (response.statusCode) {
        case HttpStatus.notFound:
          throw BaseError("Profiles from account not found");
      }
      return ResponseModelWithArray<ProfileModel>.fromJson(
          json.decode(response.body));
    });
  }

  ///
  /// Profiles
  ///

  Future<ResponseModel<ProfileModel>> fetchProfileDetails(
    String token,
    String profileId,
  ) async {
    Uri uri = Uri.https(_baseUrl, "/profiles/$profileId", {
      "token": token,
    });

    return client.get(uri).then((Response response) {
      return ResponseModel<ProfileModel>.fromJson(json.decode(response.body));
    });
  }

  ///
  /// Parts
  ///

  Future<ResponseModel<ProfilePartModel>> fetchProfilePart(
    String token,
    String profilePartId,
  ) async {
    Uri uri = Uri.https(_baseUrl, "/parts/$profilePartId", {
      "token": token,
    });

    return client.get(uri).then((Response response) {
      return ResponseModel<ProfilePartModel>.fromJson(
          json.decode(response.body));
    });
  }

  ///
  /// Groups
  ///

  Future<ResponseModel<ProfileGroupModel>> fetchProfileGroup(
    String token,
    String profileGroupId,
  ) async {
    Uri uri = Uri.https(_baseUrl, "/groups/$profileGroupId", {
      "token": token,
    });

    return client.get(uri).then((Response response) {
      return ResponseModel<ProfileGroupModel>.fromJson(
          json.decode(response.body));
    });
  }

  ///
  /// Entries
  ///

  Future<ResponseModel<ProfileEntryModel>> fetchProfileEntry(
    String token,
    String profileEntryId,
  ) async {
    Uri uri = Uri.https(_baseUrl, "/entries/$profileEntryId", {
      "token": token,
    });

    return client.get(uri).then((Response response) {
      return ResponseModel<ProfileEntryModel>.fromJson(
          json.decode(response.body));
    });
  }

  ///
  /// Profiles
  ///

  Future<ResponseModelWithArray<ProfileModel>> fetchProfiles(
    String token,
    String profileTitle, {
    int offset = 0,
    int limit = 10,
  }) async {
    Uri uri = Uri.https(_baseUrl, "/profiles", {
      "token": token,
      "title": profileTitle,
      "offset": offset.toString(),
      "limit": limit.toString(),
    });

    return client.get(uri).then((Response response) {
      switch (response.statusCode) {
        case HttpStatus.badRequest:
          throw ApiErrorWrongPaginationError();
        case HttpStatus.notFound:
          throw ApiErrorProfileNotFoundError();
      }
      return ResponseModelWithArray<ProfileModel>.fromJson(
          json.decode(response.body));
    });
  }
}

class ApiClient extends BaseClient {
  final Client _client = Client();

  final Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  ApiClient({this.timeoutSecond = 30}) : super();

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
      case HttpStatus.notImplemented:
        throw HttpServerErrorNotImplementedError();
      case HttpStatus.badGateway:
        throw HttpServerErrorBadGatewayError();
      case HttpStatus.serviceUnavailable:
        throw HttpServerErrorServiceUnavailableError();
      case HttpStatus.gatewayTimeout:
        throw HttpServerErrorGatewayTimeoutError();
      case HttpStatus.httpVersionNotSupported:
        throw HttpServerErrorHttpVersionNotSupportedError();
    }
    return response;
  }
}
