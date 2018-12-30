import 'package:cv/src/blocs/account_bloc.dart';
import 'package:cv/src/blocs/bloc_provider.dart';
import 'package:cv/src/blocs/profile_list_bloc.dart';
import 'package:cv/src/localizations/localization.dart';
import 'package:cv/src/models/user_model.dart';
import 'package:cv/src/utils/logger.dart';
import 'package:cv/src/utils/navigation.dart';
import 'package:cv/src/utils/utils.dart';
import 'package:cv/src/widgets/error_widget.dart';
import 'package:cv/src/widgets/profile_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

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
        child: Text(Localization.of(context).loginCTA),
        onPressed: () => navigateToLogin(context),
      ),
    );
  }
}

class _AccountPageDetailsConnected extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AccountBloc _accountBloc = BlocProvider.of<AccountBloc>(context);

    return StreamBuilder<UserModel>(
      stream: _accountBloc.fetchAccountDetailsStream,
      builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
        if (snapshot.hasData) {
          return ListView(
            children: <Widget>[
              ExpansionTile(
                leading: Icon(MdiIcons.accountBoxMultiple),
                title: Text(Localization.of(context).accountMyProfile),
                children: <Widget>[
                  BlocProvider(
                    bloc: ProfileListBloc(),
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
