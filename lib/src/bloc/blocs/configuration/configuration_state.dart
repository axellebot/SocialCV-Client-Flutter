import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:social_cv_client_flutter/domain.dart';

abstract class ConfigurationState extends Equatable {
  ConfigurationState([List props = const []]) : super(props);

  @override
  String toString() => '$runtimeType{}';
}

class ConfigLoading extends ConfigurationState {}

class ConfigLoaded extends ConfigurationState {
  final CVAuthService cvAuthService;

  final AuthInfoRepository authInfoRepository;
  final AppPrefsRepository appPrefsRepository;

  final IdentityRepository identityRepository;
  final UserRepository userRepository;
  final ProfileRepository profileRepository;
  final PartRepository partRepository;
  final GroupRepository groupRepository;
  final EntryRepository entryRepository;

  ConfigLoaded({
    @required this.cvAuthService,
    @required this.authInfoRepository,
    @required this.appPrefsRepository,
    @required this.identityRepository,
    @required this.userRepository,
    @required this.profileRepository,
    @required this.partRepository,
    @required this.groupRepository,
    @required this.entryRepository,
  })  : assert(cvAuthService != null, 'No $CVAuthService given'),
        assert(authInfoRepository != null, 'No $AuthInfoRepository given'),
        assert(appPrefsRepository != null, 'No $AppPrefsRepository given'),
        assert(identityRepository != null, 'No $IdentityRepository given'),
        assert(userRepository != null, 'No $UserRepository given'),
        assert(profileRepository != null, 'No $ProfileRepository given'),
        assert(partRepository != null, 'No $PartRepository given'),
        assert(groupRepository != null, 'No $GroupRepository given'),
        assert(entryRepository != null, 'No $EntryRepository given'),
        super([
          cvAuthService,
          authInfoRepository,
          appPrefsRepository,
          identityRepository,
          userRepository,
          profileRepository,
          partRepository,
          groupRepository,
          entryRepository,
        ]);
}

class ConfigFailure extends ConfigurationState {
  final dynamic error;

  ConfigFailure({@required this.error})
      : assert(error != null),
        super([error]);

  @override
  String toString() => '$runtimeType{ '
      'error: $error'
      ' }';
}
