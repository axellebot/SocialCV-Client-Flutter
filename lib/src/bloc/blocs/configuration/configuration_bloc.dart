import 'package:bloc/bloc.dart';
import 'package:social_cv_client_flutter/bloc.dart';
import 'package:social_cv_client_flutter/data.dart';
import 'package:social_cv_client_flutter/domain.dart';
import 'package:social_cv_client_flutter/presentation.dart';

class ConfigurationBloc extends Bloc<ConfigurationEvent, ConfigurationState> {
  final String _tag = '$ConfigurationBloc';

  ConfigurationBloc() : super();

  /// Services
  FoundationConfigService _foundationConfigService;
  CVAuthService _cvAuthService;

  /// Repositories
  AuthInfoRepository _authInfoRepository;
  AppPrefsRepository _appPrefsRepository;

  /// Entities Repositories
  IdentityRepository _identityRepository;
  UserRepository _userRepository;
  ProfileRepository _profileRepository;
  PartRepository _partRepository;
  GroupRepository _groupRepository;
  EntryRepository _entryRepository;

  @override
  ConfigurationState get initialState => ConfigLoading();

  @override
  Stream<ConfigurationState> mapEventToState(ConfigurationEvent event) async* {
    if (event is AppLaunched) {
      yield* _mapAppLaunchedEventToState();
    }
  }

  /// -----------------------------------------------------------------------
  ///                       All Event map to State
  /// -----------------------------------------------------------------------

  Stream<ConfigurationState> _mapAppLaunchedEventToState() async* {
    try {
      yield ConfigLoading();

      _foundationConfigService = ConfigAssetsManager();

      final AuthInfoDataStore diskAuthInfoDataStore =
          AuthSharedPreferencesManager();

      final apiInterceptor = ApiInterceptor(
        accessToken: await diskAuthInfoDataStore.getAccessToken(),
        refreshToken: await diskAuthInfoDataStore.getRefreshToken(),
      );

      final CVApiManager cvApiManager = CVApiManager(
        apiBaseUrl: await _foundationConfigService.getApiServerUrl(),
        tokenInterceptor: apiInterceptor,
      );

      _cvAuthService = cvApiManager;

      // Data Stores

      final AppPrefsDataStore diskAppPrefsDataStore = AppPrefsManager();

      final IdentityDataStore memoryIdentityDataStore =
          MemoryIdentityDataStore();
      final IdentityDataStore cloudIdentityDataStore = cvApiManager;

      final ProfileDataStore memoryProfileDataStore = MemoryProfileDataStore();
      final ProfileDataStore cloudProfileDataStore = cvApiManager;

      final UserDataStore memoryUserDataStore = MemoryUserDataStore();
      final UserDataStore cloudUserDataStore = cvApiManager;

      final PartDataStore memoryPartDataStore = MemoryPartDataStore();
      final PartDataStore cloudPartDataStore = cvApiManager;

      final GroupDataStore memoryGroupDataStore = MemoryGroupDataStore();
      final GroupDataStore cloudGroupDataStore = cvApiManager;

      final EntryDataStore memoryEntryDataStore = MemoryEntryDataStore();
      final EntryDataStore cloudEntryDataStore = cvApiManager;

      // Data Store Factories

      final appPrefsDataStoreFactory = AppPrefsDataStoreFactory(
        diskDataStore: diskAppPrefsDataStore,
      );

      final authInfoDataStoreFactory = AuthInfoDataStoreFactory(
        diskDataStore: diskAuthInfoDataStore,
      );

      final identityDataStoreFactory = IdentityDataStoreFactory(
        memoryDataStore: memoryIdentityDataStore,
        cloudDataStore: cloudIdentityDataStore,
      );

      final userDataStoreFactory = UserDataStoreFactory(
        memoryDataStore: memoryUserDataStore,
        cloudDataStore: cloudUserDataStore,
      );

      final profileDataStoreFactory = ProfileDataStoreFactory(
        memoryDataStore: memoryProfileDataStore,
        cloudDataStore: cloudProfileDataStore,
      );

      final partDataStoreFactory = PartDataStoreFactory(
        memoryDataStore: memoryPartDataStore,
        cloudDataStore: cloudPartDataStore,
      );

      final groupDataStoreFactory = GroupDataStoreFactory(
        memoryDataStore: memoryGroupDataStore,
        cloudDataStore: cloudGroupDataStore,
      );

      final entryDataStoreFactory = EntryDataStoreFactory(
        memoryDataStore: memoryEntryDataStore,
        cloudDataStore: cloudEntryDataStore,
      );

      // Repositories

      _appPrefsRepository = ImplAppPrefsRepository(
        factory: appPrefsDataStoreFactory,
      );

      _authInfoRepository = ImplAuthInfoRepository(
        factory: authInfoDataStoreFactory,
      );

      _identityRepository = ImplIdentityRepository(
        factory: identityDataStoreFactory,
      );

      _userRepository = ImplUserRepository(
        factory: userDataStoreFactory,
      );

      _profileRepository = ImplProfileRepository(
        factory: profileDataStoreFactory,
      );

      _partRepository = ImplPartRepository(
        factory: partDataStoreFactory,
      );

      _groupRepository = ImplGroupRepository(
        factory: groupDataStoreFactory,
      );

      _entryRepository = ImplEntryRepository(
        factory: entryDataStoreFactory,
      );

      // Return config

      yield ConfigLoaded(
        cvAuthService: _cvAuthService,
        authInfoRepository: _authInfoRepository,
        appPrefsRepository: _appPrefsRepository,
        identityRepository: _identityRepository,
        userRepository: _userRepository,
        profileRepository: _profileRepository,
        partRepository: _partRepository,
        groupRepository: _groupRepository,
        entryRepository: _entryRepository,
      );
    } catch (error, stacktrace) {
      Logger.error('${error.runtimeType}', stackTrace: stacktrace);
      yield ConfigFailure(error: error);
    }
  }
}
