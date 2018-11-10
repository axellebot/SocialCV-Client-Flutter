import 'package:cv/src/blocs/auth_bloc.dart';
import 'package:cv/src/blocs/bloc_provider.dart';
import 'package:cv/src/blocs/application_bloc.dart';
import 'package:flutter/material.dart';
import 'package:cv/src/app.dart';

Future<void> main() async {
  //  SystemChrome.setPreferredOrientations(
  //      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(
    BlocProvider<ApplicationBloc>(
      bloc: ApplicationBloc(),
      child: BlocProvider<AuthBloc>(
        bloc: AuthBloc(),
        child: CVApp(),
      ),
    ),
  );
}
