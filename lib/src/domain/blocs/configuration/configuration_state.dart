import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:social_cv_client_dart_common/repositories.dart';

abstract class ConfigurationState extends Equatable {
  ConfigurationState([List props = const []]) : super(props);
}

class ConfigLoading extends ConfigurationState {}

class ConfigLoaded extends ConfigurationState {
  final CVRepository cvRepository;
  final PreferencesRepository preferencesRepository;
  final ConfigRepository configRepository;

  ConfigLoaded({
    @required this.cvRepository,
    @required this.preferencesRepository,
    @required this.configRepository,
  })  : assert(cvRepository != null, 'No $CVRepository given'),
        assert(
            preferencesRepository != null, 'No $PreferencesRepository given'),
        assert(configRepository != null, 'No $ConfigRepository given'),
        super([cvRepository, preferencesRepository, configRepository]);
}
