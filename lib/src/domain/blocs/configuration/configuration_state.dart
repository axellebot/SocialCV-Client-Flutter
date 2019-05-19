import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:social_cv_client_dart_common/repositories.dart';

abstract class ConfigurationState extends Equatable {
  ConfigurationState([List props = const []]) : super(props);

  @override
  String toString() => '$runtimeType{}';
}

class ConfigLoading extends ConfigurationState {}

class ConfigLoaded extends ConfigurationState {
  final CVRepository cvRepository;
  final AuthPreferencesRepository authPreferencesRepository;
  final AppPreferencesRepository appPreferencesRepository;
  final ConfigRepository configRepository;

  ConfigLoaded({
    @required this.cvRepository,
    @required this.authPreferencesRepository,
    @required this.appPreferencesRepository,
    @required this.configRepository,
  })  : assert(
          cvRepository != null,
          'No $CVRepository given',
        ),
        assert(
          authPreferencesRepository != null,
          'No $AuthPreferencesRepository given',
        ),
        assert(
          appPreferencesRepository != null,
          'No $AppPreferencesRepository given',
        ),
        assert(
          configRepository != null,
          'No $ConfigRepository given',
        ),
        super([
          cvRepository,
          authPreferencesRepository,
          appPreferencesRepository,
          configRepository,
        ]);
}

class ConfigFailure extends ConfigurationState {
  final Error error;

  ConfigFailure({@required this.error}) : super([error]);

  @override
  String toString() => '$runtimeType{ error: ${error.runtimeType} }';
}
