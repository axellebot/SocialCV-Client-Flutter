import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/models.dart';
import 'package:social_cv_client_flutter/src/blocs/bloc_provider.dart';
import 'package:social_cv_client_flutter/src/localizations/cv_localization.dart';
import 'package:social_cv_client_flutter/src/repositories/repositories_provider.dart';
import 'package:social_cv_client_flutter/src/utils/logger.dart';
import 'package:social_cv_client_flutter/src/utils/navigation.dart';
import 'package:social_cv_client_flutter/src/utils/utils.dart';
import 'package:social_cv_client_flutter/src/widgets/error_widget.dart';
import 'package:social_cv_client_flutter/src/widgets/profile_list_widget.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    logger.info('Building AccountPage');

    AccountBloc _accountBloc = BlocProvider.of<AccountBloc>(context);

    return SafeArea(
      left: false,
      right: false,
      child: Stack(
        children: <Widget>[
          StreamBuilder<bool>(
            stream: _accountBloc.isFetchingAccountDetailsStream,
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (snapshot.data == true) {
                return LinearProgressIndicator();
              }
              return Container();
            },
          ),
          _AccountPageDetails(),
        ],
      ),
    );
  }
}

class _AccountPageDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AccountBloc _accountBloc = BlocProvider.of<AccountBloc>(context);

    return StreamBuilder<bool>(
      stream: _accountBloc.isAuthenticatedStream,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data == true) return _AccountPageDetailsConnected();
          if (snapshot.data == false) return _AccountPageDetailsNotConnected();
        } else if (snapshot.hasError) {
          return Container(
            child:
                ErrorContent(message: translateError(context, snapshot.error)),
          );
        }
        return Container();
      },
    );
  }
}

class _AccountPageDetailsNotConnected extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        child: Text(CVLocalizations.of(context).authSignInCTA),
        onPressed: () => navigateToLogin(context),
      ),
    );
  }
}

class _AccountPageDetailsConnected extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AccountBloc _accountBloc = BlocProvider.of<AccountBloc>(context);
    RepositoriesProvider _repositories = RepositoriesProvider.of(context);

    return StreamBuilder<UserModel>(
      stream: _accountBloc.accountDetailsStream,
      builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
        if (snapshot.hasData) {
          return ListView(
            children: <Widget>[
              ExpansionTile(
                leading: Icon(MdiIcons.accountBoxMultiple),
                title: Text(CVLocalizations.of(context).accountMyProfile),
                children: <Widget>[
                  BlocProvider(
                    bloc: ProfileListBloc(
                      cvRepository: _repositories.cvRepository,
                      preferencesRepository:
                          _repositories.preferencesRepository,
                    ),
                    child: ProfileListWidget(
                      fromUserModel: snapshot.data,
                      showOptions: false,
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                    ),
                  ),
                ],
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return ErrorCard(message: translateError(context, snapshot.error));
        }
        return Container();
      },
    );
  }
}
