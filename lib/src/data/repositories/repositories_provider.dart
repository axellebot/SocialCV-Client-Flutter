import 'package:flutter/material.dart';
import 'package:social_cv_client_dart_common/repositories.dart';

class RepositoriesProvider extends InheritedWidget {
  const RepositoriesProvider({
    Key key,
    Widget child,
    @required this.cvRepository,
    @required this.configRepository,
    @required this.preferencesRepository,
  })  : assert(cvRepository != null, 'No $CVRepository given'),
        assert(configRepository != null, 'No $ConfigRepository given'),
        assert(
            preferencesRepository != null, 'No $PreferencesRepository given'),
        super(key: key, child: child);

  final CVRepository cvRepository;
  final ConfigRepository configRepository;
  final PreferencesRepository preferencesRepository;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static RepositoriesProvider of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(RepositoriesProvider)
        as RepositoriesProvider;
  }
}
