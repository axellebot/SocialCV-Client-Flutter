import 'package:equatable/equatable.dart';
import 'package:social_cv_client_flutter/domain.dart';

abstract class ConfigurationState extends Equatable {
  const ConfigurationState() : super();

  @override
  List<Object> get props => [];

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

  const ConfigLoaded({
    required this.cvAuthService,
    required this.authInfoRepository,
    required this.appPrefsRepository,
    required this.identityRepository,
    required this.userRepository,
    required this.profileRepository,
    required this.partRepository,
    required this.groupRepository,
    required this.entryRepository,
  }) : super();

  @override
  List<Object> get props => super.props
    ..addAll([
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
  final Object error;

  const ConfigFailure({
    required this.error,
  }) : super();

  @override
  List<Object> get props => super.props..addAll([error]);

  @override
  String toString() => '$runtimeType{ '
      'error: $error'
      ' }';
}
