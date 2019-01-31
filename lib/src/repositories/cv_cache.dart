import 'package:social_cv_client_dart_common/models.dart';
import 'package:social_cv_client_dart_common/repositories.dart';

class CVCacheImpl implements CVCache {
  CVCacheImpl();

  final _users = <String, _CacheModel<UserModel>>{};
  final _profiles = <String, _CacheModel<ProfileModel>>{};
  final _parts = <String, _CacheModel<PartModel>>{};
  final _groups = <String, _CacheModel<GroupModel>>{};
  final _entries = <String, _CacheModel<EntryModel>>{};

  _CacheModel<UserModel> accountCache;

  ///
  /// Account
  ///

  Future<UserModel> getAccount() async {
    return (accountCache != null && !accountCache.isExpired())
        ? accountCache.model
        : null;
  }

  void setAccount(UserModel userModel) async {
    DateTime expiration = _generateExpirationDateTime(Duration(minutes: 1));
    this.accountCache =
        _CacheModel<UserModel>(model: userModel, expiration: expiration);
  }

  ///
  /// Users
  ///

  Future<UserModel> getUser(String userId) async {
    _CacheModel<UserModel> cacheModel = _users[userId];
    return (cacheModel != null && !cacheModel.isExpired())
        ? cacheModel.model
        : null;
  }

  void setUser(UserModel userModel) async {
    DateTime expiration = _generateExpirationDateTime(Duration(minutes: 1));
    final cacheModel =
        _CacheModel<UserModel>(model: userModel, expiration: expiration);
    _users[userModel.id] = cacheModel;
  }

  ///
  /// Profiles
  ///

  Future<ProfileModel> getProfile(String profileId) async {
    _CacheModel<ProfileModel> cacheModel = _profiles[profileId];
    return (cacheModel != null && !cacheModel.isExpired())
        ? cacheModel.model
        : null;
  }

  void setProfile(ProfileModel profileModel) async {
    DateTime expiration = _generateExpirationDateTime(Duration(minutes: 1));
    final cacheModel =
        _CacheModel<ProfileModel>(model: profileModel, expiration: expiration);
    _profiles[profileModel.id] = cacheModel;
  }

  ///
  /// Parts
  ///

  Future<PartModel> getPart(String partId) async {
    _CacheModel<PartModel> cacheModel = _parts[partId];
    return (cacheModel != null && !cacheModel.isExpired())
        ? cacheModel.model
        : null;
  }

  void setPart(PartModel partModel) async {
    DateTime expiration = _generateExpirationDateTime(Duration(minutes: 1));
    final cacheModel =
        _CacheModel<PartModel>(model: partModel, expiration: expiration);
    _parts[partModel.id] = cacheModel;
  }

  ///
  /// Groups
  ///

  Future<GroupModel> getGroup(String groupId) async {
    _CacheModel<GroupModel> cacheModel = _groups[groupId];
    return (cacheModel != null && !cacheModel.isExpired())
        ? cacheModel.model
        : null;
  }

  void setGroup(GroupModel groupModel) async {
    DateTime expiration = _generateExpirationDateTime(Duration(minutes: 1));
    final cacheModel =
        _CacheModel<GroupModel>(model: groupModel, expiration: expiration);
    _groups[groupModel.id] = cacheModel;
  }

  ///
  /// Entries
  ///

  Future<EntryModel> getEntry(String entryId) async {
    _CacheModel<EntryModel> cacheModel = _entries[entryId];
    return (cacheModel != null && !cacheModel.isExpired())
        ? cacheModel.model
        : null;
  }

  void setEntry(EntryModel entryModel) async {
    DateTime expiration = _generateExpirationDateTime(Duration(minutes: 1));
    final cacheModel =
        _CacheModel<EntryModel>(model: entryModel, expiration: expiration);
    _entries[entryModel.id] = cacheModel;
  }

  DateTime _generateExpirationDateTime(Duration duration) {
    DateTime.now().add(duration);
  }
}

class _CacheModel<T> {
  _CacheModel({
    this.model,
    this.expiration,
  })  : assert(model != null),
        assert(model != null);

  T model;
  DateTime expiration;

  bool isExpired() {
    return DateTime.now().compareTo(expiration) >= 0 ? true : false;
  }
}
