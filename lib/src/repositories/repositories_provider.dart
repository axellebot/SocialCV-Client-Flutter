import 'package:flutter/material.dart';
import 'package:social_cv_client_dart_common/repositories.dart';

class RepositoriesProvider extends InheritedWidget {
  const RepositoriesProvider({
    Key key,
    Widget child,
    this.cvRepository,
    this.secretsRepository,
    this.preferencesRepository,
  }) : super(key: key, child: child);

  final CVRepository cvRepository;
  final SecretsRepository secretsRepository;
  final PreferencesRepository preferencesRepository;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static RepositoriesProvider of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(RepositoriesProvider)
        as RepositoriesProvider;
  }
}
