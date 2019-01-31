import 'package:flutter/material.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_flutter/src/blocs/bloc_provider.dart';
import 'package:social_cv_client_flutter/src/localizations/cv_localization.dart';
import 'package:social_cv_client_flutter/src/utils/logger.dart';
import 'package:social_cv_client_flutter/src/widgets/login_form_widget.dart';

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
        title: Text(CVLocalizations.of(context).loginTitle),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          StreamBuilder<bool>(
            stream: _accountBloc.isLoggingStream,
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
