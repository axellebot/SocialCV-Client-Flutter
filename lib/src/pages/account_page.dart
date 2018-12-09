import 'package:cv/src/blocs/account_bloc.dart';
import 'package:cv/src/blocs/bloc_provider.dart';
import 'package:cv/src/commons/logger.dart';
import 'package:cv/src/commons/paths.dart';
import 'package:cv/src/commons/utils.dart';
import 'package:cv/src/localizations/localization.dart';
import 'package:cv/src/models/profile_model.dart';
import 'package:cv/src/models/user_model.dart';
import 'package:cv/src/widgets/card_error.dart';
import 'package:cv/src/widgets/error_content.dart';
import 'package:cv/src/widgets/loading_shadow_content_widget.dart';
import 'package:cv/src/widgets/profile_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AccountPage extends StatelessWidget {
  AccountPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    logger.info('Building AccountPage');

    AccountBloc _accountBloc = BlocProvider.of<AccountBloc>(context);

    return SafeArea(
      child: Stack(
        children: <Widget>[
          _buildProgressBar(context),
          _buildAccount(context),
        ],
      ),
    );
  }

  Widget _buildProgressBar(BuildContext context) {
    AccountBloc _accountBloc = BlocProvider.of<AccountBloc>(context);
    return StreamBuilder<bool>(
      stream: _accountBloc.isFetchingAccountDetailsStream,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.data == true) {
          return LinearProgressIndicator();
        }
        return Container();
      },
    );
  }

  Widget _buildAccount(BuildContext context) {
    AccountBloc _accountBloc = BlocProvider.of<AccountBloc>(context);
    return StreamBuilder<bool>(
      stream: _accountBloc.isAuthenticatedStream,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data == true) return _buildConnectedAccount(context);
          if (snapshot.data == false) return _buildNotConnectedAccount(context);
        } else if (snapshot.hasError) {
          return Container(
              child: Text(translateError(context, snapshot.error)));
        }
        return Container();
      },
    );
  }

  Widget _buildConnectedAccount(context) {
    AccountBloc _accountBloc = BlocProvider.of<AccountBloc>(context);

    return StreamBuilder<UserModel>(
      stream: _accountBloc.fetchAccountDetailsStream,
      builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
        if (snapshot.hasData) {
          UserModel userModel = snapshot.data;
          return _buildAccountDetails(context, userModel);
        } else if (snapshot.hasError) {
          return CardError(translateError(context, snapshot.error));
        }
        return Container();
      },
    );
  }

  Center _buildNotConnectedAccount(BuildContext context) {
    return Center(
      child: RaisedButton(
        child: Text(Localization.of(context).loginCTA),
        onPressed: () => _navigateToLogin(context),
      ),
    );
  }

  Widget _buildAccountDetails(BuildContext context, UserModel userModel) {
    return ListView(
      children: <Widget>[
        ExpansionTile(
          leading: Icon(MdiIcons.accountBoxMultiple),
          title: Text(Localization.of(context).accountMyProfile),
          children: <Widget>[_buildProfiles(context, userModel.profileIds)],
        ),
      ],
    );
  }

  Widget _buildProfiles(BuildContext context, List<String> ids) {
    AccountBloc _accountBloc = BlocProvider.of<AccountBloc>(context);
    _accountBloc.fetchAccountProfiles();

    return StreamBuilder<List<ProfileModel>>(
      stream: _accountBloc.fetchAccountProfilesStream,
      builder:
          (BuildContext context, AsyncSnapshot<List<ProfileModel>> snapshot) {
        if (snapshot.hasError) {
          return ErrorContent(translateError(context, snapshot.error));
        } else if (snapshot.hasData) {
          List<ProfileModel> list = snapshot.data;
          List<Widget> _widgetList = [];
          list.forEach((profileModel) {
            _widgetList.add(
              ProfileTile(profileModel),
            );
          });
          return Column(children: _widgetList);
        }
        List<Widget> _widgetList = [];
        ids.forEach((profileId) {
          _widgetList.add(LoadingShadowContent(
            numberOfTitleLines: 1,
            numberOfContentLines: 1,
          ));
        });
        return Column(children: _widgetList);
      },
    );
  }

  void _navigateToLogin(BuildContext context) {
    Navigator.of(context).pushNamed(kPathLogin);
  }
}
