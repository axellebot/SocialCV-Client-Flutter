import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:social_cv_client_flutter/data.dart';
import 'package:social_cv_client_flutter/domain.dart';
import 'package:social_cv_client_flutter/presentation.dart';
import 'package:social_cv_client_flutter/src/data/managers/api_interceptor.dart';

/// Default Implementation of [CVApiManager]
class CVApiManager
    implements
        CVAuthService,
        IdentityDataStore,
        UserDataStore,
        ProfileDataStore,
        PartDataStore,
        GroupDataStore,
        EntryDataStore {
  final String _tag = '$CVApiManager';

  final String apiBaseUrl;

  late Dio _dio;

  static const String _pathOauth = '/oauth';
  static const String _pathOauthToken = '$_pathOauth/token';

  static const String _pathMe = '/me';
  static const String _pathUsers = '/users';
  static const String _pathProfiles = '/profiles';
  static const String _pathParts = '/parts';
  static const String _pathGroups = '/groups';
  static const String _pathEntries = '/entries';

  final OAuthInterceptor oauthInterceptor;
  final ApiInterceptor apiInterceptor;

  CVApiManager({
    required this.apiBaseUrl,
    required this.oauthInterceptor,
    required this.apiInterceptor,
  }) {
    _dio = Dio(BaseOptions(
      baseUrl: apiBaseUrl,
      connectTimeout: 3000,
      contentType: '${ContentType.json}',
      responseType: ResponseType.json,
    ));

    // Add Interceptor
    _dio.interceptors.add(oauthInterceptor);
    _dio.interceptors.add(apiInterceptor);
  }

  /// --------------------------------------------------------------------------
  ///                           CVAuthService
  /// --------------------------------------------------------------------------

  @override
  FutureOr<ResponseAuthDataModel> authenticate({
    required String email,
    required String password,
  }) async {
    print('$_tag:authenticate');

    final RequestAuthDataModel oauthModel = RequestAuthDataModel(
      username: email,
      password: password,
    );

    final Response<Map<String, dynamic>> response = await _dio
        .post<Map<String, dynamic>>(_pathOauthToken, data: oauthModel.toJson());

    final model = ResponseAuthDataModel.fromJson(response.data!);
    return model;
  }

  @override
  FutureOr<AuthEntity> register({
    required String fName,
    required String lName,
    required String email,
    required String password,
  }) {
    // TODO: implement register
    throw NotImplementedYetError();
  }

  /// Logout
  @override
  FutureOr<void> logout() async {
    await oauthInterceptor.deleteAuthData();
  }

  /// --------------------------------------------------------------------------
  ///                             IdentityDataStore
  /// --------------------------------------------------------------------------

  @override
  FutureOr<UserDataModel?> getIdentity() async {
    print('$_tag:getIdentity()');

    final Response<Map<String, dynamic>> response =
        await _dio.get<Map<String, dynamic>>(_pathMe);

    final DataEnvelop<UserDataModel> envelop =
        DataEnvelop<UserDataModel>.fromJson(response.data!);

    return envelop.data;
  }

  @override
  FutureOr<UserDataModel> setIdentity(UserDataModel? userModel) {
    // TODO: implement setIdentity
    throw NotImplementedYetError();
  }

  FutureOr<List<ProfileDataModel>?> getProfilesFromIdentity({
    Cursor cursor = const Cursor(),
  }) async {
    print('$_tag:getProfilesFromIdentity');

    const String _path = '$_pathMe$_pathProfiles';

    final Response<Map<String, dynamic>> response =
        await _dio.get<Map<String, dynamic>>(
      _path,
      queryParameters: {
        'offset': cursor.offset.toString(),
        'limit': cursor.limit.toString(),
      },
    );

    final envelop = DataArrayEnvelop<ProfileDataModel>.fromJson(response.data!);
    return envelop.data;
  }

  /// --------------------------------------------------------------------------
  ///                            UserDataStore
  /// --------------------------------------------------------------------------

  @override
  FutureOr<UserDataModel> getUser(String userId) async {
    print('$_tag:getUser($userId)');

    final String _path = '$_pathUsers/$userId';

    final Response<Map<String, dynamic>> response =
        await _dio.get<Map<String, dynamic>>(_path);

    final envelop = DataEnvelop<UserDataModel>.fromJson(response.data!);

    return envelop.data;
  }

  @override
  FutureOr<UserDataModel> setUser(UserDataModel? userModel) {
    print('$_tag:setUser($userModel)');
    // TODO: implement setUser
    throw NotImplementedYetError();
  }

  @override
  FutureOr<List<UserDataModel>> getUsers({
    Cursor cursor = const Cursor(),
  }) async {
    print('$_tag:getUsers');

    const String _path = _pathUsers;

    final Response<Map<String, dynamic>> response =
        await _dio.get<Map<String, dynamic>>(_path, queryParameters: {
      'offset': cursor.offset.toString(),
      'limit': cursor.limit.toString(),
    });

    final envelop = DataArrayEnvelop<UserDataModel>.fromJson(response.data!);
    return envelop.data;
  }

  /// --------------------------------------------------------------------------
  ///                          ProfileDataStore
  /// --------------------------------------------------------------------------

  @override
  FutureOr<ProfileDataModel?> getProfile(String? profileId) async {
    print('$_tag:fetchProfile($profileId)');

    final String _path = '$_pathProfiles/$profileId';

    final Response<Map<String, dynamic>> response =
        await _dio.get<Map<String, dynamic>>(_path);
    final envelop = DataEnvelop<ProfileDataModel>.fromJson(response.data!);
    return envelop.data;
  }

  @override
  FutureOr<ProfileDataModel> setProfile(ProfileDataModel? profileModel) {
    print('$_tag:setProfile($profileModel)');
    // TODO: implement setProfile
    throw NotImplementedYetError();
  }

  @override
  FutureOr<List<ProfileDataModel>> getProfiles({
    Cursor cursor = const Cursor(),
  }) async {
    print('$_tag:getProfiles');

    const String _path = _pathProfiles;

    final Response<Map<String, dynamic>> response =
        await _dio.get<Map<String, dynamic>>(_path, queryParameters: {
      'offset': cursor.offset.toString(),
      'limit': cursor.limit.toString(),
    });

    final envelop = DataArrayEnvelop<ProfileDataModel>.fromJson(response.data!);
    return envelop.data;
  }

  @override
  FutureOr<List<ProfileDataModel>> getProfilesFromUser(
    String? userId, {
    Cursor cursor = const Cursor(),
  }) async {
    print('$_tag:getProfilesFromUser');

    final String _path = '$_pathUsers/$userId$_pathProfiles';

    final Response<Map<String, dynamic>> response =
        await _dio.get<Map<String, dynamic>>(_path, queryParameters: {
      'offset': cursor.offset.toString(),
      'limit': cursor.limit.toString(),
    });

    final envelop = DataArrayEnvelop<ProfileDataModel>.fromJson(response.data!);
    return envelop.data;
  }

  /// --------------------------------------------------------------------------
  ///                               PartDataStore
  /// --------------------------------------------------------------------------

  @override
  FutureOr<PartDataModel?> getPart(String partId) async {
    print('$_tag:getPart($partId)');

    final String _path = '$_pathParts/$partId';

    final Response<Map<String, dynamic>> response =
        await _dio.get<Map<String, dynamic>>(_path);
    final envelop = DataEnvelop<PartDataModel>.fromJson(response.data!);
    return envelop.data;
  }

  @override
  FutureOr<PartDataModel> setPart(PartDataModel? partModel) {
    // TODO: implement setPart
    throw NotImplementedYetError();
  }

  @override
  FutureOr<List<PartDataModel>> getParts({
    Cursor cursor = const Cursor(),
  }) async {
    print('$_tag:getParts');

    const String _path = _pathParts;

    final Response<Map<String, dynamic>> response =
        await _dio.get<Map<String, dynamic>>(_path, queryParameters: {
      'offset': cursor.offset.toString(),
      'limit': cursor.limit.toString(),
    });

    final envelop = DataArrayEnvelop<PartDataModel>.fromJson(response.data!);
    return envelop.data;
  }

  @override
  FutureOr<List<PartDataModel>> getPartsFromProfile(
    String? profileId, {
    Cursor cursor = const Cursor(),
  }) async {
    print('$_tag:getPartsFromProfile');

    final String _path = '$_pathProfiles/$profileId$_pathParts';

    final Response<Map<String, dynamic>> response =
        await _dio.get<Map<String, dynamic>>(_path, queryParameters: {
      'offset': cursor.offset.toString(),
      'limit': cursor.limit.toString(),
      'sort': '+order'
    });

    final envelop = DataArrayEnvelop<PartDataModel>.fromJson(response.data!);
    return envelop.data;
  }

  @override
  FutureOr<List<PartDataModel>> getPartsFromUser(
    String userId, {
    Cursor cursor = const Cursor(),
  }) async {
    print('$_tag:fetchPartsFromUser($userId)');

    final String _path = '$_pathUsers/$userId$_pathParts';

    final Response<Map<String, dynamic>> response =
        await _dio.get<Map<String, dynamic>>(_path, queryParameters: {
      'offset': cursor.offset.toString(),
      'limit': cursor.limit.toString(),
    });

    final envelop = DataArrayEnvelop<PartDataModel>.fromJson(response.data!);
    return envelop.data;
  }

  /// --------------------------------------------------------------------------
  ///                            GroupDataStore
  /// --------------------------------------------------------------------------

  @override
  FutureOr<GroupDataModel?> getGroup(String groupId) async {
    print('$_tag:getGroup($groupId)');

    final String _path = '$_pathGroups/$groupId';

    final Response<Map<String, dynamic>> response =
        await _dio.get<Map<String, dynamic>>(_path);
    final envelop = DataEnvelop<GroupDataModel>.fromJson(response.data!);
    return envelop.data;
  }

  @override
  FutureOr<GroupDataModel> setGroup(GroupDataModel? groupModel) {
    print('$_tag:setGroup($groupModel)');
    // TODO: implement setGroup
    throw NotImplementedYetError();
  }

  @override
  FutureOr<List<GroupDataModel>> getGroups({
    Cursor cursor = const Cursor(),
  }) async {
    print('$_tag:getGroups');

    const String _path = _pathGroups;

    final Response<Map<String, dynamic>> response =
        await _dio.get<Map<String, dynamic>>(_path, queryParameters: {
      'offset': cursor.offset.toString(),
      'limit': cursor.limit.toString(),
    });

    final envelop = DataArrayEnvelop<GroupDataModel>.fromJson(response.data!);
    return envelop.data;
  }

  @override
  FutureOr<List<GroupDataModel>> getGroupsFromPart(
    String? partId, {
    Cursor cursor = const Cursor(),
  }) async {
    print('$_tag:getGroupsFromPart($partId)');

    final String _path = '$_pathParts/$partId$_pathGroups';

    final Response<Map<String, dynamic>> response =
        await _dio.get<Map<String, dynamic>>(_path, queryParameters: {
      'offset': cursor.offset.toString(),
      'limit': cursor.limit.toString(),
      'sort': '+order',
    });

    final envelop = DataArrayEnvelop<GroupDataModel>.fromJson(response.data!);
    return envelop.data;
  }

  @override
  FutureOr<List<GroupDataModel>> getGroupsFromUser(
    String? userId, {
    Cursor cursor = const Cursor(),
  }) async {
    print('$_tag:getGroupsFromUser($userId)');

    final String _path = '$_pathUsers/$userId$_pathGroups';

    final Response<Map<String, dynamic>> response =
        await _dio.get<Map<String, dynamic>>(_path, queryParameters: {
      'offset': cursor.offset.toString(),
      'limit': cursor.limit.toString(),
    });

    final envelop = DataArrayEnvelop<GroupDataModel>.fromJson(response.data!);
    return envelop.data;
  }

  /// --------------------------------------------------------------------------
  ///                              EntryDataStore
  /// --------------------------------------------------------------------------

  @override
  FutureOr<EntryDataModel> getEntry(String entryId) async {
    print('$_tag:getEntry($entryId)');

    final String _path = '$_pathEntries/$entryId';

    final Response<Map<String, dynamic>> response =
        await _dio.get<Map<String, dynamic>>(_path);
    final envelop = DataEnvelop<EntryDataModel>.fromJson(response.data!);
    return envelop.data;
  }

  @override
  FutureOr<List<EntryDataModel>> getEntries({
    Cursor cursor = const Cursor(),
  }) async {
    print('$_tag:getEntries');

    const String _path = _pathEntries;

    final Response<Map<String, dynamic>> response =
        await _dio.get<Map<String, dynamic>>(_path, queryParameters: {
      'offset': cursor.offset.toString(),
      'limit': cursor.limit.toString(),
    });

    final envelop = DataArrayEnvelop<EntryDataModel>.fromJson(response.data!);

    return envelop.data;
  }

  @override
  FutureOr<EntryDataModel> setEntry(EntryDataModel? entryModel) {
    print('$_tag:setEntry($entryModel)');
    // TODO: implement setEntry
    throw NotImplementedYetError();
  }

  @override
  FutureOr<List<EntryDataModel>> getEntriesFromGroup(
    String? groupId, {
    Cursor cursor = const Cursor(),
  }) async {
    print('$_tag:getEntriesFromGroup($groupId)');

    final String _path = '$_pathGroups/$groupId$_pathEntries';

    final Response<Map<String, dynamic>> response =
        await _dio.get<Map<String, dynamic>>(_path, queryParameters: {
      'offset': cursor.offset.toString(),
      'limit': cursor.limit.toString(),
      'sort': '+order',
    });
    final envelop = DataArrayEnvelop<EntryDataModel>.fromJson(response.data!);
    return envelop.data;
  }

  @override
  FutureOr<List<EntryDataModel>> getEntriesFromUser(
    String? userId, {
    Cursor cursor = const Cursor(),
  }) async {
    print('$_tag:getEntriesFromUser($userId)');

    final String _path = '$_pathUsers/$userId$_pathEntries';

    final Response<Map<String, dynamic>> response =
        await _dio.get<Map<String, dynamic>>(_path, queryParameters: {
      'offset': cursor.offset.toString(),
      'limit': cursor.limit.toString(),
    });

    final envelop = DataArrayEnvelop<EntryDataModel>.fromJson(response.data!);
    return envelop.data;
  }

  /// --------------------------------------------------------------------------
  ///                                 Misc
  /// --------------------------------------------------------------------------

  @override
  String toString() => '$runtimeType{}';
}
