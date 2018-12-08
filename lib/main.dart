import 'package:cv/src/app.dart';
import 'package:cv/src/blocs/account_bloc.dart';
import 'package:cv/src/blocs/application_bloc.dart';
import 'package:cv/src/blocs/bloc_provider.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  //  SystemChrome.setPreferredOrientations(
  //      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(
    BlocProvider<ApplicationBloc>(
      bloc: ApplicationBloc(),
      child: BlocProvider<AccountBloc>(
        bloc: AccountBloc(),
        child: CVApp(),
      ),
    ),
  );
}
