import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/errors.dart';
import 'package:social_cv_client_flutter/src/ui/localizations/cv_localization.dart';
import 'package:social_cv_client_flutter/src/ui/widgets/error_widget.dart';
import 'package:social_cv_client_flutter/src/utils/logging_service.dart';
import 'package:social_cv_client_flutter/src/utils/navigation.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final String _tag = '$_AccountPageState';

  /// TODO: Add AuthenticationBloc
  AuthenticationBloc get _authBloc => null;

  @override
  Widget build(BuildContext context) {
    Logger.log('$_tag:$build');

    return SafeArea(
      left: false,
      right: false,
      child: BlocBuilder<AuthenticationEvent, AuthenticationState>(
        bloc: _authBloc,
        builder: (BuildContext context, AuthenticationState state) {
          if (state is AuthenticationUninitialized) return Container();
          if (state is AuthenticationUnauthenticated)
            return _AccountPageDetailsNotConnected();
          if (state is AuthenticationAuthenticated)
            return _AccountPageDetailsConnected();
          if (state is AuthenticationLoading)
            return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

////////////////////////////////////////////////////////////////////////////////
//                                                                            //
//                       _AccountPageDetailsNotConnected                      //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////
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

////////////////////////////////////////////////////////////////////////////////
//                                                                            //
//                       _AccountPageDetailsConnected                         //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////
class _AccountPageDetailsConnected extends StatefulWidget {
  _AccountPageDetailsConnected({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AccountPageDetailsConnectedState();
}

class _AccountPageDetailsConnectedState
    extends State<_AccountPageDetailsConnected> {
  /// TODO: Add AccountBloc
  AccountBloc get _accountBloc => null;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountEvent, AccountState>(
      bloc: _accountBloc,
      builder: (BuildContext context, AccountState state) {
        if (state is AccountUninitialized) {
        } else if (state is AccountLoaded) {
          return ListView(
            children: <Widget>[
              ExpansionTile(
                leading: Icon(MdiIcons.accountBoxMultiple),
                title: Text(CVLocalizations.of(context).accountMyProfile),
                children: <Widget>[
//                  BlocProvider(
//                    bloc: ElementListBloc<ProfileViewModel>(
//                      cvRepository: _repositories.cvRepository,
//                      preferencesRepository:
//                          _repositories.preferencesRepository,
//                    ),
//                    child: ProfileListWidget(
//                      fromUserViewModel: snapshot.data,
//                      showOptions: false,
//                      shrinkWrap: true,
//                      physics: ClampingScrollPhysics(),
//                    ),
//                  ),
                ],
              ),
            ],
          );
        } else if (state is AccountFailed) {
          return ErrorCard(error: state.error);
        }
        return ErrorCard(error: NotImplementedYetError());
      },
    );
  }
}
