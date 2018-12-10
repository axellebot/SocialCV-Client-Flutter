import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cv/src/errors/api_errors.dart';
import 'package:cv/src/errors/base_errors.dart';
import 'package:cv/src/errors/http_errors.dart';
import 'package:cv/src/models/api_models.dart';
import 'package:cv/src/models/entry_model.dart';
import 'package:cv/src/models/group_model.dart';
import 'package:cv/src/models/part_model.dart';
import 'package:cv/src/models/profile_model.dart';
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
    int limit = 5,
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

  Future<ResponseModelWithArray<PartModel>> fetchProfileParts(
    String token,
    String profileId, {
    int offset = 0,
    int limit = 5,
  }) async {
    Uri uri = Uri.https(_baseUrl, "/profiles/$profileId/parts", {
      "token": token,
      "offset": offset.toString(),
      "limit": limit.toString(),
      "sort": "+order"
    });

    return client.get(uri).then((Response response) {
      return ResponseModelWithArray<PartModel>.fromJson(
          json.decode(response.body));
    });
  }

  ///
  /// Parts
  ///

  Future<ResponseModel<PartModel>> fetchPart(
    String token,
    String profilePartId,
  ) async {
    Uri uri = Uri.https(_baseUrl, "/parts/$profilePartId", {
      "token": token,
    });

    return client.get(uri).then((Response response) {
      return ResponseModel<PartModel>.fromJson(json.decode(response.body));
    });
  }

  Future<ResponseModelWithArray<GroupModel>> fetchPartGroups(
    String token,
    String partId, {
    int offset = 0,
    int limit = 5,
  }) async {
    Uri uri = Uri.https(_baseUrl, "/parts/$partId/groups", {
      "token": token,
      "offset": offset.toString(),
      "limit": limit.toString(),
      "sort": "+order",
    });

    return client.get(uri).then((Response response) {
      return ResponseModelWithArray<GroupModel>.fromJson(
          json.decode(response.body));
    });
  }

  ///
  /// Groups
  ///

  Future<ResponseModel<GroupModel>> fetchGroup(
    String token,
    String groupId,
  ) async {
    Uri uri = Uri.https(_baseUrl, "/groups/$groupId", {
      "token": token,
    });

    return client.get(uri).then((Response response) {
      return ResponseModel<GroupModel>.fromJson(json.decode(response.body));
    });
  }

  Future<ResponseModelWithArray<EntryModel>> fetchGroupEntries(
    String token,
    String groupId, {
    int offset = 0,
    int limit = 5,
  }) async {
    Uri uri = Uri.https(_baseUrl, "/groups/$groupId/entries", {
      "token": token,
      "offset": offset.toString(),
      "limit": limit.toString(),
      "sort": "+order",
    });

    return client.get(uri).then((Response response) {
      return ResponseModelWithArray<EntryModel>.fromJson(
          json.decode(response.body));
    });
  }

  ///
  /// Entries
  ///

  Future<ResponseModel<EntryModel>> fetchEntry(
    String token,
    String entryId,
  ) async {
    Uri uri = Uri.https(_baseUrl, "/entries/$entryId", {
      "token": token,
    });

    return client.get(uri).then((Response response) {
      return ResponseModel<EntryModel>.fromJson(json.decode(response.body));
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
