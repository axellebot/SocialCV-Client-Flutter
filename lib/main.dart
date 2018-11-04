import 'package:cv/src/blocs/auth_bloc.dart';
import 'package:cv/src/blocs/bloc_provider.dart';
import 'package:cv/src/blocs/settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:cv/src/app.dart';

Future<void> main() async {
  //  SystemChrome.setPreferredOrientations(
  //      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(BlocProvider<AuthBloc>(
    bloc: AuthBloc(),
    child: BlocProvider<SettingsBloc>(
      bloc: SettingsBloc(),
      child: CVApp(),
    ),
  ));
}
