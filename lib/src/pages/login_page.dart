import 'package:cv/src/blocs/account_bloc.dart';
import 'package:cv/src/blocs/bloc_provider.dart';
import 'package:cv/src/localizations/localization.dart';
import 'package:cv/src/utils/logger.dart';
import 'package:cv/src/widgets/login_form_widget.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    logger.info('Building LoginPage');
    AccountBloc _accountBloc = BlocProvider.of<AccountBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(Localization.of(context).loginTitle),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          StreamBuilder<bool>(
            stream: _accountBloc.isLogingStream,
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (snapshot.data == true) {
                return LinearProgressIndicator();
              }
              return Container();
            },
          ),
          LoginForm(),
        ],
      ),
    );
  }
}
