import 'dart:async';
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
import 'package:cv/src/utils/logger.dart';
import 'package:dio/dio.dart';

// TODO : Inject ApiService
class CVApiService {
  const CVApiService();

  static final Dio client = Dio(Options(
    baseUrl: _apiBaseUrl,
    connectTimeout: 3000,
    responseType: ResponseType.JSON,
  ));

  static final String _apiBaseUrl = "https://api.cv.lebot.me";

  static final String _pathOauth = "/oauth";
  static final String _pathOauthToken = _pathOauth + "/token";

  static final String _pathMe = "/me";
  static final String _pathProfiles = "/profiles";
  static final String _pathParts = "/parts";
  static final String _pathGroups = "/groups";
  static final String _pathEntries = "/entries";

  static final String _pathMeProfiles = _pathMe + _pathProfiles;

  ///
  /// OAuth
  ///

  Future<OAuthAccessTokenResponseModel> fetchToken({
    OAuthTokenModel oauthTokenModel,
  }) async {
    assert(oauthTokenModel != null);

    return client
        .post(
      _pathOauthToken,
      options: Options(
        contentType: ContentType.parse("application/x-www-form-urlencoded"),
      ),
      data: oauthTokenModel.toJson(),
    )
        .then((Response response) {
      switch (response.statusCode) {
        case HttpStatus.badRequest:
          throw ApiErrorWrongPasswordError();
        case HttpStatus.notFound:
          throw ApiErrorUserNotFoundError();
      }
      return OAuthAccessTokenResponseModel.fromJson(response.data);
    });
  }

  ///
  /// Account
  ///

  Future<ResponseModel<UserModel>> fetchAccountDetails({
    String accessToken,
  }) async {
    logger.info("API Service:fetchAccountDetails");
    return client
        .get(
      _pathMe,
      options: Options(
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      ),
    )
        .then((Response response) {
      return ResponseModel<UserModel>.fromJson(response.data);
    });
  }

  Future<ResponseModelWithArray<ProfileModel>> fetchAccountProfiles({
    String accessToken,
    int offset = 0,
    int limit = 5,
  }) async {
    return client
        .get(
      _pathMeProfiles,
      data: {
        "offset": offset.toString(),
        "limit": limit.toString(),
      },
      options: Options(
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      ),
    )
        .then((Response response) {
      switch (response.statusCode) {
        case HttpStatus.notFound:
          throw BaseError("Profiles from account not found");
      }
      return ResponseModelWithArray<ProfileModel>.fromJson(response.data);
    });
  }

  ///
  /// Profiles
  ///

  Future<ResponseModel<ProfileModel>> fetchProfileDetails({
    String accessToken,
    String profileId,
  }) async {
    return client
        .get(
      _pathProfiles + "/$profileId",
      options: Options(
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      ),
    )
        .then((Response response) {
      return ResponseModel<ProfileModel>.fromJson(response.data);
    });
  }

  Future<ResponseModelWithArray<PartModel>> fetchProfileParts({
    String accessToken,
    String profileId,
    int offset = 0,
    int limit = 5,
  }) async {
    Uri uri = Uri.https(
      _apiBaseUrl,
      _pathProfiles + "/$profileId" + _pathParts,
      {
        "offset": offset.toString(),
        "limit": limit.toString(),
        "sort": "+order"
      },
    );

    return client
        .get(
      _pathProfiles + "/$profileId" + _pathParts,
      data: {
        "offset": offset.toString(),
        "limit": limit.toString(),
        "sort": "+order"
      },
      options: Options(
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      ),
    )
        .then((Response response) {
      return ResponseModelWithArray<PartModel>.fromJson(response.data);
    });
  }

  ///
  /// Parts
  ///

  Future<ResponseModel<PartModel>> fetchPart({
    String accessToken,
    String partId,
  }) async {
    return client
        .get(
      _pathParts + "/$partId",
      options: Options(
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      ),
    )
        .then((Response response) {
      return ResponseModel<PartModel>.fromJson(response.data);
    });
  }

  Future<ResponseModelWithArray<GroupModel>> fetchPartGroups({
    String accessToken,
    String partId,
    int offset = 0,
    int limit = 5,
  }) async {
    return client
        .get(
      _pathParts + "/$partId" + _pathGroups,
      data: {
        "offset": offset.toString(),
        "limit": limit.toString(),
        "sort": "+order",
      },
      options: Options(
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      ),
    )
        .then((response) {
      return ResponseModelWithArray<GroupModel>.fromJson(response.data);
    });
  }

  ///
  /// Groups
  ///

  Future<ResponseModel<GroupModel>> fetchGroup({
    String accessToken,
    String groupId,
  }) async {
    return client
        .get(
      _pathGroups + "/$groupId",
      options: Options(
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      ),
    )
        .then((response) {
      return ResponseModel<GroupModel>.fromJson(response.data);
    });
  }

  Future<ResponseModelWithArray<EntryModel>> fetchGroupEntries({
    String accessToken,
    String groupId,
    int offset = 0,
    int limit = 5,
  }) async {
    return client.get(
      _pathGroups + "/$groupId" + _pathEntries,
      options: Options(
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      ),
      data: {
        "offset": offset.toString(),
        "limit": limit.toString(),
        "sort": "+order",
      },
    ).then((response) {
      return ResponseModelWithArray<EntryModel>.fromJson(response.data);
    });
  }

  ///
  /// Entries
  ///

  Future<ResponseModel<EntryModel>> fetchEntry({
    String accessToken,
    String entryId,
  }) async {
    return client
        .get(
      _pathEntries + "/$entryId",
      options: Options(
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      ),
    )
        .then((Response response) {
      return ResponseModel<EntryModel>.fromJson(response.data);
    });
  }

  ///
  /// Profiles
  ///

  Future<ResponseModelWithArray<ProfileModel>> fetchProfiles({
    String accessToken,
    String profileTitle,
    int offset = 0,
    int limit = 10,
  }) async {
    return client.get(
      _pathProfiles,
      options: Options(
        baseUrl: _apiBaseUrl,
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      ),
      data: {
        "title": profileTitle,
        "offset": offset.toString(),
        "limit": limit.toString(),
      },
    ).then((Response response) {
      switch (response.statusCode) {
        case HttpStatus.badRequest:
          throw ApiErrorWrongPaginationError();
        case HttpStatus.notFound:
          throw ApiErrorProfileNotFoundError();
      }
      return ResponseModelWithArray<ProfileModel>.fromJson(response.data);
    });
  }
}

Future _filterStatusCode(response) async {
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
